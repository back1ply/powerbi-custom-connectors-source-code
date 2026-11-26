// Bump the version for every release (see README.md, "Versioning").
[Version = "0.9.0"]
section Ledgerly;

PageSize = "200";
MaxAttempts = 5;
// Longest single pause. If the server asks for more, fail instead of retrying early.
MaxWaitSeconds = 120;

//
// Data source definition
//

Ledgerly = [
    // The only required parameter of Ledgerly.Contents is the URL, so the data source path is the URL.
    TestConnection = (dataSourcePath) => {"Ledgerly.Contents", dataSourcePath},
    Authentication = [
        Key = [
            Label = Extension.LoadString("AuthLabel"),
            KeyLabel = Extension.LoadString("AuthKeyLabel")
        ]
    ],
    Label = Extension.LoadString("DataSourceLabel")
];

Ledgerly.Publish = [
    Beta = true,
    Category = "Online Services",
    ButtonText = {Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp")},
    LearnMoreUrl = "https://ledgerly.example/docs/power-bi",
    SupportsDirectQuery = false
];

//
// Public function
//

[DataSource.Kind = "Ledgerly", Publish = "Ledgerly.Publish"]
shared Ledgerly.Contents = Value.ReplaceType(Ledgerly.Navigation, Ledgerly.ContentsType);

Ledgerly.ContentsType = type function (
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
    Documentation.Name = Extension.LoadString("FunctionName"),
    Documentation.LongDescription = Extension.LoadString("FunctionDescription")
];

Ledgerly.Navigation = (url as text, optional updatedSince as nullable datetimezone) as table =>
    let
        baseUrl = ValidateUrl(url),
        // Requested up front so that a bad key or URL fails here. TestConnection relies on this,
        // because the tables below are not read until they are opened.
        account = GetJson(baseUrl, "me", []),
        filter =
            if updatedSince = null then []
            else [updated_since = FormatUtc(updatedSince)],
        objects = #table(
            {"Name", "Key", "Data", "ItemKind", "ItemName", "IsLeaf"},
            {
                {Extension.LoadString("Invoices"), "invoices", GetTable(baseUrl, "invoices", InvoiceType, filter), "Table", "Table", true},
                {Extension.LoadString("Customers"), "customers", GetTable(baseUrl, "customers", CustomerType, filter), "Table", "Table", true},
                {Extension.LoadString("Payments"), "payments", GetTable(baseUrl, "payments", PaymentType, filter), "Table", "Table", true}
            }
        ),
        navigation = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        if account is record then navigation else Fail("ErrorUnexpectedResponse", {"me"}, []);

//
// Schemas: the single definition of each table's columns and types.
// All datetime columns are in UTC.
//

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

CustomerType = type table [
    id = nullable text,
    name = nullable text,
    email = nullable text,
    country = nullable text,
    created_at = nullable datetime
];

PaymentType = type table [
    id = nullable text,
    invoice_id = nullable text,
    amount = nullable Currency.Type,
    paid_at = nullable datetime,
    method = nullable text
];

//
// Tables and paging
//

// Columns come from the schema, never from the data: empty lists and omitted (null) fields
// give the same shape, and fields added to the API later are ignored.
GetTable = (baseUrl as text, path as text, schema as type, filter as record) as table =>
    let
        fields = Type.RecordFields(Type.TableRow(schema)),
        names = Record.FieldNames(fields),
        records = GetAllRecords(baseUrl, path, filter),
        raw = #table(
            names,
            List.Transform(records, (item) => List.Transform(names, (name) => Record.FieldOrDefault(item, name, null)))
        ),
        converted = Table.TransformColumns(
            raw,
            List.Transform(
                names,
                (name) =>
                    let
                        columnType = Record.Field(fields, name)[Type]
                    in
                        {name, ConverterFor(columnType), columnType}
            )
        )
    in
        Value.ReplaceType(converted, schema);

GetAllRecords = (baseUrl as text, path as text, filter as record) as list =>
    let
        getPage = (cursor as nullable text) as record =>
            let
                query = filter & [limit = PageSize] & (if cursor = null then [] else [cursor = cursor]),
                body = GetJson(baseUrl, path, query),
                data = if body is record then Record.FieldOrDefault(body, "data", null) else null,
                next = if body is record then Record.FieldOrDefault(body, "next_cursor", null) else null
            in
                if not (data is list) then Fail("ErrorUnexpectedResponse", {path}, [])
                // A cursor that does not advance would loop forever.
                else if next <> null and next = cursor then Fail("ErrorCursorRepeated", {path}, [])
                else [data = data, next = next],
        pages = List.Generate(
            () => getPage(null),
            (page) => page <> null,
            (page) => if page[next] = null then null else getPage(page[next]),
            (page) => page[data]
        )
    in
        List.Combine(pages);

//
// Type conversion (culture-independent)
//

ConverterFor = (columnType as type) as function =>
    let
        baseType = Type.NonNullable(columnType),
        convert =
            if Type.Is(baseType, type datetime) then ToUtcDateTime
            else if Type.Is(baseType, type date) then (value) => Date.FromText(value, [Format = "yyyy-MM-dd", Culture = "en-US"])
            else if Type.Is(baseType, type number) then (value) => Number.From(value, "en-US")
            else (value) => Text.From(value, "en-US")
    in
        (value) => if value = null then null else convert(value);

// A value without an offset is taken as UTC, not as the local time of the refreshing machine.
ToUtcDateTime = (value as text) as datetime =>
    let
        time = Text.AfterDelimiter(value, "T"),
        hasZone = Text.EndsWith(time, "Z") or Text.Contains(time, "+") or Text.Contains(time, "-"),
        zoned = DateTimeZone.FromText(if hasZone then value else value & "Z", "en-US")
    in
        DateTimeZone.RemoveZone(DateTimeZone.SwitchZone(zoned, 0));

FormatUtc = (value as datetimezone) as text =>
    DateTimeZone.ToText(
        DateTimeZone.SwitchZone(value, 0),
        [Format = "yyyy-MM-dd'T'HH:mm:ss.fffffff'Z'", Culture = "en-US"]
    );

//
// HTTP
//

ValidateUrl = (url as text) as text =>
    let
        trimmed = Text.TrimEnd(Text.Trim(url), "/"),
        parts = try Uri.Parts(trimmed),
        valid =
            // Uri.Parts can supply a scheme of its own, so check what the user typed.
            Text.StartsWith(trimmed, "https://", Comparer.OrdinalIgnoreCase)
            and not parts[HasError]
            and parts[Value][Host] <> ""
            and parts[Value][UserName] = ""
            and parts[Value][Password] = ""
            and Record.FieldCount(parts[Value][Query]) = 0
            and parts[Value][Fragment] = ""
    in
        if valid then trimmed else Fail("ErrorInvalidUrl", {}, []);

// GET <baseUrl>/<path> and parse the JSON, retrying on 429 and 503.
GetJson = (baseUrl as text, path as text, query as record) as any =>
    let
        send = (attempt as number) as any =>
            let
                response = Web.Contents(baseUrl, [
                    RelativePath = path,
                    Query = query,
                    Headers = [
                        Authorization = "Bearer " & Extension.CurrentCredential()[Key],
                        Accept = "application/json"
                    ],
                    // The header above is set by this code, not by the engine's own credential handling.
                    ManualCredentials = true,
                    ManualStatusHandling = {400, 401, 403, 404, 408, 429, 500, 502, 503, 504},
                    // Without this a retry could be answered from the cache.
                    IsRetry = attempt > 1
                ]),
                body = Binary.Buffer(response),
                metadata = Value.Metadata(response),
                status = metadata[Response.Status],
                retryable = status = 429 or status = 503,
                wait = if retryable then RetryDelay(metadata, attempt) else 0
            in
                if retryable and attempt < MaxAttempts and wait <= MaxWaitSeconds then
                    Function.InvokeAfter(() => @send(attempt + 1), #duration(0, 0, 0, wait))
                else if status >= 400 then
                    HttpError(status, path, body)
                else
                    let
                        parsed = try Json.Document(body)
                    in
                        if parsed[HasError] then Fail("ErrorUnexpectedResponse", {path}, [Status = status])
                        else parsed[Value]
    in
        send(1);

// Seconds to wait: the Retry-After header if usable, otherwise 2, 4, 8, 16.
RetryDelay = (metadata as record, attempt as number) as number =>
    let
        headers = Record.FieldOrDefault(metadata, "Headers", []),
        names = List.Select(
            Record.FieldNames(headers),
            each Comparer.Equals(Comparer.OrdinalIgnoreCase, _, "Retry-After")
        ),
        seconds =
            if List.IsEmpty(names) then null
            else try Number.FromText(Record.Field(headers, names{0}), "en-US") otherwise null
    in
        if seconds <> null and seconds >= 0 then seconds else Number.Power(2, attempt);

HttpError = (status as number, path as text, body as binary) =>
    let
        apiError = try Json.Document(body)[error] otherwise null,
        code = try Text.From(apiError[code]) otherwise null,
        message = try Text.From(apiError[message]) otherwise null,
        key =
            if status = 401 then "Error401"
            else if status = 403 then "Error403"
            else if status = 404 then "Error404"
            else if status = 429 then "Error429"
            else if status = 503 then "Error503"
            else "ErrorHttp",
        summary = Text.Format(Extension.LoadString(key), {path, Text.From(status)}),
        full =
            if message = null then summary
            else summary & " " & Text.Format(Extension.LoadString("ErrorServerSaid"), {message, code ?? Text.From(status)})
    in
        if status = 401 then
            // Makes Power BI ask for the credential again.
            error Extension.CredentialError(Credential.AccessDenied, full)
        else
            error Error.Record("DataSource.Error", full, [Status = status, Code = code, Path = path]);

Fail = (resourceKey as text, arguments as list, detail as record) =>
    error Error.Record("DataSource.Error", Text.Format(Extension.LoadString(resourceKey), arguments), detail);

//
// Navigation table helper (from the Power Query SDK documentation)
//

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
        tableType = Value.Type(objects),
        newTableType = Type.AddTableKey(tableType, keyColumns, true) meta [
            NavigationTable.NameColumn = nameColumn,
            NavigationTable.DataColumn = dataColumn,
            NavigationTable.ItemKindColumn = itemKindColumn,
            NavigationTable.ItemNameColumn = itemNameColumn,
            Preview.DelayColumn = itemNameColumn,
            NavigationTable.IsLeafColumn = isLeafColumn
        ]
    in
        Value.ReplaceType(objects, newTableType);
