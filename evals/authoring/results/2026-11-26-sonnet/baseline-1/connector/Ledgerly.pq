// Ledgerly custom connector for Power Query (preview).
[Version = "1.0.0"]
section Ledgerly;

PageSize = "200";           // Query values must be text.
MaxAttempts = 5;
MaxWaitSeconds = 120;
RetryStatuses = {429, 502, 503, 504};
HandledStatuses = {400, 401, 403, 404, 429, 500, 502, 503, 504};

// ---------------------------------------------------------------------------
// Data source and publishing
// ---------------------------------------------------------------------------

// The data source path is the base URL (the only required parameter), so each
// tenant gets its own stored credential.
Ledgerly = [
    TestConnection = (dataSourcePath) => {"Ledgerly.Contents", dataSourcePath},
    Authentication = [
        Key = [
            KeyLabel = Extension.LoadString("KeyLabel"),
            Label = Extension.LoadString("AuthenticationLabel")
        ]
    ],
    Label = Extension.LoadString("DataSourceLabel")
];

Ledgerly.Publish = [
    Beta = true,
    Category = "Online Services",
    ButtonText = {Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp")},
    SupportsDirectQuery = false
];

[DataSource.Kind = "Ledgerly", Publish = "Ledgerly.Publish"]
shared Ledgerly.Contents = Value.ReplaceType(ContentsImpl, ContentsType);

ContentsType = type function (
    url as (Uri.Type meta [
        Documentation.FieldCaption = Extension.LoadString("UrlCaption"),
        Documentation.FieldDescription = Extension.LoadString("UrlDescription"),
        Documentation.SampleValues = {"https://acme.ledgerly.example/api/v2"}
    ]),
    optional updatedSince as (type nullable datetimezone meta [
        Documentation.FieldCaption = Extension.LoadString("UpdatedSinceCaption"),
        Documentation.FieldDescription = Extension.LoadString("UpdatedSinceDescription")
    ])
) as table meta [
    Documentation.Name = Extension.LoadString("FormulaTitle"),
    Documentation.LongDescription = Extension.LoadString("FormulaHelp")
];

ContentsImpl = (url as text, optional updatedSince as nullable datetimezone) as table =>
    let
        baseUrl = ValidateUrl(url),
        filter =
            if updatedSince = null then
                []
            else
                [updated_since = DateTimeZone.ToText(
                    DateTimeZone.SwitchZone(updatedSince, 0),
                    [Format = "yyyy-MM-dd'T'HH:mm:ss'Z'", Culture = "en-US"]
                )],
        // The navigation table is lazy and would not send a request by itself.
        // Calling /me first makes "test connection" fail on a bad key or URL.
        account = Request(baseUrl, "me", [], 1),
        objects = #table(
            {"Name", "Key", "Data", "ItemKind", "ItemName", "IsLeaf"},
            {
                {"Invoices", "invoices",
                    GetEntity(baseUrl, "invoices", filter, InvoiceType, InvoiceConverters),
                    "Table", "Table", true},
                {"Customers", "customers",
                    GetEntity(baseUrl, "customers", filter, CustomerType, CustomerConverters),
                    "Table", "Table", true},
                {"Payments", "payments",
                    GetEntity(baseUrl, "payments", filter, PaymentType, PaymentConverters),
                    "Table", "Table", true}
            }
        ),
        navigation = Table.ToNavigationTable(
            objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf"
        )
    in
        if account is record then
            navigation
        else
            Fail("The /me endpoint did not return an account. Check the base URL.", [Url = baseUrl]);

// Returns the base URL without a trailing slash, or raises before anything is sent.
ValidateUrl = (url as text) as text =>
    let
        trimmed = Text.TrimEnd(Text.Trim(url), "/"),
        parts = try Uri.Parts(trimmed),
        valid =
            not parts[HasError]
            and Text.Lower(parts[Value][Scheme]) = "https"
            and parts[Value][Host] <> ""
            and parts[Value][UserName] = ""
            and parts[Value][Password] = ""
            and Record.FieldCount(parts[Value][Query]) = 0
            and parts[Value][Fragment] = ""
    in
        if valid then
            trimmed
        else
            // The rejected value is not echoed: it may contain a pasted secret.
            error Error.Record(
                "DataSource.Error",
                "The Ledgerly base URL must be an HTTPS address without a user name, query string or fragment, "
                    & "for example https://acme.ledgerly.example/api/v2."
            );

// ---------------------------------------------------------------------------
// Schemas
//
// Datetimes are exposed as UTC "datetime" values, so that results do not depend
// on the time zone of the machine (Desktop or gateway) that runs the refresh.
// Amounts are fixed decimals (4 decimal places).
// ---------------------------------------------------------------------------

InvoiceType = type table [
    id = nullable text,
    number = nullable text,
    customer_id = nullable text,
    issued_at = nullable datetime,
    due_at = nullable date,
    total = nullable Currency.Type,
    currency = nullable text,
    status = nullable text,
    updated_at = nullable datetime
];

InvoiceConverters = [
    id = AsText,
    number = AsText,
    customer_id = AsText,
    issued_at = AsUtcDateTime,
    due_at = AsDate,
    total = AsAmount,
    currency = AsText,
    status = AsText,
    updated_at = AsUtcDateTime
];

CustomerType = type table [
    id = nullable text,
    name = nullable text,
    email = nullable text,
    country = nullable text,
    created_at = nullable datetime
];

CustomerConverters = [
    id = AsText,
    name = AsText,
    email = AsText,
    country = AsText,
    created_at = AsUtcDateTime
];

PaymentType = type table [
    id = nullable text,
    invoice_id = nullable text,
    amount = nullable Currency.Type,
    paid_at = nullable datetime,
    method = nullable text
];

PaymentConverters = [
    id = AsText,
    invoice_id = AsText,
    amount = AsAmount,
    paid_at = AsUtcDateTime,
    method = AsText
];

AsText = (value) => if value = null then null else Text.From(value, "en-US");

AsAmount = (value) => if value = null then null else Currency.From(value, "en-US");

AsDate = (value) =>
    if value = null then null else Date.FromText(value, [Format = "yyyy-MM-dd", Culture = "en-US"]);

// A value without an offset is read as UTC, not as the machine's local time.
AsUtcDateTime = (value) =>
    if value = null then
        null
    else
        let
            hasOffset =
                Text.EndsWith(value, "Z", Comparer.OrdinalIgnoreCase)
                or Text.PositionOfAny(Text.Middle(value, 10), {"+", "-"}) >= 0,
            zoned = DateTimeZone.FromText(if hasOffset then value else value & "Z", [Culture = "en-US"])
        in
            DateTimeZone.RemoveZone(DateTimeZone.SwitchZone(zoned, 0));

// ---------------------------------------------------------------------------
// Paging
// ---------------------------------------------------------------------------

// Fields not in the schema are ignored and omitted fields become null, so the
// columns are the same for every response, including an empty one.
GetEntity = (baseUrl as text, path as text, filter as record, tableType as type, converters as record) as table =>
    let
        columns = Table.ColumnNames(#table(tableType, {})),
        ToRow = (item as record) as list =>
            List.Transform(
                columns,
                (column) => Record.Field(converters, column)(Record.FieldOrDefault(item, column))
            ),
        items = List.Combine(GetPages(baseUrl, path, filter))
    in
        Table.FromRows(List.Transform(items, ToRow), tableType);

// A list with one entry per page, each entry being that page's list of records.
GetPages = (baseUrl as text, path as text, filter as record) as list =>
    let
        GetPage = (cursor as nullable text) as record =>
            let
                query =
                    [limit = PageSize]
                    & filter
                    & (if cursor = null then [] else [cursor = cursor]),
                body = Request(baseUrl, path, query, 1),
                items = Record.FieldOrDefault(body, "data"),
                next = Record.FieldOrDefault(body, "next_cursor")
            in
                if not (items is list) then
                    Fail("The response from /" & path & " has no 'data' list.", [Path = path])
                else if next <> null and next = cursor then
                    // Stop instead of requesting the same page forever.
                    Fail("The API returned the same page cursor twice for /" & path & ".", [Path = path])
                else
                    [Items = items, Next = next]
    in
        List.Generate(
            () => GetPage(null),
            (page) => page <> null,
            (page) => if page[Next] = null or page[Next] = "" then null else GetPage(page[Next]),
            (page) => page[Items]
        );

// ---------------------------------------------------------------------------
// HTTP
// ---------------------------------------------------------------------------

// The only place that calls Web.Contents. Returns the parsed JSON object.
Request = (baseUrl as text, path as text, query as record, attempt as number) as any =>
    let
        response = Web.Contents(baseUrl, [
            RelativePath = path,
            Query = query,
            Headers = [
                Authorization = "Bearer " & Extension.CurrentCredential()[Key],
                Accept = "application/json"
            ],
            ManualStatusHandling = HandledStatuses,
            // Without this a retry would get the cached failed response.
            IsRetry = attempt > 1
        ]),
        metadata = Value.Metadata(response),
        status = metadata[Response.Status],
        retryAfter = RetryAfterSeconds(Record.FieldOrDefault(metadata, "Headers", [])),
        wait = if retryAfter <> null then retryAfter else Number.Power(2, attempt),
        canRetry =
            List.Contains(RetryStatuses, status)
            and attempt < MaxAttempts
            and wait <= MaxWaitSeconds
    in
        if canRetry then
            Function.InvokeAfter(
                () => @Request(baseUrl, path, query, attempt + 1),
                #duration(0, 0, 0, wait)
            )
        else if List.Contains(HandledStatuses, status) then
            HttpError(status, response, path, retryAfter)
        else
            let
                parsed = try Json.Document(response),
                isObject = not parsed[HasError] and parsed[Value] is record
            in
                if isObject then
                    parsed[Value]
                else
                    Fail(
                        "Ledgerly did not return a JSON object for /" & path & ". Check the base URL.",
                        [Path = path, Status = status]
                    );

// The Retry-After header as a number of seconds, or null if absent or unreadable.
RetryAfterSeconds = (headers as record) as nullable number =>
    let
        name = List.First(
            List.Select(Record.FieldNames(headers), each Comparer.OrdinalIgnoreCase(_, "Retry-After") = 0),
            null
        ),
        seconds =
            if name = null then
                null
            else
                try Number.FromText(Text.Trim(Record.Field(headers, name)), "en-US") otherwise null
    in
        if seconds <> null and seconds >= 0 then seconds else null;

HttpError = (status as number, response as binary, path as text, retryAfter as nullable number) =>
    let
        // The body may not be JSON (for example an HTML page from a proxy).
        apiError = try Json.Document(response)[error],
        code = try Text.From(apiError[Value][code]) otherwise null,
        apiMessage = try Text.From(apiError[Value][message]) otherwise null,
        suffix =
            " (HTTP " & Text.From(status, "en-US")
            & (if code = null then "" else ", " & code)
            & ")"
            & (if apiMessage = null then "" else ": " & apiMessage),
        detail = [Path = path, Status = status, Code = code, Message = apiMessage],
        waitHint =
            if retryAfter = null then
                "Try again later."
            else
                "Try again in " & Text.From(retryAfter, "en-US") & " seconds."
    in
        if status = 401 then
            // A credential error makes Power BI ask for a new key.
            error Extension.CredentialError(
                Credential.AccessDenied,
                "Ledgerly rejected the API key: it is wrong or has expired. Update the data source credential" & suffix
            )
        else if status = 403 then
            Fail("This API key is not allowed to read /" & path & suffix, detail)
        else if status = 404 then
            Fail(
                "Ledgerly found nothing at /" & path & ". Check the base URL (does it include /api/v2?)" & suffix,
                detail
            )
        else if status = 429 then
            Fail("Ledgerly is rate limiting requests. " & waitHint & suffix, detail)
        else if status = 400 then
            Fail("Ledgerly rejected the request for /" & path & suffix, detail)
        else
            // 500, 502, 503, 504
            Fail("Ledgerly is temporarily unavailable. " & waitHint & suffix, detail);

Fail = (message as text, detail as record) =>
    error Error.Record("DataSource.Error", message, detail);

// ---------------------------------------------------------------------------
// Navigation table helper (from the Power Query SDK documentation)
// ---------------------------------------------------------------------------

Table.ToNavigationTable = (
    objects as table,
    keyColumns as list,
    nameColumn as text,
    dataColumn as text,
    itemKindColumn as text,
    itemNameColumn as text,
    isLeafColumn as text
) as table =>
    let
        newType = Type.AddTableKey(Value.Type(objects), keyColumns, true) meta [
            NavigationTable.NameColumn = nameColumn,
            NavigationTable.DataColumn = dataColumn,
            NavigationTable.ItemKindColumn = itemKindColumn,
            Preview.DelayColumn = itemNameColumn,
            NavigationTable.IsLeafColumn = isLeafColumn
        ]
    in
        Value.ReplaceType(objects, newType);
