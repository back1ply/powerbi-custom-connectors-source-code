[Version="1.0.1"]
section Bitbucket;

[DataSource.Kind="Bitbucket", Publish="Bitbucket.Publish"]
shared Bitbucket.Contents = Value.ReplaceType(Bitbucket.ContentsImpl, Bitbucket.ContentsType);

Bitbucket.Schemas = [
    getHookEvents = {
    },
    getUser = {
    },
    getUserWorkspaces = {
        [Name = "type", Type = Text.Type],
        [Name = "administrator", Type = Logical.Type],
        [Name = "workspace.type", Type = Text.Type]
    }
];

Bitbucket.Expansions = [
    getHookEvents = {},
    getUser = {},
    getUserWorkspaces = {
        [
            Kind = "Record",
            Name = "workspace",
            Fields = {"type"},
            Names = {"workspace.type"}
        ]
    }
];

Bitbucket.Collections = [
    getHookEvents = [
        Name = "HookEvents",
        Key = "hook_events",
        OperationId = "getHookEvents",
        Path = "/hook_events",
        Fetch = (baseUrl as text) as table =>
            Bitbucket.FetchCollection(
                Uri.Combine(baseUrl & "/", "hook_events"),
                null,
                [
                    CollectionPath = {},
                    Columns = Record.Field(Bitbucket.Schemas, "getHookEvents"),
                    Expansions = Record.Field(Bitbucket.Expansions, "getHookEvents"),
                    Paging = [Style = "none"]
                ]
            )
        ],
    getUser = [
        Name = "User",
        Key = "user",
        OperationId = "getUser",
        Path = "/user",
        Fetch = (baseUrl as text) as table =>
            Bitbucket.FetchCollection(
                Uri.Combine(baseUrl & "/", "user"),
                null,
                [
                    CollectionPath = {},
                    Columns = Record.Field(Bitbucket.Schemas, "getUser"),
                    Expansions = Record.Field(Bitbucket.Expansions, "getUser"),
                    Paging = [Style = "none"]
                ]
            )
        ],
    getUserWorkspaces = [
        Name = "UserWorkspaces",
        Key = "workspaces",
        OperationId = "getUserWorkspaces",
        Path = "/user/workspaces",
        Fetch = (baseUrl as text) as table =>
            Bitbucket.FetchCollection(
                Uri.Combine(baseUrl & "/", "user/workspaces"),
                "values",
                [
                    CollectionPath = {"values"},
                    Columns = Record.Field(Bitbucket.Schemas, "getUserWorkspaces"),
                    Expansions = Record.Field(Bitbucket.Expansions, "getUserWorkspaces"),
                    Paging = [Style = "nextLinkBody", NextField = "next"]
                ]
            )
        ]
];

Bitbucket.BasePath = "/2.0";

Bitbucket.RequestHeaders = [Accept = "application/json", Authorization = "Bearer " & Extension.CurrentCredential()[Key]];

Bitbucket.Request = (url as text, optional query as nullable record) as binary =>
    let
        manualRetryStatusCodes = {500, 502},
        send = (attempt as number) as binary =>
            let
                baseOptions = [
                    ManualStatusHandling = manualRetryStatusCodes,
                    IsRetry = attempt > 0
                ],
                queryOptions = if query = null then baseOptions else Record.AddField(baseOptions, "Query", query),
                requestOptions = if Record.FieldCount(Bitbucket.RequestHeaders) = 0
                    then queryOptions else Record.AddField(queryOptions, "Headers", Bitbucket.RequestHeaders),
                response = Web.Contents(url, requestOptions),
                status = Record.FieldOrDefault(Value.Metadata(response), "Response.Status", 200)
            in
                if List.Contains(manualRetryStatusCodes, status) then
                    if attempt < 2 then
                        Function.InvokeAfter(() => @send(attempt + 1), #duration(0, 0, 0, (attempt + 1) * 1))
                    else error Error.Record(
                        "HttpRequestFailed",
                        "HTTP request failed after retries.",
                        [Status = status])
                else response
    in
        send(0);

Bitbucket.RequestJson = (url as text, optional query as nullable record) as any =>
    Json.Document(Bitbucket.Request(url, query));

Bitbucket.TestConnectionProbe = (baseUrl as text) as table =>
    let
        endpoint = Uri.Combine(baseUrl & "/", "user/workspaces"),
        response = Binary.Buffer(Bitbucket.Request(endpoint, null))
    in
        #table({"Connected"}, {{Binary.Length(response) >= 0}});

Bitbucket.FetchCollection = (url as text, optional collectionName as text, optional options as record) =>
    let
            __options = options ?? [],
            __collectionPath = Record.FieldOrDefault(
                __options,
                "CollectionPath",
                if collectionName = null then {} else Text.Split(collectionName, ".")),
            __cols = Record.FieldOrDefault(__options, "Columns", {}),
            __expansions = Record.FieldOrDefault(__options, "Expansions", {}),
            __paging = Record.FieldOrDefault(__options, "Paging", [Style = "none"]),
            __style = Record.FieldOrDefault(__paging, "Style", "none"),
            __pageSize = Record.FieldOrDefault(__options, "PageSize", 100),
            __readPath = (value as any, path as list) as any =>
                List.Accumulate(
                    path,
                    value,
                    (state, segment) =>
                        if state is record and Record.HasFields(state, {segment})
                        then Record.Field(state, segment)
                        else null),
            pickCollection = (response as any) as list =>
                if response is list then response
                else if response is record then
                    let
                        explicit = if List.IsEmpty(__collectionPath)
                            then null else __readPath(response, __collectionPath),
                        auto = if explicit <> null then null else List.First(
                            List.Select(
                                Record.FieldNames(response),
                                each not List.Contains(
                                    {"next_page", "previous_page", "next", "previous", "nextLink", "@odata.nextLink", "count", "total", "total_count", "page", "per_page", "page_size", "has_more", "hasMore", "meta", "links", "links_meta"},
                                    _) and Value.Is(Record.Field(response, _), type list)),
                            null),
                        picked = if explicit <> null then explicit
                            else if auto <> null then Record.Field(response, auto)
                            else null
                    in
                        if picked is list then picked
                        else if picked is record then {picked}
                        else {response}
                else {},
            toTable = (items as list) as table =>
                let
                    records = List.Select(items, each _ is record),
                    rows = if List.IsEmpty(records)
                        then #table(List.Transform(__cols, each _[Name]), {})
                        else Table.FromRecords(records)
                in
                    ApplySchema(rows, __cols, __expansions),
            getPageNextLinkBody = (nextUrl as nullable text, first as logical) as nullable table =>
                if nextUrl = null or nextUrl = "" then null else
                let
                    limitParam = Record.FieldOrDefault(__paging, "LimitParam", null),
                    query = if first and limitParam <> null
                        then Record.AddField([], limitParam, Text.From(__pageSize))
                        else null,
                    response = Bitbucket.RequestJson(nextUrl, query),
                    nextField = Record.FieldOrDefault(__paging, "NextField", "next_page"),
                    nextLink = __readPath(response, Text.Split(nextField, ".")),
                    page = toTable(pickCollection(response))
                in
                    page meta [Next = nextLink],
            result =
                if __style = "nextLinkBody" then
                    Table.GenerateByPage(
                        (previous) =>
                            let nextUrl = if previous = null then url else Value.Metadata(previous)[Next]
                            in getPageNextLinkBody(nextUrl, previous = null),
                        toTable({}))
                else
                    let
                        limitParam = Record.FieldOrDefault(__paging, "LimitParam", null),
                        query = if limitParam = null then null
                            else Record.AddField([], limitParam, Text.From(__pageSize))
                    in
                        toTable(pickCollection(Bitbucket.RequestJson(url, query)))
        in
            result;

Bitbucket.ContentsImpl = (url as text, optional options as record) =>
    let
        __options = options ?? [],
        __testConnection = Record.FieldOrDefault(__options, "TestConnection", false)
    in
        if __testConnection = true then
            Bitbucket.TestConnectionProbe(NormalizeUrl(url))
        else
            let
                    baseUrl = NormalizeUrl(url),
                    definitions = Record.ToTable(Bitbucket.Collections),
                    withDisplayName = Table.AddColumn(definitions, "DisplayName", each [Value][Name], type text),
                    withKey = Table.AddColumn(withDisplayName, "Key", each [Value][Key], type text),
                    withData = Table.AddColumn(withKey, "Data", each [Value][Fetch](baseUrl), type table),
                    withItemKind = Table.AddColumn(withData, "ItemKind", each "Table", type text),
                    withItemName = Table.AddColumn(withItemKind, "ItemName", each "Table", type text),
                    withIsLeaf = Table.AddColumn(withItemName, "IsLeaf", each true, type logical),
                    selected = Table.SelectColumns(
                        withIsLeaf,
                        {"DisplayName", "Key", "Data", "ItemKind", "ItemName", "IsLeaf"}),
                    objects = Table.RenameColumns(selected, {{"DisplayName", "Name"}}),
                    nav = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
                in
                    nav;

Bitbucket.ContentsType =
    let
        url = (type text) meta [
            Documentation.FieldCaption = Extension.LoadString("bitbucket.Contents.Parameter.url.FieldCaption"),
            Documentation.FieldDescription = Extension.LoadString("bitbucket.Contents.Parameter.url.FieldDescription"),
            Documentation.SampleValues = {"https://api.bitbucket.org/2.0"}
        ],
        options = (type record) meta [
            Documentation.FieldCaption = Extension.LoadString("bitbucket.Contents.Parameter.options.FieldCaption"),
            Documentation.FieldDescription = Extension.LoadString("bitbucket.Contents.Parameter.options.FieldDescription")
        ],
        t = type function (url as url, optional options as options) as table
    in
        t meta [
            Documentation.Name = Extension.LoadString("bitbucket.Contents.Function.Name"),
            Documentation.Caption = Extension.LoadString("bitbucket.Contents.Function.Caption"),
            Documentation.Description = Extension.LoadString("bitbucket.Contents.Function.Description")
        ];

Bitbucket = [
    Type = "Custom",
    MakeResourcePath = (url) => url,
    ParseResourcePath = (url) => {url},
    TestConnection = (resource) => {"Bitbucket.Contents", resource, [TestConnection = true]},
    Authentication = [
        Key = [Label = Extension.LoadString("BearerTokenAuthLabel"), KeyLabel = Extension.LoadString("TokenLabel")]
    ],
    Label = Extension.LoadString("ResourceLabel")
];

Bitbucket.Publish = [
    Beta = true,
    Category = "Online Services",
    ButtonText = { Extension.LoadString("FormulaTitle"), Extension.LoadString("FormulaHelp") },
    SourceImage = Bitbucket.Icons,
    SourceTypeImage = Bitbucket.Icons
];

Bitbucket.Icons = [
    Icon16 = { Extension.Contents("Bitbucket16.png"), Extension.Contents("Bitbucket20.png"), Extension.Contents("Bitbucket24.png"), Extension.Contents("Bitbucket32.png") },
    Icon32 = { Extension.Contents("Bitbucket32.png"), Extension.Contents("Bitbucket40.png"), Extension.Contents("Bitbucket48.png"), Extension.Contents("Bitbucket64.png") }
];

NormalizeUrl = (url as text) as text =>
    let
        parts = Uri.Parts(url),
        scheme = Text.Lower(parts[Scheme]),
        host = Text.Lower(parts[Host]),
        rawPort = parts[Port]?,
        port = if rawPort = null or rawPort = 443 then ""
               else ":" & Text.From(rawPort),
        basePathTemplate = Bitbucket.BasePath,
        templateSegments = List.Select(
            Text.Split(Text.Trim(basePathTemplate, "/"), "/"),
            each _ <> ""),
        callerSegments = List.Select(
            Text.Split(Text.Trim(Record.FieldOrDefault(parts, "Path", ""), "/"), "/"),
            each _ <> ""),
        isVariable = (segment as text) as logical =>
            Text.StartsWith(segment, "{") and Text.EndsWith(segment, "}"),
        hasVariables = List.Contains(List.Transform(templateSegments, isVariable), true),
        pathMatches = List.Count(callerSegments) >= List.Count(templateSegments)
            and List.AllTrue(List.Transform(
                List.Positions(templateSegments),
                (index) => isVariable(templateSegments{index})
                    or templateSegments{index} = callerSegments{index})),
        resolvedSegments =
            if List.IsEmpty(templateSegments) then {}
            else if not hasVariables then templateSegments
            else if pathMatches then List.FirstN(callerSegments, List.Count(templateSegments))
            else error "endpoint path does not match OpenAPI server URL pattern",
        basePath = if List.IsEmpty(resolvedSegments)
            then "" else "/" & Text.Combine(resolvedSegments, "/")
    in
        if scheme <> "https" then error "https scheme required"
        else "https://" & host & port & basePath;

Table.GenerateByPage = (getNextPage as function, optional emptyTable as nullable table) as table =>
    let
        listOfPages = List.Generate(() => getNextPage(null), (lastPage) => lastPage <> null, (lastPage) => getNextPage(lastPage)),
        tableOfPages = Table.FromList(listOfPages, Splitter.SplitByNothing(), {"Column1"}),
        firstRow = tableOfPages{0}?
    in
        if (firstRow = null) then (emptyTable ?? Table.FromRows({}))
        else Value.ReplaceType(
            Table.ExpandTableColumn(tableOfPages, "Column1", Table.ColumnNames(firstRow[Column1])),
            Value.Type(firstRow[Column1]));

ApplySchema = (rows as table, columns as list, expansions as list) as table =>
    let
        normalizeList = (value as any, name as text) as list =>
            if value is list then value
            else if value = null then {null}
            else error Error.Record("OpenAPI projection", "Expected a list while expanding '" & name & "'.", null),
        normalizeRecord = (value as any, fields as list, name as text) as record =>
            if value is record then Record.SelectFields(value, fields, MissingField.UseNull)
            else if value = null then Record.FromList(List.Repeat({null}, List.Count(fields)), fields)
            else error Error.Record("OpenAPI projection", "Expected a record while expanding '" & name & "'.", null),
        applyExpansion = (state as table, expansion as record) as table =>
            if not List.Contains(Table.ColumnNames(state), expansion[Name]) then state
            else if expansion[Kind] = "List" then
                Table.ExpandListColumn(
                    Table.TransformColumns(state, {{expansion[Name], each normalizeList(_, expansion[Name])}}),
                    expansion[Name])
            else
                Table.ExpandRecordColumn(
                    Table.TransformColumns(state, {{expansion[Name], each normalizeRecord(_, expansion[Fields], expansion[Name])}}),
                    expansion[Name],
                    expansion[Fields],
                    expansion[Names]),
        projected = List.Accumulate(expansions, rows, applyExpansion),
        present = List.Select(columns, each List.Contains(Table.ColumnNames(projected), _[Name])),
        isStructured = (column as record) as logical =>
            let columnType = Type.NonNullable(column[Type])
            in columnType = type record or columnType = type list,
        conversions = List.Select(present, each not isStructured(_)),
        structured = List.Select(present, each isStructured(_)),
        pairs = List.Transform(conversions, each {_[Name], _[Type]}),
        converted = if List.IsEmpty(pairs) then projected else Table.TransformColumnTypes(projected, pairs),
        operations = List.Transform(structured, each {_[Name], (value) => value, _[Type]})
    in
        if List.IsEmpty(operations) then converted
        else Table.TransformColumns(converted, operations);

Table.ToNavigationTable = (
    table as table,
    keyColumns as list,
    nameColumn as text,
    dataColumn as text,
    itemKindColumn as text,
    itemNameColumn as text,
    isLeafColumn as text) as table =>
    let
        tableType = Value.Type(table),
        newTableType = Type.AddTableKey(tableType, keyColumns, true) meta [
            NavigationTable.NameColumn     = nameColumn,
            NavigationTable.DataColumn     = dataColumn,
            NavigationTable.ItemKindColumn = itemKindColumn,
            Preview.DelayColumn            = itemNameColumn,
            NavigationTable.IsLeafColumn   = isLeafColumn
        ],
        navigationTable = Value.ReplaceType(table, newTableType)
    in
        navigationTable;
