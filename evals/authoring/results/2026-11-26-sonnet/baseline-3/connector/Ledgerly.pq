[Version = "0.1.0"]
section Ledgerly;

// Tunables
PageSize = 200;                 // API maximum
MaxRetries = 5;                 // retries after the first attempt
MaxRetryAfterSeconds = 120;     // a longer Retry-After fails the refresh instead of stalling it
RequestTimeout = #duration(0, 0, 1, 40);

// ---------------------------------------------------------------------------
// Public function
// ---------------------------------------------------------------------------

[DataSource.Kind = "Ledgerly", Publish = "Ledgerly.Publish"]
shared Ledgerly.Contents = Value.ReplaceType(LedgerlyNavigation, LedgerlyContentsType);

LedgerlyContentsType =
    type function (
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
        Documentation.Name = Extension.LoadString("DataSourceLabel"),
        Documentation.LongDescription = Extension.LoadString("FunctionDescription")
    ];

LedgerlyNavigation = (url as text, optional updatedSince as nullable datetimezone) as table =>
    let
        baseUrl = ValidateUrl(url),
        // Checked eagerly so that TestConnection and the connect dialog verify the key.
        account = GetJson(baseUrl, "me", []),
        // Rows are list literals so that each Data cell stays lazy: loading one table must not
        // request the others. The Key column is not localized, so saved queries keep working in
        // any UI language.
        entities = #table(
            {"Name", "Key", "Data", "ItemKind", "ItemName", "IsLeaf"},
            {
                {Extension.LoadString("InvoicesName"), "Invoices",
                    GetTable(baseUrl, "invoices", InvoiceSchema, updatedSince), "Table", "Table", true},
                {Extension.LoadString("CustomersName"), "Customers",
                    GetTable(baseUrl, "customers", CustomerSchema, updatedSince), "Table", "Table", true},
                {Extension.LoadString("PaymentsName"), "Payments",
                    GetTable(baseUrl, "payments", PaymentSchema, updatedSince), "Table", "Table", true}
            }
        ),
        navigation = Table.ToNavigationTable(entities, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        if account <> null then navigation else error DataSourceError(Extension.LoadString("ErrorBadResponse"), "me");

// ---------------------------------------------------------------------------
// Schemas: {column, converter, type}. Fields not listed here are ignored.
// ---------------------------------------------------------------------------

InvoiceSchema = {
    {"id", ToText, type text},
    {"number", ToText, type text},
    {"customer_id", ToText, type text},
    {"issued_at", ToUtcDateTime, type datetime},
    {"due_at", ToDate, type date},
    {"total", ToDecimal, Currency.Type},
    {"currency", ToText, type text},
    {"status", ToText, type text},
    {"updated_at", ToUtcDateTime, type datetime}
};

CustomerSchema = {
    {"id", ToText, type text},
    {"name", ToText, type text},
    {"email", ToText, type text},
    {"country", ToText, type text},
    {"created_at", ToUtcDateTime, type datetime}
};

PaymentSchema = {
    {"id", ToText, type text},
    {"invoice_id", ToText, type text},
    {"amount", ToDecimal, Currency.Type},
    {"paid_at", ToUtcDateTime, type datetime},
    {"method", ToText, type text}
};

ToText = (value) => if value = null then null else Text.From(value, "en-US");

ToDecimal = (value) => if value = null then null else Currency.From(value, "en-US");

ToDate = (value) => if value = null then null else Date.FromText(value, [Format = "yyyy-MM-dd", Culture = "en-US"]);

// Returns UTC without a zone, so Desktop, the service and the gateway all show the same value
// whatever their local time zone. A value with no offset is taken to be UTC already.
ToUtcDateTime = (value) =>
    if value = null then
        null
    else
        let
            time = Text.AfterDelimiter(value, "T"),
            hasZone = Text.EndsWith(time, "Z") or Text.Contains(time, "+") or Text.Contains(time, "-"),
            zoned = DateTimeZone.FromText(if hasZone then value else value & "Z", [Culture = "en-US"])
        in
            DateTimeZone.RemoveZone(DateTimeZone.SwitchZone(zoned, 0));

// ---------------------------------------------------------------------------
// Tables and paging
// ---------------------------------------------------------------------------

GetTable = (baseUrl as text, path as text, schema as list, updatedSince as nullable datetimezone) as table =>
    let
        columns = List.Transform(schema, each _{0}),
        records = GetAllRecords(baseUrl, path, updatedSince),
        rows = List.Transform(
            records,
            (item) => List.Transform(columns, (column) => Record.FieldOrDefault(item, column, null))
        ),
        // Building from rows and a fixed column list keeps the columns when there are no records.
        raw = Table.FromRows(rows, columns)
    in
        Table.TransformColumns(raw, schema);

GetAllRecords = (baseUrl as text, path as text, updatedSince as nullable datetimezone) as list =>
    let
        filter = [limit = Number.ToText(PageSize, "D", "en-US")]
            & (if updatedSince = null then [] else [updated_since = ToIso8601Utc(updatedSince)]),
        getPage = (current as nullable text) as record =>
            let
                query = filter & (if current = null then [] else [cursor = current]),
                body = GetJson(baseUrl, path, query),
                data = body[data]?,
                next = body[next_cursor]?
            in
                if not (data is list) then
                    error DataSourceError(Extension.LoadString("ErrorBadResponse"), path)
                else if next <> null and next = current then
                    error DataSourceError(Extension.LoadString("ErrorRepeatedCursor"), path)
                else
                    [Data = data, Next = next],
        pages = List.Generate(
            () => getPage(null),
            (page) => page <> null,
            (page) => if page[Next] = null then null else getPage(page[Next]),
            (page) => page[Data]
        )
    in
        List.Combine(pages);

ToIso8601Utc = (value as datetimezone) as text =>
    DateTime.ToText(
        DateTimeZone.RemoveZone(DateTimeZone.SwitchZone(value, 0)),
        [Format = "yyyy-MM-dd'T'HH:mm:ss'Z'", Culture = "en-US"]
    );

// ---------------------------------------------------------------------------
// HTTP
// ---------------------------------------------------------------------------

ValidateUrl = (url as text) as text =>
    let
        trimmed = Text.TrimEnd(Text.Trim(url), "/"),
        parts = try Uri.Parts(trimmed),
        valid =
            Text.StartsWith(trimmed, "https://", Comparer.OrdinalIgnoreCase)
            and not parts[HasError]
            and parts[Value][Host] <> ""
            and parts[Value][UserName] = ""
            and parts[Value][Password] = ""
            and not Text.Contains(trimmed, "?")
            and not Text.Contains(trimmed, "#")
    in
        // The rejected text is deliberately not echoed: it might contain a secret.
        if valid then trimmed else error Error.Record("DataSource.Error", Extension.LoadString("ErrorInvalidUrl"));

// The only place that sends requests. The key goes in the Authorization header and nowhere else.
GetJson = (baseUrl as text, path as text, query as record) as record =>
    let
        key = Extension.CurrentCredential()[Key],
        send = (attempt as number) as record =>
            let
                response = Web.Contents(baseUrl, [
                    RelativePath = path,
                    Query = query,
                    Headers = [Authorization = "Bearer " & key, Accept = "application/json"],
                    ManualCredentials = true,
                    ManualStatusHandling = {400, 401, 403, 404, 429, 500, 502, 503, 504},
                    Timeout = RequestTimeout,
                    IsRetry = attempt > 0
                ]),
                // Buffer before reading metadata so the request is made exactly once.
                content = Binary.Buffer(response),
                metadata = Value.Metadata(response),
                status = metadata[Response.Status],
                retryAfter = RetryAfterSeconds(metadata[Headers]?),
                // The server's Retry-After if sent, otherwise 2, 4, 8, 16, 32 seconds.
                delay = if retryAfter <> null then retryAfter else Number.Power(2, attempt + 1),
                retryable = List.Contains({429, 502, 503, 504}, status),
                json = try Json.Document(content)
            in
                if status >= 200 and status < 300 then
                    if not json[HasError] and json[Value] is record then
                        json[Value]
                    else
                        error DataSourceError(Extension.LoadString("ErrorBadResponse"), path)
                else if retryable and attempt < MaxRetries and delay <= MaxRetryAfterSeconds then
                    Function.InvokeAfter(() => @send(attempt + 1), #duration(0, 0, 0, delay))
                else
                    RaiseHttpError(status, if json[HasError] then null else json[Value], path, key)
    in
        send(0);

// Header names are case-insensitive. Returns null if absent or not a number of seconds.
RetryAfterSeconds = (headers as nullable record) as nullable number =>
    let
        names = if headers = null then {} else Record.FieldNames(headers),
        name = List.First(List.Select(names, each Comparer.OrdinalIgnoreCase(_, "Retry-After") = 0), null),
        seconds =
            if name = null then null
            else try Number.FromText(Record.Field(headers, name), "en-US") otherwise null
    in
        if seconds = null or seconds < 0 then null else seconds;

RaiseHttpError = (status as number, body as any, path as text, key as text) =>
    let
        apiError = try body[error] otherwise null,
        code = try Text.From(apiError[code]) otherwise null,
        apiMessage = try Text.From(apiError[message]) otherwise null,
        summaryTemplate =
            if status = 401 then Extension.LoadString("Error401")
            else if status = 403 then Extension.LoadString("Error403")
            else if status = 404 then Extension.LoadString("Error404")
            else if status = 429 then Extension.LoadString("Error429")
            else if List.Contains({502, 503, 504}, status) then Extension.LoadString("ErrorUnavailable")
            else Extension.LoadString("ErrorHttp"),
        summary = Text.Format(summaryTemplate, {Number.ToText(status, "D", "en-US")}),
        // Redact the key in case the server repeats it back.
        redact = (value as text) as text => if key = "" then value else Text.Replace(value, key, "***"),
        message =
            if apiMessage = null then summary
            else summary & " " & Text.Format(Extension.LoadString("ErrorApiMessage"), {redact(apiMessage)})
    in
        if status = 401 then
            error Extension.CredentialError(Credential.AccessDenied, message)
        else
            error Error.Record("DataSource.Error", message, [
                Status = status,
                Code = if code = null then null else redact(code),
                Endpoint = path
            ]);

DataSourceError = (message as text, path as text) as record =>
    Error.Record("DataSource.Error", message, [Endpoint = path]);

// ---------------------------------------------------------------------------
// Data source and publish records
// ---------------------------------------------------------------------------

// Do not rename the kind or change the required parameters: saved credentials and
// gateway data sources are bound to them.
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

// ---------------------------------------------------------------------------
// Standard navigation table helper (from the Power Query connector docs)
// ---------------------------------------------------------------------------

Table.ToNavigationTable = (
    source as table,
    keyColumns as list,
    nameColumn as text,
    dataColumn as text,
    itemKindColumn as text,
    itemNameColumn as text,
    isLeafColumn as text
) as table =>
    let
        tableType = Value.Type(source),
        newTableType = Type.AddTableKey(tableType, keyColumns, true) meta [
            NavigationTable.NameColumn = nameColumn,
            NavigationTable.DataColumn = dataColumn,
            NavigationTable.ItemKindColumn = itemKindColumn,
            Preview.DelayColumn = itemNameColumn,
            NavigationTable.IsLeafColumn = isLeafColumn
        ]
    in
        Value.ReplaceType(source, newTableType);
