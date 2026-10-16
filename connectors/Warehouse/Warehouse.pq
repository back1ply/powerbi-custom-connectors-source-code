[ Version = "1.2.45" ]
section Warehouse;

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

FilterSchemasForHierarchicalNavigation = Utils[Value.ConvertToLogical](Environment.FeatureSwitch("MashupFlight_FilterSchemasForHierarchicalNavigation", false));

Utils = Extension.LoadFunction("Utils.pqm");
OutputInterceptor.Create = Extension.LoadFunction("OutputInterceptor.pqm");
WarehouseOutputInterceptor = Extension.LoadFunction("WarehouseOutputInterceptor.pqm", [
    OutputInterceptorCreate = OutputInterceptor.Create
]);
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

UseNewClusterAPI = Utils[Value.ConvertToLogical](Environment.FeatureSwitch("MashupFlight_UseNewClusterAPI", false));
UseOutputInterceptorVersionedWrites =
    let
        enabled = Utils[Value.ConvertToLogical](
            Environment.FeatureSwitch("MashupFlight_WarehouseOutputInterceptorVersionedWrites", false))
    in
        Diagnostics.Trace(
            TraceLevel.Information,
            [
                Name = "Warehouse/OutputInterceptorVersionedWrites",
                Data = [Enabled = Utils[NonPii](Utils[Value.ToText](enabled))]
            ],
            enabled);

// For sensitivity label information in Excel
IncludeFabricSensitivityLabels =
    let
        value = Utils[Value.ConvertToLogical](Environment.FeatureSwitch("IncludeFabricSensitivityLabels", false))
    in
        Diagnostics.Trace(
            TraceLevel.Information,
            [
                Name = "Warehouse/IncludeFabricSensitivityLabels",
                Data = [Enabled = Utils[NonPii](Utils[Value.ToText](value))]
            ],
            value);

Warehouse = [
    Type = "Custom",
    MakeResourcePath =  (optional options) => "Warehouse",
    ParseResourcePath = (options) => { },
    RedactResourcePath = (resourcePath, safecategories) => resourcePath,
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
{"protocol":"fabric-warehouse", "address":{}}
{"protocol":"fabric-warehouse", "address":{"workspace":"66402100-396f-41d4-8e88-19e8c6ae0834"}}
{"protocol":"fabric-warehouse", "address":{"workspace":"66402100-396f-41d4-8e88-19e8c6ae0834", "warehouse":"a83d87f0-70e7-497a-8ad2-757a63d499ef"}}
{"protocol":"fabric-warehouse", "address":{"workspace":"66402100-396f-41d4-8e88-19e8c6ae0834", "warehouse":"a83d87f0-70e7-497a-8ad2-757a63d499ef", "schema":"model"}}
{"protocol":"fabric-warehouse", "address":{"workspace":"66402100-396f-41d4-8e88-19e8c6ae0834", "warehouse":"a83d87f0-70e7-497a-8ad2-757a63d499ef", "item":"Product", "schema":"model"}}
*/
    DSRHandlers = [
        #"fabric-warehouse" = [
            GetDSR = (optional options, optional navigation) =>
                let
                    workspace = navigation{0}?[workspaceId]?,
                    warehouse = navigation{2}?[warehouseId]?,
                    warehouseDisplayName = navigation{2}?[displayName]?,
                    Item =  navigation{4}?[Item]?,
                    Schema =  navigation{4}?[Schema]?,
                    Name = navigation{6}?[Name]?,
                    NavigationWithoutData = List.RemoveItems(navigation, {"Data"}),
                    count = List.Count(NavigationWithoutData),

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
                    warehouseIdOrDisplayName = if isRelativeReference then [displayName = warehouseDisplayName] else [warehouseId = warehouse],
                    warehouseNameOrDisplayName = if isRelativeReference then [warehouseName = warehouseDisplayName] else [warehouse = warehouse],
                    // end Relative References

                    matchWarehouseWithItem = List.FirstN({ [workspaceId=workspace], warehouseIdOrDisplayName, [Item = Item, Schema = Schema]}, count),
                    matchWarehouseWithHierarchicalNavigation = List.FirstN({[workspaceId=workspace], warehouseIdOrDisplayName, [Schema = Schema], [Name = Name]}, count),
                    isValidWarehouse = matchWarehouseWithItem = NavigationWithoutData or List.FirstN(matchWarehouseWithHierarchicalNavigation, count) = NavigationWithoutData,
                    address = if navigation = null then []
                              else if not isValidWarehouse then ...
                              else Record.Combine(List.Select({[workspace = finalWsId], warehouseNameOrDisplayName, [item = if Item is null then Name else Item], [schema = Schema]}, each Record.ToList(_) <> { null }))
                in
                    {[protocol = "fabric-warehouse", address = address], options ?? []},
            GetFormula = (dsr, optional options) =>
                let
                    address = ValidateAddressRecord(dsr[address]),
                    workspace = Record.FieldOrDefault(address, "workspace", null),
                    warehouse = Record.FieldOrDefault(address, "warehouse", null),
                    warehouseName = Record.FieldOrDefault(address, "warehouseName", null),
                    item = Record.FieldOrDefault(address, "item", null),
                    schema = Record.FieldOrDefault(address, "schema", null),
                    relativeReferenceWorkspaceId = ".",
                    hasHierarchicalNavigation = options <> null and Value.Is(options, type record) and Record.HasFields(options, "HierarchicalNavigation") and options[HierarchicalNavigation] = true
                in
                    if (workspace <> null) then
                        if (warehouse <> null and item <> null and schema <> null) then
                            if (hasHierarchicalNavigation) then
                                () => Fabric.Warehouse(options){[workspaceId=workspace]}[Data]{[warehouseId=warehouse]}[Data]{[Schema=schema]}[Data]{[Name=item]}[Data]
                            else
                                () => Fabric.Warehouse(options){[workspaceId=workspace]}[Data]{[warehouseId=warehouse]}[Data]{[Item=item, Schema=schema]}[Data]
                        else if (warehouseName <> null and item <> null and schema <> null) then
                            if (hasHierarchicalNavigation) then
                                    () => Fabric.Warehouse(options){[workspaceId=relativeReferenceWorkspaceId]}[Data]{[displayName=warehouseName]}[Data]{[Schema=schema]}[Data]{[Name=item]}[Data]
                            else
                                () => Fabric.Warehouse(options){[workspaceId=relativeReferenceWorkspaceId]}[Data]{[displayName=warehouseName]}[Data]{[Item=item, Schema=schema]}[Data]
                        else if (warehouse <> null) then
                            if (hasHierarchicalNavigation = true and schema <> null) then
                                () => Fabric.Warehouse(options){[workspaceId=workspace]}[Data]{[warehouseId=warehouse]}[Data]{[Schema=schema]}[Data]
                            else
                                () => Fabric.Warehouse(options){[workspaceId=workspace]}[Data]{[warehouseId=warehouse]}[Data]
                        else if (warehouseName <> null) then
                            if (hasHierarchicalNavigation = true and schema <> null) then
                                () => Fabric.Warehouse(options){[workspaceId=relativeReferenceWorkspaceId]}[Data]{[displayName=warehouseName]}[Data]{[Schema=schema]}[Data]
                            else
                                () => Fabric.Warehouse(options){[workspaceId=relativeReferenceWorkspaceId]}[Data]{[displayName=warehouseName]}[Data]
                        else
                            () => Fabric.Warehouse(options){[workspaceId=workspace]}[Data]
                    else
                        () => Fabric.Warehouse(options),
            GetFriendlyName = (dsr) => "Fabric Warehouse"
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
            warehouse = Guid.Type,
            item = Text.Type,
            schema = Text.Type,
            warehouseName = Text.Type
        ])
    in
        validated;

[DataSource.Kind = "Warehouse", Publish="Warehouse.Publish"]
shared Fabric.Warehouse = Value.ReplaceType(WarehouseImpl, Warehouse.Type);

WarehouseImpl = (optional options as record) =>
    let
        nonNullOptions = options ?? [],
        
        testConnection = () => let
            firstWarehouse = Workspace[GetFirstWarehouse](Extension.LoadString("NoWarehousesFound")),
            warehouseId = firstWarehouse[warehouseId]?,
            workspaceId = firstWarehouse[workspaceId]?,
            result = Workspace[GetTDSEndPoint](workspaceId, warehouseId, "Warehouse", null),
            tdsEndPoint = result[tdsEndpoint]?,
            displayName = result[name]?
        in
            Sql.TestServerConnection(tdsEndPoint, displayName, warehouseId),

        result = Workspace[GetWorkspacesNavTable](GetWarehouses, nonNullOptions, testConnection)
    in
        result;

Warehouse.Type =
    let
       HierarchicalNavigationOptionType = type logical meta [
            Documentation.FieldCaption = Extension.LoadString("Warehouse.Fields.HierarchicalNavigation.FieldCaption")
       ],
       WarehouseOptions = type [
            optional HierarchicalNavigation = HierarchicalNavigationOptionType
       ],
       WarehouseType = type function (optional options as WarehouseOptions)
                      as table meta [
                        Documentation.Name = Extension.LoadString("Warehouse_Title"),
                        Documentation.Caption = Extension.LoadString("Warehouse_Title"),
                        Documentation.Description = Extension.LoadString("Warehouse_Description"),
                        Documentation.LongDescription = Extension.LoadString("Warehouse_LongDescription")
                      ]
     in
       WarehouseType;

GetWarehouses = (powerBIClusterUri as text, workspaceId as text, options as record, isRelativeReference as logical) as table =>
    let
        warehouseEndpoint = Uri.Combine(powerBIClusterUri, Text.Format("v1/workspaces/#{0}/items?type=Warehouse", {workspaceId})),
        jsonResponse = Utils[Web.JsonContents](
            warehouseEndpoint, 
            /*headers*/ WorkspacePrivateLink[GetPrivateLinkS2SHeader](workspaceId), 
            /*additionalHandlers*/ null, 
            /*jsonBody*/ null, 
            /*startState*/ null, 
            /*traceContext*/ [Origin = Utils[NonPii]("GetWarehouses")]),
        workspacesData = jsonResponse[value],
        withSensitivityInfo =
            if IncludeFabricSensitivityLabels then
                List.Transform(
                    workspacesData,
                    (item as record) =>
                        item & [sensitivityLabelId = Utils[GetSensitivityLabelId](item)]
                )
            else
                workspacesData,
        validateFields = List.Transform(withSensitivityInfo, each if Record.HasFields(_, {"id", "displayName"})
            then _ else error Utils[Connector.GenerateErrorRecord]("GetWarehousesFailure", Extension.LoadString("MissingFieldsError"), "GetWarehouses")),
        warehouses = Table.FromRecords(validateFields, if IncludeFabricSensitivityLabels then {"id","displayName","sensitivityLabelId"} else {"id","displayName"}),
        renameToWarehouseId = Table.RenameColumns(warehouses, {{"id", "warehouseId"}}),
        keyName = if isRelativeReference then "displayName" else "warehouseId",
        withData =
            Table.AddColumn(
                renameToWarehouseId,
                "Data",
                each GetTables(workspaceId, [warehouseId], [displayName], options, [sensitivityLabelId]?),
                type table),
        withWarehouseIdForNavTable = if isRelativeReference then [warehouseId = each [warehouseId]] else [],
        nav = Table.NavigationTableView(
            () => withData,
            {keyName},
            (keyValue) => 
                let
                    // For relative references case as the keyValue is warehouseName, we need to load all artifacts in a workspace
                    // to fetch the dwId corresponding to the warehouseName. This will break the existing folding behavior.
                    dwId = if isRelativeReference = true then GetDwIdByName(withData, keyValue, workspaceId) else keyValue,
                    result = Workspace[GetTDSEndPoint](workspaceId, dwId, "Warehouse", null),
                    tdsEndPoint = result[tdsEndpoint],
                    displayName = if isRelativeReference then keyValue else result[name]? ?? withData{[warehouseId = dwId]}[displayName],
                    sensitivityLabelId = GetWarehouseSensitivityLabelId(powerBIClusterUri, workspaceId, dwId),
                    warehouseResults = GetWarehouse(tdsEndPoint, displayName, options, sensitivityLabelId),
                    filteredResult = if FilterSchemasForHierarchicalNavigation then 
                        FilterSchemasFromSql(warehouseResults, tdsEndPoint, displayName, dwId, options) 
                    else 
                        warehouseResults
                in
                    filteredResult,
            [
                Name = if isRelativeReference then "displayName" else {"displayName", each [displayName]},
                ItemKind = each "Database",
                ItemName = each "Database",
                IsLeaf = each false
            ] & withWarehouseIdForNavTable,
            [ 
                OnTestConnection = () => 
                    let
                        warehouseId = Table.First(warehouses)[id]?,
                        result = Workspace[GetTDSEndPoint](workspaceId, warehouseId, "Warehouse", null),
                        tdsEndPoint = result[tdsEndpoint]?,
                        displayName = result[name]? ?? withData{[warehouseId = warehouseId]}[displayName]
                    in
                        if (warehouseId <> null) then Sql.TestServerConnection(tdsEndPoint, displayName, warehouseId)
                            else Sql.TestServerConnection(null, null, "")
            ])
    in
        nav;

GetWarehouseSensitivityLabelId = (powerBIClusterUri as text, workspaceId as text, warehouseId as text) as nullable text =>
    if IncludeFabricSensitivityLabels
        then Utils[GetSensitivityLabelId](Workspace[GetWarehouseInformation](workspaceId, warehouseId))
    else
        null;

GetDwIdByName = (dwInWorkspace as table, dwName as text, workspaceId as text) =>
    let
       dwId = dwInWorkspace{[displayName=dwName]}?[warehouseId]?
    in
       if dwId = null then
            error Table.ViewError(Error.Record(
                    Utils[NonPii]("DataSource.Error"),
                    Utils[NonPii](Extension.LoadString("FabricDWNotFoundError")),
                    [
                        DwName = Utils[NonPii](dwName),
                        WorkspaceId = Utils[NonPii](workspaceId)
                    ],
                    {Utils[NonPii](dwName), Utils[NonPii](workspaceId)}
                ))
       else
            dwId;

GetTables = (workspaceId as text, artifactObjectId as text, warehouseName as text, options as record, optional sensitivityLabelId as nullable text) as table =>
    let
        jsonResponse = Workspace[GetTDSEndPoint](workspaceId, artifactObjectId, "Warehouse", null),
        tdsEndPoint = jsonResponse[tdsEndpoint],
        nav = GetWarehouse(tdsEndPoint, warehouseName, options, sensitivityLabelId)
    in
       FilterSchemasFromSql(nav, tdsEndPoint, warehouseName, artifactObjectId, options);

FilterSchemasFromSql = (input, tdsEndPoint, warehouseName, artifactObjectId, options) =>
    if FilterSchemasForHierarchicalNavigation and options[HierarchicalNavigation]?= true then
        Utils[FilterSystemSchemas](input) 
    else
        FilterSystemSchemas(input, tdsEndPoint, warehouseName, artifactObjectId);
        
FilterSystemSchemas = (nav, tdsEndPoint, warehouseName, artifactObjectId) =>
    let
        withoutSystemTables = Table.SelectRows(nav, each [Schema] <> "sys")
     in
        Table.View(withoutSystemTables,[
            OnInvoke = (function, args, index) =>
                if (function = Value.Versions) then Value.Versions(nav)
                else if (function = Value.VersionIdentity) then Value.VersionIdentity(nav)
                else ...,
            OnSelectRows = (selector) => Table.SelectRows(nav, selector), // Prevent the "sys" schema predicate from blocking folding
            GetExpression = () => Value.Expression(Value.Optimize(nav)),
            OnTestConnection = () => Sql.TestServerConnection(tdsEndPoint, warehouseName, artifactObjectId)
        ]);

GetWarehouse = (tdsEndPoint as text, warehouseName as text, options as record, optional sensitivityLabelId as nullable text) =>
    Extension.InvokeWithCredentials(
        (datasource) => Utils[GetCredential](AadSqlResource),
        () =>
            let
                curatedOptions = Record.SelectFields(options, {"CommandTimeout", "CreateNavigationProperties", "HierarchicalNavigation"}, MissingField.Ignore),
                warehouse = Sql.Database(tdsEndPoint, warehouseName, curatedOptions & [EnableCrossDatabaseFolding=true]),
                outputDestination =
                    if UseOutputInterceptorVersionedWrites then
                        WarehouseOutputInterceptor[WrapDatabase](
                            warehouse,
                            tdsEndPoint,
                            warehouseName,
                            curatedOptions[HierarchicalNavigation]? ?? false)
                    else
                        warehouse,
                sensitivityLabelApplied =
                    if IncludeFabricSensitivityLabels then
                        Utils[AddSensitivityTrait](outputDestination, sensitivityLabelId)
                    else
                        outputDestination
            in
                sensitivityLabelApplied
    );

Sql.TestConnection = (serverInstance as nullable text, dbname as nullable text, warehouseId as nullable text) =>
    Extension.InvokeWithCredentials(
        (datasource) => Utils[GetCredential](AadSqlResource),
        () =>
            let
                ErrorMessageFormat = Extension.LoadString("TestConnectionFailure"),
                result = if (serverInstance <> null) then DataSource.TestConnection(Sql.Database(serverInstance, dbname)) else
                    error Error.Record(Utils[NonPii]("DataSource.Error"), Utils[NonPii](ErrorMessageFormat), [], {Utils[NonPii](warehouseId), serverInstance, dbname})
            in
                try result catch (e) => error Diagnostics.Trace(TraceLevel.Error, [
                        Name = "SqlTestConnectionFailure",
                        Data = [ Exception = Utils[Value.ToText](e) ],
                        SafeData = [ WarehouseId = warehouseId ]
                    ], e)
    );

// Server-only variant of Sql.TestConnection. Probes the SQL endpoint using
// Sql.Databases(serverInstance) rather than Sql.Database(serverInstance, dbname),
// so the host validates only "AAD token works AND TDS server is reachable" without
// requiring the selected warehouse database to be enumerable.
Sql.TestServerConnection = (serverInstance as nullable text, dbname as nullable text, warehouseId as nullable text) =>
    Extension.InvokeWithCredentials(
        (datasource) => Utils[GetCredential](AadSqlResource),
        () =>
            let
                ErrorMessageFormat = Extension.LoadString("TestConnectionFailure"),
                result = if (serverInstance <> null) then DataSource.TestConnection(Sql.Databases(serverInstance)) else
                    error Error.Record(Utils[NonPii]("DataSource.Error"), Utils[NonPii](ErrorMessageFormat), [], {Utils[NonPii](warehouseId), serverInstance, dbname})
            in
                try result catch (e) => error Diagnostics.Trace(TraceLevel.Error, [
                        Name = "SqlTestServerConnectionFailure",
                        Data = [ Exception = Utils[Value.ToText](e) ],
                        SafeData = [ WarehouseId = warehouseId ]
                    ], e)
    );


Warehouse.Publish = [
    Name = Extension.LoadString("DataSourceLabel"),
    SupportsDirectQuery = true,
    Category = "Fabric",
    ButtonText = {
            Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp")
        },
    SourceImage = Warehouse.Icons,
    SourceTypeImage = Warehouse.Icons
];

Warehouse.Icons = [
    Icon16 = { Extension.Contents("Warehouse_16.png"), Extension.Contents("Warehouse_20.png"), Extension.Contents("Warehouse_20.png"), Extension.Contents("Warehouse_24.png") },
    Icon32 = { Extension.Contents("Warehouse_32.png"), Extension.Contents("Warehouse_40.png"), Extension.Contents("Warehouse_48.png"), Extension.Contents("Warehouse_64.png") }
];
