[Version="1.0.1"]
section Attio;

[DataSource.Kind="Attio", Publish="Attio.Publish"]
shared Attio.Contents = Value.ReplaceType(Attio.ContentsImpl, Attio.ContentsType);

Attio.Schemas = [
    getObjects = {
        [Name = "id.workspace_id", Type = Text.Type],
        [Name = "id.object_id", Type = Text.Type],
        [Name = "api_slug", Type = Text.Type],
        [Name = "singular_noun", Type = Text.Type],
        [Name = "plural_noun", Type = Text.Type],
        [Name = "created_at", Type = Text.Type]
    },
    getLists = {
        [Name = "id.workspace_id", Type = Text.Type],
        [Name = "id.list_id", Type = Text.Type],
        [Name = "api_slug", Type = Text.Type],
        [Name = "name", Type = Text.Type],
        [Name = "parent_object", Type = Text.Type],
        [Name = "workspace_access", Type = Text.Type],
        [Name = "workspace_member_access.workspace_member_id", Type = Text.Type],
        [Name = "workspace_member_access.level", Type = Text.Type],
        [Name = "created_by_actor.id", Type = Text.Type],
        [Name = "created_by_actor.type", Type = Text.Type],
        [Name = "created_at", Type = Text.Type]
    },
    getWorkspaceMembers = {
        [Name = "id.workspace_id", Type = Text.Type],
        [Name = "id.workspace_member_id", Type = Text.Type],
        [Name = "first_name", Type = Text.Type],
        [Name = "last_name", Type = Text.Type],
        [Name = "avatar_url", Type = Text.Type],
        [Name = "email_address", Type = Text.Type],
        [Name = "created_at", Type = Text.Type],
        [Name = "access_level", Type = Text.Type]
    },
    getNotes = {
        [Name = "id.workspace_id", Type = Text.Type],
        [Name = "id.note_id", Type = Text.Type],
        [Name = "parent_object", Type = Text.Type],
        [Name = "parent_record_id", Type = Text.Type],
        [Name = "title", Type = Text.Type],
        [Name = "meeting_id", Type = Text.Type],
        [Name = "content_plaintext", Type = Text.Type],
        [Name = "content_markdown", Type = Text.Type],
        [Name = "tags", Type = type any],
        [Name = "created_by_actor.id", Type = Text.Type],
        [Name = "created_by_actor.type", Type = Text.Type],
        [Name = "created_at", Type = Text.Type]
    },
    getTasks = {
        [Name = "id.workspace_id", Type = Text.Type],
        [Name = "id.task_id", Type = Text.Type],
        [Name = "content_plaintext", Type = Text.Type],
        [Name = "deadline_at", Type = Text.Type],
        [Name = "is_completed", Type = Logical.Type],
        [Name = "completed_at", Type = Text.Type],
        [Name = "linked_records.target_object_id", Type = Text.Type],
        [Name = "linked_records.target_record_id", Type = Text.Type],
        [Name = "assignees.referenced_actor_type", Type = Text.Type],
        [Name = "assignees.referenced_actor_id", Type = Text.Type],
        [Name = "created_by_actor.id", Type = Text.Type],
        [Name = "created_by_actor.type", Type = Text.Type],
        [Name = "created_at", Type = Text.Type]
    },
    getThreads = {
        [Name = "id.workspace_id", Type = Text.Type],
        [Name = "id.thread_id", Type = Text.Type],
        [Name = "comments.id", Type = type nullable record],
        [Name = "comments.thread_id", Type = Text.Type],
        [Name = "comments.content_plaintext", Type = Text.Type],
        [Name = "comments.entry", Type = type nullable record],
        [Name = "comments.record", Type = type nullable record],
        [Name = "comments.resolved_at", Type = Text.Type],
        [Name = "comments.resolved_by", Type = type nullable record],
        [Name = "comments.created_at", Type = Text.Type],
        [Name = "comments.author", Type = type nullable record],
        [Name = "created_at", Type = Text.Type]
    },
    getMeetings = {
        [Name = "id.workspace_id", Type = Text.Type],
        [Name = "id.meeting_id", Type = Text.Type],
        [Name = "title", Type = Text.Type],
        [Name = "description", Type = Text.Type],
        [Name = "is_all_day", Type = Logical.Type],
        [Name = "start", Type = type any],
        [Name = "end", Type = type any],
        [Name = "participants.status", Type = Text.Type],
        [Name = "participants.is_organizer", Type = Logical.Type],
        [Name = "participants.email_address", Type = Text.Type],
        [Name = "linked_records.object_slug", Type = Text.Type],
        [Name = "linked_records.object_id", Type = Text.Type],
        [Name = "linked_records.record_id", Type = Text.Type],
        [Name = "created_at", Type = Text.Type],
        [Name = "created_by_actor.id", Type = Text.Type],
        [Name = "created_by_actor.type", Type = Text.Type]
    },
    getWebhooks = {
        [Name = "target_url", Type = Text.Type],
        [Name = "subscriptions.event_type", Type = Text.Type],
        [Name = "subscriptions.filter", Type = type any],
        [Name = "id.workspace_id", Type = Text.Type],
        [Name = "id.webhook_id", Type = Text.Type],
        [Name = "status", Type = Text.Type],
        [Name = "created_at", Type = Text.Type]
    },
    getSelf = {
    }
];

Attio.Expansions = [
    getObjects = {
        [
            Kind = "Record",
            Name = "id",
            Fields = {"workspace_id", "object_id"},
            Names = {"id.workspace_id", "id.object_id"}
        ]
    },
    getLists = {
        [
            Kind = "Record",
            Name = "id",
            Fields = {"workspace_id", "list_id"},
            Names = {"id.workspace_id", "id.list_id"}
        ],
        [
            Kind = "List",
            Name = "parent_object"
        ],
        [
            Kind = "List",
            Name = "workspace_member_access"
        ],
        [
            Kind = "Record",
            Name = "workspace_member_access",
            Fields = {"workspace_member_id", "level"},
            Names = {
                "workspace_member_access.workspace_member_id",
                "workspace_member_access.level"
            }
        ],
        [
            Kind = "Record",
            Name = "created_by_actor",
            Fields = {"id", "type"},
            Names = {"created_by_actor.id", "created_by_actor.type"}
        ]
    },
    getWorkspaceMembers = {
        [
            Kind = "Record",
            Name = "id",
            Fields = {"workspace_id", "workspace_member_id"},
            Names = {"id.workspace_id", "id.workspace_member_id"}
        ]
    },
    getNotes = {
        [
            Kind = "Record",
            Name = "id",
            Fields = {"workspace_id", "note_id"},
            Names = {"id.workspace_id", "id.note_id"}
        ],
        [
            Kind = "List",
            Name = "tags"
        ],
        [
            Kind = "Record",
            Name = "created_by_actor",
            Fields = {"id", "type"},
            Names = {"created_by_actor.id", "created_by_actor.type"}
        ]
    },
    getTasks = {
        [
            Kind = "Record",
            Name = "id",
            Fields = {"workspace_id", "task_id"},
            Names = {"id.workspace_id", "id.task_id"}
        ],
        [
            Kind = "List",
            Name = "linked_records"
        ],
        [
            Kind = "Record",
            Name = "linked_records",
            Fields = {"target_object_id", "target_record_id"},
            Names = {"linked_records.target_object_id", "linked_records.target_record_id"}
        ],
        [
            Kind = "List",
            Name = "assignees"
        ],
        [
            Kind = "Record",
            Name = "assignees",
            Fields = {"referenced_actor_type", "referenced_actor_id"},
            Names = {"assignees.referenced_actor_type", "assignees.referenced_actor_id"}
        ],
        [
            Kind = "Record",
            Name = "created_by_actor",
            Fields = {"id", "type"},
            Names = {"created_by_actor.id", "created_by_actor.type"}
        ]
    },
    getThreads = {
        [
            Kind = "Record",
            Name = "id",
            Fields = {"workspace_id", "thread_id"},
            Names = {"id.workspace_id", "id.thread_id"}
        ],
        [
            Kind = "List",
            Name = "comments"
        ],
        [
            Kind = "Record",
            Name = "comments",
            Fields = {
                "id",
                "thread_id",
                "content_plaintext",
                "entry",
                "record",
                "resolved_at",
                "resolved_by",
                "created_at",
                "author"
            },
            Names = {
                "comments.id",
                "comments.thread_id",
                "comments.content_plaintext",
                "comments.entry",
                "comments.record",
                "comments.resolved_at",
                "comments.resolved_by",
                "comments.created_at",
                "comments.author"
            }
        ]
    },
    getMeetings = {
        [
            Kind = "Record",
            Name = "id",
            Fields = {"workspace_id", "meeting_id"},
            Names = {"id.workspace_id", "id.meeting_id"}
        ],
        [
            Kind = "List",
            Name = "participants"
        ],
        [
            Kind = "Record",
            Name = "participants",
            Fields = {"status", "is_organizer", "email_address"},
            Names = {
                "participants.status",
                "participants.is_organizer",
                "participants.email_address"
            }
        ],
        [
            Kind = "List",
            Name = "linked_records"
        ],
        [
            Kind = "Record",
            Name = "linked_records",
            Fields = {"object_slug", "object_id", "record_id"},
            Names = {
                "linked_records.object_slug",
                "linked_records.object_id",
                "linked_records.record_id"
            }
        ],
        [
            Kind = "Record",
            Name = "created_by_actor",
            Fields = {"id", "type"},
            Names = {"created_by_actor.id", "created_by_actor.type"}
        ]
    },
    getWebhooks = {
        [
            Kind = "List",
            Name = "subscriptions"
        ],
        [
            Kind = "Record",
            Name = "subscriptions",
            Fields = {"event_type", "filter"},
            Names = {"subscriptions.event_type", "subscriptions.filter"}
        ],
        [
            Kind = "Record",
            Name = "id",
            Fields = {"workspace_id", "webhook_id"},
            Names = {"id.workspace_id", "id.webhook_id"}
        ]
    },
    getSelf = {}
];

Attio.Collections = [
    getObjects = [
        Name = "Objects",
        Key = "objects",
        OperationId = "getObjects",
        Path = "/v2/objects",
        Fetch = (baseUrl as text) as table =>
            Attio.FetchCollection(
                Uri.Combine(baseUrl & "/", "v2/objects"),
                "data",
                [
                    CollectionPath = {"data"},
                    Columns = Record.Field(Attio.Schemas, "getObjects"),
                    Expansions = Record.Field(Attio.Expansions, "getObjects"),
                    Paging = [Style = "none"]
                ]
            )
        ],
    getLists = [
        Name = "Lists",
        Key = "lists",
        OperationId = "getLists",
        Path = "/v2/lists",
        Fetch = (baseUrl as text) as table =>
            Attio.FetchCollection(
                Uri.Combine(baseUrl & "/", "v2/lists"),
                "data",
                [
                    CollectionPath = {"data"},
                    Columns = Record.Field(Attio.Schemas, "getLists"),
                    Expansions = Record.Field(Attio.Expansions, "getLists"),
                    Paging = [Style = "none"]
                ]
            )
        ],
    getWorkspaceMembers = [
        Name = "WorkspaceMembers",
        Key = "workspace_members",
        OperationId = "getWorkspaceMembers",
        Path = "/v2/workspace_members",
        Fetch = (baseUrl as text) as table =>
            Attio.FetchCollection(
                Uri.Combine(baseUrl & "/", "v2/workspace_members"),
                "data",
                [
                    CollectionPath = {"data"},
                    Columns = Record.Field(Attio.Schemas, "getWorkspaceMembers"),
                    Expansions = Record.Field(Attio.Expansions, "getWorkspaceMembers"),
                    Paging = [Style = "none"]
                ]
            )
        ],
    getNotes = [
        Name = "Notes",
        Key = "notes",
        OperationId = "getNotes",
        Path = "/v2/notes",
        Fetch = (baseUrl as text) as table =>
            Attio.FetchCollection(
                Uri.Combine(baseUrl & "/", "v2/notes"),
                "data",
                [
                    CollectionPath = {"data"},
                    Columns = Record.Field(Attio.Schemas, "getNotes"),
                    Expansions = Record.Field(Attio.Expansions, "getNotes"),
                    Paging = [Style = "offsetLimit", OffsetParam = "offset", LimitParam = "limit"]
                ]
            )
        ],
    getTasks = [
        Name = "Tasks",
        Key = "tasks",
        OperationId = "getTasks",
        Path = "/v2/tasks",
        Fetch = (baseUrl as text) as table =>
            Attio.FetchCollection(
                Uri.Combine(baseUrl & "/", "v2/tasks"),
                "data",
                [
                    CollectionPath = {"data"},
                    Columns = Record.Field(Attio.Schemas, "getTasks"),
                    Expansions = Record.Field(Attio.Expansions, "getTasks"),
                    Paging = [Style = "offsetLimit", OffsetParam = "offset", LimitParam = "limit"]
                ]
            )
        ],
    getThreads = [
        Name = "Threads",
        Key = "threads",
        OperationId = "getThreads",
        Path = "/v2/threads",
        Fetch = (baseUrl as text) as table =>
            Attio.FetchCollection(
                Uri.Combine(baseUrl & "/", "v2/threads"),
                "data",
                [
                    CollectionPath = {"data"},
                    Columns = Record.Field(Attio.Schemas, "getThreads"),
                    Expansions = Record.Field(Attio.Expansions, "getThreads"),
                    Paging = [Style = "offsetLimit", OffsetParam = "offset", LimitParam = "limit"]
                ]
            )
        ],
    getMeetings = [
        Name = "Meetings",
        Key = "meetings",
        OperationId = "getMeetings",
        Path = "/v2/meetings",
        Fetch = (baseUrl as text) as table =>
            Attio.FetchCollection(
                Uri.Combine(baseUrl & "/", "v2/meetings"),
                "data",
                [
                    CollectionPath = {"data"},
                    Columns = Record.Field(Attio.Schemas, "getMeetings"),
                    Expansions = Record.Field(Attio.Expansions, "getMeetings"),
                    Paging = [Style = "cursor", CursorParam = "cursor", CursorField = "nextCursor", CursorLimitParam = "limit"]
                ]
            )
        ],
    getWebhooks = [
        Name = "Webhooks",
        Key = "webhooks",
        OperationId = "getWebhooks",
        Path = "/v2/webhooks",
        Fetch = (baseUrl as text) as table =>
            Attio.FetchCollection(
                Uri.Combine(baseUrl & "/", "v2/webhooks"),
                "data",
                [
                    CollectionPath = {"data"},
                    Columns = Record.Field(Attio.Schemas, "getWebhooks"),
                    Expansions = Record.Field(Attio.Expansions, "getWebhooks"),
                    Paging = [Style = "offsetLimit", OffsetParam = "offset", LimitParam = "limit"]
                ]
            )
        ],
    getSelf = [
        Name = "Self",
        Key = "self",
        OperationId = "getSelf",
        Path = "/v2/self",
        Fetch = (baseUrl as text) as table =>
            Attio.FetchCollection(
                Uri.Combine(baseUrl & "/", "v2/self"),
                null,
                [
                    CollectionPath = {},
                    Columns = Record.Field(Attio.Schemas, "getSelf"),
                    Expansions = Record.Field(Attio.Expansions, "getSelf"),
                    Paging = [Style = "none"]
                ]
            )
        ]
];

Attio.BasePath = "";

Attio.RequestHeaders = [Accept = "application/json", Authorization = "Bearer " & Extension.CurrentCredential()[Key]];

Attio.Request = (url as text, optional query as nullable record) as binary =>
    let
        manualRetryStatusCodes = {500, 502},
        send = (attempt as number) as binary =>
            let
                baseOptions = [
                    ManualStatusHandling = manualRetryStatusCodes,
                    IsRetry = attempt > 0
                ],
                queryOptions = if query = null then baseOptions else Record.AddField(baseOptions, "Query", query),
                requestOptions = if Record.FieldCount(Attio.RequestHeaders) = 0
                    then queryOptions else Record.AddField(queryOptions, "Headers", Attio.RequestHeaders),
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

Attio.RequestJson = (url as text, optional query as nullable record) as any =>
    Json.Document(Attio.Request(url, query));

Attio.TestConnectionProbe = (baseUrl as text) as table =>
    let
        endpoint = Uri.Combine(baseUrl & "/", "v2/objects"),
        response = Binary.Buffer(Attio.Request(endpoint, null))
    in
        #table({"Connected"}, {{Binary.Length(response) >= 0}});

Attio.FetchCollection = (url as text, optional collectionName as text, optional options as record) =>
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
            __pageSize = Record.FieldOrDefault(__options, "PageSize", 50),
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
            getPageOffset = (offset as number) as nullable table =>
                let
                    offsetParam = Record.FieldOrDefault(__paging, "OffsetParam", "offset"),
                    limitParam = Record.FieldOrDefault(__paging, "LimitParam", "limit"),
                    query = Record.AddField(
                        Record.AddField([], offsetParam, Text.From(offset)),
                        limitParam,
                        Text.From(__pageSize)),
                    response = Attio.RequestJson(url, query),
                    items = pickCollection(response),
                    page = toTable(items),
                    itemCount = List.Count(items),
                    nextOffset = if itemCount < __pageSize then null else offset + __pageSize
                in
                    if itemCount = 0 then null else page meta [NextOffset = nextOffset],
            getPageCursor = (cursor as nullable text) as nullable table =>
                let
                    cursorParam = Record.FieldOrDefault(__paging, "CursorParam", "cursor"),
                    limitParam = Record.FieldOrDefault(__paging, "CursorLimitParam", null),
                    baseQuery = if limitParam = null then []
                        else Record.AddField([], limitParam, Text.From(__pageSize)),
                    query = if cursor = null then baseQuery
                        else Record.AddField(baseQuery, cursorParam, cursor),
                    response = Attio.RequestJson(url, query),
                    items = pickCollection(response),
                    page = toTable(items),
                    cursorField = Record.FieldOrDefault(__paging, "CursorField", "next_cursor"),
                    hasMoreField = Record.FieldOrDefault(__paging, "HasMoreField", null),
                    lastRowIdField = Record.FieldOrDefault(__paging, "LastRowIdField", null),
                    hasMore = if hasMoreField = null then null
                        else __readPath(response, Text.Split(hasMoreField, ".")),
                    responseCursor = if lastRowIdField <> null
                        then if List.IsEmpty(items) then null
                            else Record.FieldOrDefault(List.Last(items), lastRowIdField, null)
                        else __readPath(response, Text.Split(cursorField, ".")),
                    nextCursor = if hasMore = false or responseCursor = null
                        or (responseCursor is text and Text.Trim(responseCursor) = "")
                        then null else Text.From(responseCursor)
                in
                    page meta [NextCursor = nextCursor],
            result =
                if __style = "offsetLimit" then
                    Table.GenerateByPage(
                        (previous) =>
                            let offset = if previous = null then 0 else Value.Metadata(previous)[NextOffset]
                            in if offset = null then null else getPageOffset(offset),
                        toTable({}))
                else
                if __style = "cursor" or __style = "cursorId" then
                    Table.GenerateByPage(
                        (previous) =>
                            if previous = null then getPageCursor(null)
                            else
                                let cursor = Value.Metadata(previous)[NextCursor]
                                in if cursor = null then null else getPageCursor(cursor),
                        toTable({}))
                else
                    let
                        limitParam = Record.FieldOrDefault(__paging, "LimitParam", null),
                        query = if limitParam = null then null
                            else Record.AddField([], limitParam, Text.From(__pageSize))
                    in
                        toTable(pickCollection(Attio.RequestJson(url, query)))
        in
            result;

Attio.ContentsImpl = (url as text, optional options as record) =>
    let
        __options = options ?? [],
        __testConnection = Record.FieldOrDefault(__options, "TestConnection", false)
    in
        if __testConnection = true then
            Attio.TestConnectionProbe(NormalizeUrl(url))
        else
            let
                    baseUrl = NormalizeUrl(url),
                    definitions = Record.ToTable(Attio.Collections),
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

Attio.ContentsType =
    let
        url = (type text) meta [
            Documentation.FieldCaption = Extension.LoadString("attio.Contents.Parameter.url.FieldCaption"),
            Documentation.FieldDescription = Extension.LoadString("attio.Contents.Parameter.url.FieldDescription"),
            Documentation.SampleValues = {"https://api.attio.com"}
        ],
        options = (type record) meta [
            Documentation.FieldCaption = Extension.LoadString("attio.Contents.Parameter.options.FieldCaption"),
            Documentation.FieldDescription = Extension.LoadString("attio.Contents.Parameter.options.FieldDescription")
        ],
        t = type function (url as url, optional options as options) as table
    in
        t meta [
            Documentation.Name = Extension.LoadString("attio.Contents.Function.Name"),
            Documentation.Caption = Extension.LoadString("attio.Contents.Function.Caption"),
            Documentation.Description = Extension.LoadString("attio.Contents.Function.Description")
        ];

Attio = [
    Type = "Custom",
    MakeResourcePath = (url) => url,
    ParseResourcePath = (url) => {url},
    TestConnection = (resource) => {"Attio.Contents", resource, [TestConnection = true]},
    Authentication = [
        Key = [Label = Extension.LoadString("BearerTokenAuthLabel"), KeyLabel = Extension.LoadString("TokenLabel")]
    ],
    Label = Extension.LoadString("ResourceLabel")
];

Attio.Publish = [
    Beta = true,
    Category = "Online Services",
    ButtonText = { Extension.LoadString("FormulaTitle"), Extension.LoadString("FormulaHelp") },
    SourceImage = Attio.Icons,
    SourceTypeImage = Attio.Icons
];

Attio.Icons = [
    Icon16 = { Extension.Contents("Attio16.png"), Extension.Contents("Attio20.png"), Extension.Contents("Attio24.png"), Extension.Contents("Attio32.png") },
    Icon32 = { Extension.Contents("Attio32.png"), Extension.Contents("Attio40.png"), Extension.Contents("Attio48.png"), Extension.Contents("Attio64.png") }
];

NormalizeUrl = (url as text) as text =>
    let
        parts = Uri.Parts(url),
        scheme = Text.Lower(parts[Scheme]),
        host = Text.Lower(parts[Host]),
        rawPort = parts[Port]?,
        port = if rawPort = null or rawPort = 443 then ""
               else ":" & Text.From(rawPort),
        basePathTemplate = Attio.BasePath,
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
