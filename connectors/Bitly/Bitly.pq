[Version="1.0.0"]
section Bitly;

[DataSource.Kind="Bitly", Publish="Bitly.Publish"]
shared Bitly.Contents = Value.ReplaceType(Bitly.ContentsImpl, Bitly.ContentsType);

Bitly.FetchCollection = (url as text, optional collectionName as text) =>
    let
            __pageSize = 100,
            pickCollection = (response as record) as list =>
                let
                    explicit = if collectionName <> null and Record.HasFields(response, {collectionName})
                               then Record.Field(response, collectionName) else null,
                    reserved = {"next_page", "previous_page", "next", "previous", "nextLink", "@odata.nextLink", "count", "total", "total_count", "page", "per_page", "page_size", "has_more", "hasMore", "meta", "links_meta"},
                    auto     = List.First(
                        List.Select(Record.FieldNames(response), each
                            not List.Contains(reserved, _) and
                            Value.Is(Record.Field(response, _), type list)),
                        null),
                    picked   = if explicit <> null then explicit
                               else if auto <> null then Record.Field(response, auto)
                               else null
                in
                    if picked is list then picked
                    else if picked is record then {picked}
                    else {response},
            __schemas = [
                campaigns = [PathSuffix = "/campaigns", Columns = {[Name = "references", Type = type nullable record], [Name = "guid", Type = Text.Type], [Name = "group_guid", Type = Text.Type], [Name = "created_by", Type = Text.Type], [Name = "name", Type = Text.Type], [Name = "description", Type = Text.Type], [Name = "created", Type = Text.Type], [Name = "modified", Type = Text.Type]}],
                channels = [PathSuffix = "/channels", Columns = {[Name = "name", Type = Text.Type], [Name = "guid", Type = Text.Type], [Name = "created", Type = Text.Type], [Name = "modified", Type = Text.Type], [Name = "group_guid", Type = Text.Type], [Name = "references", Type = type nullable record]}],
                groups = [PathSuffix = "/groups", Columns = {[Name = "references", Type = type nullable record], [Name = "name", Type = Text.Type], [Name = "guid", Type = Text.Type], [Name = "created", Type = Text.Type], [Name = "modified", Type = Text.Type], [Name = "is_active", Type = Logical.Type], [Name = "role", Type = Text.Type], [Name = "organization_guid", Type = Text.Type], [Name = "bsds", Type = type nullable list]}],
                organizations = [PathSuffix = "/organizations", Columns = {[Name = "references", Type = type nullable record], [Name = "name", Type = Text.Type], [Name = "is_active", Type = Logical.Type], [Name = "guid", Type = Text.Type], [Name = "tier", Type = Text.Type], [Name = "tier_family", Type = Text.Type], [Name = "tier_display_name", Type = Text.Type], [Name = "role", Type = Text.Type], [Name = "created", Type = Text.Type], [Name = "modified", Type = Text.Type], [Name = "bsds", Type = type nullable list], [Name = "require_sso", Type = Text.Type], [Name = "require_2fa", Type = Text.Type]}],
                user = [PathSuffix = "/user", Columns = {[Name = "email", Type = Text.Type], [Name = "is_primary", Type = Logical.Type], [Name = "is_verified", Type = Logical.Type]}],
                user_platform_limits = [PathSuffix = "/user/platform_limits", Columns = {[Name = "endpoint", Type = Text.Type], [Name = "methods", Type = type nullable list]}]
            ],
            __pickSchema = (u as text) as list =>
                let
                    matches = List.Select(Record.FieldNames(__schemas), each Text.EndsWith(u, Record.Field(__schemas, _)[PathSuffix])),
                    sorted  = List.Sort(matches, (a, b) => Value.Compare(Text.Length(Record.Field(__schemas, b)[PathSuffix]), Text.Length(Record.Field(__schemas, a)[PathSuffix]))),
                    first   = List.First(sorted, null)
                in
                    if first = null then {} else Record.Field(__schemas, first)[Columns],
            __cols = __pickSchema(url),
            __sizeKnobPaths = {},
            __sendsLimit = (u as text) as logical =>
                List.AnyTrue(List.Transform(__sizeKnobPaths, each Text.EndsWith(u, _))),
            toTable = (items as list) as table =>
                if List.IsEmpty(items) then #table({}, {})
                else ApplySchema(Table.FromRecords(List.Select(items, each _ is record)), __cols),
            response = Json.Document(Web.Contents(url, [Headers = [Authorization = "Bearer " & Extension.CurrentCredential()[Key]]])),
            items    = if response is record then pickCollection(response)
                       else if response is list then response
                       else {},
            result   = toTable(items)
        in
            result;

Bitly.ContentsImpl = (url as text, optional options as record) =>
    let
        __options = options ?? [],
        __testConnection = Record.FieldOrDefault(__options, "TestConnection", false)
    in
        if __testConnection = true then
            Bitly.FetchCollection(url & "/groups")
        else
            let
                    objects = #table(
                        {"Name",      "Key",        "Data",                            "ItemKind", "ItemName", "IsLeaf"},
                        {
                            {"Groups", "groups", Bitly.FetchCollection(url & "/groups"), "Table", "Table", true},
                            {"Organizations", "organizations", Bitly.FetchCollection(url & "/organizations"), "Table", "Table", true},
                            {"User", "user", Bitly.FetchCollection(url & "/user"), "Table", "Table", true},
                            {"Campaigns", "campaigns", Bitly.FetchCollection(url & "/campaigns"), "Table", "Table", true},
                            {"Channels", "channels", Bitly.FetchCollection(url & "/channels"), "Table", "Table", true},
                            {"BSDs", "bsds", Bitly.FetchCollection(url & "/bsds"), "Table", "Table", true},
                            {"PlatformLimits", "platform_limits", Bitly.FetchCollection(url & "/user/platform_limits"), "Table", "Table", true}
                        }),
                    nav = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
                in
                    nav;

Bitly.ContentsType =
    let
        url = (type text) meta [Documentation.FieldCaption = Extension.LoadString("bitly.Contents.Parameter.url.FieldCaption"), Documentation.FieldDescription = Extension.LoadString("bitly.Contents.Parameter.url.FieldDescription"), Documentation.SampleValues = {"https://api-ssl.bitly.com/v4"}],
        options = (type record) meta [Documentation.FieldCaption = Extension.LoadString("bitly.Contents.Parameter.options.FieldCaption"), Documentation.FieldDescription = Extension.LoadString("bitly.Contents.Parameter.options.FieldDescription")],
        t = type function (url as url, optional options as options) as table
    in
        t meta [
            Documentation.Name = Extension.LoadString("bitly.Contents.Function.Name"),
            Documentation.Caption = Extension.LoadString("bitly.Contents.Function.Caption"),
            Documentation.Description = Extension.LoadString("bitly.Contents.Function.Description")
        ];

Bitly = [
    Description = "Bitly OpenAPI connector.",
    Type = "Custom",
    MakeResourcePath = (url) => url,
    ParseResourcePath = (url) => {url},
    TestConnection = (resource) => {"Bitly.Contents", resource, [TestConnection = true]},
    Authentication = [
        Key = [Label = Extension.LoadString("BearerTokenAuthLabel"), KeyLabel = Extension.LoadString("TokenLabel")]
    ],
    Label = "Bitly"
];

Bitly.Publish = [
    Beta = true,
    Category = "Online Services",
    ButtonText = { "Bitly", "Connect to Bitly." },
    SourceImage = Bitly.Icons,
    SourceTypeImage = Bitly.Icons
];

Bitly.Icons = [
    Icon16 = { Extension.Contents("Bitly16.png"), Extension.Contents("Bitly20.png"), Extension.Contents("Bitly24.png"), Extension.Contents("Bitly32.png") },
    Icon32 = { Extension.Contents("Bitly32.png"), Extension.Contents("Bitly40.png"), Extension.Contents("Bitly48.png"), Extension.Contents("Bitly64.png") }
];

ApplySchema = (rows as table, columns as list) as table =>
    let
        present     = List.Select(columns, each List.Contains(Table.ColumnNames(rows), _[Name])),
        isStructured = (column as record) as logical =>
            let columnType = Type.NonNullable(column[Type])
            in columnType = type record or columnType = type list,
        conversions = List.Select(present, each not isStructured(_)),
        structured  = List.Select(present, each isStructured(_)),
        pairs        = List.Transform(conversions, each {_[Name], _[Type]}),
        converted    = if List.IsEmpty(pairs) then rows else Table.TransformColumnTypes(rows, pairs),
        operations   = List.Transform(structured, each {_[Name], (value) => value, _[Type]})
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
