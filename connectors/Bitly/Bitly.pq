[Version="1.0.1"]
section Bitly;

[DataSource.Kind="Bitly", Publish="Bitly.Publish"]
shared Bitly.Contents = Value.ReplaceType(Bitly.ContentsImpl, Bitly.ContentsType);

Bitly.Schemas = [
    getGroups = {
        [Name = "references", Type = type nullable record],
        [Name = "name", Type = Text.Type],
        [Name = "guid", Type = Text.Type],
        [Name = "created", Type = Text.Type],
        [Name = "modified", Type = Text.Type],
        [Name = "is_active", Type = Logical.Type],
        [Name = "role", Type = Text.Type],
        [Name = "organization_guid", Type = Text.Type],
        [Name = "bsds", Type = Text.Type]
    },
    getOrganizations = {
        [Name = "references", Type = type nullable record],
        [Name = "name", Type = Text.Type],
        [Name = "is_active", Type = Logical.Type],
        [Name = "guid", Type = Text.Type],
        [Name = "tier", Type = Text.Type],
        [Name = "tier_family", Type = Text.Type],
        [Name = "tier_display_name", Type = Text.Type],
        [Name = "role", Type = Text.Type],
        [Name = "created", Type = Text.Type],
        [Name = "modified", Type = Text.Type],
        [Name = "bsds", Type = Text.Type],
        [Name = "require_sso", Type = Text.Type],
        [Name = "require_2fa", Type = Text.Type]
    },
    getUser = {
        [Name = "email", Type = Text.Type],
        [Name = "is_primary", Type = Logical.Type],
        [Name = "is_verified", Type = Logical.Type]
    },
    getCampaigns = {
        [Name = "references", Type = type nullable record],
        [Name = "guid", Type = Text.Type],
        [Name = "group_guid", Type = Text.Type],
        [Name = "created_by", Type = Text.Type],
        [Name = "name", Type = Text.Type],
        [Name = "description", Type = Text.Type],
        [Name = "created", Type = Text.Type],
        [Name = "modified", Type = Text.Type]
    },
    getChannels = {
        [Name = "name", Type = Text.Type],
        [Name = "guid", Type = Text.Type],
        [Name = "created", Type = Text.Type],
        [Name = "modified", Type = Text.Type],
        [Name = "group_guid", Type = Text.Type],
        [Name = "references", Type = type nullable record]
    },
    getBSDs = {
    },
    getPlatformLimits = {
        [Name = "endpoint", Type = Text.Type],
        [Name = "methods.name", Type = Text.Type],
        [Name = "methods.limit", Type = Int64.Type],
        [Name = "methods.count", Type = Int64.Type]
    }
];

Bitly.Expansions = [
    getGroups = {
        [
            Kind = "List",
            Name = "bsds"
        ]
    },
    getOrganizations = {
        [
            Kind = "List",
            Name = "bsds"
        ]
    },
    getUser = {},
    getCampaigns = {},
    getChannels = {},
    getBSDs = {},
    getPlatformLimits = {
        [
            Kind = "List",
            Name = "methods"
        ],
        [
            Kind = "Record",
            Name = "methods",
            Fields = {"name", "limit", "count"},
            Names = {"methods.name", "methods.limit", "methods.count"}
        ]
    }
];

Bitly.Collections = [
    getGroups = [
        Name = "Groups",
        Key = "groups",
        OperationId = "getGroups",
        Path = "/groups",
        Fetch = (baseUrl as text) as table =>
            Bitly.FetchCollection(
                Uri.Combine(baseUrl & "/", "groups"),
                "groups",
                [
                    CollectionPath = {"groups"},
                    Columns = Record.Field(Bitly.Schemas, "getGroups"),
                    Expansions = Record.Field(Bitly.Expansions, "getGroups"),
                    Paging = [Style = "none"]
                ]
            )
        ],
    getOrganizations = [
        Name = "Organizations",
        Key = "organizations",
        OperationId = "getOrganizations",
        Path = "/organizations",
        Fetch = (baseUrl as text) as table =>
            Bitly.FetchCollection(
                Uri.Combine(baseUrl & "/", "organizations"),
                "organizations",
                [
                    CollectionPath = {"organizations"},
                    Columns = Record.Field(Bitly.Schemas, "getOrganizations"),
                    Expansions = Record.Field(Bitly.Expansions, "getOrganizations"),
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
            Bitly.FetchCollection(
                Uri.Combine(baseUrl & "/", "user"),
                "emails",
                [
                    CollectionPath = {"emails"},
                    Columns = Record.Field(Bitly.Schemas, "getUser"),
                    Expansions = Record.Field(Bitly.Expansions, "getUser"),
                    Paging = [Style = "none"]
                ]
            )
        ],
    getCampaigns = [
        Name = "Campaigns",
        Key = "campaigns",
        OperationId = "getCampaigns",
        Path = "/campaigns",
        Fetch = (baseUrl as text) as table =>
            Bitly.FetchCollection(
                Uri.Combine(baseUrl & "/", "campaigns"),
                "campaigns",
                [
                    CollectionPath = {"campaigns"},
                    Columns = Record.Field(Bitly.Schemas, "getCampaigns"),
                    Expansions = Record.Field(Bitly.Expansions, "getCampaigns"),
                    Paging = [Style = "none"]
                ]
            )
        ],
    getChannels = [
        Name = "Channels",
        Key = "channels",
        OperationId = "getChannels",
        Path = "/channels",
        Fetch = (baseUrl as text) as table =>
            Bitly.FetchCollection(
                Uri.Combine(baseUrl & "/", "channels"),
                "channels",
                [
                    CollectionPath = {"channels"},
                    Columns = Record.Field(Bitly.Schemas, "getChannels"),
                    Expansions = Record.Field(Bitly.Expansions, "getChannels"),
                    Paging = [Style = "none"]
                ]
            )
        ],
    getBSDs = [
        Name = "BSDs",
        Key = "bsds",
        OperationId = "getBSDs",
        Path = "/bsds",
        Fetch = (baseUrl as text) as table =>
            Bitly.FetchCollection(
                Uri.Combine(baseUrl & "/", "bsds"),
                "bsds",
                [
                    CollectionPath = {"bsds"},
                    Columns = Record.Field(Bitly.Schemas, "getBSDs"),
                    Expansions = Record.Field(Bitly.Expansions, "getBSDs"),
                    Paging = [Style = "none"]
                ]
            )
        ],
    getPlatformLimits = [
        Name = "PlatformLimits",
        Key = "platform_limits",
        OperationId = "getPlatformLimits",
        Path = "/user/platform_limits",
        Fetch = (baseUrl as text) as table =>
            Bitly.FetchCollection(
                Uri.Combine(baseUrl & "/", "user/platform_limits"),
                "platform_limits",
                [
                    CollectionPath = {"platform_limits"},
                    Columns = Record.Field(Bitly.Schemas, "getPlatformLimits"),
                    Expansions = Record.Field(Bitly.Expansions, "getPlatformLimits"),
                    Paging = [Style = "none"]
                ]
            )
        ]
];

Bitly.BasePath = "/v4";

Bitly.RequestHeaders = [Accept = "application/json", Authorization = "Bearer " & Extension.CurrentCredential()[Key]];

Bitly.Request = (url as text, optional query as nullable record) as binary =>
    let
        manualRetryStatusCodes = {500, 502},
        send = (attempt as number) as binary =>
            let
                baseOptions = [
                    ManualStatusHandling = manualRetryStatusCodes,
                    IsRetry = attempt > 0
                ],
                queryOptions = if query = null then baseOptions else Record.AddField(baseOptions, "Query", query),
                requestOptions = if Record.FieldCount(Bitly.RequestHeaders) = 0
                    then queryOptions else Record.AddField(queryOptions, "Headers", Bitly.RequestHeaders),
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

Bitly.RequestJson = (url as text, optional query as nullable record) as any =>
    Json.Document(Bitly.Request(url, query));

Bitly.TestConnectionProbe = (baseUrl as text) as table =>
    let
        endpoint = Uri.Combine(baseUrl & "/", "groups"),
        response = Binary.Buffer(Bitly.Request(endpoint, null))
    in
        #table({"Connected"}, {{Binary.Length(response) >= 0}});

Bitly.FetchCollection = (url as text, optional collectionName as text, optional options as record) =>
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
            result =
                    let
                        limitParam = Record.FieldOrDefault(__paging, "LimitParam", null),
                        query = if limitParam = null then null
                            else Record.AddField([], limitParam, Text.From(__pageSize))
                    in
                        toTable(pickCollection(Bitly.RequestJson(url, query)))
        in
            result;

Bitly.ContentsImpl = (url as text, optional options as record) =>
    let
        __options = options ?? [],
        __testConnection = Record.FieldOrDefault(__options, "TestConnection", false)
    in
        if __testConnection = true then
            Bitly.TestConnectionProbe(NormalizeUrl(url))
        else
            let
                    baseUrl = NormalizeUrl(url),
                    definitions = Record.ToTable(Bitly.Collections),
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

Bitly.ContentsType =
    let
        url = (type text) meta [
            Documentation.FieldCaption = Extension.LoadString("bitly.Contents.Parameter.url.FieldCaption"),
            Documentation.FieldDescription = Extension.LoadString("bitly.Contents.Parameter.url.FieldDescription"),
            Documentation.SampleValues = {"https://api-ssl.bitly.com/v4"}
        ],
        options = (type record) meta [
            Documentation.FieldCaption = Extension.LoadString("bitly.Contents.Parameter.options.FieldCaption"),
            Documentation.FieldDescription = Extension.LoadString("bitly.Contents.Parameter.options.FieldDescription")
        ],
        t = type function (url as url, optional options as options) as table
    in
        t meta [
            Documentation.Name = Extension.LoadString("bitly.Contents.Function.Name"),
            Documentation.Caption = Extension.LoadString("bitly.Contents.Function.Caption"),
            Documentation.Description = Extension.LoadString("bitly.Contents.Function.Description")
        ];

Bitly = [
    Type = "Custom",
    MakeResourcePath = (url) => url,
    ParseResourcePath = (url) => {url},
    TestConnection = (resource) => {"Bitly.Contents", resource, [TestConnection = true]},
    Authentication = [
        Key = [Label = Extension.LoadString("BearerTokenAuthLabel"), KeyLabel = Extension.LoadString("TokenLabel")]
    ],
    Label = Extension.LoadString("ResourceLabel")
];

Bitly.Publish = [
    Beta = true,
    Category = "Online Services",
    ButtonText = { Extension.LoadString("FormulaTitle"), Extension.LoadString("FormulaHelp") },
    SourceImage = Bitly.Icons,
    SourceTypeImage = Bitly.Icons
];

Bitly.Icons = [
    Icon16 = { Extension.Contents("Bitly16.png"), Extension.Contents("Bitly20.png"), Extension.Contents("Bitly24.png"), Extension.Contents("Bitly32.png") },
    Icon32 = { Extension.Contents("Bitly32.png"), Extension.Contents("Bitly40.png"), Extension.Contents("Bitly48.png"), Extension.Contents("Bitly64.png") }
];

NormalizeUrl = (url as text) as text =>
    let
        parts = Uri.Parts(url),
        scheme = Text.Lower(parts[Scheme]),
        host = Text.Lower(parts[Host]),
        rawPort = parts[Port]?,
        port = if rawPort = null or rawPort = 443 then ""
               else ":" & Text.From(rawPort),
        basePathTemplate = Bitly.BasePath,
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
