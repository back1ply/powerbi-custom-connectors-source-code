[ Version = "1.2.43" ]
section FabricSql;

FilterSchemasForHierarchicalNavigation = Utils[Value.ConvertToLogical](Environment.FeatureSwitch("MashupFlight_FilterSchemasForHierarchicalNavigation", false));

// For sensitivity label information in Excel
IncludeFabricSensitivityLabels = Utils[Value.ConvertToLogical](Environment.FeatureSwitch("IncludeFabricSensitivityLabels", false));

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
WorkspaceDlp = Extension.LoadFunction("Workspace.DLP.pqm");
FabricEnvironment = Extension.LoadFunction("FabricEnvironment.pqm");

AadSqlResource = FabricEnvironment[SqlResource];

Workspace = Extension.LoadFunction("Workspace.pqm", [
    Utils = Utils, 
    Table.NavigationTableView = Table.NavigationTableView,
    WorkspacePrivateLink = WorkspacePrivateLink,
    WorkspaceDlp = WorkspaceDlp
]);

FabricSql = [
    Type = "Custom",
    MakeResourcePath =  (optional options) => "FabricSql",
    ParseResourcePath = (options) => { },
    TestConnection = (dataSourcePath) => { "FabricSql.Contents" },
    Authentication = [
          Aad = [
                   AuthorizationUri = FabricEnvironment[AuthorizationUri],
                   Resource = "",
                   Scope = Utils[Utility.CreateOrderedScope]({FabricEnvironment[PowerBiResource], AadSqlResource})
                ]
           ],

    ApplicationProperties = [
        PBI_CapacityObjectId = [PropertyType = Text.Type, IsRequired = false],
        PBIEndpointUrl = [PropertyType = Text.Type, IsRequired = false]
    ],
    
// valid DSRs
/*
{"protocol":"fabric-sql", "address":{}}
{"protocol":"fabric-sql", "address":{"workspace":"66402100-396f-41d4-8e88-19e8c6ae0834"}}
{"protocol":"fabric-sql", "address":{"workspace":"66402100-396f-41d4-8e88-19e8c6ae0834", "sqlId":"a83d87f0-70e7-497a-8ad2-757a63d499ef"}}
{"protocol":"fabric-sql", "address":{"workspace":"66402100-396f-41d4-8e88-19e8c6ae0834", "sqlId":"a83d87f0-70e7-497a-8ad2-757a63d499ef", "schema":"model"}}
{"protocol":"fabric-sql", "address":{"workspace":"66402100-396f-41d4-8e88-19e8c6ae0834", "sqlId":"a83d87f0-70e7-497a-8ad2-757a63d499ef", "item":"Product", "schema":"model"}}
*/
    DSRHandlers = [
        #"fabric-sql" = [
            GetDSR = (optional options, optional navigation) =>
                let
                    workspace = navigation{0}?[workspaceId]?,
                    sqlId = navigation{2}?[sqlId]?,
                    displayName = navigation{2}?[displayName]?,
                    Item =  navigation{4}?[Item]?,
                    Schema =  navigation{4}?[Schema]?,
                    Name = navigation{6}?[Name]?,
                    // Relative References
                    isRelativeReference = workspace = ".",
                    finalWsId = if isRelativeReference then 
                        let
                            resolvedWsId = Variable.ValueOrDefault("currentWorkspaceId", "<error>")
                        in 
                            // return an error to fall back to parent DSR resolution
                            if resolvedWsId = "<error>" then error "Current Workspace could not be resolved."
                            else resolvedWsId
                    else workspace,
                    sqlIdOrDisplayName = if isRelativeReference then [displayName = displayName] else [sqlId = sqlId],
                    sqlIdOrSqlName = if isRelativeReference then [sqlName = displayName] else [sqlId = sqlId],
                    // end Relative References
                    NavigationWithoutData = List.RemoveItems(navigation, {"Data"}),
                    count = List.Count(NavigationWithoutData),
                    matchSqlWithItem = List.FirstN({ [workspaceId=workspace], sqlIdOrDisplayName, [Item = Item, Schema = Schema]}, count),
                    matchSqlWithHierarchicalNavigation = List.FirstN({[workspaceId=workspace], sqlIdOrDisplayName, [Schema = Schema], [Name = Name]}, count),
                    isValidFabricSql = matchSqlWithItem = NavigationWithoutData or List.FirstN(matchSqlWithHierarchicalNavigation, count) = NavigationWithoutData,
                    address = if navigation = null then []
                        else if not isValidFabricSql then ...
                        else Record.Combine(List.Select({[workspace = finalWsId], sqlIdOrSqlName, [item = if Item is null then Name else Item], [schema = Schema]}, each Record.ToList(_) <> { null }))
                in
                    {[protocol = "fabric-sql", address = address], options ?? []},
            GetFormula = (dsr, optional options) =>
                let
                    address = ValidateAddressRecord(dsr[address]),
                    workspace = Record.FieldOrDefault(address, "workspace", null),
                    sqlId = Record.FieldOrDefault(address, "sqlId", null),
                    sqlName = Record.FieldOrDefault(address, "sqlName", null),
                    item = Record.FieldOrDefault(address, "item", null),
                    schema = Record.FieldOrDefault(address, "schema", null),
                    relativeReferenceWorkspaceId = ".",
                    hasHierarchicalNavigation = options <> null and Value.Is(options, type record) and Record.HasFields(options, "HierarchicalNavigation") and options[HierarchicalNavigation] = true
                in
                    if (workspace <> null) then
                        if (sqlId <> null and item <> null and schema <> null) then
                         if (hasHierarchicalNavigation) then
                                () => FabricSql.Contents(options){[workspaceId=workspace]}[Data]{[sqlId=sqlId]}[Data]{[Schema=schema]}[Data]{[Name=item]}[Data]
                            else
                                () => FabricSql.Contents(options){[workspaceId=workspace]}[Data]{[sqlId=sqlId]}[Data]{[Item=item, Schema=schema]}[Data]
                        else if (sqlName <> null and item <> null and schema <> null) then
                             if (hasHierarchicalNavigation) then
                                () => FabricSql.Contents(options){[workspaceId=relativeReferenceWorkspaceId]}[Data]{[displayName=sqlName]}[Data]{[Schema=schema]}[Data]{[Name=item]}[Data]
                            else
                                () => FabricSql.Contents(options){[workspaceId=relativeReferenceWorkspaceId]}[Data]{[displayName=sqlName]}[Data]{[Item=item, Schema=schema]}[Data]
                        else if (sqlId <> null) then
                            if (hasHierarchicalNavigation = true and schema <> null) then
                                () => FabricSql.Contents(options){[workspaceId=workspace]}[Data]{[sqlId=sqlId]}[Data]{[Schema=schema]}[Data]
                            else
                                () => FabricSql.Contents(options){[workspaceId=workspace]}[Data]{[sqlId=sqlId]}[Data]
                        else if (sqlName <> null) then
                            if (hasHierarchicalNavigation = true and schema <> null) then
                                () => FabricSql.Contents(options){[workspaceId=relativeReferenceWorkspaceId]}[Data]{[displayName=sqlName]}[Data]{[Schema=schema]}[Data]
                            else
                                () => FabricSql.Contents(options){[workspaceId=relativeReferenceWorkspaceId]}[Data]{[displayName=sqlName]}[Data]
                        else
                            () => FabricSql.Contents(options){[workspaceId=workspace]}[Data]
                    else
                        () => FabricSql.Contents(options),
            GetFriendlyName = (dsr) => "Fabric Sql"
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
            sqlId = Guid.Type,
            item = Text.Type,
            schema = Text.Type,
            sqlName = Text.Type
        ])
    in
        validated;

[DataSource.Kind = "FabricSql", Publish="FabricSql.Publish"]
shared FabricSql.Contents = Value.ReplaceType(FabricSqlImpl, FabricSql.Type);

FabricSql.Type =
    let
       HierarchicalNavigationOptionType = type logical meta [
            Documentation.FieldCaption = Extension.LoadString("FabricSql.Fields.HierarchicalNavigation.FieldCaption")
       ],
       FabricSqlOptions = type [
            optional HierarchicalNavigation = HierarchicalNavigationOptionType
       ],
       FabricSql = type function (optional options as FabricSqlOptions)
                      as table meta [
                        Documentation.Name = Extension.LoadString("FabricSQL_Title"),
                        Documentation.Caption = Extension.LoadString("FabricSQL_Title"),
                        Documentation.Description = Extension.LoadString("FabricSQL_Description"),
                        Documentation.LongDescription = Extension.LoadString("FabricSQL_LongDescription")
                      ]
     in
       FabricSql;

FabricSqlImpl = (optional options as record) =>
    let
        nonNullOptions = options ?? [],

        result = Workspace[GetWorkspacesNavTable](GetFabricSqlInstances, nonNullOptions)
    in
        result;

GetFabricSqlInstances = (powerBIClusterUri as text, workspaceId as text, options as record, isRelativeReference as logical) as table =>
    let
        fabricSqlDiscoveryEndpoint = Uri.Combine(powerBIClusterUri, Text.Format("v1/workspaces/#{0}/items?type=SQLDatabase", {workspaceId})),
        jsonResponse = Utils[Web.JsonContents](
            fabricSqlDiscoveryEndpoint, 
            /*headers*/ WorkspacePrivateLink[GetPrivateLinkS2SHeader](workspaceId), 
            /*additionalHandlers*/ null, 
            /*jsonBody*/ null, 
            /*startState*/ null, 
            /*traceContext*/ [Origin = Utils[NonPii]("GetFabricSqlInstances")]),
        workspacesData = jsonResponse[value],
        validateFields = List.Transform(workspacesData, each if Record.HasFields(_, {"id", "displayName"})
            then _ else error Utils[Connector.GenerateErrorRecord]("GetFabricSQLFailure", Extension.LoadString("MissingFieldsError"), "GetFabricSQLInstances")),
        workspaces = Table.FromRecords(validateFields, {"id", "displayName"}),
        renameToSqlId = Table.RenameColumns(workspaces, {{"id", "sqlId"}}),
        keyName = if isRelativeReference = true then "displayName" else "sqlId",
        withData = Table.AddColumn(renameToSqlId, "Data", each GetTables(powerBIClusterUri, workspaceId, [sqlId], [displayName], options), type table),
        sqlIdForNavTable = if isRelativeReference = true then [sqlId = each [sqlId]] else [],
        nav = Table.NavigationTableView(
            () => withData,
            {keyName},
            (keyValue) => let
                    // For relative references case as the keyValue is sqlName, we need to load all artifacts in a workspace
                    // to fetch the sqlId corresponding to the sqlName. This will break the existing folding behavior.
                    sqlId = if isRelativeReference then GetSqlDbByName(withData, keyValue, workspaceId) else keyValue,
                    result = GetSqlEndPoint(powerBIClusterUri, workspaceId, sqlId),
                    connectionDetails = GenerateFabricSqlConnection(sqlId, result[properties]),
                    sensitivityLabelId = if IncludeFabricSensitivityLabels then Utils[GetSensitivityLabelId](result) else null,
                    sqlResult = GetFabricSqlDetails(connectionDetails[server], connectionDetails[db], options, sensitivityLabelId),
                    filteredResult = if FilterSchemasForHierarchicalNavigation then FilterSchemas(sqlResult, options) else sqlResult
                in
                    filteredResult,
            [
                Name = if isRelativeReference then "displayName" else {"displayName", each [displayName]},
                ItemKind = each "Database",
                ItemName = each "Database",
                IsLeaf = each false
            ] & sqlIdForNavTable)
    in
        nav;

GetSqlDbByName = (sqlDbsInWorkspace as table, sqlDbName as text, workspaceId as text) =>
    let
       sqlId = sqlDbsInWorkspace{[displayName=sqlDbName]}?[sqlId]?
    in
       if sqlId = null then
            error Table.ViewError(Error.Record(
                    Utils[NonPii]("DataSource.Error"),
                    Utils[NonPii](Extension.LoadString("SqlDatabaseNotFoundError")),
                    [
                        SqlDatabaseName = Utils[NonPii](sqlDbName),
                        WorkspaceId =  Utils[NonPii](workspaceId)
                    ],
                    {Utils[NonPii](sqlDbName), Utils[NonPii](workspaceId)}
                ))
       else
            sqlId;

GetTables = (powerBIClusterUri as text, workspaceId as text, artifactObjectId as text, fabricSqlName as text, options as record) as table =>
    let
        jsonResponse = GetSqlEndPoint(powerBIClusterUri, workspaceId, artifactObjectId),
        connectionDetails = GenerateFabricSqlConnection(artifactObjectId, jsonResponse[properties]),
        nav = GetFabricSqlDetails(connectionDetails[server], connectionDetails[db], options, if IncludeFabricSensitivityLabels then Utils[GetSensitivityLabelId](jsonResponse) else null)
     in
        FilterSchemas(nav, options);

FilterSchemas = (input, options) =>
    if FilterSchemasForHierarchicalNavigation and options[HierarchicalNavigation]?= true then
        Utils[FilterSystemSchemas](input) 
    else
        FilterSystemSchemas(input);
        
FilterSystemSchemas = (nav) =>
    let
        withoutSystemTables = Table.SelectRows(nav, each [Schema] <> "sys")
     in
        Table.View(withoutSystemTables,[
            OnInvoke = (function, args, index) =>
                if (function = Value.Versions) then Value.Versions(nav)
                else if (function = Value.VersionIdentity) then Value.VersionIdentity(nav)
                else ...,
            OnSelectRows = (selector) => Table.SelectRows(nav, selector), // Prevent the "sys" schema predicate from blocking folding
            GetExpression = () => Value.Expression(Value.Optimize(nav))
        ]);

GenerateFabricSqlConnection = (sqlId as text, sqlDbProperties as record) as record =>
    let
        lowerCasedSqlDbProperties = Record.FromList(Record.ToList(sqlDbProperties), List.Transform(Record.FieldNames(sqlDbProperties), Text.Lower)),
        serverDetails = lowerCasedSqlDbProperties[serverfqdn]? ?? "",
        databaseName = lowerCasedSqlDbProperties[databasename]? ?? "",
        provisioningState = lowerCasedSqlDbProperties[provisioningstate]?,
        sqlPropertiesAsText = Utils[Value.ToText](sqlDbProperties)
    in
        if Utils[Text.IsNullOrEmpty](serverDetails) or Utils[Text.IsNullOrEmpty](databaseName) then
        error Diagnostics.Trace(TraceLevel.Error, [Name = "GenerateFabricSqlConnection/MissingRequiredProperties", 
            Data = [SqlProperties = sqlPropertiesAsText], SafeData=[SqlId = sqlId]],
             Error.Record(
                Utils[NonPii]("DataSource.Error"),
                Utils[NonPii](Extension.LoadString("FabricSqlMissingProperties")),
                [
                    SqlDatabaseId = sqlId,
                    SqlDatabaseProperties = sqlPropertiesAsText
                ],
                {Utils[NonPii](sqlId), sqlPropertiesAsText}
                ))
        // There are discussions on removing provisoningState as public apis only return those artifacts with provisioning state as 'Active'.
        else if provisioningState <> null and provisioningState <> "Active" then 
        error Diagnostics.Trace(TraceLevel.Error, [Name = "GenerateFabricSqlConnection/SqlDBNotActive", Data = [SqlProperties = sqlPropertiesAsText], SafeData=[SqlId = sqlId]],
             Error.Record(
                Utils[NonPii]("DataSource.Error"),
                Utils[NonPii](Extension.LoadString("FabricSqlInValidState")),
                [
                    SqlDatabaseId = sqlId,
                    SqlDatabaseProperties = sqlPropertiesAsText
                ],
                {Utils[NonPii](sqlId), Utils[NonPii](provisioningState), sqlPropertiesAsText}
                ))
        else [server = serverDetails, db = databaseName];

GetSqlEndPoint = (powerBIClusterUri as text, workspaceId as text, artifactObjectId as text) as record  =>
    let
        url = Uri.Combine(powerBIClusterUri, Text.Format("v1/workspaces/#{0}/sqldatabases/#{1}", {workspaceId, artifactObjectId})),
        jsonResponse = Utils[Web.JsonContents](
            url, 
            /*headers*/ WorkspacePrivateLink[GetPrivateLinkS2SHeader](workspaceId), 
            /*additionalHandlers*/ null, 
            /*jsonBody*/ null, 
            /*startState*/ null, 
            /*traceContext*/ [Origin = Utils[NonPii]("GetSqlEndPoint")])
     in
        jsonResponse;

GetFabricSqlDetails = (tdsEndPoint as text, fabricSqlName as text, options as record, optional sensitivityLabelId as nullable text) =>
    Extension.InvokeWithCredentials(
         (datasource) => Utils[GetCredential](AadSqlResource),
         () =>
            let
                curatedOptions = Record.SelectFields(options, {"CommandTimeout", "CreateNavigationProperties", "HierarchicalNavigation"}, MissingField.Ignore),
                // Fabric SQL does not support cross-database folding, diabling it by default.
                fabricSql = Sql.Database(tdsEndPoint, fabricSqlName, curatedOptions & [EnableCrossDatabaseFolding=false]),
                sensitivityLabelApplied = if IncludeFabricSensitivityLabels then Utils[AddSensitivityTrait](fabricSql, sensitivityLabelId) else fabricSql
            in
                sensitivityLabelApplied
    );

FabricSql.Publish = [
    Beta = true,
    Name = Extension.LoadString("DataSourceLabel"),
    SupportsDirectQuery = true,
    Category = "Fabric",
    ButtonText = {
            Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp")
        },
    SourceImage = FabricSql.Icons,
    SourceTypeImage = FabricSql.Icons
];

FabricSql.Icons = [
    Icon16 = { Extension.Contents("FabricSQLDatabase_16.png"), Extension.Contents("FabricSQLDatabase_20.png"), Extension.Contents("FabricSQLDatabase_20.png"), Extension.Contents("FabricSQLDatabase_24.png") },
    Icon32 = { Extension.Contents("FabricSQLDatabase_32.png"), Extension.Contents("FabricSQLDatabase_40.png"), Extension.Contents("FabricSQLDatabase_48.png"), Extension.Contents("FabricSQLDatabase_64.png") }
];
