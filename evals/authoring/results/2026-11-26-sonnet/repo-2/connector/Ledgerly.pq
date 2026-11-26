[Version = "1.0.0"]
section Ledgerly;

// Settings
PageSize = 200;                 // the API maximum
MaxRetries = 5;                 // retries after the first attempt
MaxRetryWaitSeconds = 300;      // a longer Retry-After fails instead of stalling the refresh
RetryStatuses = {429, 502, 503, 504};
// Statuses handled here. Any other error status keeps the Power Query default.
HandledStatuses = {400, 401, 403, 404, 429, 500, 502, 503, 504};

// Data source definition

Ledgerly = [
    // The gateway calls this to check saved credentials: one cheap GET /me.
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
    ButtonText = {Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp")}
];

[DataSource.Kind = "Ledgerly", Publish = "Ledgerly.Publish"]
shared Ledgerly.Contents = Value.ReplaceType(Ledgerly.ContentsImpl, Ledgerly.ContentsType);

// Function documentation

Ledgerly.ContentsType = type function (
    url as (Uri.Type meta [
        Documentation.FieldCaption = Extension.LoadString("UrlCaption"),
        Documentation.FieldDescription = Extension.LoadString("UrlDescription"),
        Documentation.SampleValues = {"https://acme.ledgerly.example/api/v2"}
    ]),
    optional options as (type nullable [
        optional UpdatedSince = (type nullable datetime meta [
            Documentation.FieldCaption = Extension.LoadString("UpdatedSinceCaption"),
            Documentation.FieldDescription = Extension.LoadString("UpdatedSinceDescription")
        ])
    ] meta [
        Documentation.FieldCaption = Extension.LoadString("OptionsCaption")
    ])
) as table meta [
    Documentation.Name = Extension.LoadString("FunctionName"),
    Documentation.LongDescription = Extension.LoadString("FunctionDescription")
];

// Entry point

Ledgerly.ContentsImpl = (url as text, optional options as nullable record) as table =>
    let
        baseUrl = ValidateBaseUrl(url),
        settings = ValidateOptions(options),
        updatedSince = FormatUpdatedSince(Record.FieldOrDefault(settings, "UpdatedSince"))
    in
        if Record.FieldOrDefault(settings, "TestConnection", false) = true then
            ProbeCredentials(baseUrl)
        // Comparing here makes a bad URL fail now, not when a table is first opened.
        else if baseUrl <> null then
            NavigationTable(baseUrl, updatedSince)
        else
            null;

ValidateBaseUrl = (url as text) as text =>
    let
        trimmed = Text.Trim(url),
        parts = try Uri.Parts(trimmed) otherwise null,
        isValid =
            parts <> null
            and Text.StartsWith(trimmed, "https://", Comparer.OrdinalIgnoreCase)
            and parts[Host] <> ""
            and parts[UserName] = ""
            and parts[Password] = ""
            and parts[Fragment] = ""
            and Record.FieldCount(parts[Query]) = 0
    in
        if isValid then
            Text.TrimEnd(trimmed, "/")
        else
            error Error.Record("Expression.Error", Extension.LoadString("ErrorInvalidUrl"));

// TestConnection is internal (set by the gateway test), so it is not in the documented type.
ValidateOptions = (options as nullable record) as record =>
    let
        settings = options ?? [],
        unknown = List.Difference(Record.FieldNames(settings), {"UpdatedSince", "TestConnection"})
    in
        if List.IsEmpty(unknown) then
            settings
        else
            error Error.Record(
                "Expression.Error",
                Text.Format(Extension.LoadString("ErrorUnknownOption"), {Text.Combine(unknown, ", ")})
            );

// A datetime without a zone is taken as UTC, matching the datetime columns returned.
FormatUpdatedSince = (value as any) as nullable text =>
    if value = null then
        null
    else if value is datetimezone then
        FormatUtc(DateTimeZone.RemoveZone(DateTimeZone.SwitchZone(value, 0)))
    else if value is datetime then
        FormatUtc(value)
    else
        error Error.Record("Expression.Error", Extension.LoadString("ErrorUpdatedSinceType"));

FormatUtc = (value as datetime) as text =>
    DateTime.ToText(value, [Format = "yyyy-MM-dd'T'HH:mm:ss'Z'", Culture = "en-US"]);

ProbeCredentials = (baseUrl as text) as table =>
    let
        account = GetJson(baseUrl, "me", [])
    in
        if account is record then
            #table(type table [Connected = logical], {{true}})
        else
            error UnexpectedResponse("me");

// Navigation. Data values are evaluated only when a table is opened.

NavigationTable = (baseUrl as text, updatedSince as nullable text) as table =>
    let
        entity = (path as text, columns as list) => GetTable(baseUrl, path, columns, updatedSince),
        items = #table(
            {"Name", "Key", "Data", "ItemKind", "ItemName", "IsLeaf"},
            {
                {Extension.LoadString("Invoices"), "invoices", entity("invoices", InvoiceColumns), "Table", "Table", true},
                {Extension.LoadString("Customers"), "customers", entity("customers", CustomerColumns), "Table", "Table", true},
                {Extension.LoadString("Payments"), "payments", entity("payments", PaymentColumns), "Table", "Table", true}
            }
        ),
        keyed = Type.AddTableKey(Value.Type(items), {"Key"}, true) meta [
            NavigationTable.NameColumn = "Name",
            NavigationTable.DataColumn = "Data",
            NavigationTable.ItemKindColumn = "ItemKind",
            Preview.DelayColumn = "ItemName",
            NavigationTable.IsLeafColumn = "IsLeaf"
        ]
    in
        Value.ReplaceType(items, keyed);

// Schemas: {column name, type, converter}. Columns the API adds later are ignored,
// so existing reports keep a stable shape until a release declares them.

ToText = (value) => if value = null then null else Text.From(value, "en-US");
ToDecimal = (value) => if value = null then null else Number.From(value, "en-US");
ToDate = (value) => if value = null then null else Date.FromText(value, [Format = "yyyy-MM-dd", Culture = "en-US"]);

// Returns UTC. A value without an offset is already taken as UTC, so that Desktop and
// the service (different local zones) give the same result.
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

InvoiceColumns = {
    {"id", type nullable text, ToText},
    {"number", type nullable text, ToText},
    {"customer_id", type nullable text, ToText},
    {"issued_at", type nullable datetime, ToUtcDateTime},
    {"due_at", type nullable date, ToDate},
    {"total", type nullable Decimal.Type, ToDecimal},
    {"currency", type nullable text, ToText},
    {"status", type nullable text, ToText},
    {"updated_at", type nullable datetime, ToUtcDateTime}
};

CustomerColumns = {
    {"id", type nullable text, ToText},
    {"name", type nullable text, ToText},
    {"email", type nullable text, ToText},
    {"country", type nullable text, ToText},
    {"created_at", type nullable datetime, ToUtcDateTime}
};

PaymentColumns = {
    {"id", type nullable text, ToText},
    {"invoice_id", type nullable text, ToText},
    {"amount", type nullable Decimal.Type, ToDecimal},
    {"paid_at", type nullable datetime, ToUtcDateTime},
    {"method", type nullable text, ToText}
};

// Builds the table once from all records, so an empty list still has every column and type.
GetTable = (baseUrl as text, path as text, columns as list, updatedSince as nullable text) as table =>
    let
        names = List.Transform(columns, each _{0}),
        rows = List.Transform(
            GetAllRecords(baseUrl, path, updatedSince),
            (item) => List.Transform(names, (name) => Record.FieldOrDefault(item, name))
        ),
        raw = Table.FromRows(rows, names)
    in
        Table.TransformColumns(raw, List.Transform(columns, each {_{0}, _{2}, _{1}}));

// Paging. Stops only when next_cursor is null; an empty page with a cursor continues.
// (Not Table.GenerateByPage: the sample helper returns early when the first page is empty.)

GetAllRecords = (baseUrl as text, path as text, updatedSince as nullable text) as list =>
    let
        pages = List.Generate(
            () => GetPage(baseUrl, path, updatedSince, null),
            (page) => page <> null,
            (page) =>
                if page[NextCursor] = null then
                    null
                else
                    GetPage(baseUrl, path, updatedSince, page[NextCursor]),
            (page) => page[Records]
        )
    in
        List.Combine(pages);

GetPage = (baseUrl as text, path as text, updatedSince as nullable text, cursor as nullable text) as record =>
    let
        query =
            [limit = Number.ToText(PageSize)]
            & (if updatedSince = null then [] else [updated_since = updatedSince])
            & (if cursor = null then [] else [cursor = cursor]),
        body = GetJson(baseUrl, path, query),
        isPage = body is record and Record.HasFields(body, "data") and body[data] is list,
        // Query values must be text. A missing next_cursor counts as null.
        rawNext = Record.FieldOrDefault(body, "next_cursor"),
        next = if rawNext = null then null else Text.From(rawNext, "en-US")
    in
        if not isPage then
            error UnexpectedResponse(path)
        // A repeated cursor would page forever.
        else if next <> null and next = cursor then
            error Error.Record("DataSource.Error", Text.Format(Extension.LoadString("ErrorRepeatedCursor"), {path}))
        else
            [Records = body[data], NextCursor = next];

// HTTP. The base URL stays static and the key travels only in the Authorization header.

GetJson = (baseUrl as text, path as text, query as record) as any =>
    let
        body = Send(baseUrl, path, query, 0),
        parsed = try Json.Document(body)
    in
        // Binary.Length runs the request outside the try, so HTTP and credential errors
        // keep their own messages instead of becoming "unexpected response".
        if Binary.Length(body) = 0 or parsed[HasError] then
            error UnexpectedResponse(path)
        else
            parsed[Value];

Send = (baseUrl as text, path as text, query as record, attempt as number) as binary =>
    let
        response = Web.Contents(baseUrl, [
            RelativePath = path,
            Query = query,
            Headers = [
                Authorization = "Bearer " & Extension.CurrentCredential()[Key],
                Accept = "application/json"
            ],
            ManualCredentials = true,
            ManualStatusHandling = HandledStatuses,
            // Skip the engine cache on retries, and always for the credential check.
            IsRetry = attempt > 0 or path = "me"
        ]),
        metadata = Value.Metadata(response),
        status = metadata[Response.Status],
        wait = RetryWaitSeconds(Record.FieldOrDefault(metadata, "Headers", []), attempt)
    in
        if not List.Contains(HandledStatuses, status) then
            Binary.Buffer(response)
        else if List.Contains(RetryStatuses, status) and attempt < MaxRetries and wait <= MaxRetryWaitSeconds then
            Function.InvokeAfter(
                () => @Send(baseUrl, path, query, attempt + 1),
                #duration(0, 0, 0, wait)
            )
        else
            error HttpError(status, Binary.Buffer(response), path);

// Retry-After (seconds) when the server sends it, else 1, 2, 4, 8, 16.
RetryWaitSeconds = (headers as record, attempt as number) as number =>
    let
        name = List.First(
            List.Select(Record.FieldNames(headers), each Comparer.OrdinalIgnoreCase(_, "Retry-After") = 0)
        ),
        seconds = if name = null then null else try Number.From(Record.Field(headers, name), "en-US") otherwise null
    in
        if seconds <> null and seconds >= 0 then seconds else Number.Power(2, attempt);

// Errors

// The body may not be JSON (for example a proxy's HTML 503 page).
HttpError = (status as number, body as binary, path as text) as record =>
    let
        apiError = try Record.ToTable(Json.Document(body)[error]) otherwise null,
        details = if apiError = null then [] else Record.FromList(apiError[Value], apiError[Name]),
        code = Text.From(Record.FieldOrDefault(details, "code") ?? ""),
        serverMessage = Text.From(Record.FieldOrDefault(details, "message") ?? ""),
        hint =
            if status = 401 then Extension.LoadString("Error401")
            else if status = 403 then Extension.LoadString("Error403")
            else if status = 404 then Extension.LoadString("Error404")
            else if status = 429 then Extension.LoadString("Error429")
            else if status >= 500 then Extension.LoadString("Error5xx")
            else Extension.LoadString("ErrorRequest"),
        message = Text.Format(
            Extension.LoadString("ErrorTemplate"),
            {hint, Number.ToText(status), path, code, serverMessage}
        )
    in
        // A credential error makes Power Query ask for a new key.
        if status = 401 then
            Extension.CredentialError(Credential.AccessDenied, message)
        else
            Error.Record("DataSource.Error", message, [Status = status, Code = code, Path = path]);

UnexpectedResponse = (path as text) as record =>
    Error.Record("DataSource.Error", Text.Format(Extension.LoadString("ErrorUnexpectedResponse"), {path}));
