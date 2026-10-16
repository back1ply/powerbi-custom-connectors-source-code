[ Version = "1.0.24" ]
section OneLakeSql;

AadSqlResource = "https://database.windows.net/";
ResourcePathSeparator = ";";
apiUrl = Environment.FeatureSwitch("PowerBiUri", "https://api.powerbi.com");

// Extension library functions
Extension.LoadFunction = (name as text, optional additionalContext as nullable record) =>
    let
        binary = Extension.Contents(name),
        asText = Text.FromBinary(binary),
        baseContext = #shared,
        context = if additionalContext = null 
            then baseContext 
            else Record.Combine({baseContext, additionalContext})
    in
        try
            Expression.Evaluate(asText, context)
        catch (e) =>
            error [
                Reason = "Extension.LoadFunction Failure",
                Message.Format = "Loading '#{0}' failed - '#{1}': '#{2}'",
                Message.Parameters = {name, e[Reason], e[Message]},
                Detail = [File = name, Error = e]
            ];

// Load modules
Utils = Extension.LoadFunction("Utils.pqm");
Table.NavigationTableView = Extension.LoadFunction("Table.NavigationTableView.pqm");

WorkspacePrivateLink = Extension.LoadFunction("Workspace.PrivateLink.pqm", [Utils = Utils]);
Workspace = Extension.LoadFunction("Workspace.pqm", [
    Utils = Utils, 
    Table.NavigationTableView = Table.NavigationTableView,
    WorkspacePrivateLink = WorkspacePrivateLink
]);
Variable.ValueOrDefault = try #shared[Variable.ValueOrDefault] otherwise (url, optional options) => error "Internal Error: Variable.ValueOrDefault not found in shared context. Ensure the module is loaded with the correct context.";

OneLakeSql = [
    Type = "Custom",
    MakeResourcePath =  MakeResourcePath,
    ParseResourcePath = ParseResourcePath,
    TestConnection = (dataSourcePath) => { "OneLake.SqlAnalytics" } & ParseResourcePath(dataSourcePath),
    Authentication = [
          Aad = [
                   AuthorizationUri = Uri.Combine(Environment.FeatureSwitch("AzureActiveDirectoryUri", "https://login.microsoftonline.com"), "/common/oauth2/authorize"),
                   Resource = "",
                   Scope = Utils[Utility.CreateOrderedScope]({Environment.FeatureSwitch("PowerBiAadResource", "https://analysis.windows.net/powerbi/api"), AadSqlResource})
                ]
           ],

    ApplicationProperties = [
        PBI_CapacityObjectId = [PropertyType = Text.Type, IsRequired = false],
        PBIEndpointUrl = [PropertyType = Text.Type, IsRequired = false]
    ],
    
// valid DSRs
/*
{"protocol":"onelake-sqlanalytics", "address":{"workspace":"66402100-396f-41d4-8e88-19e8c6ae0834", "database":"a83d87f0-70e7-497a-8ad2-757a63d499ef", "artifactType":"Lakehouse"}}
*/
    DSRHandlers = [
        #"onelake-sqlanalytics" = [
            GetDSR = (workspace as text, database as text, artifactType as text, optional options, optional navigation) =>
                let
                    // Relative References
                    isRelativeReference = workspace = ".",
                    finalWsId = if isRelativeReference then Variable.ValueOrDefault("currentWorkspaceId", workspace) else workspace,
                    address = 
                        [
                            workspace = finalWsId,
                            database = database,
                            artifactType = artifactType,
                            isRelativeReference = isRelativeReference
                        ]
                in
                    {[protocol = "onelake-sqlanalytics", address = address], options ?? []},
            GetFormula = (dsr, optional options) =>
                let
                    address = ValidateAddressRecord(dsr[address]),
                    workspace = Record.FieldOrDefault(address, "workspace", null),
                    database = Record.FieldOrDefault(address, "database", null),
                    artifactType = Record.FieldOrDefault(address, "artifactType", null)
                in
                    () => OneLake.SqlAnalytics(workspace, database, artifactType),
            GetFriendlyName = (dsr) => "OneLake Sql Analytics"
        ]
   ]
];

ValidateOptions2 = (options, optionsType) =>
    let
        available = Type.RecordFields(optionsType),
        found = Record.FieldNames(options),
        unknown = Text.Combine(List.FirstN(found, each not Record.HasFields(available, _)), ","),
        result = if (unknown <> null and unknown <> "") then error "Unknown field: " & unknown else options
    in
        result;

ValidateAddressRecord = (address as record) =>
    let
        validated = ValidateOptions2(address, type [
            workspace = Guid.Type,
            database = Text.Type,
            artifactType = Text.Type,
            isRelativeReference = Logical.Type
        ])
    in
        validated;

MakeResourcePath = (workspace as text, database as text, artifactType as text, optional options as record) as text =>   
    let
        actualWorkspace = if workspace = "."
            then try Variable.Value("currentWorkspaceId")
                catch () => error Error.Record("Expression.Error", Extension.LoadString("CannotResolveCurrentWorkspace"))
            else workspace,
        resourcePathList = {Text.Lower(actualWorkspace), database, artifactType},
        resourcePath = Text.Combine(resourcePathList, ResourcePathSeparator)
    in
        resourcePath;

ParseResourcePath = (resourcePath as text) as list => 
    let 
        resourcePathValue = Text.Split(resourcePath, ResourcePathSeparator),
        resourcePathList = List.ReplaceValue(resourcePathValue, List.First(resourcePathValue), Text.Lower(List.First(resourcePathValue)), Replacer.ReplaceText)
    in 
        resourcePathList;
       

[DataSource.Kind = "OneLakeSql", Publish="OneLakeSql.Publish"]
shared OneLake.SqlAnalytics  = Value.ReplaceType(OneLakeSqlImpl, OneLakeSql.Type);

OneLakeSql.Type =
    let
        OneLakeSqlFunctionType = Type.ForFunction([
            Parameters = [
                workspace = type text meta [
                    Documentation.FieldCaption = Extension.LoadString("OneLakeSql_WorkspaceCaption"),
                    Documentation.SampleValues = { "85599f29-c009-4253-b53b-c3ba6e4afa97" }
                ],
                database = type text meta [
                    Documentation.FieldCaption = Extension.LoadString("OneLakeSql_DatabaseCaption"),
                    Documentation.SampleValues = { "mySqlAnalyticsDatabase" }
                ],
                artifactType = type text meta [
                    Documentation.FieldCaption = Extension.LoadString("OneLakeSql_ArtifactTypeCaption"),
                    Documentation.SampleValues = { "Lakehouse" }
                ],
                options = type record meta [
                    Documentation.FieldCaption = Extension.LoadString("OptionsParameterCaption"),
                    Documentation.SampleValues = { "[ ConnectionTimeout = 0 ]" }
                ]
            ],
            ReturnType = type table
            ], 3
        ),

        withMetadata = Value.ReplaceMetadata(
            OneLakeSqlFunctionType,
            [
                Documentation.Name = Extension.LoadString("OneLakeSql_Title"),
                Documentation.Caption = Extension.LoadString("OneLakeSql_Title"),
                Documentation.Description = Extension.LoadString("OneLakeSql_Description"),
                Documentation.LongDescription = Extension.LoadString("OneLakeSql_LongDescription"),
                Documentation.Examples = {[
                    Description = Extension.LoadString("OneLakeSql_ExampleDescription"),
                    Code = "OneLake.SqlAnalytics(""85599f29-c009-4253-b53b-c3ba6e4afa97"", ""mySqlAnalyticsDatabase"", ""Lakehouse"")",
                    Result = Extension.LoadString("OneLakeSql_ExampleResult")
                ]}
            ])
    in
        withMetadata;

OneLakeSqlImpl = (workspace as text, database as text, artifactType as text, optional options as record) =>
    let
        nonNullOptions = options ?? [],

        // get list of onelake sql endpoints using listsql endpoints api here https://learn.microsoft.com/en-us/rest/api/fabric/sqlendpoint/items/list-sql-endpoints?tabs=HTTP
        // once we have sql endpoint that matches the display name of database
        // we can use the connectionstring api here https://learn.microsoft.com/en-us/rest/api/fabric/sqlendpoint/items/get-connection-string?tabs=HTTP
        // to get the tds endpoint and database name to connect to using Sql.Database using the display name as databse name

        // however this means, i cannot have one query to get the sql endpoint with just workspace name
        // i have to query the workspace for all sql endpoints and then filter based on display name
        // also the platform APIs are marked as not supporting SPNs. This might have changed recently
        // also if a specific sqlendpoint is shared with me and i do not have access to the workspace that it belongs to
        // to query for the sqlendpoints how would that work?
        // This means we again won't be able to support shared onelake sql endpoints until the platform apis support spns
        isRelativeReference = workspace = ".",
        finalWsId = if isRelativeReference
            then try Variable.Value("currentWorkspaceId")
                catch () => error Error.Record("Expression.Error", Extension.LoadString("CannotResolveCurrentWorkspace"))
            else workspace,

        sqlConnectionString = if Text.Upper(artifactType) = "WAREHOUSE" then
            GetWarehouseSqlConnectionString(finalWsId, database)
        else
            GetSqlEndpointConnectionString(finalWsId, database),
        tdsEndpoint =  if sqlConnectionString = [] or sqlConnectionString[tdsEndpoint] = null then
            error Utils[Connector.GenerateErrorRecord]("OneLakeSqlConnectionStringNotFound", Extension.LoadString("OneLakeSqlConnectionStringNotFound"), "OneLake.SqlAnalytics")
        else
            sqlConnectionString[tdsEndpoint],
        sqlEndpointNavTable = GetSqlEndpointNavTable(tdsEndpoint, database, nonNullOptions)
    in
        sqlEndpointNavTable;

GetSqlEndpointConnectionString = (workspaceId as text, database as text) as record =>
    let
        sqlEndPointsTable = GetSqlEndPointsTable(workspaceId),
        filteredSqlEndPoints = Table.First(Table.SelectRows(sqlEndPointsTable, each [database] = database), null),
        filteredSqlEndPoint = if filteredSqlEndPoints = null then
            error Utils[Connector.GenerateErrorRecord]("OneLakeSqlEndpointNotFound", Extension.LoadString("OneLakeSqlEndpointNotFound"), "OneLake.SqlAnalytics")
        else
            filteredSqlEndPoints[artifactId],
        sqlConnectionString = GetSqlConnectionString(workspaceId, filteredSqlEndPoint)
    in
        sqlConnectionString;

GetWarehouseSqlConnectionString = (workspaceId as text, database as text) as record =>
    let
        warehousesTable = GetWarehousesTable(workspaceId),
        filteredWarehouse = Table.First(Table.SelectRows(warehousesTable, each [database] = database), null),
        warehouseConnectionString = if filteredWarehouse = null then
            error Utils[Connector.GenerateErrorRecord]("OneLakeSqlEndpointNotFound", Extension.LoadString("OneLakeSqlEndpointNotFound"), "OneLake.SqlAnalytics")
        else
            [ tdsEndpoint = filteredWarehouse[tdsEndpoint] ]
    in
        warehouseConnectionString;

GetSqlEndpointNavTable = (tdsEndPoint as text, database as text, options as record) =>
    Extension.InvokeWithCredentials(
        (datasource) => Utils[GetCredential](AadSqlResource),
        () => GetSqlEndpointNavTable_WithPermissions(tdsEndPoint, database, options));

GetSqlEndpointNavTable_WithPermissions = (tdsEndPoint as text, database as text, options as record) =>
    Extension.InvokeWithPermissions(
        (permission) => Extension.HasPermission(Record.SelectFields(permission, {"PermissionKind", "Value", "Parameters"})),
        () =>
            let
                curatedOptions = Record.SelectFields(options, {"CommandTimeout", "CreateNavigationProperties", "HierarchicalNavigation"}, MissingField.Ignore),
                sqlAnalytics = Sql.Database(tdsEndPoint, database, curatedOptions),
                withoutSystemTables = Table.SelectRows(sqlAnalytics, each ([Schema] <> "sys" and [Schema] <> "queryinsights"))
            in
                Table.View(withoutSystemTables,[
                    OnSelectRows = (selector) => Table.SelectRows(sqlAnalytics, selector), // Prevent the "sys" schema predicate from blocking folding
                    GetExpression = () => Value.Expression(Value.Optimize(sqlAnalytics)),
                    OnTestConnection = () => DataSource.TestConnection(sqlAnalytics)
                ])
        );

// https://learn.microsoft.com/en-us/rest/api/fabric/sqlendpoint/items/get-connection-string?tabs=HTTP&tryIt=true&source=docs
GetSqlEndPointsTable = (workspaceId as text) as table =>
    let
        workspaceSpecificApiUrl = WorkspacePrivateLink[GetWorkspaceBaseUrl](apiUrl, workspaceId),
        isPL = WorkspacePrivateLink[IsWorkspacePLUrl](workspaceSpecificApiUrl),
        endPoints = Text.Format("v1/workspaces/#{0}/sqlEndpoints", {workspaceId}),
        connectionPath = if isPL then endPoints & "?privateLinkType=Workspace" else endPoints,
        url = Uri.Combine(workspaceSpecificApiUrl, connectionPath),
        response = Utils[Web.JsonContents](
            url,
            /*headers*/ WorkspacePrivateLink[GetPrivateLinkS2SHeader](workspaceId),
            /*additionalHandlers*/ null,
            /*jsonBody*/ null,
            /*startState*/ null,
            /*traceContext*/ [Origin = Utils[NonPii]("GetSqlEndpoints")] )
    in
        GetSqlEndPoints(response);

GetSqlEndPoints = (jsonResponse as record) as table =>
    let
        jsonResponseValue = 
        if jsonResponse = null or not Record.HasFields(jsonResponse, "value") or jsonResponse[value] = null or List.Count(jsonResponse[value]) = 0 then
            error Utils[Connector.GenerateErrorRecord]("GetSqlEndpointsFailure", Extension.LoadString("GetSqlEndpointsFailure"), "GetSqlEndpoints")
        else jsonResponse[value],
        validEndpoints = Table.FromRecords(jsonResponseValue, {"id", "displayName", "description", "type", "workspaceId"}),
        rename = Table.RenameColumns(validEndpoints, {{"id", "artifactId"}, {"displayName", "database"}, {"type", "artifactType"}, {"workspaceId", "workspaceId"}})
    in
        rename;

GetWarehousesTable = (workspaceId as text) as table =>
    let
        workspaceSpecificApiUrl = WorkspacePrivateLink[GetWorkspaceBaseUrl](apiUrl, workspaceId),
        isPL = WorkspacePrivateLink[IsWorkspacePLUrl](workspaceSpecificApiUrl),
        warehouses = Text.Format("v1/workspaces/#{0}/warehouses", {workspaceId}),
        connectionPath = if isPL then warehouses & "?privateLinkType=Workspace" else warehouses,
        url = Uri.Combine(workspaceSpecificApiUrl, connectionPath),
        response = Utils[Web.JsonContents](
            url,
            /*headers*/ WorkspacePrivateLink[GetPrivateLinkS2SHeader](workspaceId),
            /*additionalHandlers*/ null,
            /*jsonBody*/ null,
            /*startState*/ null,
            /*traceContext*/ [Origin = Utils[NonPii]("GetWarehouses")] )
    in
        GetWarehouses(response);

GetWarehouses = (jsonResponse as record) as table =>
    let
        jsonResponseValue =
        if jsonResponse = null or not Record.HasFields(jsonResponse, "value") or jsonResponse[value] = null or List.Count(jsonResponse[value]) = 0 then
            error Utils[Connector.GenerateErrorRecord]("GetWarehousesFailure", Extension.LoadString("GetWarehousesFailure"), "GetWarehouses")
        else jsonResponse[value],
        validWarehouses = Table.FromRecords(jsonResponseValue, {"id", "displayName", "description", "type", "workspaceId", "properties"}),
        rename = Table.RenameColumns(validWarehouses, {{"id", "artifactId"}, {"displayName", "database"}, {"type", "artifactType"}, {"workspaceId", "workspaceId"}}),
        withConnectionString = Table.AddColumn(
            rename,
            "tdsEndpoint",
            each
                let
                    properties = [properties]?
                in
                    if properties = null then null else properties[connectionString]?,
            type nullable text),
        result = Table.SelectColumns(withConnectionString, {"artifactId", "database", "artifactType", "workspaceId", "tdsEndpoint"})
    in
        result;

GetSqlConnectionString = (workspaceId as text, sqlEndpointId as text) as record =>
    let
        workspaceSpecificApiUrl = WorkspacePrivateLink[GetWorkspaceBaseUrl](apiUrl, workspaceId),
        isPL = WorkspacePrivateLink[IsWorkspacePLUrl](workspaceSpecificApiUrl),
        endPoint = Text.Format("v1/workspaces/#{0}/sqlEndpoints/#{1}/connectionString", {workspaceId, sqlEndpointId}),
        connectionPath = if isPL then endPoint & "?privateLinkType=Workspace" else endPoint,
        url = Uri.Combine(workspaceSpecificApiUrl, connectionPath),
        connectionStringRecord = Utils[Web.JsonContents](
            url,
            /*headers*/ WorkspacePrivateLink[GetPrivateLinkS2SHeader](workspaceId),
            /*additionalHandlers*/ null,
            /*jsonBody*/ null,
            /*startState*/ null,
            /*traceContext*/ [Origin = Utils[NonPii]("GetSqlConnectionString2")] ),
        connectionString = if connectionStringRecord <> null and Record.HasFields(connectionStringRecord, "connectionString") then
                [ tdsEndpoint = connectionStringRecord[connectionString] ] else []
    in
        connectionString;

OneLakeSql.Publish = [
    Beta = true,
    Name = Extension.LoadString("OneLakeSql_Title"),
    SupportsDirectQuery = true,
    Category = "Fabric",
    ButtonText = {
            Extension.LoadString("OneLakeSql_Title"), Extension.LoadString("OneLakeSql_Description")
        },
    SourceImage = OneLakeSql.Icons,
    SourceTypeImage = OneLakeSql.Icons
];

OneLakeSql.Icons = [
    Icon16 = { Extension.Contents("OneLakeSql_16.png"), Extension.Contents("OneLakeSql_20.png"), Extension.Contents("OneLakeSql_20.png"), Extension.Contents("OneLakeSql_24.png") },
    Icon32 = { Extension.Contents("OneLakeSql_32.png"), Extension.Contents("OneLakeSql_40.png"), Extension.Contents("OneLakeSql_48.png"), Extension.Contents("OneLakeSql_64.png") }
];
