[Version="1.0.0"]
section Attio;

[DataSource.Kind="Attio", Publish="Attio.Publish"]
shared Attio.Contents = Value.ReplaceType(Attio.ContentsImpl, Attio.ContentsType);

Attio.FetchCollection = (url as text, optional collectionName as text) =>
    let
            __pageSize = 50,
            pickCollection = (response as record) as list =>
                let
                    explicit = if collectionName <> null and Record.HasFields(response, {collectionName})
                               then Record.Field(response, collectionName) else null,
                    reserved = {"next_page", "previous_page", "next", "previous", "nextLink", "@odata.nextLink", "count", "total", "total_count", "page", "per_page", "page_size", "has_more", "hasMore", "meta", "links", "links_meta"},
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
                v2_lists = [PathSuffix = "/v2/lists", Columns = {[Name = "id", Type = type nullable record], [Name = "api_slug", Type = Text.Type], [Name = "name", Type = Text.Type], [Name = "parent_object", Type = type nullable list], [Name = "workspace_access", Type = Text.Type], [Name = "workspace_member_access", Type = type nullable list], [Name = "created_by_actor", Type = type nullable record], [Name = "created_at", Type = Text.Type]}],
                v2_meetings = [PathSuffix = "/v2/meetings", Columns = {[Name = "id", Type = type nullable record], [Name = "title", Type = Text.Type], [Name = "description", Type = Text.Type], [Name = "is_all_day", Type = Logical.Type], [Name = "participants", Type = type nullable list], [Name = "linked_records", Type = type nullable list], [Name = "created_at", Type = Text.Type], [Name = "created_by_actor", Type = type nullable record]}],
                v2_notes = [PathSuffix = "/v2/notes", Columns = {[Name = "id", Type = type nullable record], [Name = "parent_object", Type = Text.Type], [Name = "parent_record_id", Type = Text.Type], [Name = "title", Type = Text.Type], [Name = "meeting_id", Type = Text.Type], [Name = "content_plaintext", Type = Text.Type], [Name = "content_markdown", Type = Text.Type], [Name = "tags", Type = type nullable list], [Name = "created_by_actor", Type = type nullable record], [Name = "created_at", Type = Text.Type]}],
                v2_objects = [PathSuffix = "/v2/objects", Columns = {[Name = "id", Type = type nullable record], [Name = "api_slug", Type = Text.Type], [Name = "singular_noun", Type = Text.Type], [Name = "plural_noun", Type = Text.Type], [Name = "created_at", Type = Text.Type]}],
                v2_tasks = [PathSuffix = "/v2/tasks", Columns = {[Name = "id", Type = type nullable record], [Name = "content_plaintext", Type = Text.Type], [Name = "deadline_at", Type = Text.Type], [Name = "is_completed", Type = Logical.Type], [Name = "completed_at", Type = Text.Type], [Name = "linked_records", Type = type nullable list], [Name = "assignees", Type = type nullable list], [Name = "created_by_actor", Type = type nullable record], [Name = "created_at", Type = Text.Type]}],
                v2_threads = [PathSuffix = "/v2/threads", Columns = {[Name = "id", Type = type nullable record], [Name = "comments", Type = type nullable list], [Name = "created_at", Type = Text.Type]}],
                v2_webhooks = [PathSuffix = "/v2/webhooks", Columns = {[Name = "target_url", Type = Text.Type], [Name = "subscriptions", Type = type nullable list], [Name = "id", Type = type nullable record], [Name = "status", Type = Text.Type], [Name = "created_at", Type = Text.Type]}],
                v2_workspace_members = [PathSuffix = "/v2/workspace_members", Columns = {[Name = "id", Type = type nullable record], [Name = "first_name", Type = Text.Type], [Name = "last_name", Type = Text.Type], [Name = "avatar_url", Type = Text.Type], [Name = "email_address", Type = Text.Type], [Name = "created_at", Type = Text.Type], [Name = "access_level", Type = Text.Type]}]
            ],
            __pickSchema = (u as text) as list =>
                let
                    matches = List.Select(Record.FieldNames(__schemas), each Text.EndsWith(u, Record.Field(__schemas, _)[PathSuffix])),
                    sorted  = List.Sort(matches, (a, b) => Value.Compare(Text.Length(Record.Field(__schemas, b)[PathSuffix]), Text.Length(Record.Field(__schemas, a)[PathSuffix]))),
                    first   = List.First(sorted, null)
                in
                    if first = null then {} else Record.Field(__schemas, first)[Columns],
            __cols = __pickSchema(url),
            __sizeKnobPaths = {"/v2/files", "/v2/lists/{list}/entries/{entry_id}/attributes/{attribute}/values", "/v2/lists/{list}/views", "/v2/meetings", "/v2/meetings/{meeting_id}/call_recordings", "/v2/notes", "/v2/objects/{object}/records/{record_id}/attributes/{attribute}/values", "/v2/objects/{object}/records/{record_id}/entries", "/v2/objects/{object}/views", "/v2/tasks", "/v2/threads", "/v2/webhooks", "/v2/{target}/{identifier}/attributes"},
            __sendsLimit = (u as text) as logical =>
                List.AnyTrue(List.Transform(__sizeKnobPaths, each Text.EndsWith(u, _))),
            toTable = (items as list) as table =>
                if List.IsEmpty(items) then #table({}, {})
                else ApplySchema(Table.FromRecords(List.Select(items, each _ is record)), __cols),
            __pagingByPath = [
                v2_files = [PathSuffix = "/v2/files", Style = "cursor", CursorParam = "cursor", CursorField = "nextCursor", CursorLimitParam = "limit"],
                v2_lists_list_entries_entry_id_attributes_attribute_values = [PathSuffix = "/v2/lists/{list}/entries/{entry_id}/attributes/{attribute}/values", Style = "offsetLimit", OffsetParam = "offset", LimitParam = "limit"],
                v2_lists_list_views = [PathSuffix = "/v2/lists/{list}/views", Style = "cursor", CursorParam = "cursor", CursorField = "nextCursor", CursorLimitParam = "limit"],
                v2_meetings = [PathSuffix = "/v2/meetings", Style = "cursor", CursorParam = "cursor", CursorField = "nextCursor", CursorLimitParam = "limit"],
                v2_meetings_meeting_id_call_recordings = [PathSuffix = "/v2/meetings/{meeting_id}/call_recordings", Style = "cursor", CursorParam = "cursor", CursorField = "nextCursor", CursorLimitParam = "limit"],
                v2_meetings_meeting_id_call_recordings_call_recording_id_transcript = [PathSuffix = "/v2/meetings/{meeting_id}/call_recordings/{call_recording_id}/transcript", Style = "cursor", CursorParam = "cursor", CursorField = "nextCursor"],
                v2_notes = [PathSuffix = "/v2/notes", Style = "offsetLimit", OffsetParam = "offset", LimitParam = "limit"],
                v2_objects_object_records_record_id_attributes_attribute_values = [PathSuffix = "/v2/objects/{object}/records/{record_id}/attributes/{attribute}/values", Style = "offsetLimit", OffsetParam = "offset", LimitParam = "limit"],
                v2_objects_object_records_record_id_entries = [PathSuffix = "/v2/objects/{object}/records/{record_id}/entries", Style = "offsetLimit", OffsetParam = "offset", LimitParam = "limit"],
                v2_objects_object_views = [PathSuffix = "/v2/objects/{object}/views", Style = "cursor", CursorParam = "cursor", CursorField = "nextCursor", CursorLimitParam = "limit"],
                v2_tasks = [PathSuffix = "/v2/tasks", Style = "offsetLimit", OffsetParam = "offset", LimitParam = "limit"],
                v2_threads = [PathSuffix = "/v2/threads", Style = "offsetLimit", OffsetParam = "offset", LimitParam = "limit"],
                v2_webhooks = [PathSuffix = "/v2/webhooks", Style = "offsetLimit", OffsetParam = "offset", LimitParam = "limit"],
                v2_target_identifier_attributes = [PathSuffix = "/v2/{target}/{identifier}/attributes", Style = "offsetLimit", OffsetParam = "offset", LimitParam = "limit"]
            ],
            __pickPaging = (u as text) as record =>
                let
                    matches = List.Select(Record.FieldNames(__pagingByPath), each Text.EndsWith(u, Record.Field(__pagingByPath, _)[PathSuffix])),
                    sorted  = List.Sort(matches, (a, b) => Value.Compare(Text.Length(Record.Field(__pagingByPath, b)[PathSuffix]), Text.Length(Record.Field(__pagingByPath, a)[PathSuffix]))),
                    first   = List.First(sorted, null)
                in
                    if first = null then [Style = "none"] else Record.Field(__pagingByPath, first),
            __paging = __pickPaging(url),
            __style  = __paging[Style],
            __readPath = (rec, path) =>
                if path = null then null else
                List.Accumulate(Text.Split(path, "."), rec, (st, seg) =>
                    if st is record and Record.HasFields(st, {seg}) then Record.Field(st, seg) else null),
            getPageCursor = (cursor as nullable text) as nullable table =>
                let
                    __lim    = __paging[CursorLimitParam]?,
                    base     = if __lim <> null and __sendsLimit(url) then Record.AddField([], __lim, Text.From(__pageSize)) else [],
                    query    = if cursor = null then base else Record.AddField(base, __paging[CursorParam], cursor),
                    response = Json.Document(Web.Contents(url, [Query = query, Headers = [Authorization = "Bearer " & Extension.CurrentCredential()[Key]]])),
                    rawCursor = __readPath(response, __paging[CursorField]),
                    __hm     = __paging[HasMoreField]?,
                    hasMore  = if __hm = null then null else __readPath(response, __hm),
                    nextCursor = if hasMore = false or rawCursor = null or (rawCursor is text and Text.Trim(rawCursor) = "") then null else rawCursor,
                    items    = if response is record then pickCollection(response)
                               else if response is list then response
                               else {},
                    asTable  = toTable(items)
                in
                    asTable meta [NextCursor = nextCursor],
            getPageOffset = (offset as number) as nullable table =>
                let
                    query    = if __sendsLimit(url) then Record.AddField(Record.AddField([], __paging[OffsetParam], Text.From(offset)), __paging[LimitParam], Text.From(__pageSize)) else [],
                    response = Json.Document(Web.Contents(url, [Query = query, Headers = [Authorization = "Bearer " & Extension.CurrentCredential()[Key]]])),
                    items    = if response is record then pickCollection(response)
                               else if response is list then response
                               else {},
                    asTable  = toTable(items),
                    rowCount = Table.RowCount(asTable),
                    nextOffset = if rowCount < __pageSize then null else offset + __pageSize
                in
                    if rowCount = 0 then null else asTable meta [NextOffset = nextOffset],
            result =
                if __style = "cursor" then Table.GenerateByPage((previous) => if previous = null then getPageCursor(null) else let nc = Value.Metadata(previous)[NextCursor] in if nc = null then null else getPageCursor(nc))
                else if __style = "offsetLimit" then Table.GenerateByPage((previous) => let off = if previous = null then 0 else Value.Metadata(previous)[NextOffset] in if off = null then null else getPageOffset(off))
                else
                    let
                        response = Json.Document(Web.Contents(url, [Headers = [Authorization = "Bearer " & Extension.CurrentCredential()[Key]]])),
                        items    = if response is record then pickCollection(response)
                                   else if response is list then response
                                   else {},
                        r        = toTable(items)
                    in
                        r
        in
            result;

Attio.ContentsImpl = (url as text, optional options as record) =>
    let
        __options = options ?? [],
        __testConnection = Record.FieldOrDefault(__options, "TestConnection", false)
    in
        if __testConnection = true then
            Attio.FetchCollection(url & "/v2/objects")
        else
            let
                    objects = #table(
                        {"Name",      "Key",        "Data",                            "ItemKind", "ItemName", "IsLeaf"},
                        {
                            {"Objects", "objects", Attio.FetchCollection(url & "/v2/objects"), "Table", "Table", true},
                            {"Lists", "lists", Attio.FetchCollection(url & "/v2/lists"), "Table", "Table", true},
                            {"WorkspaceMembers", "workspace_members", Attio.FetchCollection(url & "/v2/workspace_members"), "Table", "Table", true},
                            {"Notes", "notes", Attio.FetchCollection(url & "/v2/notes"), "Table", "Table", true},
                            {"Tasks", "tasks", Attio.FetchCollection(url & "/v2/tasks"), "Table", "Table", true},
                            {"Threads", "threads", Attio.FetchCollection(url & "/v2/threads"), "Table", "Table", true},
                            {"Meetings", "meetings", Attio.FetchCollection(url & "/v2/meetings"), "Table", "Table", true},
                            {"Webhooks", "webhooks", Attio.FetchCollection(url & "/v2/webhooks"), "Table", "Table", true},
                            {"Self", "self", Attio.FetchCollection(url & "/v2/self"), "Table", "Table", true}
                        }),
                    nav = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
                in
                    nav;

Attio.ContentsType =
    let
        url = (type text) meta [Documentation.FieldCaption = Extension.LoadString("attio.Contents.Parameter.url.FieldCaption"), Documentation.FieldDescription = Extension.LoadString("attio.Contents.Parameter.url.FieldDescription"), Documentation.SampleValues = {"https://api.attio.com"}],
        options = (type record) meta [Documentation.FieldCaption = Extension.LoadString("attio.Contents.Parameter.options.FieldCaption"), Documentation.FieldDescription = Extension.LoadString("attio.Contents.Parameter.options.FieldDescription")],
        t = type function (url as url, optional options as options) as table
    in
        t meta [
            Documentation.Name = Extension.LoadString("attio.Contents.Function.Name"),
            Documentation.Caption = Extension.LoadString("attio.Contents.Function.Caption"),
            Documentation.Description = Extension.LoadString("attio.Contents.Function.Description")
        ];

Attio = [
    Description = "Attio OpenAPI connector.",
    Type = "Custom",
    MakeResourcePath = (url) => url,
    ParseResourcePath = (url) => {url},
    TestConnection = (resource) => {"Attio.Contents", resource, [TestConnection = true]},
    Authentication = [
        Key = [Label = Extension.LoadString("BearerTokenAuthLabel"), KeyLabel = Extension.LoadString("TokenLabel")]
    ],
    Label = "Attio"
];

Attio.Publish = [
    Beta = true,
    Category = "Online Services",
    ButtonText = { "Attio", "Connect to Attio." },
    SourceImage = Attio.Icons,
    SourceTypeImage = Attio.Icons
];

Attio.Icons = [
    Icon16 = { Extension.Contents("Attio16.png"), Extension.Contents("Attio20.png"), Extension.Contents("Attio24.png"), Extension.Contents("Attio32.png") },
    Icon32 = { Extension.Contents("Attio32.png"), Extension.Contents("Attio40.png"), Extension.Contents("Attio48.png"), Extension.Contents("Attio64.png") }
];

Table.GenerateByPage = (getNextPage as function) as table =>
    let
        listOfPages = List.Generate(() => getNextPage(null), (lastPage) => lastPage <> null, (lastPage) => getNextPage(lastPage)),
        tableOfPages = Table.FromList(listOfPages, Splitter.SplitByNothing(), {"Column1"}),
        firstRow = tableOfPages{0}?
    in
        if (firstRow = null) then Table.FromRows({})
        else Value.ReplaceType(
            Table.ExpandTableColumn(tableOfPages, "Column1", Table.ColumnNames(firstRow[Column1])),
            Value.Type(firstRow[Column1]));

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
