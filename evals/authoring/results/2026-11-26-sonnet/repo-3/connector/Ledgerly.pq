[Version = "1.0.0"]
section Ledgerly;

// Request settings
Ledgerly.PageSize = "200";                       // API maximum; fewest requests against the rate limit
Ledgerly.MaxAttempts = 5;                        // first try plus four retries
Ledgerly.MaxRetryAfterSeconds = 300;             // a longer Retry-After fails instead of blocking a refresh
Ledgerly.RetryStatusCodes = {429, 502, 503, 504};
Ledgerly.HandledStatusCodes = {400, 401, 403, 404, 429, 500, 502, 503, 504};

//
// Data source kind and publishing
//
Ledgerly = [
    // Gateway and credential check: a single call to /me instead of a data load.
    TestConnection = (dataSourcePath) => {"Ledgerly.Contents", dataSourcePath, [TestConnection = true]},
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
    Category = "Other",
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

//
// Entry function
//
[DataSource.Kind = "Ledgerly", Publish = "Ledgerly.Publish"]
shared Ledgerly.Contents = Value.ReplaceType(Ledgerly.ContentsImpl, Ledgerly.ContentsType);

Ledgerly.ContentsType = type function (
    url as (Uri.Type meta [
        Documentation.FieldCaption = Extension.LoadString("UrlCaption"),
        Documentation.FieldDescription = Extension.LoadString("UrlDescription"),
        Documentation.SampleValues = {"https://acme.ledgerly.example/api/v2"}
    ]),
    optional options as (type nullable record meta [
        Documentation.FieldCaption = Extension.LoadString("OptionsCaption"),
        Documentation.FieldDescription = Extension.LoadString("OptionsDescription")
    ])
) as table meta [
    Documentation.Name = Extension.LoadString("FunctionName"),
    Documentation.LongDescription = Extension.LoadString("FunctionDescription")
];

Ledgerly.ContentsImpl = (url as text, optional options as nullable record) as table =>
    let
        baseUrl = Ledgerly.ValidateUrl(url),
        settings = if options = null then [] else options,
        unknown = List.Difference(Record.FieldNames(settings), {"UpdatedSince", "TestConnection"}),
        updatedSince = Ledgerly.FormatUpdatedSince(Record.FieldOrDefault(settings, "UpdatedSince", null))
    in
        if not List.IsEmpty(unknown) then
            error Error.Record(
                "Expression.Error",
                Text.Format(Extension.LoadString("ErrorUnknownOption"), {Text.Combine(unknown, ", ")})
            )
        else if Record.FieldOrDefault(settings, "TestConnection", false) = true then
            Ledgerly.Probe(baseUrl)
        else
            Ledgerly.NavigationTable(baseUrl, updatedSince);

// Only HTTPS, and nothing in the URL that could carry a secret or be lost when paths are appended.
Ledgerly.ValidateUrl = (url as text) as text =>
    let
        parts = try Uri.Parts(url) otherwise null
    in
        if parts = null or parts[Host] = "" then
            error Error.Record("Expression.Error", Extension.LoadString("ErrorInvalidUrl"))
        else if Uri.Parts(url)[Scheme] <> "https" then
            error Error.Record("Expression.Error", Extension.LoadString("ErrorHttpsRequired"))
        else if Record.FieldCount(parts[Query]) > 0
            or parts[Fragment] <> ""
            or parts[UserName] <> ""
            or parts[Password] <> ""
        then
            error Error.Record("Expression.Error", Extension.LoadString("ErrorUrlExtras"))
        else
            Text.TrimEnd(url, "/");

// A value without a time zone is read as UTC, so Desktop and gateway send the same filter.
Ledgerly.FormatUpdatedSince = (value as any) as nullable text =>
    let
        utc =
            if value is datetimezone then DateTimeZone.RemoveZone(DateTimeZone.SwitchZone(value, 0))
            else if value is datetime then value
            else if value is date then DateTime.From(value)
            else error Error.Record("Expression.Error", Extension.LoadString("ErrorUpdatedSince"))
    in
        if value = null then null
        else DateTime.ToText(utc, [Format = "yyyy-MM-dd'T'HH:mm:ss'Z'", Culture = "en-US"]);

Ledgerly.Probe = (baseUrl as text) as table =>
    let
        account = Ledgerly.GetJson(baseUrl, "me", [])
    in
        // Reading the response in the cell condition forces the request.
        if account is record then
            #table({"Connected"}, {{true}})
        else
            error Ledgerly.InvalidResponse("me");

//
// Navigation
//
Ledgerly.NavigationTable = (baseUrl as text, updatedSince as nullable text) as table =>
    let
        load = (path as text, schema as type) => Ledgerly.GetTable(baseUrl, path, schema, updatedSince),
        // Names and keys are part of users' saved queries: never rename or localize them.
        objects = #table(
            {"Name", "Key", "Data", "ItemKind", "ItemName", "IsLeaf"},
            {
                {"Invoices", "invoices", load("invoices", Ledgerly.InvoiceType), "Table", "Table", true},
                {"Customers", "customers", load("customers", Ledgerly.CustomerType), "Table", "Table", true},
                {"Payments", "payments", load("payments", Ledgerly.PaymentType), "Table", "Table", true}
            }
        )
    in
        Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf");

//
// Schemas (datetime columns are UTC)
//
Ledgerly.InvoiceType = type table [
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

Ledgerly.CustomerType = type table [
    id = nullable text,
    name = nullable text,
    email = nullable text,
    country = nullable text,
    created_at = nullable datetime
];

Ledgerly.PaymentType = type table [
    id = nullable text,
    invoice_id = nullable text,
    amount = nullable number,
    paid_at = nullable datetime,
    method = nullable text
];

//
// Paging
//
Ledgerly.GetTable = (baseUrl as text, path as text, schema as type, updatedSince as nullable text) as table =>
    let
        columns = Record.FieldNames(Type.RecordFields(Type.TableRow(schema))),
        pages = List.Generate(
            () => Ledgerly.GetPage(baseUrl, path, schema, updatedSince, null),
            (page) => page <> null,
            (page) =>
                if page[NextCursor] = null then
                    null
                else
                    Ledgerly.GetPage(baseUrl, path, schema, updatedSince, page[NextCursor])
        ),
        pageTables = List.Transform(pages, each [Rows]),
        // Column names come from the schema, not the first page, so an empty page
        // that still has a next cursor does not end or reshape the result.
        combined = Table.ExpandTableColumn(
            Table.FromList(pageTables, Splitter.SplitByNothing(), {"Page"}),
            "Page",
            columns
        )
    in
        Value.ReplaceType(combined, schema);

Ledgerly.GetPage = (
    baseUrl as text,
    path as text,
    schema as type,
    updatedSince as nullable text,
    cursor as nullable text
) as record =>
    let
        query = [limit = Ledgerly.PageSize]
            & (if updatedSince = null then [] else [updated_since = updatedSince])
            & (if cursor = null then [] else [cursor = cursor]),
        json = Ledgerly.GetJson(baseUrl, path, query),
        valid = json is record
            and Record.HasFields(json, {"data", "next_cursor"})
            and json[data] is list,
        next = Text.From(json[next_cursor])
    in
        if not valid then
            error Ledgerly.InvalidResponse(path)
        // A cursor that does not advance would page forever.
        else if next <> null and next = cursor then
            error Error.Record(
                "DataSource.Error",
                Text.Format(Extension.LoadString("ErrorRepeatedCursor"), {path})
            )
        else
            [Rows = Ledgerly.ToTypedTable(json[data], schema), NextCursor = next];

// Missing fields become null, fields the schema does not list are dropped.
Ledgerly.ToTypedTable = (records as list, schema as type) as table =>
    let
        fields = Type.RecordFields(Type.TableRow(schema)),
        columns = Record.FieldNames(fields),
        expanded = Table.ExpandRecordColumn(
            Table.FromList(records, Splitter.SplitByNothing(), {"Record"}, null, ExtraValues.Error),
            "Record",
            columns
        ),
        converted = Table.TransformColumns(
            expanded,
            List.Transform(columns, (name) => {name, Ledgerly.ConverterFor(Record.Field(fields, name)[Type])})
        )
    in
        Value.ReplaceType(converted, schema);

Ledgerly.ConverterFor = (columnType as type) as function =>
    let
        base = Type.NonNullable(columnType)
    in
        if Type.Is(base, type datetime) then Ledgerly.ToUtcDateTime
        else if Type.Is(base, type date) then (value) => if value = null then null else Date.FromText(value, "en-US")
        else if Type.Is(base, type number) then (value) => Number.From(value, "en-US")
        else (value) => Text.From(value, "en-US");

// ISO 8601 text to a UTC datetime. Text without an offset is taken as UTC,
// not as the time zone of the machine that runs the refresh.
Ledgerly.ToUtcDateTime = (value as nullable text) as nullable datetime =>
    if value = null then
        null
    else
        let
            time = Text.AfterDelimiter(value, "T"),
            hasZone = Text.EndsWith(time, "Z") or Text.Contains(time, "+") or Text.Contains(time, "-"),
            zoned = DateTimeZone.FromText(if hasZone then value else value & "Z", "en-US")
        in
            DateTimeZone.RemoveZone(DateTimeZone.SwitchZone(zoned, 0));

//
// HTTP
//
Ledgerly.GetJson = (baseUrl as text, path as text, query as record) as any =>
    let
        body = Ledgerly.Send(baseUrl, path, query, 1),
        json = try Json.Document(body)
    in
        if json[HasError] then error Ledgerly.InvalidResponse(path) else json[Value];

Ledgerly.Send = (baseUrl as text, path as text, query as record, attempt as number) as binary =>
    let
        response = Web.Contents(baseUrl, [
            RelativePath = path,
            Query = query,
            Headers = [
                Accept = "application/json",
                Authorization = "Bearer " & Extension.CurrentCredential()[Key]
            ],
            // The connector sets the Authorization header itself and handles 401.
            ManualCredentials = true,
            ManualStatusHandling = Ledgerly.HandledStatusCodes,
            // A retry must not be answered from the cached failure.
            IsRetry = attempt > 1
        ]),
        body = Binary.Buffer(response),
        metadata = Value.Metadata(response),
        status = Record.FieldOrDefault(metadata, "Response.Status", 200),
        retryAfter = Ledgerly.RetryAfterSeconds(Record.FieldOrDefault(metadata, "Headers", [])),
        // Retry-After when given, otherwise 2, 4, 8, 16 seconds.
        delay = if retryAfter = null then Number.Power(2, attempt) else retryAfter,
        canRetry = List.Contains(Ledgerly.RetryStatusCodes, status)
            and attempt < Ledgerly.MaxAttempts
            and delay <= Ledgerly.MaxRetryAfterSeconds
    in
        if not List.Contains(Ledgerly.HandledStatusCodes, status) then
            body
        else if canRetry then
            Function.InvokeAfter(
                () => @Ledgerly.Send(baseUrl, path, query, attempt + 1),
                #duration(0, 0, 0, delay)
            )
        else
            error Ledgerly.HttpError(status, body, path, attempt, retryAfter);

// Header names are matched without regard to case. Returns null when absent or not a number of seconds.
Ledgerly.RetryAfterSeconds = (headers as record) as nullable number =>
    let
        name = List.First(
            List.Select(Record.FieldNames(headers), each Comparer.OrdinalIgnoreCase(_, "Retry-After") = 0),
            null
        ),
        seconds = if name = null then null else try Number.From(Record.Field(headers, name), "en-US") otherwise null
    in
        if seconds = null or seconds < 0 then null else seconds;

Ledgerly.HttpError = (
    status as number,
    body as binary,
    path as text,
    attempts as number,
    retryAfter as nullable number
) =>
    let
        // The body may not be JSON (for example an HTML page from a proxy).
        apiError = try Json.Document(body)[error] otherwise null,
        code = try Text.From(apiError[code]) otherwise null,
        apiMessage = try Text.From(apiError[message]) otherwise null,
        key =
            if status = 401 then "ErrorUnauthorized"
            else if status = 403 then "ErrorForbidden"
            else if status = 404 then "ErrorNotFound"
            else if status = 429 then "ErrorRateLimited"
            else if List.Contains({502, 503, 504}, status) then "ErrorUnavailable"
            else "ErrorRequestFailed",
        summary = Text.Format(Extension.LoadString(key), {Text.From(status), path, Text.From(attempts)}),
        message = if apiMessage = null then summary else summary & " " & apiMessage
    in
        if status = 401 then
            // Makes Power BI ask for a new key.
            Extension.CredentialError(Credential.AccessDenied, message)
        else
            Error.Record("DataSource.Error", message, [
                Status = status,
                Code = code,
                Path = path,
                Attempts = attempts,
                RetryAfterSeconds = retryAfter
            ]);

Ledgerly.InvalidResponse = (path as text) as record =>
    Error.Record(
        "DataSource.Error",
        Text.Format(Extension.LoadString("ErrorInvalidResponse"), {path}),
        [Path = path]
    );

//
// Helper from Microsoft's samples (Table.ToNavigationTable)
//
Table.ToNavigationTable = (
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
