[Version="1.0.0"]
section Bitbucket;

[DataSource.Kind="Bitbucket", Publish="Bitbucket.Publish"]
shared Bitbucket.Contents = Value.ReplaceType(Bitbucket.ContentsImpl, Bitbucket.ContentsType);

Bitbucket.FetchCollection = (url as text, optional collectionName as text) =>
    let
            __pageSize = 100,
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
                user_workspaces = [PathSuffix = "/user/workspaces", Columns = {[Name = "type", Type = Text.Type], [Name = "administrator", Type = Logical.Type], [Name = "workspace", Type = type nullable record]}]
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
            __pagingByPath = [
                hook_events_subject_type = [PathSuffix = "/hook_events/{subject_type}", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace = [PathSuffix = "/repositories/{workspace}", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_branch_restrictions = [PathSuffix = "/repositories/{workspace}/{repo_slug}/branch-restrictions", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_commit_commit_comments = [PathSuffix = "/repositories/{workspace}/{repo_slug}/commit/{commit}/comments", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_commit_commit_pullrequests = [PathSuffix = "/repositories/{workspace}/{repo_slug}/commit/{commit}/pullrequests", Style = "pageNumber", PageParam = "page", StartPage = 1],
                repositories_workspace_repo_slug_commit_commit_reports = [PathSuffix = "/repositories/{workspace}/{repo_slug}/commit/{commit}/reports", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_commit_commit_reports_reportId_annotations = [PathSuffix = "/repositories/{workspace}/{repo_slug}/commit/{commit}/reports/{reportId}/annotations", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_commit_commit_statuses = [PathSuffix = "/repositories/{workspace}/{repo_slug}/commit/{commit}/statuses", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_commits = [PathSuffix = "/repositories/{workspace}/{repo_slug}/commits", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_commits_revision = [PathSuffix = "/repositories/{workspace}/{repo_slug}/commits/{revision}", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_default_reviewers = [PathSuffix = "/repositories/{workspace}/{repo_slug}/default-reviewers", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_deploy_keys = [PathSuffix = "/repositories/{workspace}/{repo_slug}/deploy-keys", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_deployments = [PathSuffix = "/repositories/{workspace}/{repo_slug}/deployments", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_deployments_config_environments_environment_uuid_variables = [PathSuffix = "/repositories/{workspace}/{repo_slug}/deployments_config/environments/{environment_uuid}/variables", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_diffstat_spec = [PathSuffix = "/repositories/{workspace}/{repo_slug}/diffstat/{spec}", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_effective_default_reviewers = [PathSuffix = "/repositories/{workspace}/{repo_slug}/effective-default-reviewers", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_environments = [PathSuffix = "/repositories/{workspace}/{repo_slug}/environments", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_file_conflicts_spec = [PathSuffix = "/repositories/{workspace}/{repo_slug}/file-conflicts/{spec}", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_filehistory_commit_path = [PathSuffix = "/repositories/{workspace}/{repo_slug}/filehistory/{commit}/{path}", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_forks = [PathSuffix = "/repositories/{workspace}/{repo_slug}/forks", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_hooks = [PathSuffix = "/repositories/{workspace}/{repo_slug}/hooks", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_permissions_config_groups = [PathSuffix = "/repositories/{workspace}/{repo_slug}/permissions-config/groups", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_permissions_config_users = [PathSuffix = "/repositories/{workspace}/{repo_slug}/permissions-config/users", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_pipelines = [PathSuffix = "/repositories/{workspace}/{repo_slug}/pipelines", Style = "pageNumber", PageParam = "page", StartPage = 1],
                repositories_workspace_repo_slug_pipelines_config_caches = [PathSuffix = "/repositories/{workspace}/{repo_slug}/pipelines-config/caches", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_pipelines_config_runners = [PathSuffix = "/repositories/{workspace}/{repo_slug}/pipelines-config/runners", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_pipelines_pipeline_uuid_steps = [PathSuffix = "/repositories/{workspace}/{repo_slug}/pipelines/{pipeline_uuid}/steps", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_pipelines_config_schedules = [PathSuffix = "/repositories/{workspace}/{repo_slug}/pipelines_config/schedules", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_pipelines_config_schedules_schedule_uuid_executions = [PathSuffix = "/repositories/{workspace}/{repo_slug}/pipelines_config/schedules/{schedule_uuid}/executions", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_pipelines_config_ssh_known_hosts = [PathSuffix = "/repositories/{workspace}/{repo_slug}/pipelines_config/ssh/known_hosts", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_pipelines_config_variables = [PathSuffix = "/repositories/{workspace}/{repo_slug}/pipelines_config/variables", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_pullrequests = [PathSuffix = "/repositories/{workspace}/{repo_slug}/pullrequests", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_pullrequests_pull_request_id_comments = [PathSuffix = "/repositories/{workspace}/{repo_slug}/pullrequests/{pull_request_id}/comments", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_pullrequests_pull_request_id_statuses = [PathSuffix = "/repositories/{workspace}/{repo_slug}/pullrequests/{pull_request_id}/statuses", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_pullrequests_pull_request_id_tasks = [PathSuffix = "/repositories/{workspace}/{repo_slug}/pullrequests/{pull_request_id}/tasks", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_refs = [PathSuffix = "/repositories/{workspace}/{repo_slug}/refs", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_refs_branches = [PathSuffix = "/repositories/{workspace}/{repo_slug}/refs/branches", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_refs_tags = [PathSuffix = "/repositories/{workspace}/{repo_slug}/refs/tags", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_src = [PathSuffix = "/repositories/{workspace}/{repo_slug}/src", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_src_commit_path = [PathSuffix = "/repositories/{workspace}/{repo_slug}/src/{commit}/{path}", Style = "nextLinkBody", NextField = "next"],
                repositories_workspace_repo_slug_watchers = [PathSuffix = "/repositories/{workspace}/{repo_slug}/watchers", Style = "nextLinkBody", NextField = "next"],
                snippets_workspace = [PathSuffix = "/snippets/{workspace}", Style = "nextLinkBody", NextField = "next"],
                snippets_workspace_encoded_id_comments = [PathSuffix = "/snippets/{workspace}/{encoded_id}/comments", Style = "nextLinkBody", NextField = "next"],
                snippets_workspace_encoded_id_commits = [PathSuffix = "/snippets/{workspace}/{encoded_id}/commits", Style = "nextLinkBody", NextField = "next"],
                user_workspaces = [PathSuffix = "/user/workspaces", Style = "nextLinkBody", NextField = "next"],
                user_workspaces_workspace_permissions_repositories = [PathSuffix = "/user/workspaces/{workspace}/permissions/repositories", Style = "nextLinkBody", NextField = "next"],
                users_selected_user_gpg_keys = [PathSuffix = "/users/{selected_user}/gpg-keys", Style = "nextLinkBody", NextField = "next"],
                users_selected_user_ssh_keys = [PathSuffix = "/users/{selected_user}/ssh-keys", Style = "nextLinkBody", NextField = "next"],
                workspaces_workspace_hooks = [PathSuffix = "/workspaces/{workspace}/hooks", Style = "nextLinkBody", NextField = "next"],
                workspaces_workspace_members = [PathSuffix = "/workspaces/{workspace}/members", Style = "nextLinkBody", NextField = "next"],
                workspaces_workspace_permissions = [PathSuffix = "/workspaces/{workspace}/permissions", Style = "nextLinkBody", NextField = "next"],
                workspaces_workspace_permissions_repositories = [PathSuffix = "/workspaces/{workspace}/permissions/repositories", Style = "nextLinkBody", NextField = "next"],
                workspaces_workspace_permissions_repositories_repo_slug = [PathSuffix = "/workspaces/{workspace}/permissions/repositories/{repo_slug}", Style = "nextLinkBody", NextField = "next"],
                workspaces_workspace_pipelines_config_runners = [PathSuffix = "/workspaces/{workspace}/pipelines-config/runners", Style = "nextLinkBody", NextField = "next"],
                workspaces_workspace_pipelines_config_variables = [PathSuffix = "/workspaces/{workspace}/pipelines-config/variables", Style = "nextLinkBody", NextField = "next"],
                workspaces_workspace_projects = [PathSuffix = "/workspaces/{workspace}/projects", Style = "nextLinkBody", NextField = "next"],
                workspaces_workspace_projects_project_key_default_reviewers = [PathSuffix = "/workspaces/{workspace}/projects/{project_key}/default-reviewers", Style = "nextLinkBody", NextField = "next"],
                workspaces_workspace_projects_project_key_deploy_keys = [PathSuffix = "/workspaces/{workspace}/projects/{project_key}/deploy-keys", Style = "nextLinkBody", NextField = "next"],
                workspaces_workspace_projects_project_key_permissions_config_groups = [PathSuffix = "/workspaces/{workspace}/projects/{project_key}/permissions-config/groups", Style = "nextLinkBody", NextField = "next"],
                workspaces_workspace_projects_project_key_permissions_config_users = [PathSuffix = "/workspaces/{workspace}/projects/{project_key}/permissions-config/users", Style = "nextLinkBody", NextField = "next"],
                workspaces_workspace_pullrequests_selected_user = [PathSuffix = "/workspaces/{workspace}/pullrequests/{selected_user}", Style = "nextLinkBody", NextField = "next"]
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
            getPageNLB = (nextUrl as nullable text) as nullable table =>
                if nextUrl = null then null else
                let
                    response = Json.Document(Web.Contents(nextUrl, [Headers = [Authorization = "Bearer " & Extension.CurrentCredential()[Key]]])),
                    nextLink = __readPath(response, __paging[NextField]),
                    items    = if response is record then pickCollection(response)
                               else if response is list then response
                               else {},
                    asTable  = toTable(items)
                in
                    asTable meta [Next = nextLink],
            getPagePage = (page as number) as nullable table =>
                let
                    __ps     = __paging[PageSizeParam]?,
                    base     = Record.AddField([], __paging[PageParam], Text.From(page)),
                    query    = if __ps <> null and __sendsLimit(url) then Record.AddField(base, __ps, Text.From(__pageSize)) else base,
                    response = Json.Document(Web.Contents(url, [Query = query, Headers = [Authorization = "Bearer " & Extension.CurrentCredential()[Key]]])),
                    items    = if response is record then pickCollection(response)
                               else if response is list then response
                               else {},
                    asTable  = toTable(items),
                    rowCount = Table.RowCount(asTable),
                    nextPage = if rowCount < __pageSize then null else page + 1
                in
                    if rowCount = 0 then null else asTable meta [NextPage = nextPage],
            result =
                if __style = "nextLinkBody" then Table.GenerateByPage((previous) => let next = if previous = null then (let __lim = __paging[LimitParam]? in if __lim <> null and __sendsLimit(url) then url & (if Text.Contains(url, "?") then "&" else "?") & __lim & "=" & Text.From(__pageSize) else url) else Value.Metadata(previous)[Next] in getPageNLB(next))
                else if __style = "pageNumber" then Table.GenerateByPage((previous) => let pg = if previous = null then __paging[StartPage] else Value.Metadata(previous)[NextPage] in if pg = null then null else getPagePage(pg))
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

Bitbucket.ContentsImpl = (url as text, optional options as record) =>
    let
        __options = options ?? [],
        __testConnection = Record.FieldOrDefault(__options, "TestConnection", false)
    in
        if __testConnection = true then
            Bitbucket.FetchCollection(url & "/user/workspaces")
        else
            let
                    objects = #table(
                        {"Name",      "Key",        "Data",                            "ItemKind", "ItemName", "IsLeaf"},
                        {
                            {"HookEvents", "hook_events", Bitbucket.FetchCollection(url & "/hook_events"), "Table", "Table", true},
                            {"User", "user", Bitbucket.FetchCollection(url & "/user"), "Table", "Table", true},
                            {"UserWorkspaces", "workspaces", Bitbucket.FetchCollection(url & "/user/workspaces"), "Table", "Table", true}
                        }),
                    nav = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
                in
                    nav;

Bitbucket.ContentsType =
    let
        url = (type text) meta [Documentation.FieldCaption = Extension.LoadString("bitbucket.Contents.Parameter.url.FieldCaption"), Documentation.FieldDescription = Extension.LoadString("bitbucket.Contents.Parameter.url.FieldDescription"), Documentation.SampleValues = {"https://api.bitbucket.org/2.0"}],
        options = (type record) meta [Documentation.FieldCaption = Extension.LoadString("bitbucket.Contents.Parameter.options.FieldCaption"), Documentation.FieldDescription = Extension.LoadString("bitbucket.Contents.Parameter.options.FieldDescription")],
        t = type function (url as url, optional options as options) as table
    in
        t meta [
            Documentation.Name = Extension.LoadString("bitbucket.Contents.Function.Name"),
            Documentation.Caption = Extension.LoadString("bitbucket.Contents.Function.Caption"),
            Documentation.Description = Extension.LoadString("bitbucket.Contents.Function.Description")
        ];

Bitbucket = [
    Description = "Bitbucket OpenAPI connector.",
    Type = "Custom",
    MakeResourcePath = (url) => url,
    ParseResourcePath = (url) => {url},
    TestConnection = (resource) => {"Bitbucket.Contents", resource, [TestConnection = true]},
    Authentication = [
        Key = [Label = Extension.LoadString("BearerTokenAuthLabel"), KeyLabel = Extension.LoadString("TokenLabel")]
    ],
    Label = "Bitbucket"
];

Bitbucket.Publish = [
    Beta = true,
    Category = "Online Services",
    ButtonText = { "Bitbucket", "Connect to Bitbucket." },
    SourceImage = Bitbucket.Icons,
    SourceTypeImage = Bitbucket.Icons
];

Bitbucket.Icons = [
    Icon16 = { Extension.Contents("Bitbucket16.png"), Extension.Contents("Bitbucket20.png"), Extension.Contents("Bitbucket24.png"), Extension.Contents("Bitbucket32.png") },
    Icon32 = { Extension.Contents("Bitbucket32.png"), Extension.Contents("Bitbucket40.png"), Extension.Contents("Bitbucket48.png"), Extension.Contents("Bitbucket64.png") }
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
