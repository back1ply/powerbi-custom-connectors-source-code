[Version = "1.0.0"]
section Ledgerly;

// ---------------------------------------------------------------------------
// Settings
// ---------------------------------------------------------------------------

DefaultPageSize = 200;          // the API maximum; fewer requests under rate limits
MaxRetries = 5;                 // retries after the first attempt
MaxBackoffSeconds = 30;         // cap for the exponential delay when there is no Retry-After
MaxRetryAfterSeconds = 300;     // a longer Retry-After fails the query instead of stalling it
RetryStatuses = {429, 502, 503, 504};
HandledStatuses = {400, 401, 403, 404, 429, 500, 502, 503, 504};

// ---------------------------------------------------------------------------
// Data source kind and publishing
// ---------------------------------------------------------------------------

Ledgerly = [
    // The single required parameter is a URL, so dataSourcePath is that URL.
    // The extra option routes the gateway's test to a cheap call to /me.
    TestConnection = (dataSourcePath) => {"Ledgerly.Contents", dataSourcePath, [TestConnection = true]},
    Authentication = [
        Key = [
            Label = Extension.LoadString("AuthKeyLabel"),
            KeyLabel = Extension.LoadString("AuthKeyFieldLabel")
        ]
    ],
    Label = Extension.LoadString("DataSourceLabel")
];

Ledgerly.Publish = [
    Beta = true,
    Category = "Online Services",
    ButtonText = {Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp")},
    SupportsDirectQuery = false,
    SourceImage = Ledgerly.Icons,
    SourceTypeImage = Ledgerly.Icons
];

Ledgerly.Icons = [
    Icon16 = {
        Extension.Contents("Ledgerly16.png"),
        Extension.Contents("Ledgerly20.png"),
        Extension.Contents("Ledgerly24.png"),
        Extension.Contents("Ledgerly32.png")
    },
    Icon32 = {
        Extension.Contents("Ledgerly32.png"),
        Extension.Contents("Ledgerly40.png"),
        Extension.Contents("Ledgerly48.png"),
        Extension.Contents("Ledgerly64.png")
    }
];

// ---------------------------------------------------------------------------
// Public function
// ---------------------------------------------------------------------------

[DataSource.Kind = "Ledgerly", Publish = "Ledgerly.Publish"]
shared Ledgerly.Contents = Value.ReplaceType(ContentsImpl, ContentsType);

ContentsType =
    type function (
        url as (Uri.Type meta [
            Documentation.FieldCaption = Extension.LoadString("UrlCaption"),
            Documentation.FieldDescription = Extension.LoadString("UrlDescription"),
            Documentation.SampleValues = {"https://acme.ledgerly.example/api/v2"}
        ]),
        optional options as (type nullable [
            optional UpdatedSince = (type datetimezone meta [
                Documentation.FieldCaption = Extension.LoadString("UpdatedSinceCaption"),
                Documentation.FieldDescription = Extension.LoadString("UpdatedSinceDescription")
            ]),
            optional PageSize = (type number meta [
                Documentation.FieldCaption = Extension.LoadString("PageSizeCaption"),
                Documentation.FieldDescription = Extension.LoadString("PageSizeDescription"),
                Documentation.SampleValues = {200}
            ])
        ])
    ) as table meta [
        Documentation.Name = Extension.LoadString("FunctionName"),
        Documentation.Caption = Extension.LoadString("FunctionCaption"),
        Documentation.LongDescription = Extension.LoadString("FunctionDescription"),
        Documentation.Examples = {
            [
                Description = Extension.LoadString("ExampleDescription"),
                Code = "Ledgerly.Contents(""https://acme.ledgerly.example/api/v2""){[Name = ""Invoices""]}[Data]",
                Result = Extension.LoadString("ExampleResult")
            ]
        }
    ];

ContentsImpl = (url as text, optional options as nullable record) as table =>
    let
        baseUrl = ValidateUrlScheme(url),
        settings = ReadOptions(options)
    in
        // The comparison forces URL validation now; otherwise it would wait until a
        // table's Data is read.
        if baseUrl <> null and settings[TestConnection] then
            ConnectionProbe(baseUrl)
        else
            NavigationTable(baseUrl, settings[Query]);

// The result must depend on the response, or lazy evaluation would skip the request.
ConnectionProbe = (baseUrl as text) as table =>
    Table.FromRecords({Request(baseUrl, "me", [], 0)});

// ---------------------------------------------------------------------------
// Input validation
// ---------------------------------------------------------------------------

// Runs before any request, so the key is never sent over plain HTTP.
ValidateUrlScheme = (url as text) as text =>
    let
        trimmed = Text.Trim(url),
        parts = try Uri.Parts(trimmed) otherwise null,
        isValid =
            parts <> null
                and parts[Scheme] = "https"
                and parts[Host] <> ""
                and parts[UserName] = ""
                and parts[Password] = ""
                and Record.FieldCount(parts[Query]) = 0
                and parts[Fragment] = ""
    in
        if isValid then
            Text.TrimEnd(trimmed, "/")
        else
            error Error.Record("Expression.Error", Extension.LoadString("ErrorInvalidUrl"));

ReadOptions = (options as nullable record) as record =>
    let
        given = options ?? [],
        unknown = List.Difference(Record.FieldNames(given), {"UpdatedSince", "PageSize", "TestConnection"}),
        pageSize = Record.FieldOrDefault(given, "PageSize") ?? DefaultPageSize,
        isPageSizeValid =
            Value.Is(pageSize, type number)
                and pageSize >= 1
                and pageSize <= 200
                and Number.RoundDown(pageSize) = pageSize,
        updatedSince = Record.FieldOrDefault(given, "UpdatedSince"),
        query =
            [limit = Number.ToText(pageSize, "F0", "en-US")]
                & (if updatedSince = null then [] else [updated_since = ToUtcText(updatedSince)])
    in
        if not List.IsEmpty(unknown) then
            error Error.Record(
                "Expression.Error",
                Text.Format(Extension.LoadString("ErrorUnknownOption"), {Text.Combine(unknown, ", ")})
            )
        else if not isPageSizeValid then
            error Error.Record("Expression.Error", Extension.LoadString("ErrorPageSize"))
        else
            [Query = query, TestConnection = Record.FieldOrDefault(given, "TestConnection") = true];

// A datetime without a zone is read as UTC, so results do not depend on the gateway's time zone.
ToUtcText = (value as any) as text =>
    let
        utc =
            if Value.Is(value, type datetimezone) then
                DateTimeZone.RemoveZone(DateTimeZone.SwitchZone(value, 0))
            else if Value.Is(value, type datetime) then
                value
            else
                error Error.Record("Expression.Error", Extension.LoadString("ErrorUpdatedSince"))
    in
        DateTime.ToText(utc, [Format = "yyyy-MM-dd'T'HH:mm:ss'Z'", Culture = "en-US"]);

// ---------------------------------------------------------------------------
// HTTP
// ---------------------------------------------------------------------------

// The only place that reads the credential.
RequestHeaders = () as record =>
    [
        Accept = "application/json",
        Authorization = "Bearer " & Extension.CurrentCredential()[Key]
    ];

// One GET, with retries. attempt is 0 for the first try.
Request = (baseUrl as text, path as text, query as record, attempt as number) as record =>
    let
        response = Web.Contents(
            baseUrl,
            [
                RelativePath = path,
                Query = query,
                Headers = RequestHeaders(),
                ManualCredentials = true,
                ManualStatusHandling = HandledStatuses,
                // Bypasses the cache, which would otherwise replay the failed response.
                IsRetry = attempt > 0
            ]
        ),
        metadata = Value.Metadata(response),
        status = metadata[Response.Status],
        retryAfter = RetryAfterSeconds(Record.FieldOrDefault(metadata, "Headers", [])),
        delay = retryAfter ?? List.Min({Number.Power(2, attempt), MaxBackoffSeconds}),
        shouldRetry =
            List.Contains(RetryStatuses, status)
                and attempt < MaxRetries
                and delay <= MaxRetryAfterSeconds
    in
        if shouldRetry then
            Function.InvokeAfter(
                () => @Request(baseUrl, path, query, attempt + 1),
                #duration(0, 0, 0, delay)
            )
        else if List.Contains(HandledStatuses, status) then
            RaiseHttpError(status, path, response, retryAfter)
        else
            ParseBody(response, path);

// Header names are case-insensitive in HTTP but not in M records.
RetryAfterSeconds = (headers as record) as nullable number =>
    let
        name = List.First(
            List.Select(Record.FieldNames(headers), each Text.Lower(_) = "retry-after")
        ),
        seconds =
            if name = null then
                null
            else
                try Number.FromText(Record.Field(headers, name), "en-US") otherwise null
    in
        if seconds = null then null else List.Max({seconds, 0});

ParseBody = (response as binary, path as text) as record =>
    let
        body = try Json.Document(response) otherwise null
    in
        if body <> null and Value.Is(body, type record) then
            body
        else
            error Error.Record(
                "DataSource.Error",
                Text.Format(Extension.LoadString("ErrorInvalidResponse"), {path})
            );

RaiseHttpError = (status as number, path as text, response as binary, retryAfter as nullable number) =>
    let
        // A proxy or load balancer may answer with something that is not the API's JSON.
        apiError = try Json.Document(response)[error] otherwise [],
        code = try Text.From(apiError[code]) otherwise "",
        apiMessage =
            (try Text.From(apiError[message]) otherwise null) ?? Extension.LoadString("ErrorNoMessage"),
        template =
            if status = 401 then
                "Error401"
            else if status = 403 then
                "Error403"
            else if status = 404 then
                "Error404"
            else if status = 429 then
                "Error429"
            else if List.Contains(RetryStatuses, status) then
                "ErrorUnavailable"
            else
                "ErrorHttp",
        waitText =
            if retryAfter = null then
                ""
            else
                Text.Format(Extension.LoadString("ErrorRetryAfter"), {retryAfter}),
        message =
            Text.Format(Extension.LoadString(template), {apiMessage, Text.From(status), path})
                & (if status = 429 then waitText else "")
    in
        if status = 401 then
            // Makes Power BI mark the stored key as bad and ask for a new one.
            error Extension.CredentialError(Credential.AccessDenied, message)
        else
            error Error.Record(
                "DataSource.Error",
                message,
                [Status = status, Code = code, Message = apiMessage, Path = path]
            );

// ---------------------------------------------------------------------------
// Paging
// ---------------------------------------------------------------------------

// cursor is null for the first page. limit and updated_since are repeated on every page.
GetPage = (baseUrl as text, path as text, query as record, cursor as nullable text) as record =>
    let
        pageQuery = if cursor = null then query else query & [cursor = cursor],
        body = Request(baseUrl, path, pageQuery, 0),
        data = Record.FieldOrDefault(body, "data"),
        next = Record.FieldOrDefault(body, "next_cursor")
    in
        [
            Data =
                if data <> null and Value.Is(data, type list) then
                    data
                else
                    error Error.Record(
                        "DataSource.Error",
                        Text.Format(Extension.LoadString("ErrorInvalidResponse"), {path})
                    ),
            // A server that hands back the same cursor would otherwise loop forever.
            NextCursor =
                if next <> null and next = cursor then
                    error Error.Record(
                        "DataSource.Error",
                        Text.Format(Extension.LoadString("ErrorRepeatedCursor"), {path})
                    )
                else
                    next
        ];

// Stops only on a null next_cursor, so an empty page in the middle does not end paging.
GetAllRecords = (baseUrl as text, path as text, query as record) as list =>
    List.Combine(
        List.Generate(
            () => GetPage(baseUrl, path, query, null),
            (page) => page <> null,
            (page) =>
                if page[NextCursor] = null then
                    null
                else
                    GetPage(baseUrl, path, query, page[NextCursor]),
            (page) => page[Data]
        )
    );

// ---------------------------------------------------------------------------
// Schema
// Column names and types are a public contract: reports depend on them.
// Datetimes are UTC.
// ---------------------------------------------------------------------------

InvoicesType = type table [
    id = nullable text,
    number = nullable text,
    customer_id = nullable text,
    issued_at = nullable datetime,
    due_at = nullable date,
    total = nullable number,
    currency = nullable text,
    status = nullable text,
    updated_at = nullable datetime
];

CustomersType = type table [
    id = nullable text,
    name = nullable text,
    email = nullable text,
    country = nullable text,
    created_at = nullable datetime
];

PaymentsType = type table [
    id = nullable text,
    invoice_id = nullable text,
    amount = nullable number,
    paid_at = nullable datetime,
    method = nullable text
];

ToText = (value) => if value = null then null else Text.From(value, "en-US");

ToAmount = (value) => if value = null then null else Number.From(value, "en-US");

ToDate = (value) =>
    if value = null then null else Date.FromText(value, [Format = "yyyy-MM-dd", Culture = "en-US"]);

// ISO 8601 text to a UTC datetime. Text without an offset is taken to be UTC already.
ToUtcDateTime = (value) =>
    if value = null then
        null
    else
        let
            time = Text.AfterDelimiter(value, "T"),
            hasZone = Text.EndsWith(time, "Z") or Text.Contains(time, "+") or Text.Contains(time, "-"),
            zoned = DateTimeZone.FromText(
                if hasZone then value else value & "Z",
                [Culture = "en-US"]
            )
        in
            DateTimeZone.RemoveZone(DateTimeZone.SwitchZone(zoned, 0));

InvoicesConverters = {
    {"id", ToText},
    {"number", ToText},
    {"customer_id", ToText},
    {"issued_at", ToUtcDateTime},
    {"due_at", ToDate},
    {"total", ToAmount},
    {"currency", ToText},
    {"status", ToText},
    {"updated_at", ToUtcDateTime}
};

CustomersConverters = {
    {"id", ToText},
    {"name", ToText},
    {"email", ToText},
    {"country", ToText},
    {"created_at", ToUtcDateTime}
};

PaymentsConverters = {
    {"id", ToText},
    {"invoice_id", ToText},
    {"amount", ToAmount},
    {"paid_at", ToUtcDateTime},
    {"method", ToText}
};

// Omitted fields become null, unknown fields are ignored, and no records still
// gives every declared column.
ToTypedTable = (records as list, tableType as type, converters as list) as table =>
    let
        columns = Record.FieldNames(Type.RecordFields(Type.TableRow(tableType))),
        projected = List.Transform(records, each Record.SelectFields(_, columns, MissingField.UseNull)),
        raw = Table.FromRecords(projected, columns),
        converted = Table.TransformColumns(raw, converters)
    in
        Value.ReplaceType(converted, tableType);

// ---------------------------------------------------------------------------
// Navigation
// ---------------------------------------------------------------------------

NavigationTable = (baseUrl as text, query as record) as table =>
    let
        // The names are literals, not localized: user queries refer to them.
        entities = #table(
            type table [Name = text, Path = text, Schema = record],
            {
                {"Invoices", "invoices", [Type = InvoicesType, Converters = InvoicesConverters]},
                {"Customers", "customers", [Type = CustomersType, Converters = CustomersConverters]},
                {"Payments", "payments", [Type = PaymentsType, Converters = PaymentsConverters]}
            }
        ),
        // Data is lazy: opening the navigator makes no request.
        withData = Table.AddColumn(
            entities,
            "Data",
            (row) =>
                ToTypedTable(
                    GetAllRecords(baseUrl, row[Path], query),
                    row[Schema][Type],
                    row[Schema][Converters]
                ),
            type table
        ),
        withItemKind = Table.AddColumn(withData, "ItemKind", each "Table", type text),
        withItemName = Table.AddColumn(withItemKind, "ItemName", each "Table", type text),
        withIsLeaf = Table.AddColumn(withItemName, "IsLeaf", each true, type logical),
        selected = Table.SelectColumns(withIsLeaf, {"Name", "Data", "ItemKind", "ItemName", "IsLeaf"})
    in
        ToNavigationTable(selected, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf");

// Microsoft's Table.ToNavigationTable helper (DataConnectors samples, MIT).
ToNavigationTable = (
    table as table,
    keyColumns as list,
    nameColumn as text,
    dataColumn as text,
    itemKindColumn as text,
    itemNameColumn as text,
    isLeafColumn as text
) as table =>
    let
        tableType = Value.Type(table),
        newTableType = Type.AddTableKey(tableType, keyColumns, true) meta [
            NavigationTable.NameColumn = nameColumn,
            NavigationTable.DataColumn = dataColumn,
            NavigationTable.ItemKindColumn = itemKindColumn,
            Preview.DelayColumn = itemNameColumn,
            NavigationTable.IsLeafColumn = isLeafColumn
        ]
    in
        Value.ReplaceType(table, newTableType);
