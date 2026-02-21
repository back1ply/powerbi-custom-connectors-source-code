[ Version = "1.2.16" ]
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

AadSqlResource = "https://database.windows.net/";

Utils = Extension.LoadFunction("Utils.pqm");
Table.NavigationTableView = Extension.LoadFunction("Table.NavigationTableView.pqm");
Fabric.GetClusterUrl = Extension.LoadFunction("Fabric.GetClusterUrl.pqm", [Utils = Utils]);
WorkspacePrivateLink = Extension.LoadFunction("Workspace.PrivateLink.pqm", [Utils = Utils]);
WorkspaceDlp = Extension.LoadFunction("Workspace.DLP.pqm");
Workspace = Extension.LoadFunction("Workspace.pqm", [
    Fabric.GetClusterUrl = Fabric.GetClusterUrl,
    Utils = Utils,
    Table.NavigationTableView = Table.NavigationTableView,
    WorkspacePrivateLink = WorkspacePrivateLink,
    WorkspaceDlp = WorkspaceDlp
]);

UseNewClusterAPI = Utils[Value.ConvertToLogical](Environment.FeatureSwitch("MashupFlight_UseNewClusterAPI", false));

Warehouse = [
    Type = "Custom",
    MakeResourcePath =  (optional options) => "Warehouse",
    ParseResourcePath = (options) => { },
    RedactResourcePath = (resourcePath, safecategories) => resourcePath,
    Authentication = [
          Aad = [
                   AuthorizationUri = Uri.Combine(Environment.FeatureSwitch("AzureActiveDirectoryUri", "https://login.microsoftonline.com"), "common/oauth2/authorize"),
                   Resource = "",
                   Scope = Utils[Utility.CreateScope](AadSqlResource, Environment.FeatureSwitch("PowerBiAadResource", "https://analysis.windows.net/powerbi/api"))
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
                    Item =  navigation{4}?[Item]?,
                    Schema =  navigation{4}?[Schema]?,
                    Name = navigation{6}?[Name]?,
                    NavigationWithoutData = List.RemoveItems(navigation, {"Data"}),
                    count = List.Count(NavigationWithoutData),
                    matchWarehouseWithItem = List.FirstN({ [workspaceId=workspace], [warehouseId=warehouse], [Item = Item, Schema = Schema]}, count),
                    matchWarehouseWithHierarchicalNavigation = List.FirstN({[workspaceId=workspace], [warehouseId=warehouse], [Schema = Schema], [Name = Name]}, count),
                    isValidWarehouse = List.FirstN(matchWarehouseWithItem, count) = NavigationWithoutData or List.FirstN(matchWarehouseWithHierarchicalNavigation, count) = NavigationWithoutData,
                    address = if navigation = null then []
                              else if not isValidWarehouse then ...
                              else Record.Combine(List.Select({[workspace = workspace], [warehouse = warehouse], [item = if Item is null then Name else Item], [schema = Schema]}, each Record.ToList(_) <> { null }))
                in
                    {[protocol = "fabric-warehouse", address = address], options ?? []},
            GetFormula = (dsr, optional options) =>
                let
                    address = ValidateAddressRecord(dsr[address]),
                    workspace = Record.FieldOrDefault(address, "workspace", null),
                    warehouse = Record.FieldOrDefault(address, "warehouse", null),
                    item = Record.FieldOrDefault(address, "item", null),
                    schema = Record.FieldOrDefault(address, "schema", null),
                    hasHierarchicalNavigation = options <> null and Value.Is(options, type record) and Record.HasFields(options, "HierarchicalNavigation") and options[HierarchicalNavigation] = true
                in
                    if (workspace <> null) then
                        if (warehouse <> null and item <> null and schema <> null) then
                            if (hasHierarchicalNavigation) then
                                () => Fabric.Warehouse(options){[workspaceId=workspace]}[Data]{[warehouseId=warehouse]}[Data]{[Schema=schema]}[Data]{[Name=item]}[Data]
                            else
                                () => Fabric.Warehouse(options){[workspaceId=workspace]}[Data]{[warehouseId=warehouse]}[Data]{[Item=item, Schema=schema]}[Data]
                        else if (warehouse <> null) then
                            if (hasHierarchicalNavigation = true and schema <> null) then
                                () => Fabric.Warehouse(options){[workspaceId=workspace]}[Data]{[warehouseId=warehouse]}[Data]{[Schema=schema]}[Data]
                            else
                                () => Fabric.Warehouse(options){[workspaceId=workspace]}[Data]{[warehouseId=warehouse]}[Data]
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
            schema = Text.Type
        ])
    in
        validated;

[DataSource.Kind = "Warehouse", Publish="Warehouse.Publish"]
shared Fabric.Warehouse = Value.ReplaceType(WarehouseImpl, Warehouse.Type);

WarehouseImpl = (optional options as record) =>
    let
        nonNullOptions = options ?? [],
        
        testConnection = () => let
            firstWarehouse = Workspace[GetFirstWarehouse](),
            warehouseId = firstWarehouse[warehouseId]?,
            workspaceId = firstWarehouse[workspaceId]?,
            result = Workspace[GetTDSEndPoint](workspaceId, warehouseId, "Warehouse"),
            tdsEndPoint = result[tdsEndpoint]?,
            displayName = result[name]?
        in
            Sql.TestConnection(tdsEndPoint, displayName, warehouseId),

        result = Workspace[GetWorkspacesNavTable](GetWarehouses, nonNullOptions, testConnection)
    in
        result;

Warehouse.Type =
    let
       WarehouseType = type function (optional options as record)
                      as table meta [
                        Documentation.Name = Extension.LoadString("Warehouse_Title"),
                        Documentation.Caption = Extension.LoadString("Warehouse_Title"),
                        Documentation.Description = Extension.LoadString("Warehouse_Description"),
                        Documentation.LongDescription = Extension.LoadString("Warehouse_LongDescription")
                      ]
     in
       WarehouseType;

GetWarehouses = (powerBIClusterUri as text, workspaceId as text, options as record) as table =>
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
        validateFields = List.Transform(workspacesData, each if Record.HasFields(_, {"id", "displayName"})
            then _ else error Utils[Connector.GenerateErrorRecord]("GetWarehousesFailure", Extension.LoadString("MissingFieldsError"), "GetWarehouses")),
        warehouses = Table.FromRecords(validateFields, {"id", "displayName"}),
        renameToWarehouseId = Table.RenameColumns(warehouses, {{"id", "warehouseId"}}),
        withData = Table.AddColumn(renameToWarehouseId, "Data", each GetTables(workspaceId, [warehouseId], [displayName], options), type table),
        nav = Table.NavigationTableView(
            () => withData,
            {"warehouseId"},
            (_warehouseId) => let
                                result = Workspace[GetTDSEndPoint](workspaceId, _warehouseId, "Warehouse"),
                                tdsEndPoint = result[tdsEndpoint],
                                displayName = result[name]? ?? withData{[warehouseId = _warehouseId]}[displayName]
                              in
                                GetWarehouse(tdsEndPoint, displayName, options),
            [
                Name = {"displayName", each [displayName]},
                ItemKind = each "Database",
                ItemName = each "Database",
                IsLeaf = each false
            ],
            [ 
                OnTestConnection = () => 
                    let
                        warehouseId = Table.First(warehouses)[id]?,
                        result = Workspace[GetTDSEndPoint](workspaceId, warehouseId, "Warehouse"),
                        tdsEndPoint = result[tdsEndpoint]?,
                        displayName = result[name]? ?? withData{[warehouseId = warehouseId]}[displayName]
                    in
                        if (warehouseId <> null) then Sql.TestConnection(tdsEndPoint, displayName, warehouseId)
                            else Sql.TestConnection(null, null, "")
            ])
    in
        nav;

GetTables = (workspaceId as text, artifactObjectId as text, warehouseName as text, options as record) as table =>
    let
          jsonResponse = Workspace[GetTDSEndPoint](workspaceId, artifactObjectId, "Warehouse"),
          tdsEndPoint = jsonResponse[tdsEndpoint],
          nav = GetWarehouse(tdsEndPoint, warehouseName, options),
          withoutSystemTables = Table.SelectRows(nav, each [Schema] <> "sys")
     in
         Table.View(withoutSystemTables,[
            OnInvoke = (function, args, index) =>
                if (function = Value.Versions) then Value.Versions(nav)
                else if (function = Value.VersionIdentity) then Value.VersionIdentity(nav)
                else ...,
            OnSelectRows = (selector) => Table.SelectRows(nav, selector), // Prevent the "sys" schema predicate from blocking folding
            GetExpression = () => Value.Expression(Value.Optimize(nav)),
            OnTestConnection = () => Sql.TestConnection(tdsEndPoint, warehouseName, artifactObjectId)
          ]);

GetWarehouse = (tdsEndPoint as text, warehouseName as text, options as record) =>
    Extension.InvokeWithCredentials(
         (datasource) => Utils[GetCredential](AadSqlResource),
         () =>
            let
                curatedOptions = Record.SelectFields(options, {"CommandTimeout", "CreateNavigationProperties", "HierarchicalNavigation"}, MissingField.Ignore),
                warehouse = Sql.Database(tdsEndPoint, warehouseName, curatedOptions & [EnableCrossDatabaseFolding=true])
            in
                warehouse
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
