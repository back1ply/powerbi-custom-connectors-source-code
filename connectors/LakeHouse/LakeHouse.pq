[
    Version = "1.0.197",
    Requires = [
        Core = "[0.0,)",
        DataSource = "[0.0,)",
        Environment = "[0.0,)",
        Extensibility = "[0.0,)",
        DeltaLake="[0.0,)",
        Web="[0.0,)",
        AzureDataLakeStorage="[0.0,)",
        Sql="[0.0,)",
        Action="[0.0,)",
        SqlView = "[0.0,)"
    ]
]
section Lakehouse;

// -----------------------------------------------------
// | 1. Lakehouse.Contents() Navigation Table
// -----------------------------------------------------
//  |- Lakehouse
//      |- Workspace
//      |- Workspace
//          |- Lakehouse Artifact
//                  |- Tables
//          |- Lakehouse Artifact
//                  |- Tables
//
// -----------------------------------------------------


PBIBaseUrl = Environment.FeatureSwitch("PowerBiUri", "https://api.powerbi.com");
AadWorkspaceApiOAuthResource = Environment.FeatureSwitch("PowerBiAadResource", "https://analysis.windows.net/powerbi/api");
AadAuthorizationUri =  Uri.Combine(Environment.FeatureSwitch("AzureActiveDirectoryUri", "https://login.microsoftonline.com"), "/common/oauth2/authorize");
AadAdlsStorageResource = "https://storage.azure.com";
AadSqlResource = "https://database.windows.net/";
AadRedirectUrl = "https://oauth.powerbi.com/views/oauthredirect.html";

DeltaLake.DefaultOptions = [Compression=Compression.Snappy];

UseDmsTableApi = Utils[Value.ConvertToLogical](Environment.FeatureSwitch("MashupFlight_EnableDMSTableApi", true));
ValidateStagingArtifacts = Utils[Value.ConvertToLogical](Environment.FeatureSwitch("MashupFlight_ValidateStagingArtifacts", false));
FixedSchemaFix = Utils[Value.ConvertToLogical](Environment.FeatureSwitch("MashupFlight_FixedSchemaFix", true));
DisableDmsDelayedBackgroudProcessing = Utils[Value.ConvertToLogical](Environment.FeatureSwitch("MashupFlight_DisableDmsDelayedBackgroudProcessing", true));
LogSqlErrorCodesFromDMSResponse = Utils[Value.ConvertToLogical](Environment.FeatureSwitch("MashupFlight_LogSqlErrorCodesFromDMSResponse", true));
IgnoreTableNameValidation = Utils[Value.ConvertToLogical](Environment.FeatureSwitch("MashupFlight_IgnoreTableNameValidation", true));
DynamicSchemaEmptyTableFix = Utils[Value.ConvertToLogical](Environment.FeatureSwitch("MashupFlight_DynamicSchemaEmptyTableFix", true));
MaxDMSBatchDuration = Value.ConvertToNumber(Environment.FeatureSwitch("MashupFlight_MaxDMSBatchDuration", 3600)); //batch duration of 1 hour by default.
UseFileCache = Utils[Value.ConvertToLogical](Environment.FeatureSwitch("MashupFlight_UseFileCache", false));
DMSUseLongPolling = Utils[Value.ConvertToLogical](Environment.FeatureSwitch("MashupFlight_DMSUseLongPolling", true));
ReportDMSBatchDuration = Utils[Value.ConvertToLogical](Environment.FeatureSwitch("MashupFlight_ReportDMSBatchDuration", true));
CacheTrimDuration = Value.ConvertToNumber(Environment.FeatureSwitch("MashupFlight_CacheTrimDuration", 86400));
EnablePartitionedRefresh = Utils[Value.ConvertToLogical](Environment.FeatureSwitch("MashupFlight_EnablePartitionedRefresh", false));
ForceMDSyncForODLakehouse = Utils[Value.ConvertToLogical](Environment.FeatureSwitch("MashupFlight_ForceMDSyncForODLakehouse", false));
TranslateKeyNotFound = Utils[Value.ConvertToLogical](Environment.FeatureSwitch("MashupFlight_TranslateKeyNotFound", false));
HideSysAndQueryInsightsSchema = Utils[Value.ConvertToLogical](Environment.FeatureSwitch("MashupFlight_HideSysAndQueryInsightsSchema", false));
EnableHierarchicalNavigationSupport = Utils[Value.ConvertToLogical](Environment.FeatureSwitch("MashupFlight_EnableHierarchicalNavigationSupport", false));

//TODO use FailIfPollingExpiresFlag once TableAPI is propertly tested
// TODO revisit the MaxIterationCount and PollingCount once we have more data from telemetry.
// With the polling multiplier of 1.22, with 20 retries we will wait for a max of around 5 mins per batch
// For Long Polling we will poll a max of 5 times without delay. 
MetadataSyncConfig = if UseDmsTableApi then if DMSUseLongPolling then
            [MaxIterationCount = 55, PollingCount = 5, NothingInProgressIterationCount = 55, PollingDelayMultiplier=1]
        else
            [MaxIterationCount = 55, PollingCount = 20, NothingInProgressIterationCount = 55, PollingDelayMultiplier=1.22]
    else [MaxIterationCount = 1, PollingCount = 55, NothingInProgressIterationCount = 25, PollingDelayMultiplier = 1.1];

// This folder will hold all the version folders which are created in the connector as a part of Replace and Append Data scenarios
TemporaryParentVersionFolder = "_mashup_temporary";
CreatedMarker = ".created";
DeletedMarker = ".deleted";
ReplaceMarker = ".replace";

IsNonPii = (x) => Value.Metadata(x)[Is.Pii]? = false;

CreateSafeRecordToLog = (input as record) =>
    let
        withNonPiiMeta = List.Transform(Record.FieldValues(input), (t) => Utils[NonPii](t)),
        fieldNames = Record.FieldNames(input)
    in
        Record.FromList(withNonPiiMeta, fieldNames);

/**
Cache Setup
*/
BaseCacheKeyFormat = "#{0}.#{1}";
OneLakeFilesPathFormat =  "#{0}/#{1}/#{2}/Files";
OneLakeCacheFolderFilesPathFormat =  Text.Combine({"#{0}/#{1}/#{2}/Files/", CacheParentFolder});
OneLakeFilesContentPathFormat =  Text.Combine({"#{0}/#{1}/#{2}/Files/" , CacheParentFolder , "/#{3}"});
CacheParentFolder = "FileCache";
cloud = Environment.FeatureSwitch("Cloud", "global");
LakehouseCacheParentTable = (workspaceId as text, lakehouseId as text, isMsit as logical) => OneLake.Contents(Text.Format(OneLakeFilesPathFormat, {OneLakeFilesPathBaseUrl(cloud, isMsit), workspaceId, lakehouseId}));
LakehouseCacheTable = (workspaceId as text, lakehouseId as text, isMsit as logical) => OneLake.Contents(Text.Format(OneLakeCacheFolderFilesPathFormat, {OneLakeFilesPathBaseUrl(cloud, isMsit), workspaceId, lakehouseId}));
LakehouseCacheFile = (workspaceId as text, lakehouseId as text, cacheKey as text, isMsit as logical) => Binary.Buffer(OneLake.FileContents(Text.Format(OneLakeFilesContentPathFormat, {OneLakeFilesPathBaseUrl(cloud, isMsit), workspaceId, lakehouseId, cacheKey})));
OneLakeFilesPathBaseUrl = (cloudEnv, isMsit as logical) => LakehouseUtils[GetOneLakeBaseUrl](cloudEnv, isMsit, true);
// END of Cache Setup

// TODO : Add Support for Equals.
SupportedOperatorsForParitionedRefresh = {"GreaterThanOrEquals", "LessThan"};

KeyNotFoundErrorCode = "10061";

OneLakeUriFormat = "https://#{0}/v1.0/workspaces/#{1}/artifacts/#{2}/sasuri?expiryTimeInMinutes=#{3}&subFolderPath=#{4}";
// End Workspace PL Setup.

IsHierarchicalNavigationEnabled = (options) => 
    EnableHierarchicalNavigationSupport and options[HierarchicalNavigation]? = true;

[DataSource.Kind="Lakehouse", Publish="Lakehouse.Publish"]
shared Lakehouse.Contents = Value.ReplaceType(LakehouseView, LakehouseType);

LakehouseType =
    let
        functionType = type function (optional options as record)
            as table meta [
                Documentation.Name = Extension.LoadString("DataSourceLabel"),
                Documentation.Caption = Extension.LoadString("lakehouse.caption"),
                Documentation.Description = Extension.LoadString("lakehouse.description"),
                Documentation.LongDescription = Extension.LoadString("lakehouse.longDescription")
            ]
    in
        functionType;

LakehouseView = (optional options as record) as table =>
    let
        invoke = LakehouseImpl(options),
        view = (x) => Table.View(null, Handlers((op, transform) =>
            if List.Contains({"GetRows", "GetType", "GetRowCount", "GetExpression", "OnTestConnection"}, op) then transform(x(invoke))
            else @view((y) => transform(x(y)))))
    in
        view((t) => t);

LakehouseImpl = (optional options as record) => Lakehouses(options);

Lakehouses = (options) =>
    let
        result = GetNavTableForLakehouses(options)
    in
        result;


GetNavTableForLakehouses = (options as nullable record) as nullable table =>
    let
        baseUrl = Fabric.GetClusterUrl(PBIBaseUrl)
    in
        GetWorkspaces2(baseUrl, options ?? []);

GetWorkspaces2 = (baseUrl as text, options as record) =>
    let
        dlpPolicies = WorkspaceDlp[GetDlpPolicies](),
        allWorkspaces = GetWorkspaces(baseUrl, options),
        // Filter workspaces based on DLP policy
        workspaces = Diagnostics.Trace(
            TraceLevel.Information,
            [
                Name = "GetWorkspaces2/ApplyWorkspaceDlp",
                Data = [
                    DlpPolicies = Utils[NonPii](Utils[Value.ToText](dlpPolicies))
                ]
            ],
            Table.SelectRows(allWorkspaces, each WorkspaceDlp[IsWorkspaceAllowed]([workspaceId], dlpPolicies))),
        // build nav table
        navTable = Table.NavigationTableView(
            () => workspaces,
            {"workspaceId"},
            (workspaceId) => GetNavTableForWorkspace(WorkspacePrivateLink[GetWorkspaceBaseUrl](baseUrl, workspaceId), workspaceId, options),
            [
                Name = {"workspaceName", each [workspaceName]},
                ItemKind = each "Folder",
                ItemName = each "Folder",
                IsLeaf = each false
            ],
            [
                OnTestConnection = () => 
                let
                    firstLakehouse = GetFirstLakehouse(workspaces, baseUrl),
                    lakehouseDbId = firstLakehouse[lakehouseDbId]?,
                    workspaceId = firstLakehouse[workspaceId]?,
                    database = GetLakehouseDatabase(baseUrl, workspaceId, lakehouseDbId)
                in
                    Sql.TestConnection(database, lakehouseDbId)
            ])
    in
        navTable;

GetFirstLakehouse = (allWorkspaces as table, baseUrl as text) as record =>
    let
        allLakehouses = Table.AddColumn(allWorkspaces, "lakehouseDbId", each GetFirstLakehouseDbId([workspaceId], baseUrl)),
        firstLakehouse = Table.First(Table.SelectRows(allLakehouses, each [lakehouseDbId] <> null))
    in
        firstLakehouse;

GetFirstLakehouseDbId = (workspaceId as text, baseUrl as text) as any =>
    let
        lakehouses = GetLakehousePublicAPIWitoutData(baseUrl, workspaceId, []),
        withDatabaseIdOnly = Table.SelectRows(lakehouses, each [databaseId] <> null)
    in
        Table.First(withDatabaseIdOnly)[databaseId]?;

LakehouseNavTableType = type table [
    lakehouseId=text,
    lakehouseName=text,
    description=nullable text,
    capacityObjectId=nullable text,
    extendedProperties=any,
    Data=table,
    databaseId=nullable text
];

LakehouseTableDetailType = type table [
    Name = text,
    Id = text,
    Data = table,
    Schema = nullable text,
    ItemKind = text,
    ItemName = text,
    IsLeaf = logical
];

GetNavTableForWorkspace = (baseUrl as text, workspaceId as text, options as record) as nullable table =>
    let
        dlpPolicies = WorkspaceDlp[GetDlpPolicies](),
        validatedWorkspaceId = WorkspaceDlp[CheckWorkspaceAllowed](workspaceId, dlpPolicies),
        lakehouses = GetLakehouses(baseUrl, validatedWorkspaceId, options),
        warehouses = GetWarehouses(baseUrl, validatedWorkspaceId, options),
        includeWarehouses = options[IncludeWarehouses]? ?? false,
        all = if includeWarehouses then Table.Combine({lakehouses, warehouses}) else lakehouses,
        emptyTable = AddLakehouseTrivia(#table(LakehouseNavTableType, {})),

        navTable = Table.View(null, [
            GetType = () => Value.Type(emptyTable),
            GetRows = () => AddLakehouseTrivia(all),

            OnSelectRows = (selector) =>
                let
                    index = try GetIndex(selector, {"databaseId", "ItemName"}) otherwise ...,
                    lakeHouseIndex = try GetIndex(selector, {"lakehouseId"}) otherwise ...,
                    cacheLocation = GetCacheLocation(options, validatedWorkspaceId, lakeHouseIndex[lakehouseId]),
                    // Fetch extended properties for lakehouse from state table
                    stateTableDataForLakehouse = GetDataFromCacheTable(cacheLocation, lakeHouseIndex[lakehouseId], "GetNavTableForWorkspace/OnSelectRows", baseUrl),
                    cachedLakehouseExtendedProperties = stateTableDataForLakehouse[Data]? ?? null, 
                    getLakehouseDetails = (storedBaseUrl, extendedProperties) => GenerateLakehouseView(storedBaseUrl, validatedWorkspaceId, lakeHouseIndex[lakehouseId], extendedProperties, options),
                    isWarehouse = includeWarehouses and index[ItemName] = "Warehouse",
                    default = Table.SelectRows(GetRows(), selector), // TODO: optimize to skip LH
                    triedData = GetWarehouseDatabaseView(baseUrl, validatedWorkspaceId, index[databaseId], options),
                    lazyRecord = (recordCtor, keys, baseRecord) =>
                        let record = recordCtor() in List.Accumulate(keys, [], (r, f) => Record.AddField(r, f, () => (Record.FieldOrDefault(baseRecord, f, null) ?? Record.Field(record, f)), true)),
                    result = (indexInfo, dataTable) => Table.FromRecords({
                        lazyRecord(
                            () => Table.First(default),
                            Table.ColumnNames(emptyTable),
                            indexInfo & [Data = dataTable])
                        },
                        Value.Type(emptyTable))
                in
                    if isWarehouse then
                        if triedData = null then emptyTable
                        else result(index, triedData)
                    else if lakeHouseIndex <> null and cachedLakehouseExtendedProperties <> null then
                        result(lakeHouseIndex, getLakehouseDetails(cachedLakehouseExtendedProperties[BaseUrl], cachedLakehouseExtendedProperties[ExtendedProperties]))
                    else 
                        if TranslateKeyNotFound and lakeHouseIndex <> null then
                            let
                                result =
                                    try GetRows(){[lakehouseId = lakeHouseIndex[lakehouseId]]} <> null 
                                    catch(e) => if e[ErrorCode]? = KeyNotFoundErrorCode then false else error e,
                                errorDetail = [
                                    LakehouseId = Utils[NonPii](lakeHouseIndex[lakehouseId]),
                                    WorkspaceId = Utils[NonPii](validatedWorkspaceId)
                                ]
                            in
                                if not result then error NewKeyNotFoundError(
                                    errorDetail,
                                    Record.FieldValues(errorDetail),
                                    "LakehouseNotFound")
                                else
                                    default
                        else
                            default,
            OnTestConnection = () =>
                let
                    lakehouseWithDb = Table.SelectRows(lakehouses, each [databaseId] <> null),
                    firstLakehouse = Table.First(lakehouseWithDb)[databaseId]?,
                    database = if (firstLakehouse <> null) then GetLakehouseDatabase(baseUrl, validatedWorkspaceId, firstLakehouse) else null
                in
                    Sql.TestConnection(database, firstLakehouse)
        ])
    in
        navTable;

GetTenantIdFromToken = () =>
    let
        token = GetCredential(AadWorkspaceApiOAuthResource)[access_token],
        payloadEncoded = Text.Split(token, "."){1},
        decodeBase64Url = Binary.FromText(Text.Replace(Text.Replace(payloadEncoded, "-", "+"), "_", "/") & {"", "", "==", "="}{Number.Mod(Text.Length(payloadEncoded), 4)}, BinaryEncoding.Base64),
        document = Json.Document(Text.FromBinary(decodeBase64Url))
    in
        document[tid];

NewKeyNotFoundError = (detail as record, parameters as list, exceptionKey as text) =>
    Diagnostics.Trace(
        TraceLevel.Information,
        [
            Name = "KeyNotFound",
            Data = detail
        ],
        Table.ViewError(
            Error.Record(
                Utils[NonPii]("DataSource.Error"),
                Extension.LoadString(exceptionKey),
                detail,
                parameters)
        )
    );

AddLakehouseTrivia = (table) =>
    let
        withItemKind = Table.AddColumn(table, "ItemKind", each "Database"),
        withItemName = Table.AddColumn(withItemKind, "ItemName", each if [databaseId] = [lakehouseId] then "Warehouse" else "Database"),
        withIsLeaf = Table.AddColumn(withItemName, "IsLeaf", each false),

        nav = Table.ToNavigationTable(withIsLeaf, {"lakehouseId"}, "lakehouseName", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        nav;

GetWorkspaces = (baseUrl as text, options as record) as table =>
    let
        url = Uri.Combine(baseUrl, "/v1/workspaces"),
        response = Utils[Web.JsonContents](
            url,
            /*headers*/ null,
            /*additionalHandlers*/ null,
            /*jsonBody*/ null,
            /*startState*/ null,
            /*traceContext*/ [Origin = Utils[NonPii]("GetWorkspaces")]
        ),
        workspaces = Table.FromRecords(response[value], {"id", "displayName", "capacityId"}, MissingField.UseNull),
        justPremiumWorkspaces = Table.SelectRows(workspaces, each [capacityId] <> null),
        removedCapacityObjectColumns = Table.RemoveColumns(justPremiumWorkspaces,"capacityId"),
        rename = Table.RenameColumns(removedCapacityObjectColumns, {{"id", "workspaceId"}, {"displayName", "workspaceName"}})
    in
        rename;

GetLakehouses = (baseUrl as text, workspaceId as text, options as record) as nullable table =>
    let
        lakehouesWithoutData = GetLakehousePublicAPIWitoutData(baseUrl, workspaceId, options),
        lakehouseArtifactsWithData = Table.AddColumn(lakehouesWithoutData, "Data", each GenerateLakehouseView(baseUrl, workspaceId, [lakehouseId], 
            [extendedProperties], options), type table),
        reorderdColumns = Table.ReorderColumns(lakehouseArtifactsWithData,Table.ColumnNames(#table(LakehouseNavTableType, {})))
    in
        if (lakehouesWithoutData = null) then #table(LakehouseNavTableType, {}) else reorderdColumns;

GetLakehousePublicAPIWitoutData = (baseUrl as text, workspaceId as text, options as record) =>
    let
        maxRetryCount = 5,
        url = Uri.Combine(baseUrl, Text.Format("/v1/workspaces/#{0}/lakehouses", {workspaceId})),
        response = Utils[Web.JsonContents](
            url,
            /*headers*/ WorkspacePrivateLink[GetPrivateLinkS2SHeader](workspaceId),
            /*additionalHandlers*/ [503 = Utils[RetryHandler](maxRetryCount)],
            /*jsonBody*/ null,
            /*startState*/ null,
            /*traceContext*/ [Origin = Utils[NonPii]("GetLakehouses")]
        ),
        responseAsRecord = Table.FromList(response[value], Splitter.SplitByNothing(), {"Lakehouses"}),
        lakehouses = Table.ExpandRecordColumn(
            responseAsRecord,
            "Lakehouses",
            {"id", "displayName", "description", "properties"}, 
            {"lakehouseId", "lakehouseName", "description", "extendedProperties"}),
        transformFields = Table.TransformColumns(lakehouses, {{"extendedProperties",
            (property) => TransformLakehouseExtendedProperties(property)
            }}),
        withCapacityObjectIdColumn = Table.AddColumn(transformFields, "capacityObjectId", each ""),
        withDatabaseId = Table.AddColumn(
            withCapacityObjectIdColumn,
            "databaseId",
            each try GetDwProperties([extendedProperties])[id]? otherwise null)
    in 
        if (response = null) then null else withDatabaseId;

GetWarehouses = (baseUrl as text, workspaceId as text, options as record) as table =>
    let
        url = Uri.Combine(baseUrl, Text.Format("/v1/workspaces/#{0}/warehouses", {workspaceId})),
        response = Utils[Web.JsonContents](
            url,
            /*headers*/ WorkspacePrivateLink[GetPrivateLinkS2SHeader](workspaceId),
            /*additionalHandlers*/ null,
            /*jsonBody*/ null,
            /*startState*/ null,
            /*traceContext*/ [Origin = Utils[NonPii]("GetWarehouses")]
        ),
        responseStatusCode = Record.FieldOrDefault(Value.Metadata(response), "Response.Status", 0),
        responseAsRecord = Table.FromList(response[value], Splitter.SplitByNothing(), {"Warehouses"}),
        dataWarehouses = Table.ExpandRecordColumn(responseAsRecord, "Warehouses", {"id", "displayName"}, {"lakehouseId", "lakehouseName"}),
        withData = Table.AddColumn(dataWarehouses, "Data", each GetWarehouseDatabaseView(baseUrl, workspaceId, [lakehouseId], options), type table),
        withDatabaseId = Table.AddColumn(withData, "databaseId", each [lakehouseId])
    in
        if (response = null) then #table(LakehouseNavTableType, {}) else withDatabaseId;

/**
    Get the staging lakehouse extended properties record from lakehouse artifacts api.
    This will be used to store the version table information.
**/
GetStagingLakehouseExtendedProperties = (baseUrl as text, workspaceId as text, stagingLakehouseDetails as record) as nullable record =>
    let
        url = Uri.Combine(baseUrl, Text.Format("/v1/workspaces/#{0}/lakehouses/#{1}", {stagingLakehouseDetails[StagingWorkspaceId], stagingLakehouseDetails[StagingLakehouseId]})),
        response = try Utils[Web.JsonContents](
            url,
            /*headers*/ WorkspacePrivateLink[GetPrivateLinkS2SHeader](workspaceId),
            /*additionalHandlers*/ null,
            /*jsonBody*/ null,
            /*startState*/ null,
            /*traceContext*/ [Origin = Utils[NonPii]("GetStagingLakehouseExtendedProperties")]
        ) 
        catch (e) => Diagnostics.Trace(TraceLevel.Warning, [Name = "GetStagingLakehouseExtendedProperties", Data = [Reason=e[Reason]?, Message=e[Message]?]], null)
    in
        if response <> null then TransformLakehouseExtendedProperties(response[properties]) else null;

// Transform extended properties to match what is expected by the connector.
// This is needed because the legacy lakehouse artifacts api and public api return different property names.
TransformLakehouseExtendedProperties = (extendedProperties as record) as record =>
    let 
        renameFunction = (recordToModify as record, renames as list) =>
            Record.RenameFields(recordToModify, renames, MissingField.Ignore),
        renamedRecord = renameFunction(extendedProperties,
            {
                {"oneLakeTablesPath", "OneLakeTablesPath"},
                {"oneLakeFilesPath", "OneLakeFilesPath"},
                {"sqlEndpointProperties", "DwProperties"},
                {"defaultSchema", "DefaultSchema"}
            }),
        renamedInnerRecord = Record.TransformFields(
            renamedRecord,
            {"DwProperties", each renameFunction(_, {{"connectionString", "tdsEndpoint"}})})
    in
        renamedInnerRecord;

// presently DwProperties element in extendedProperties is coming back as a string,
// but if in the future this format changes to a proper json element, then we will get back a record.
GetDwProperties = (extendedProperties) => 
    let 
        dwProperties = extendedProperties[DwProperties]? ?? extendedProperties[sqlEndpointProperties]? 
    in
        if dwProperties = null then null
        else if dwProperties is text then Json.Document(dwProperties)
        else dwProperties;

GenerateLakehouseView = (
    baseUrl as text,
    workspaceId as text,
    lakehouseId as text,
    extendedProperties as record,
    options as record
) =>
    if IsHierarchicalNavigationEnabled(options) and options[EnableFolding]? = false then
        GenerateLakeHouseTablesViewWithFullHierarchy(
            baseUrl,
            workspaceId,
            lakehouseId,
            extendedProperties,
            options
        )
    else
        GenerateLakeHouseTablesView(
            baseUrl,
            workspaceId,
            lakehouseId,
            extendedProperties,
            options
        );

GenerateLakeHouseTablesViewWithFullHierarchy = (
    baseUrl as text,
    workspaceId as text,
    lakehouseId as text, 
    extendedProperties as record,
    options as record
) as nullable table =>
    let
        lakehouseDefaultSchemaName = extendedProperties[DefaultSchema]?,
        oneLakeTables = OneLake.Contents(extendedProperties[OneLakeTablesPath]),
        transformedData = Table.AddColumn(oneLakeTables, "Data", each GenerateLakeHouseTablesView(
            baseUrl,
            workspaceId,
            lakehouseId,
            extendedProperties,
            options,
            /*schema*/ if lakehouseDefaultSchemaName <> null then [Name] else null,
            /*includeFiles*/ false
        )),
        removedContent = Table.RemoveColumns(transformedData, {"Content"}),
        withItemKind = Table.AddColumn(removedContent, "ItemKind", each "Schema"),
        withItemName = Table.AddColumn(withItemKind, "ItemName", each "Schema"),
        withIsLeaf = Table.AddColumn(withItemName, "IsLeaf", each false),
        withId = Table.AddColumn(withIsLeaf, "Id", each [Name]),
        withSchema = Table.AddColumn(withId, "Schema", each [Name]),
        removeOtherColumns = Table.SelectColumns(withSchema, Table.ColumnNames(#table(LakehouseTableDetailType, {}))),
        onelakeFilesTable = GenerateFilesViewForLakeHouse(extendedProperties[OneLakeFilesPath], Action.DoNothing),
        tableWithContent = #table(
            LakehouseTableDetailType,
            {
                {
                    Extension.LoadString("Files"),
                    "Files",
                    onelakeFilesTable,
                    null,
                    "Folder",
                    "Folder",
                    false
                }
            }
        ),
        finalOneLakeNavTables = if lakehouseDefaultSchemaName <> null then 
            removeOtherColumns 
        else 
            GenerateLakehouseTablesForNonSchemaLakehouses(baseUrl, workspaceId, lakehouseId, extendedProperties, options),
        combinedFilesAndTables = finalOneLakeNavTables & tableWithContent,
        nav = Table.ToNavigationTable(
            combinedFilesAndTables,
            {"Id", "ItemKind"},
            "Name",
            "Data",
            "ItemKind",
            "ItemName",
            "IsLeaf"
        )
    in
        nav;

// Used when HierarchicalNavigation is true and lakehouse is not schema enabled.
// Wrap the tables under a default schema "dbo" to match what is returned by SQL endpoint 
// for non-schema enabled lakehouses.
GenerateLakehouseTablesForNonSchemaLakehouses = (
    baseUrl as text,
    workspaceId as text,
    lakehouseId as text, 
    extendedProperties as record,
    options as record
) as nullable table =>
    let
        // match what is returned by SQL endpoint for non-schema enabled lakehouses.
        defaultSchemaIndicator = "dbo",
        oneLakeTables = GenerateLakeHouseTablesView(
            baseUrl,
            workspaceId,
            lakehouseId,
            extendedProperties,
            options,
            /*schema*/ null,
            /*includeFiles*/ false
        ),
        navTable = #table(LakehouseTableDetailType, {
            {
                defaultSchemaIndicator,
                defaultSchemaIndicator,
                oneLakeTables,
                defaultSchemaIndicator,
                "Schema",
                "Schema",
                false
            }
        })
    in
        navTable;

GenerateLakeHouseTablesView = (
    baseUrl as text,
    workspaceId as text,
    lakehouseId as text,
    extendedProperties as record,
    options as record,
    optional schema as text,
    optional includeFiles as logical) as nullable table =>
    let
        // if staging lakehouse id and workspace id are passed in use that lakehouse for storing versions.
        stagingLakehouseDetails = if options[StagingWorkspaceId]? <> null and options[StagingLakehouseId]? <> null then
            GetStagingLakehouseExtendedProperties(baseUrl, workspaceId, options)
        else 
            null,
        isStagingLakehouseOptionPresent = options[StagingLakehouseId]? <> null,
        lakehouseDefaultSchemaName = extendedProperties[DefaultSchema]?,
        oneLakeTableUrl = if schema <> null and IsHierarchicalNavigationEnabled(options) then
            extendedProperties[OneLakeTablesPath] & "/" & schema
        else if lakehouseDefaultSchemaName <> null then
            extendedProperties[OneLakeTablesPath] & "/" & lakehouseDefaultSchemaName
        else
            extendedProperties[OneLakeTablesPath],
        getLakehouses = GetLakehouses(baseUrl, workspaceId, options),
        updatedExtendedProperties = getLakehouses{[lakehouseId = lakehouseId]}?[extendedProperties]? ?? extendedProperties,
        dwProperties =  GetDwProperties(extendedProperties),
        lakehouseDBId = dwProperties[id]?,
        database = GetLakehouseDatabase(baseUrl, workspaceId, lakehouseDBId),
        //Spark Compute Setup
        sparkComputeSetup = [
            WorkspaceId = workspaceId,
            LakehouseId = lakehouseId,
            SchemaName = if lakehouseDefaultSchemaName <> null then lakehouseDefaultSchemaName else "default"
        ],

        finalSchemaNameForMDSync = Diagnostics.Trace(
            TraceLevel.Information,
            [
                Name = "MDSync/SchemaName",
                Data = 
                [
                    SchemaName = Utils[NonPii](schema),
                    DefaultSchemaName = Utils[NonPii](lakehouseDefaultSchemaName)
                ]
            ],
            schema ?? lakehouseDefaultSchemaName),
        refreshActionDetails = [BaseUrl = baseUrl, DwProperties=dwProperties, Options = options],
        tableMDSync = (tableName, optional additionalOption as record) =>
            RefreshAction(
                baseUrl,
                workspaceId,
                dwProperties,
                if additionalOption <> null then
                    options & additionalOption
                else 
                    options, 
                tableName,
                finalSchemaNameForMDSync),
        // Pass the tableMDSync as a meta because refreshAction is passed in all the down stream methods
        // and we only want to trigger MDSync during Version commit phase i.e. when the Delta Table is marked as
        // published. 
        refreshAction = Action.DoNothing meta [MDSyncFunction = tableMDSync, IsLakehouseSchemaEnabled = lakehouseDefaultSchemaName <> null],
        onelakeTables = GenerateOneLakeTable(
            baseUrl,
            workspaceId,
            oneLakeTableUrl,
            dwProperties,
            false,
            options,
            refreshActionDetails,
            // Pass in the Cache Table Insert Record, for populating the cache in Partitioned Refresh Scenario
            cacheTableConfigRecord,
            sparkComputeSetup,
            finalSchemaNameForMDSync),
        //Cache setup.
        lakehouseMetadata = 
        [
            BaseUrl = baseUrl, 
            ExtendedProperties = updatedExtendedProperties,
            OneLakeTableUrl = oneLakeTableUrl, 
            OneLakeFilesUrl = updatedExtendedProperties[OneLakeFilesPath]
        ],
        cachedLakehouseEntry = 
         [
            Key = "SelectedLakehouse",
            Id = lakehouseId, 
            Info = lakehouseMetadata
        ],
        cachedLakehouseDBEntry = 
        [
            Key = "SelectedLakehouseDbId",
            Id = lakehouseDBId, 
            Info = database
        ],
        cachedStagingLakehouseEntry = 
        [
            Key = "StagingLakehouseId",
            Id = options[StagingLakehouseId], 
            Info = [
                ExtendedProperties = stagingLakehouseDetails, 
                BaseUrl = baseUrl, 
                OneLakeTablesPath = stagingLakehouseDetails[OneLakeTablesPath], 
                OneLakeFilesPath = stagingLakehouseDetails[OneLakeFilesPath]
            ]
        ],
        stateTableInsertData = {cachedLakehouseEntry, cachedLakehouseDBEntry},
        withStagingLakehouseDetails = if isStagingLakehouseOptionPresent then 
            stateTableInsertData & {cachedStagingLakehouseEntry}
        else 
            stateTableInsertData,
        cacheLocation = GetCacheLocation(options, workspaceId, lakehouseId),
        // End Cache Setup
        cacheInsertActions = CacheTableInsertBuilder(
            cacheLocation,
            withStagingLakehouseDetails, 
            baseUrl),
        stagingLkFromStateTable = GetDataFromCacheTable(
            cacheLocation,
            options[StagingLakehouseId],
            "GenerateLakeHouseTablesView/StagingLakehouseId", 
            baseUrl),
        finalStagingLakehouseDetails = if isStagingLakehouseOptionPresent and stagingLkFromStateTable[Data]? <> null then
                stagingLkFromStateTable[Data][ExtendedProperties] 
            else 
                stagingLakehouseDetails,
        cacheTableConfigRecord = [
            CacheTableInsertAction = cacheInsertActions
        ],
        detailsFromStateTable = GetDataFromCacheTable(
            cacheLocation,
            lakehouseId,
            "GenerateLakeHouseTablesView/LakehouseId",
            baseUrl),

        finalOneLakeTableUrl = detailsFromStateTable[Data]?[OneLakeTableUrl]? ?? oneLakeTableUrl,
        onelakeFilesTable = GenerateFilesViewForLakeHouse(extendedProperties[OneLakeFilesPath], cacheInsertActions),
        tableWithContent = #table(
            LakehouseTableDetailType,
            {
                {
                    Extension.LoadString("Files"),
                    "Files",
                    onelakeFilesTable,
                    null,
                    "Folder",
                    "Folder",
                    false
                }
            }
        ),
        combinedFilesAndTables = if includeFiles <> false then onelakeTables & tableWithContent else onelakeTables,
        nav = Table.ToNavigationTable(
            combinedFilesAndTables,
            {
                "Id",
                "ItemKind"
            },
            "Name",
            "Data",
            "ItemKind",
            "ItemName",
            "IsLeaf"
        ),
        view = Table.View(nav, [
            OnInvoke = (function, args, index) =>
                if (function = Value.Versions) then
                    GetLakehouseTableVersions(
                        finalOneLakeTableUrl,
                        extendedProperties[OneLakeFilesPath],
                        GenerateOneLakeTable(
                            baseUrl,
                            workspaceId,
                            finalOneLakeTableUrl,
                            dwProperties,
                            true,
                            options,
                            refreshActionDetails,
                            cacheTableConfigRecord,
                            sparkComputeSetup,
                            finalSchemaNameForMDSync),
                        refreshAction,
                        finalStagingLakehouseDetails,
                        cacheTableConfigRecord,
                        options)
                // TODO pass in the table name to refresh action once the support for it is enabled.
                else if (Value.Metadata(Value.Type(function))[Documentation.Name]? = "Lakehouse.RefreshSqlMetadata") then
                    Diagnostics.Trace(
                        TraceLevel.Information,
                        [
                            Name = "RefreshSqlMetadata",
                            Data = 
                            [
                                TableName = Utils[Value.ToText](List.Last(args))
                            ]
                        ],
                        tableMDSync(Utils[Value.ToText](List.Last(args))))
                else if (Value.Metadata(Value.Type(function))[Documentation.Name]? = "Lakehouse.TrimCache") then
                    Diagnostics.Trace(
                        TraceLevel.Information,
                        [
                            Name = "TrimCache",
                            Data = [],
                            SafeData = 
                            [
                                CacheTrimDuration = Utils[Value.ToText](CacheTrimDuration)
                            ]
                        ],
                        TrimCache(GetCacheLocation(options, workspaceId, lakehouseId), baseUrl))
                else if (Value.Metadata(Value.Type(function))[Documentation.Name]? = "Lakehouse.IsModelStorage") then
                    Diagnostics.Trace(
                        TraceLevel.Information,
                        [
                            Name = "ModelStorageCheck",
                            Data = []
                        ],
                        options[IsModelStorage]? = true)
                else ...,

            OnSelectRows = (selector) =>
                // If getting the "Files" node, short-circuit the listing of the tables
                let
                    index = try GetIndex(selector, {"Name", "ItemKind"}) otherwise [],
                    isFiles = index = [Name="Files", ItemKind="Folder"]
                in
                    if isFiles then tableWithContent
                    else Table.View(Table.SelectRows(nav, selector), [OnDeleteRows = () => DeleteRows(selector)]),

            OnInsertRows = (rowsToInsert as table) =>
                let
                    result =  Diagnostics.Trace(TraceLevel.Information, [Name = "LakehouseNonVersionedInsert", Data=[]], try
                    let
                        // TODO add support for list of tables
                        singleRow = try Table.SingleRow(rowsToInsert) 
                            otherwise error Extension.LoadString("MultiTableInsertNotSupported"),
                        tableName = singleRow[Id],
                        tableData = Diagnostics.Trace(
                            TraceLevel.Information,
                            [
                                Name = "LakehouseNonVersionedInsert",
                                Data = [TableName = tableName]
                            ],
                            AnnotateDecimalTypes(singleRow[Data])),

                        // Incremental Refresh (IR)/Partitioned Refresh Scenario
                        // An empty table is first created before populating it with data. The subsequent reads for the table
                        // happen via SQL endpoint; hence, this empty table has to be synced to the SQL endpoint via Metadata Refresh.
                        // DFE passes in StagingLakehouseId/StagingWorkspaceId options for writes to output lakehouse.
                        // These options are not passed when writing to staging via LHMS.
                        // For IR scenario, UX is generating a pattern that causes DFE to add these options and take a 
                        // non-versioned/non-transactional path to create an empty table.
                        updatedOptions = if EnablePartitionedRefresh
                            and options[StagingWorkspaceId]? <> null 
                            and options[StagingLakehouseId]? <> null then 
                                options & [MetadataRefresh = true]
                            else 
                                options,

                        onelakeContents = () => OneLake.Contents(finalOneLakeTableUrl),
                        updatedDwProperties = GetDwProperties(updatedExtendedProperties),
                        tableFolder = if ValidateStagingArtifacts then
                                if IsStagingLakehouseProvisioned(updatedDwProperties) then 
                                    onelakeContents
                                else
                                    error Diagnostics.Trace(TraceLevel.Error,
                                        [
                                            Name = "StagingLakehouseInInvalidState",
                                            Data = [],
                                            SafeData = 
                                            [ 
                                                Id = Utils[Value.ToText](updatedDwProperties[id]?), 
                                                Status = updatedDwProperties[provisioningStatus]?
                                            ]
                                        ],
                                        Error.Record(
                                            Utils[NonPii]("DataSource.Error"),
                                            Utils[NonPii](Extension.LoadString("StagingLakehouseInInvalidState")),
                                            [
                                                #"StagingLakehouseProperties" = Utils[Value.ToText](updatedDwProperties)
                                            ],
                                            {Utils[NonPii](lakehouseId)}
                                        )
                                    )
                            else
                                onelakeContents
                    in
                        Action.Sequence({
                            cacheInsertActions,
                            TableAction.InsertRows(
                                tableFolder(),
                                #table({"Name", "Content"}, {{ tableName, #table({},{}) }})
                            ),
                            () => ValueAction.Replace(
                                DeltaLake.Table(tableFolder(){[Name = tableName]}[Content], DeltaLake.DefaultOptions),
                                tableData),
                            tableMDSync(tableName, updatedOptions)
                        })
                    )
                in
                    Connector.EvaluateQueryAndActionsForErrors(
                        result,
                        "LakehouseNonVersionedInsertError",
                        "LakehouseNonVersionedInsertError",
                        "GenerateLakeHouseTablesView"
                    ),

            OnDeleteRows = (selector as function) => DeleteRows(selector),

            DeleteRows = (selector as function) =>
                let
                    //we need the table based on delta format and not the table from tds endpoint.
                    result = Table.SelectRows(GenerateOneLakeTable(
                            baseUrl,
                            workspaceId,
                            oneLakeTableUrl,
                            dwProperties,
                            true,
                            options,
                            refreshActionDetails,
                            cacheTableConfigRecord,
                            sparkComputeSetup,
                            finalSchemaNameForMDSync),
                        selector),
                    dataLakeFolders = OneLake.Contents(oneLakeTableUrl),
                    addDeleteActionColumn = Table.AddColumn(
                        result,
                        "DeleteActions",
                        (r) => 
                            let 
                                actions = TableAction.DeleteRows(Table.SelectRows(dataLakeFolders, each [Name] = r[Id])) 
                            in 
                                actions 
                        ),
                    deleteActions = Action.Sequence({
                        cacheInsertActions,
                        Diagnostics.Trace(
                            TraceLevel.Information,
                            [
                                Name = "LakehouseNonVersionedDelete", 
                                Data = []
                            ],
                            Action.DoNothing),
                        Action.Sequence(addDeleteActionColumn[DeleteActions]),
                        Action.DoNothing
                    }),
                    deleteResults =  Diagnostics.Trace(
                        TraceLevel.Information,
                        [
                            Name = "LakehouseNonVersionedDelete",
                            Data=[]
                        ], 
                        try deleteActions)
                 in
                    Connector.EvaluateQueryAndActionsForErrors(
                        deleteResults,
                        "LakehouseNonVersionedDeleteError",
                        "LakehouseNonVersionedDeleteError",
                        "GenerateLakeHouseTablesView"
                    ),
            OnTestConnection = () => Sql.TestConnection(database, lakehouseId)
        ])
    in
       view;

GetWarehouseDatabaseView = (baseUrl as text, workspaceId as text, objectId as text, options as record) =>
    let
        cacheLocation = GetCacheLocation(options),
        tdsEndpointFromState = GetDataFromCacheTable(
            cacheLocation, objectId, "GetWarehouseDatabase/StagingWarehouseId", baseUrl),
        checkCachedEndpoint = try
                Sql.ValidateInstance(tdsEndpointFromState[Data])
            catch(e) => 
                Diagnostics.Trace(TraceLevel.Warning, [Name = "TDSEndpointCacheInvalid", Data = [Error = Utils[Value.ToText](e)]], false),                
        tdsEndpointDetails = if tdsEndpointFromState[Data]? <> null and checkCachedEndpoint then 
                tdsEndpointFromState[Data]
            else 
                try Workspace[GetTDSEndPoint](workspaceId, objectId, "Warehouse") otherwise null,
        stateTableInsert = CacheTableInsertBuilder(
            cacheLocation,
            { [ Key = "StagingWarehouse", Id = objectId, Info = tdsEndpointDetails ] },
            baseUrl),
        result = if tdsEndpointDetails <> null then
                try GenerateViewForWarehouseSqlTableData(
                    Sql.Contents(tdsEndpointDetails[tdsEndpoint], tdsEndpointDetails[name], options & [CreateNavigationProperties = false]),
                    stateTableInsert)
                catch(e) => error e
            else
                null
    in
        result;

IsStagingLakehouseProvisioned = (dwProperties) =>
    dwProperties <> null  and not Utils[Text.IsNullOrEmpty](dwProperties[tdsEndpoint]?)
    and not Utils[Text.IsNullOrEmpty](dwProperties[id]?)
    and not Utils[Text.IsNullOrEmpty](dwProperties[provisioningStatus]?)
    and dwProperties[provisioningStatus]? = "Success";

GenerateViewForWarehouseSqlTableData = (content as table, cacheTableInsertAction) as table =>
let
    view = (content2) => Table.View(
        content2,
        [
            GetExpression = () => Value.Expression(Value.Optimize(content2)),
            OnInvoke = (function, args, index) =>
                if (Value.Metadata(Value.Type(function))[Documentation.Name]? = "Lakehouse.SqlTable") then content2
                else Function.Invoke(function, List.ReplaceRange(args, index, 1, {content2})),
            TableDefault = (newTable) => @view(newTable)
        ]),
    withView = Table.TransformColumns(content, {{"Data", view}})
in
    Table.View(withView, [
        GetExpression = () => Value.Expression(Value.Optimize(content)),
        OnInsertRows = (rows) => Diagnostics.Trace(TraceLevel.Information, [Name = "StagingWarehouseInsert", Data = []] , Action.Sequence({ cacheTableInsertAction, TableAction.InsertRows(content, rows) })),
        OnUpdateRows = (updates, selector) => Diagnostics.Trace(TraceLevel.Information, [Name = "StagingWarehouseUpdate", Data = [] ], Action.Sequence({ cacheTableInsertAction, TableAction.UpdateRows(Table.SelectRows(content, selector), updates) })),
        OnDeleteRows = (selector) => Diagnostics.Trace(TraceLevel.Information, [Name = "StagingWarehouseDelete", Data = []], Action.Sequence({ cacheTableInsertAction, TableAction.DeleteRows(Table.SelectRows(content, selector)) }))
    ]);

GenerateLakehouseDetailFormatTable = (input as table) =>
    let
        withId = Table.AddColumn(input, "Id", each [Name]),
        withIsLeaf = Table.AddColumn(withId, "IsLeaf", each true),
        withItemKind = Table.AddColumn(withIsLeaf, "ItemName", each "Table"),
        // Tables returned via Sql Hierarchical Navigation option don't have Item field.
        removeColumns = Table.RemoveColumns(withItemKind, {"Item"}, MissingField.Ignore),
        renamedColumns = Table.RenameColumns(removeColumns,{{"Kind", "ItemKind"}}),
        reorderColumns = Table.ReorderColumns(renamedColumns,Table.ColumnNames(#table(LakehouseTableDetailType, {})))
    in
        reorderColumns;

GenerateLakehouseDetailForHierarchicalSqlTable = (input as table) =>
    let
        withName = Table.AddColumn(input, "Name", each [Schema]),
        withId = Table.AddColumn(withName, "Id", each [Name]),
        withIsLeaf = Table.AddColumn(withId, "IsLeaf", each false),
        withItemKind = Table.AddColumn(withIsLeaf, "ItemName", each "Schema"),
        renamedColumns = Table.AddColumn(withItemKind, "ItemKind", each "Schema"),
        reorderColumns = Table.ReorderColumns(renamedColumns,Table.ColumnNames(#table(LakehouseTableDetailType, {})))
    in
        reorderColumns;

GetLakehouseDatabase = (baseUrl, workspaceId, lakewarehouseId) =>
    let
        // Reuse shared Workspace module logic (validation + error handling unified)
        tdsResponse = Workspace[GetTDSEndPoint](workspaceId, lakewarehouseId, "Lakehouse"),
        // Lakehouse expects only tdsEndpoint and name record
        result = tdsResponse[[tdsEndpoint],[name]]
    in
        result;

// Create a Versioned View for a Lakehouse
/*
The algorithm used by the connector to do a table insert in Lakehouse using DFE is as follows
1. Insert a new version in Lakehouse Version view. This step entails creating a folder with the version name in the staging lakehouse's file path or destination lakehouse files path.
2. DFE will then try to insert a new table in the version, this will trigger the OnInsertRows handler from CreateVersionableView method.
    This handler, will create the table's folder in lakehouse, create a subversion for the table using DeltaLake conector and insert an empty table with the table schema in it, publish this subversion (version + ".1")
    (required to trigger the view), create the actual version in the delta lake connector for that table.
3. DFE will then try to insert the actual data into the table, this will trigger the OnInsertRows Handler from GenerateViewForVersionedTable method and this will do the actual content insert on the delta table version.
4. Publish the version, new DFE will trigger the OnUpdateRows handler in GetLakehouseTableVersions, old DFE will trigger the OnUpdateRows handler in GetVersionTableForInnerNode (this doesn't work due to folding issue with old DFE)
    This step will publish the version on the delta table and delete the version from the ADLS as this version is marked as published.

## Use case for Fixed Schema Table Replace ##
1. During Fixed Schema Table replace, the DFE doesn't trigger a delete of a table in Lakehouse's version table.
2. Instead, there is a delete call to delete table's data. This will trigger Lakehouse connector's GenerateViewForVersionedTable delete rows handler.
3. During this delete operation, lakehouse connector will insert a version on the underlying Delta Table's version table. Then it will trigger a delete rows operation to delete the table's data in that version.
4. Next DFE will trigger an Insert Rows which will call GenerateViewForVersionedTable's InsertRows handler. In this handler as the table is already present, it will fall to AppendTable method
   in the else if block. This is happening because the table is already present and there is no .created marker and as the table was not deleted as per lakehouse's version table, there is no .deleted marker.
5. In this method, we will check if the version is already present on Delta Table and then trigger an insert rows operation on the Delta Table.
6. DFE will then trigger a commit operation to commit the version.

*/
GetLakehouseTableVersions = (
    onelakeTableUrl as text, 
    onelakeFilesUrl as text,
    onelakeTables as table,
    refreshAction as action,
    stagingLakehouseDetails as nullable record,
    cacheTableFetchInsertRecord as nullable record,
    options as record,
    optional dataRow as any) =>
let
    finalFilePathUrl = if stagingLakehouseDetails <> null then stagingLakehouseDetails[OneLakeFilesPath] else onelakeFilesUrl,
    versionsTableFromADLS = GenerateADLSVersionTable(finalFilePathUrl, refreshAction),
    staging2 = versionsTableFromADLS,
    versions = Table.SelectRows(staging2, each [Data] is table),
    nullVersionRows = {{null, true, onelakeTables, null}},
    versionsRows = Table.TransformRows(versions,
    (version) => let
        versionName = version[Name],
        // the version name which the connector returns in the version table will be without '_mashup_temporary_' marker
        splitVersionName = Text.Split(versionName, "_"){3},
        dataRowForVersionTable = if dataRow <> null then
                PartitionedRefreshVersionSupport(dataRow, versionName, cacheTableFetchInsertRecord)
            else 
                CreateVersionableView(onelakeTables, versionName, onelakeTableUrl, finalFilePathUrl, refreshAction, cacheTableFetchInsertRecord, options)
    in
        {
            splitVersionName,
            false,
            dataRowForVersionTable,
            version[Date modified]?
        }),
    versionsTable = #table(
        type table [Version = nullable text, Published = logical, Data = any, Modified = nullable datetime],
        nullVersionRows & versionsRows)
in
    Table.View(versionsTable,
    [
        // Insert a new version row in the version table.
        OnInsertRows = (rows) => if (Table.ColumnNames(rows) = {"Version"} and Table.RowCount(rows) = 1 ) then
            let
                transformedRows = Table.TransformColumns(rows,{{"Version", each TemporaryParentVersionFolder & "_" & _}}),
                renamedCols = Table.RenameColumns(transformedRows, {{"Version", "Name"}})

            in Action.Sequence(
            {
                cacheTableFetchInsertRecord[CacheTableInsertAction],
                TableAction.InsertRows(staging2, renamedCols),
                () => let
                        regenTable = @GetLakehouseTableVersions(onelakeTableUrl, onelakeFilesUrl, onelakeTables, refreshAction, stagingLakehouseDetails, cacheTableFetchInsertRecord, options),
                        bufferedListOfVersionToInsert = List.Buffer(rows[Version]),
                        versionTable = Table.SelectRows(regenTable, each List.Contains(bufferedListOfVersionToInsert,[Version]))
                      in
                        Action.Return(versionTable)
            })
        else ...,

        // commit the version to lakehouse.
        OnUpdateRows = (updates, selector) =>
        let
            result = Diagnostics.Trace(TraceLevel.Information, [ Name = "LakehouseVersionCommit1", Data = [] ],
                try CommitVersionToLakehouse(onelakeTableUrl, finalFilePathUrl, selector, refreshAction, staging2, dataRow[deltaSrc]?, options))
        in
            Connector.EvaluateQueryAndActionsForErrors(result, "LakehouseVersionCommitError", "LakehouseVersionCommitError", "GetLakehouseTableVersions"),
        //delete rows from version table.
        OnDeleteRows = (selector) =>
        let
            result = Diagnostics.Trace(TraceLevel.Information, [Name = "LakehouseVersionDelete", Data = []], try
                let
                 adlsVersionSource = OneLake.Contents(finalFilePathUrl),
                 versionsToDelete = Table.TransformColumns(Table.SelectRows(versionsTable, selector), {{"Version", each TemporaryParentVersionFolder & "_" & _}}),
                 tableWithActionColumns = Table.AddColumn(versionsToDelete, "DeleteActions", (r) =>
                    let
                        selectedVersions = Table.SelectRows(adlsVersionSource, each [Name] = r[Version]),
                        deleteAction = Action.Sequence({TableAction.DeleteRows(selectedVersions), Action.DoNothing})
                    in
                        deleteAction
                    )
                in
                    if (versionsToDelete{0}[Version] = null) then error Extension.LoadString("CannotDeletePublishedVersion")
                    else Action.Sequence(
                    {
                        Action.Sequence(tableWithActionColumns[DeleteActions])
                    })
            )
        in
            Connector.EvaluateQueryAndActionsForErrors(result, "LakehouseVersionDeleteError", "LakehouseVersionDeleteError", "GetLakehouseTableVersions")
    ]);

/**
    This method will be used to commit a version to the lakehouse. This step has three parts
    1. Go to files path to get the versions for the lakehouse. Update names to remove the _mashup_temporary_ marker.
    2. Select the version to commit using the selector function.
    3. Update the names in the table from step 2 to add back the _mashup_temporary_ marker.
    4. Get the table name which is being created, this table is in the version folder and will have a .created marker.
    5. Get the actual delta table for it and commit the version on the delta table.
    6. Commit the version on the lakehouse. This is deleting the version folder from files path.
*/
CommitVersionToLakehouse = (
    onelakeTableUrl as text,
    finalFilePathUrl as text,
    selector as function,
    refreshAction as action,
    lakehouseVersionTable as table,
    deltaSrc as nullable table,
    options as record) =>
    let
        adlsSource =  OneLake.Contents(onelakeTableUrl),
        adlsVersionSource = OneLake.Contents(finalFilePathUrl),
        renamedColForVersionFolder = Table.RenameColumns(adlsVersionSource, {{"Name", "Version"}}),
        // remove the '_mashup_temporary_' marker from the version name
        modifledNameColumn = Table.TransformColumns(
            renamedColForVersionFolder,
            {
                {
                    "Version",
                    each if Text.StartsWith(_,TemporaryParentVersionFolder & "_") then 
                        Text.Split(_,"_"){3} 
                    else 
                        _
                }
            }
        ),
        subVersions = Table.SelectRows(modifledNameColumn, selector),
        // add  back the '_mashup_temporary_' marker from the version name
        modifiedSubVersions = Table.TransformColumns(
            subVersions,
            {{"Version", each TemporaryParentVersionFolder & "_" & _}}),
        // get table name and the version to search for:
        createdTableName = Text.Split(
            Table.SelectRows(modifiedSubVersions{0}[Content], each Text.Contains([Name], CreatedMarker)){0}[Name],
            CreatedMarker){0},
        versionForDeltaTable = modifiedSubVersions{0}[Version],

        // SparkComputeStep:

        sparkQueryPresent = SparkCompute[State.SparkTableActions](versionForDeltaTable & "_" & createdTableName),
        sparkQueryDetails = 
            if sparkQueryPresent <> null then
                sparkQueryPresent{0}[SparkDetails]
            else
                null,
        finalSchemaName = Diagnostics.Trace(
            TraceLevel.Information,
            [
                Name = "CommitVersion/SparkCompute",
                Data = [
                    SparkQueryDetails = Utils[Value.ToText](sparkQueryDetails)
                ]
            ],
            if isSchemaEnabledLakehouse then "dbo" else "default"),
        destinationLakehouseId = Text.Split(Uri.Parts(onelakeTableUrl)[Path], "/"){2},
        destinationWorkspaceId = Text.Split(Uri.Parts(onelakeTableUrl)[Path], "/"){1},
        sparkActions = 
            if sparkQueryDetails <> null then
                SparkCompute[GenerateAndRunSparkSqlFragmentForVersionWrite](
                    Fabric.GetClusterUrl(PBIBaseUrl),
                    sparkQueryDetails,
                    createdTableName,
                    options[StagingWorkspaceId],
                    options[StagingLakehouseId],
                    destinationLakehouseId,
                    destinationWorkspaceId,
                    finalSchemaName)
            else Action.DoNothing,
        // For Incremental Refresh use deltaSrc otherwise fall back to onelakeTableUrl
        deltaTable = deltaSrc ?? DeltaLake.Table(adlsSource{[Name = createdTableName]}[Content], DeltaLake.DefaultOptions),
        versionTable = Value.Versions(deltaTable),
        mdSyncDetails = Value.Metadata(refreshAction)[MDSyncFunction]?,
        isSchemaEnabledLakehouse = Value.Metadata(refreshAction)[IsLakehouseSchemaEnabled]? ?? false,
        // Only perform MDSync for non-incremental refresh writes.
        metadataSyncAction = if ForceMDSyncForODLakehouse 
            and deltaSrc = null 
            and mdSyncDetails <> null
        then
            Diagnostics.Trace(
                TraceLevel.Information,
                [
                    Name = "MDSyncForOutputLakehouse",
                    Data = [TableName = createdTableName]
                ],
                mdSyncDetails(createdTableName, [MetadataRefresh = true]))
        else
            Action.DoNothing
    in
        if Table.RowCount(modifiedSubVersions) <> 1 then 
            error Text.Format(
                Extension.LoadString("MultipleVersionsWithSameGuid"),
                {Text.FromBinary(Json.FromValue(modifiedSubVersions))})
        else 
            Action.Sequence({
                Diagnostics.Trace(
                    TraceLevel.Information,
                    [
                        Name = "SparkStatementExecution",
                        Data = []
                    ], 
                    sparkActions),
                if sparkQueryDetails = null then 
                    TableAction.UpdateRows(
                        Table.SelectRows(versionTable, each [Version] = versionForDeltaTable),
                        {{"Published", each true}})
                else
                    Action.DoNothing,
                Action.Sequence({
                    TableAction.DeleteRows(Table.SelectRows(adlsVersionSource, each [Name] = versionForDeltaTable)),
                    Action.DoNothing
                }),
                metadataSyncAction,
                Action.Return(lakehouseVersionTable)
            });

/* Acts like a staging location for a lakehouse version
            */
GenerateADLSVersionTable = (oneLakeFileUrl as text, refreshAction as action) =>
let
emptyTable = #table(
            type table [Name = nullable text, Extension = nullable text, #"Date accessed" = nullable datetime,#"Date modified" = nullable datetime,#"Date created" = nullable datetime, Data = any, Modified = nullable datetime],
                {{null, null,null,null, null,null,null}}),
adlsContents = OneLake.Contents(oneLakeFileUrl),
versionFolder = Table.SelectRows(adlsContents, each Text.StartsWith([Name], TemporaryParentVersionFolder)),
renameColumns = Table.RenameColumns(versionFolder, {{"Content", "Data"}}),
finalTable = if Table.RowCount(versionFolder) = 0 then emptyTable else renameColumns

in
Table.View(finalTable, [
    OnInsertRows = (rows) => if (Table.ColumnNames(rows) = {"Name"}) then
            let
                adlsSource = OneLake.Contents(oneLakeFileUrl),
                rowsToInsert = Table.AddColumn(rows,"Content", each #table({}, {})),
                versionInsertActions = Action.Sequence(
                    {
                        () =>
                        let
                                createVersionFolderAction = Action.Sequence({
                                    () => let
                                            adlsSourceNew = adlsSource ?? OneLake.Contents(oneLakeFileUrl),
                                            action = TableAction.InsertRows(adlsSourceNew,rowsToInsert)
                                            in action,
                                            Action.DoNothing
                                    })
                        in
                            createVersionFolderAction,
                        () => Action.Return(adlsSource)
                    }),
                result = Diagnostics.Trace(TraceLevel.Information, [Name = "LakehouseVersionInsert", Data = []], try versionInsertActions)

            in
                Connector.EvaluateQueryAndActionsForErrors(result, "LakehouseVersionInsertError", "LakehouseVersionInsertError", "GenerateADLSVersionTable")
        else ...,


    OnUpdateRows = (updates, selector) =>
    let
        result = Diagnostics.Trace(TraceLevel.Information, [Name = "LakehouseVersionCommit", Data = []], try
            let
                adlsSource =  OneLake.Contents(oneLakeFileUrl),
                deltaLakeTable = DeltaLake.Table(adlsSource, DeltaLake.DefaultOptions),
                getVersions = Value.Versions(deltaLakeTable)
            in
                Action.Sequence({
                    TableAction.UpdateRows(Table.SelectRows(getVersions, selector), {{"Published", each true}}),
                    refreshAction
                }))
        in
            Connector.EvaluateQueryAndActionsForErrors(result, "LakehouseVersionCommitError", "LakehouseVersionCommitError", "GenerateADLSVersionTable"),

    OnDeleteRows = (selector) =>
    let
        adlsSource = OneLake.Contents(oneLakeFileUrl),
        deleteActions = Action.Sequence
                    ({
                        () => Diagnostics.Trace(TraceLevel.Information, [Name = "LakehouseVersionDelete", Data = []], Action.DoNothing),
                        TableAction.DeleteRows(Table.SelectRows(adlsSource, selector)),
                        Action.DoNothing
                    }),
        result = Diagnostics.Trace(TraceLevel.Information, [Name = "LakehouseVersionDelete", Data = []], try deleteActions)
    in
        Connector.EvaluateQueryAndActionsForErrors(result, "LakehouseVersionDeleteError", "LakehouseVersionDeleteError", "GenerateADLSVersionTable")
]);

GenerateFilesViewForLakeHouse = (onelakeFileUrl as text, cacheTableInsertAction) as nullable table =>
    let
        oneLakeTables = OneLake.Contents(onelakeFileUrl),
        view = (t) => let
            withItemKind = Table.AddColumn(t, "ItemKind", each if [Content] is binary then "Binary" else "Folder"),
            withIsLeaf = Table.AddColumn(withItemKind, "IsLeaf", each [Content] is binary),
            nav = Table.ToNavigationTable(withIsLeaf, {"Name"}, "Name", "Content", "ItemKind", "ItemKind", "IsLeaf"),
            navWithMeta = Value.ReplaceType(nav, 
                Value.ReplaceMetadata(Value.Type(nav), Value.Metadata(Value.Type(t)) & Value.Metadata(Value.Type(nav)))),
            asUpdatable = Table.View(navWithMeta, [
                OnSelectRows = (condition) => @view(Table.SelectRows(t, condition)),
                OnInvoke = (f, a, i) =>
                    if (Value.Metadata(Value.Type(f))[Documentation.Name]? = "Value.Versions") then
                        let
                            baseVersionTable = Value.Versions(t),
                            versionWithViewContent = Table.TransformColumns(Value.Versions(t), {{"Data", @view}})
                        in
                            // Retain Action handlers for the version table.
                            Table.View(versionWithViewContent,[
                                OnInsertRows = (rowsToInsert) => Diagnostics.Trace(TraceLevel.Information, [Name = "LakehouseVersionInsertFileInsert", Data = []], TableAction.InsertRows(baseVersionTable, rowsToInsert)),
                                OnUpdateRows = (updates, selector) => 
                                    TableAction.UpdateRows(
                                        Table.SelectRows(baseVersionTable, selector), 
                                        List.Transform(updates, each {[Name], [Function]})),
                                OnDeleteRows = (selector) => 
                                    Diagnostics.Trace(TraceLevel.Information, [Name = "LakehouseVersionDeleteFile", Data = []], TableAction.DeleteRows(Table.SelectRows(baseVersionTable, selector)))
                            ])
                    else 
                        Function.Invoke(f, List.ReplaceRange(a, i, 1, {navWithMeta})),

                OnInsertRows = (rowsToInsert) => 
                    Action.Sequence({ cacheTableInsertAction, TableAction.InsertRows(t, rowsToInsert) }),
                OnUpdateRows = (updates, selector) => 
                    Action.Sequence({ 
                        cacheTableInsertAction, 
                        TableAction.UpdateRows(
                            Table.SelectRows(t, selector), 
                            List.Transform(updates, each {[Name], [Function]})) 
                    }),
                OnDeleteRows = (selector) => 
                    Action.Sequence({ cacheTableInsertAction, TableAction.DeleteRows(Table.SelectRows(t, selector)) })
            ])
        in
            if (onelakeFileUrl = null) or (t = null) then null else asUpdatable
    in
        view(oneLakeTables);

/**
    If the dwProperties element is not null then get tables from tds endpoint or fall back to delta tables from the lakehouse.
    The 'fetchDeltaTables' flag indicates this we want to fetch the Delta Table View this way during versioned writes or deletes we 
    will always return the Delta Tables and not the tables from the SQL Endpoint.
    The 'cacheTableInsertRecord' contains details to populate the cache table during Partitioned Refresh.
*/
GenerateOneLakeTable = (
    baseUrl as text, 
    workspaceId as text,
    onelakeTableUrl as text,
    dwProperties as nullable record,
    fetchDeltaTables as logical,
    options as record,
    refreshActionDetails as record,
    cacheTableInsertRecord as record,
    sparkComputeRecord as record,
    schema as nullable text) as table =>
    let
        useSparkCompute = SparkCompute[IsSparkComputeEnabled](options),
        useSql = dwProperties <> null
            // the cached dwProperties record can contain 'connectionString' or 'tdsEndpoint'.
            and (dwProperties[tdsEndpoint]? <> null
                or dwProperties[connectionString]? <> null)
            and options[EnableFolding]? <> false 
            and not fetchDeltaTables
            and not useSparkCompute,
        deltaNav = GenerateNavTableUsingDeltaTable(
            onelakeTableUrl,
            workspaceId,
            refreshActionDetails,
            [
                BaseUrl = baseUrl,
                CacheLocation = options,
                CacheTableInsertRecord = cacheTableInsertRecord,
                OnelakeTableUrl = onelakeTableUrl
            ],
            sparkComputeRecord,
            options,
            schema),
        nav = if useSql and not useSparkCompute then
                GenerateSqlTableView(
                    baseUrl,
                    workspaceId,
                    dwProperties,
                    deltaNav,
                    options,
                    onelakeTableUrl,
                    cacheTableInsertRecord)
            else if useSparkCompute then
                deltaNav[SparkCompute]
            else
                deltaNav[DeltaTableWithNavProps]
    in
        if (onelakeTableUrl = null) then null else nav;

// Go to the one lake path and fetch all tables and convert them to delta format.
GenerateNavTableUsingDeltaTable = (
    onelakeTableUrl as text,
    workspaceId as text,
    refreshActionDetails as record,
    partitionedRefreshSetup as record,
    sparkComputeSetup as record,
    options as record,
    schemaName as nullable text) =>
    let
        oneLakeTables = OneLake.Contents(onelakeTableUrl),
        renamedCols = Table.RenameColumns(oneLakeTables, {{"Content", "Data"}}),
        removedRows = Table.SelectRows(renamedCols, each not Text.StartsWith([Name], TemporaryParentVersionFolder)),
        removedRowsWithVersionIndicator = Table.SelectRows(removedRows, each not Text.StartsWith([Name], "Versions-")),
        tableWithTransformedNameWithData = Table.AddColumn(
            removedRowsWithVersionIndicator,
            "DataWithName",
            each WithAfterAction(
                DeltaLake.Table([Data], DeltaLake.DefaultOptions),
                RefreshAction(
                    refreshActionDetails[BaseUrl],
                    workspaceId,
                    refreshActionDetails[DwProperties],
                    refreshActionDetails[Options],
                    [Name],
                    schemaName),
                partitionedRefreshSetup & 
                [
                    TableId = [Name], 
                    TableData = DeltaLake.Table([Data], DeltaLake.DefaultOptions)
                ]),
            type table),

        // DeltaLake.Metadata works on raw delta table and not on DeltaTable wrapped on Table.View.
        tableWithRawDeltaTable = Table.AddColumn(removedRowsWithVersionIndicator, "RawDeltaTableData",
            each DeltaLake.Table([Data], DeltaLake.DefaultOptions)),
        withIdForDelta = Table.AddColumn(tableWithRawDeltaTable, "Id", each [Name]),
        removedDataColumnDelta = Table.RemoveColumns(withIdForDelta, {"Data"}),
        renamedDataColumnDelta = Table.RenameColumns(removedDataColumnDelta, {{"RawDeltaTableData", "Data"}}),

        // Spark Compute Setup using the Spark SQL Generator
        tableWithSparkComputeDetails = Table.AddColumn(
            renamedDataColumnDelta,
            "SparkCompute",
            each SparkCompute[SparkSqlViewOnDelta](
                Fabric.GetClusterUrl(PBIBaseUrl),
                sparkComputeSetup[WorkspaceId],
                sparkComputeSetup[LakehouseId],
                [Id],
                [Data],
                sparkComputeSetup[SchemaName],
                Value.Type([Data]),
                []
        )),

        removedDataColumn = Table.RemoveColumns(tableWithTransformedNameWithData, {"Data"}),
        renamedDataColumn = Table.RenameColumns(removedDataColumn, {{"DataWithName", "Data"}}),
        withItemKind = Table.AddColumn(renamedDataColumn, "ItemKind", each "Table"),
        withItemName = Table.AddColumn(withItemKind, "ItemName", each "Table"),
        withIsLeaf = Table.AddColumn(withItemName, "IsLeaf", each true),
        withId = Table.AddColumn(withIsLeaf, "Id", each [Name]),
        withSchema = Table.AddColumn(withId, "Schema", each schemaName),
        removeOtherColumns = Table.SelectColumns(withSchema, Table.ColumnNames(#table(LakehouseTableDetailType, {}))),
        navDeltaTable = Table.ToNavigationTable(removeOtherColumns, {"Id", "ItemKind"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")

    in
        [
            DeltaTableWithNavProps = navDeltaTable,
            RawDeltaTable = renamedDataColumnDelta,
            SparkCompute = GenerateSparkComputeNavTable(tableWithSparkComputeDetails)
        ];

GenerateSparkComputeNavTable = (input) =>
    let
        removedDataColumn = Table.RemoveColumns(input, {"Data"}),
        renamedDataColumn = Table.RenameColumns(removedDataColumn, {{"SparkCompute", "Data"}}),
        withItemKind = Table.AddColumn(renamedDataColumn, "ItemKind", each "Table"),
        withItemName = Table.AddColumn(withItemKind, "ItemName", each "Table"),
        withIsLeaf = Table.AddColumn(withItemName, "IsLeaf", each true),
        withSchema = Table.AddColumn(withIsLeaf, "Schema", each null),
        removeOtherColumns = Table.SelectColumns(withSchema, Table.ColumnNames(#table(LakehouseTableDetailType, {}))),
        navDeltaTable = Table.ToNavigationTable(removeOtherColumns, {"Id", "ItemKind"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        navDeltaTable;

WithSchemaAndData = (data as table, schema as text) =>
    let
        withSchema = Table.AddColumn(data, "Schema", each schema)
    in
        withSchema;

GenerateSqlTableView = (
    baseUrl as text,
    workspaceId as text,
    dwProperties as record,
    deltaTableContent as record,
    options as record,
    onelakeTableUrl as text,
    cacheTableInsertRecord as record) as table =>
    let
        lakehouseId = dwProperties[id]?,
        cacheLocation = GetCacheLocation(options),
        detailsFromStateTable = GetDataFromCacheTable(
            cacheLocation,
            lakehouseId,
            "GenerateSqlTableView/LakehouseDbId",
            baseUrl),
        database = if detailsFromStateTable[Data]? <> null and checkCachedLakehouseSqlEndpoint 
                then detailsFromStateTable[Data] 
            else GetLakehouseDatabase(baseUrl, workspaceId, lakehouseId),
        checkCachedLakehouseSqlEndpoint = try Sql.ValidateInstance(detailsFromStateTable[Data])
            catch(e)  => Diagnostics.Trace(TraceLevel.Warning, [Name = "LakehouseTDSCacheInvalid", Data = [Error = Utils[Value.ToText](e)]], false),
        sqlContents = Sql.Contents(database[tdsEndpoint], database[name], options),
        
        // Transform the table with right nav table schema when HierarchicalNavigation is enabled.
        transfomedTable =
            let
                formattedTable = GenerateLakehouseDetailForHierarchicalSqlTable(sqlContents),
                // Pass down the schema to list of tables as SQL table doesn't have that information.
                withDataAndSchema = Table.AddColumn(formattedTable, "DataAndSchema", 
                    each WithSchemaAndData([Data], [Name])),
                removeDataColumn = Table.RemoveColumns(withDataAndSchema, {"Data"}),
                renamedColumn = Table.RenameColumns(removeDataColumn, {{"DataAndSchema", "Data"}}),
                transformedDataColumn = Table.TransformColumns(renamedColumn, {{"Data", getNav}})
            in
                transformedDataColumn,
        getNav = (sqlTableView) => let
            formattedTable = GenerateLakehouseDetailFormatTable(sqlTableView),
            filteredTables = if HideSysAndQueryInsightsSchema then 
                // sys and queryinsight schema return views
                Table.SelectRows(formattedTable, each [ItemKind] = "Table")
            else
                formattedTable,

            // Get table ids from SQL table view and delta table view.
            idsFromSQL = filteredTables[Id],
            idsFromDelta = deltaTableContent[DeltaTableWithNavProps][Id],

            // Rather than transforming the column, add a new Data column which will have a reference to underlying 
            // delta table of the lakehouse table for easier version support integration.
            addedDataColumns = Table.AddColumn(
                filteredTables,
                "SqlTableView",
                each GenerateViewForSqlTableData(
                    [Data],
                    deltaTableContent,
                    [Id],
                    options,
                    baseUrl,
                    onelakeTableUrl,
                    cacheTableInsertRecord)),
            removeDataColumn = Table.RemoveColumns(addedDataColumns,  {"Data"}),
            renamedSqlTableViewColumn = Table.RenameColumns(removeDataColumn, {{"SqlTableView", "Data"}}),
            reorderedColumns = Table.ReorderColumns(renamedSqlTableViewColumn, Table.ColumnNames(#table(LakehouseTableDetailType, {}))),
            nav = Table.ToNavigationTable(reorderedColumns, {"Id","ItemKind"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
        in
            Table.View(nav,
            [
                OnSelectRows = (selector) => let
                    // id and itemkind is pattern from UI, Name is pattern from LMS
                    index =  try GetIndex(selector, {"Id", "ItemKind"}) otherwise try GetIndex(selector, {"Name"}) otherwise [],
                    filterValue = index[Name]? ?? index[Id]?
                in
                    if (index <> []) then @getNav(Table.SelectRows(sqlTableView, each [Name] = filterValue)) // TODO add schema once schemas for lakehouse is enabled.
                    else Table.SelectRows(nav, selector),
                OnTestConnection = () => Sql.TestConnection(database, lakehouseId)
            ])
    in
        if IsHierarchicalNavigationEnabled(options) then transfomedTable else getNav(sqlContents);

// Select the rows from the Delta table which are present in the SQL table ids list. Return this table and combine the results with the SQL table.
GetMissingTable = (missingIds as list, inputTable as table) as table =>
    let
        loggedInputTable = Diagnostics.Trace(TraceLevel.Information, [Name = "GetMissingTable/SqlDeltaMismatch", Data = [TableNames = Text.Combine(missingIds, ",")]], inputTable),
        selectedRows = Table.SelectRows(loggedInputTable, each List.Contains(missingIds,[Id]))
    in
        selectedRows;

// Create a simple view for the SQL table, this view will provide an implementation for the Value.Versions
// which will return the Version table of the Delta table representation of the lakehouse table.
GenerateViewForSqlTableData = (
    content as table,
    deltaTableContent as record,
    tableId as text,
    cacheLocation as record,
    baseUrl as text,
    onelakeTableUrl as text,
    cacheTableInsertRecord as record) as table =>
    let
        view = (content2, deltaTableContent2) => Table.View(
            content2,
            [
                GetExpression = () => Value.Expression(Value.Optimize(content2)),
                OnInvoke = (function, args, index) =>
                    if (function = Value.Versions) then Value.Versions(deltaTableContent2[DeltaTableWithNavProps]{[Id = tableId]}[Data])
                    else if (Value.Metadata(Value.Type(function))[Documentation.Name]? = "Lakehouse.SqlTable") then content2 // TODO (Output): review; used to fold output to DW
                    else Function.Invoke(function, List.ReplaceRange(args, index, 1, {content2})),
                OnSelectRows = (selector) => if EnablePartitionedRefresh
                        and deltaTableContent2 <> null
                        and deltaTableContent2[RawDeltaTable]? <> null
                    then
                        Diagnostics.Trace(TraceLevel.Information, 
                            [
                                Name = "SqlContent/PartitionedUpdate",
                                Data = []
                            ],
                            TableViewWithVersionHandlers(
                                Table.SelectRows(content2, selector),
                                cacheLocation,
                                baseUrl,
                                selector,
                                deltaTableContent2[RawDeltaTable]{[Id = tableId]}[Data],
                                tableId,
                                onelakeTableUrl,
                                cacheTableInsertRecord
                            )
                        )
                    else
                        @view(Table.SelectRows(content2, selector), null),
                TableDefault = (newTable) => @view(newTable, null)
            ])
    in
        view(content, deltaTableContent);

GenerateVersionTableBaseLocation = (cacheLocation as record, baseUrl as text) =>
    Text.Format(
        OneLakeFilesPathFormat, 
        {
            OneLakeFilesPathBaseUrl(cloud, Text.Contains(Text.Lower(baseUrl), "msit")), 
            cacheLocation[StagingWorkspaceId],
            cacheLocation[StagingLakehouseId]
        }
    );


TableViewWithVersionHandlers = (
    input as table,
    cacheLocation as record,
    baseUrl as text,
    selector as function,
    deltaTable as table,
    tableId  as text,
    onelakeTableUrl as text,
    cacheTableInsertRecord as record) =>
    Table.View(input, [
        GetExpression = () => Value.Expression(Value.Optimize(input)),
        OnInvoke = (function, args, index) =>
            if (function = Value.Versions) then 
                let
                    fileUrl = GenerateVersionTableBaseLocation(cacheLocation, baseUrl)
                in
                    GetLakehouseTableVersions(
                        onelakeTableUrl,
                        fileUrl, 
                        deltaTable, 
                        Action.DoNothing,
                        [ OneLakeFilesPath = fileUrl ],
                        cacheTableInsertRecord,
                        [],
                        [
                            data = input,
                            selectorFunction = selector,
                            deltaSrc = deltaTable,
                            versionParentLocation = fileUrl,
                            tableName = tableId
                        ]
                    )
            else 
                Function.Invoke(function, List.ReplaceRange(args, index, 1, {input}))
    ]);

PartitionedRefreshVersionSupport = (inputWithSelector as record, versionId as text, options as record) =>
    Table.View(inputWithSelector[data],
    [
        OnInsertRows = (rows) =>
            let
                dataLakeVersionParentFolder = OneLake.Contents(inputWithSelector[versionParentLocation]),
                markerFileAction = TableAction.InsertRows(dataLakeVersionParentFolder{[Name = versionId]}[Content],
                    #table({"Name"}, {{inputWithSelector[tableName] & CreatedMarker}})),
                versionPresent = GetVersionTable(inputWithSelector[deltaSrc]){[Version = versionId]}? <> null,
                deltaTableForVersion = DeltaTableForVersion(GetVersionTable(inputWithSelector[deltaSrc]), versionId),
                selectorAsRecord = SelectorAsRecord(
                    inputWithSelector[selectorFunction],
                    GetTypeRecordForDeltaTable(deltaTableForVersion)),
                insertActions = Action.Sequence({
                    () => markerFileAction,
                    () => if not versionPresent then
                            TableAction.InsertRows(GetVersionTable(inputWithSelector[deltaSrc]), #table({"Version"}, {{versionId}}))
                        else
                            Action.DoNothing,
                    () => TableAction.InsertRows(deltaTableForVersion, AddTags(rows, selectorAsRecord)),
                    () => Action.DoNothing
                }),
                result = Diagnostics.Trace(TraceLevel.Information,
                    [
                        Name = "PartitionedUpdate/InsertRows", 
                        Data = [],
                        SafeData = [ VersionId = versionId ]
                    ], 
                    try insertActions)
            in
                Connector.EvaluateQueryAndActionsForErrors(
                    result,
                    "PartitionedRefreshVersionedInsert",
                    "PartitionedRefreshVersionedInsertError",
                    "PartitionedRefreshVersionSupport"),

        OnDeleteRows = (selector) =>
            let
                dataLakeVersionParentFolder = OneLake.Contents(inputWithSelector[versionParentLocation]),
                markerFileAction = TableAction.InsertRows(dataLakeVersionParentFolder{[Name = versionId]}[Content],
                    #table({"Name"}, {{inputWithSelector[tableName] & DeletedMarker}})),
                versionPresent = GetVersionTable(inputWithSelector[deltaSrc]){[Version = versionId]}? <> null,
                deltaTableForVersion = DeltaTableForVersion(GetVersionTable(inputWithSelector[deltaSrc]), versionId),
                selectorAsRecord = SelectorAsRecord(
                    inputWithSelector[selectorFunction],
                    GetTypeRecordForDeltaTable(deltaTableForVersion)),
                deltaMetadataTable = DeltaMetadata(deltaTableForVersion),
                deleteActions = Action.Sequence({
                    () => markerFileAction,
                    () => if not versionPresent then
                            TableAction.InsertRows(GetVersionTable(inputWithSelector[deltaSrc]), #table({"Version"}, {{versionId}}))
                        else 
                            Action.DoNothing,
                    () => TableAction.DeleteRows(Table.SelectRows(deltaMetadataTable, 
                        (rec) => CheckIfTagValuesMatch(rec[Command]?[add]?[tags]?, selectorAsRecord))),
                    () => Action.DoNothing
                }),
                result = Diagnostics.Trace(TraceLevel.Information,
                    [
                        Name = "PartitionedUpdate/DeleteRows", 
                        Data = [],
                        SafeData = [ VersionId = versionId ]
                    ],
                    try deleteActions)
            in
                Connector.EvaluateQueryAndActionsForErrors(
                    result,
                    "PartitionedRefreshVersionedDelete",
                    "PartitionedRefreshVersionedDeleteError",
                    "PartitionedRefreshVersionSupport")
    ]);

DeltaMetadata = (deltaSrc) => DeltaLake.Metadata(deltaSrc);

GetVersionTable = (deltaSrc) => Value.Versions(deltaSrc);

DeltaTableForVersion = (deltaVersionTable, versionId) => deltaVersionTable{[Version = versionId]}[Data];

GetTypeRecordForDeltaTable = (deltaTable) => Type.RecordFields(Type.TableRow(Value.Type(deltaTable)));

SelectorAsRecord = (selectorFunction as function, typeRecordForTable as record) => 
    try 
        SelectorToRecord(selectorFunction, typeRecordForTable)
    catch (e) => 
        error Error.Record(
            Utils[NonPii]("DataSource.Error"),
            Utils[NonPii](Extension.LoadString("PartitionedRefreshSelectorFunctionError")),
            e,
            { Utils[NonPii](Utils[Value.ToText](e, 5)) }
        );

AddTags = (tbl, tags) =>
    let
        rowType = Type.RecordFields(Type.TableRow(Value.Type(tbl))),
        withTags = List.Transform(
            Record.ToList(rowType),
            (t) => [Type = t[Type] meta [Delta.Tags = tags], Optional = false]),
        newType = type table Type.ForRecord(Record.FromList(withTags, Record.FieldNames(rowType)), false)
    in
        Value.ReplaceType(tbl, newType);

/**
    This function compares the delta table tags with the record keys from the selector function.
    If a match is found, it will return the value for those tags.
    Otherwise it will return an empty list.
    Example
        Input:
            tableTagRecords = 
            [
                "date_Start": "2024-02-01 12:00:00 AM",
                "date_End": "2024-03-01 12:00:00 AM",
                "VORDER": "true"
            ],
            selectorRecord = 
            [
                "date_Start": "2024-02-01 12:00:00 AM",
                "date_End": "2024-03-01 12:00:00 AM"
            ]
        Output:
            {"2024-02-01 12:00:00 AM", "2024-03-01 12:00:00 AM"}
*/
CompareTagRecords = (tableTagRecords as nullable record, selectorRecord as record) =>
    let
        removeVOrderTag = Record.RemoveFields(tableTagRecords, "VORDER", MissingField.Ignore),
        result = Record.SelectFields(removeVOrderTag, Record.FieldNames(selectorRecord), MissingField.Ignore),
        count = Record.FieldCount(result)
    in
        if count > 0 then 
            Diagnostics.Trace(
                TraceLevel.Information,
                [
                    Name = "CompareTagRecords/Match",
                    Data = [ Count = Utils[Value.ToText](count), RecordAsText = Utils[Value.ToText](result) ]
                ],
                Record.FieldValues(result))
        else 
            Diagnostics.Trace(
                TraceLevel.Information,
                [
                    Name = "CompareTagRecords/NoMatch",
                    Data = [ TagRecord = Utils[Value.ToText](tableTagRecords) ]
                ],
                {});

/**
    This function tries to match the values from the DeltaTable tag record and the selector function record.
    Returns true if the record values match exactly otherwise returns a false.
    Example:
        Input:
            input = 
            [
                "date_Start": "2024-02-01 12:00:00 AM",
                "date_End": "2024-03-01 12:00:00 AM",
                "VORDER": "true"
            ],
            selectorRecord = 
            [
                "date_Start": "2024-02-01 12:00:00 AM",
                "date_End": "2024-03-01 12:00:00 AM"
            ]
        Output:
            true
*/
CheckIfTagValuesMatch = (input as nullable record, selectorAsRecord as record) =>
    let
        fieldValuesInSelector = Record.FieldValues(selectorAsRecord),
        matchedTagRecordsFromInput = CompareTagRecords(input, selectorAsRecord)
    in
        input <> null and List.ContainsAll(matchedTagRecordsFromInput, fieldValuesInSelector);

GenerateViewForVersionedTable = (
    content as table,
    version as text,
    onelakeFileUrl as text,
    tableName as text,
    refreshAction as action,
    options as record)  =>
let
    // the delta table will either have the version or subversion.
    nullVersionData = content{[Version = null]},
    selectedVersionOrDefault =  if content{[Version = version & ".1"]}? <> null then content{[Version = version & ".1"]}
                                else if content{[Version = version]}? <> null then content{[Version = version]}
                                else nullVersionData,
    tableContent = selectedVersionOrDefault[Data]
in
    Table.View(tableContent,
    [
        OnInsertRows = (rowsToInsert as table) =>
            let
                isSparkComputeEnabled = SparkCompute[IsSparkComputeEnabled](options),
                sparkComputeValueFromStateTable = SparkCompute[State.SparkTableActions](version & "_" & tableName),
                mode = 
                    if sparkComputeValueFromStateTable = null then
                        [Mode = "append"]
                    else 
                        [Mode = "overwrite"],
                sparkSqlFolded = SparkCompute[GetSparkSqlQueryIfFolded](SparkCompute[Lakehouse.TrySparkCompute](rowsToInsert)),
                sparkQueryDetails = 
                    if sparkSqlFolded = null then 
                        SparkCompute[Lakehouse.TrySparkCompute](rowsToInsert) 
                    else 
                        sparkSqlFolded,
                isSparkComputeCase = sparkQueryDetails <> null,
                sparkComputeStoreActions = Diagnostics.Trace(
                    TraceLevel.Information,
                    [
                        Name = "SparkComputeStoreActions",
                        Data = 
                        [
                            SparkQueryDetails = Utils[Value.ToText](sparkQueryDetails)
                        ]
                    ],
                    if isSparkComputeEnabled and isSparkComputeCase then
                        SparkCompute[State.SparkComputeStoreActions](
                            version,
                            tableName,
                            if sparkQueryDetails is table then 
                                sparkQueryDetails{0} & mode
                            else 
                                [
                                    Query = sparkSqlFolded[query],
                                    SourceLakehouseDetails = sparkSqlFolded[SourceLakehouseDetails]
                                ] & mode & [ColumnNames = Table.ColumnNames(rowsToInsert)])
                    else 
                        Action.DoNothing),
                dataLakeFolders = OneLake.Contents(onelakeFileUrl),
                versionFolder = dataLakeFolders{[Name = version]}[Content],
                createdMarker = versionFolder{[Name = tableName & CreatedMarker]}?,
                markerFileInsertAction = if createdMarker is null then 
                    TableAction.InsertRows(dataLakeFolders{[Name = version]}[Content], #table({"Name"}, {{tableName & CreatedMarker}}))
                else
                    Action.DoNothing,

                result = Diagnostics.Trace(
                    TraceLevel.Information, 
                    [
                        Name = "VersionedLakehouseTableInsert",
                        Data = 
                        [
                            IsSparkCompute = Utils[NonPii](isSparkComputeCase),
                            TableName = Utils[NonPii](tableName),
                            Version = Utils[NonPii](version)
                        ]
                    ],
                    try let
                        dataLakeFolders = OneLake.Contents(onelakeFileUrl),
                        //TODO what if a version has multiple tables marked as .deleted
                        versionFolder = dataLakeFolders{[Name = version]}[Content],
                        createdMarker = versionFolder{[Name = tableName & CreatedMarker]}?,
                        deletedTable = versionFolder{[Name = tableName & DeletedMarker]}?,
                        deleteOrCreateAction = if deletedTable <> null then
                            Action.Sequence({
                                // From DFE when an existing table's contents are replced, this OnInsertRows handler is invoked and we need to ensure right steps are executed to ensure Publish step is successful.
                                // Existing Table replace
                                () => let actions = Action.Sequence({
                                    () => Diagnostics.Trace(TraceLevel.Information, [Name = "VersionedLakehouseTableInsertTableReplaceWithTableContent", Data = []], Action.DoNothing),
                                    ()=> TableAction.DeleteRows(Table.SelectRows(dataLakeFolders{[Name = version]}[Content], each [Name] = tableName & DeletedMarker)),
                                    ()=> TableAction.InsertRows(dataLakeFolders{[Name = version]}[Content], #table({"Name"}, {{tableName & CreatedMarker}})),
                                    () => ValueAction.Replace(tableContent, AnnotateDecimalTypes(rowsToInsert))
                                })
                                in actions
                            })
                        // Table Append
                        else if createdMarker is null then
                            Action.Sequence({
                                () => let actions = Action.Sequence({
                                    () => Diagnostics.Trace(TraceLevel.Information, [Name = "VersionedLakehouseTableInsertTableAppendWithContent", Data = [], SafeData = [FixedSchemaFlag = Text.From(FixedSchemaFix)]], Action.DoNothing),
                                    ()=> if FixedSchemaFix then 
                                    // if Table.IsEmpty means there is no underlying version yet and we can safely insert a version.
                                        if Table.IsEmpty(Table.SelectRows(content, each [Version] = version)) then TableAction.InsertRows(content, #table({"Version"},{{version}})) 
                                        else Action.DoNothing
                                    else TableAction.InsertRows(content, #table({"Version"},{{version}})),
                                    ()=> TableAction.InsertRows(dataLakeFolders{[Name = version]}[Content], #table({"Name"}, {{tableName & CreatedMarker}})),
                                    ()=> TableAction.InsertRows(tableContent, AnnotateDecimalTypes(rowsToInsert))
                                })
                                in actions
                            })
                        // New table insert or existing table replacement with current DFE.
                        else TableAction.InsertRows(tableContent, AnnotateDecimalTypes(rowsToInsert)),
                        actions = if sparkQueryDetails <> null then 
                            Action.Sequence({markerFileInsertAction, sparkComputeStoreActions})
                        else
                            Action.Sequence
                            (
                                {
                                    deleteOrCreateAction,
                                    refreshAction,
                                    Action.DoNothing
                                }
                            )
                    in
                        actions
                )
            in
                Connector.EvaluateQueryAndActionsForErrors(result, "VersionedLakehouseTableInsertError", "VersionedLakehouseTableReplaceError", "GenerateViewForVersionedTable"),

        OnDeleteRows = (selector) =>
            let
                isSparkComputeEnabled = SparkCompute[IsSparkComputeEnabled](options),
                sparkComputeValueFromStateTable = SparkCompute[State.SparkTableActions](version & "_" & tableName),
                sparkComputeActions = 
                    if sparkComputeValueFromStateTable <> null then 
                        SparkCompute[State.SparkComputeStoreActions](version, tableName, [Mode = "overwrite"])
                    else 
                        Action.DoNothing,
                actions =
                    Action.Sequence({
                        Diagnostics.Trace(
                            TraceLevel.Information,
                            [
                                Name = "VersionedLakehouseDeleteDeltaTableData",
                                Data = 
                                [
                                    Version = Utils[NonPii](version),
                                    FixedSchemaFlag = Utils[NonPii](Text.From(FixedSchemaFix)),
                                    IsSparkComputeEnabled = Utils[NonPii](isSparkComputeEnabled)
                                ]
                            ], Action.DoNothing),
                        if isSparkComputeEnabled then 
                            SparkCompute[State.SparkComputeStoreActions](version, tableName, [Mode = "overwrite"])
                        else
                            Action.Sequence(
                                {
                                    () => TableAction.InsertRows(content,  #table({"Version"}, {{version}})),
                                    (result) => if FixedSchemaFix then
                                        TableAction.DeleteRows(result{[Version = version]}[Data]) 
                                    else
                                        Action.DoNothing
                                }),
                        Action.DoNothing
                    }),
                deleteActionResult = Diagnostics.Trace(
                    TraceLevel.Information,
                    [
                        Name = "VersionedLakehouseTableDelete",
                        Data = [],
                        SafeData = [TableName = tableName, Version = version ]
                    ], 
                    try actions
                )
            in
                Connector.EvaluateQueryAndActionsForErrors(deleteActionResult, "VersionedLakehouseTableDeleteError", "VersionedLakehouseTableDeleteError", "GenerateViewForVersionedTable")
    ]);

// Generate a list of tables which have been deleted in a version.
// These tables should be skipped in the list of tables for a version returned from lakehouse's version table.
GetDeletedTablesListForAVersion = (oneLakeFilesUrl as text, version as text) =>
let
    versionSourceFromAdls =  OneLake.Contents(oneLakeFilesUrl & "/" & version),
    justDeletedTables = Table.SelectRows(versionSourceFromAdls, each Text.Contains([Name], DeletedMarker)),
    justDeletedTableNames = List.Buffer(List.Transform(justDeletedTables[Name], each Text.Split(_, "."){0}))
in
    Diagnostics.Trace(TraceLevel.Information, [Name = "DeletedLakehouseTablesListInVersion", Data = [], SafeData = [Version = version, DeletedTableCount = List.Count(justDeletedTableNames)]], justDeletedTableNames);

// Represents each Table column for a Version. This piece does the heavy lifting of creating a empty table, adding data to a table etc.
CreateVersionableView = (
    content as table,
    version as text,
    onelakeTableUrl as text,
    onelakeFilesUrl as text,
    refreshAction as action,
    stateTableRecord as record,
    options as record) =>
let
    // Adding a new column which has a table with records of Table Id and Table Data, this makes handing cases for Table Deletes and Tables Appends easier.
    addedColumn = Table.AddColumn(content, "DataWithName", each #table({"IdWithData"}, {{[Id = [Id], Data = [Data]]}})),
    removeColumn = Table.RemoveColumns(addedColumn, {"Data"}),
    renameColumn = Table.RenameColumns(removeColumn, {"DataWithName" , "Data"}),
    justDeletedTableNames = GetDeletedTablesListForAVersion(onelakeFilesUrl, version),
    transformedDeltaLakeTable = Table.TransformColumns(renameColumn, {{"Data", (val) => GenerateViewForVersionedTable(Value.Versions(val[IdWithData]{0}[Data]), version, onelakeFilesUrl, val[IdWithData]{0}[Id], refreshAction, options), type table}}),
    removedDeletedTables = if List.Count(justDeletedTableNames) > 0 then Table.SelectRows(transformedDeltaLakeTable, each not List.Contains(justDeletedTableNames, [Name])) else transformedDeltaLakeTable
in
Table.View(removedDeletedTables,[
     OnInvoke = (function, args, index) =>
                if (function = Value.VersionIdentity) then GetVersionIdentity()
                else if (function = Value.Versions) then GetVersionTableForInnerNode()
                else ...,

    // Required by Old DFE. It executes Value.Verions on  Value.Versions(lk){[Version = <some version>]}[Data]
    // TODO clean up as it's potentiall no longer required.
    GetVersionTableForInnerNode = () =>
        let
            versionTable = GetLakehouseTableVersions(onelakeTableUrl,onelakeFilesUrl, content, refreshAction, null, stateTableRecord, options)
        in
        Table.View(versionTable,[

            OnInvoke = (function, args, index) =>
                if (function = Value.VersionIdentity) then version
                else ...,

            OnUpdateRows = (updates, optional selector) =>
            let
                commitResult = CommitVersionToLakehouse(onelakeTableUrl, onelakeFilesUrl, selector, refreshAction, content, null, options),
                result = Diagnostics.Trace(TraceLevel.Information, [Name = "OldDfeCommitVersion" , Data = []], try commitResult)
            in
                Connector.EvaluateQueryAndActionsForErrors(result, "LakehouseOldDfeVersionCommitError","LakehouseOldDfeVersionCommitError", "CreateVersionableView")
        ]),

    GetVersionIdentity = () =>
        let
            loggedVersion = Diagnostics.Trace(TraceLevel.Information, [Name = "GetVersionIdentity", Data = [], SafeData = [Version = version]], version)
        in
            loggedVersion,
    OnInsertRows = (rowsToInsert as table) =>
        let
            result = Diagnostics.Trace(
                TraceLevel.Information,
                [
                    Name = "CreateVersionableView/VersionedLakehouseTableInsert",
                    Data = [],
                    SafeData = [Version = version]
                ],
                try
                let
                    renamedColsInRowsToInsert = Table.RenameColumns(rowsToInsert, {{"Id", "Name"}}),
                    tableNameToInsert = renamedColsInRowsToInsert[Name]{0} as text,
                    tableContentToInsert = renamedColsInRowsToInsert[Data]{0},
                    dataLakeFolders = OneLake.Contents(onelakeTableUrl),
                    dataLakeVersionParentFolder = OneLake.Contents(onelakeFilesUrl),
                    isItemKindCorrect = renamedColsInRowsToInsert{0}[ItemKind] = "Table" and renamedColsInRowsToInsert{0}[Data] is table,
                    actions = if isItemKindCorrect then Action.Sequence(
                        {
                            () =>
                                let
                                    // table is present so if the table was marked as deleted in replace table scenario 
                                    // remove the .deleted entry from versions folder
                                    isTablePresent = dataLakeFolders{[Name = tableNameToInsert]}?,
                                    tablePresentActions =
                                        let
                                            // Table is being recreated in the version, delete the .deleted entry
                                            actions =  Action.Sequence({
                                                    Diagnostics.Trace(
                                                        TraceLevel.Information,
                                                        [
                                                            Name = "VersionedLakehouseTableInsertTableAlreadyExists",
                                                            Data = []
                                                        ],
                                                        Action.DoNothing),
                                                    TableAction.DeleteRows(
                                                        Table.SelectRows(
                                                            dataLakeVersionParentFolder{[Name = version]}[Content],
                                                            each [Name] = tableNameToInsert & DeletedMarker)),
                                                    Action.DoNothing
                                                })

                                        in
                                            actions,
                                    // TODO make this logic a little better to ensure if the new table creation fails, the table folder is cleared from OneLake.
                                    newTableInsertActions =
                                        let
                                            actions = Action.Sequence({
                                                () => Diagnostics.Trace(
                                                    TraceLevel.Information,
                                                    [Name = "VersionedLakehouseTableInsertNewTableFolderLakehouse", Data = []],
                                                    Action.DoNothing),
                                                () => TableAction.InsertRows(
                                                    dataLakeFolders,
                                                    Table.SelectColumns(
                                                        Table.RenameColumns(renamedColsInRowsToInsert, {{"Data","Content"}}),
                                                        {"Name", "Content"}))
                                            })
                                        in
                                            actions,
                                    actions = 
                                        if isTablePresent <> null then
                                            tablePresentActions 
                                        else newTableInsertActions
                                in
                                    actions,

                            // Create a file with .created marker to indicate the table which was created, 
                            // this helps in publishing later.
                            () => TableAction.InsertRows(
                                dataLakeVersionParentFolder{[Name = version]}[Content],
                                #table({"Name"}, {{tableNameToInsert & CreatedMarker}})),

                            // If this is a case of table replacement, we will return the existing version.
                            () =>
                            let
                                isSparkCompute = SparkCompute[IsSparkComputeEnabled](options),
                                stateTableEntryForSpark = SparkCompute[State.SparkTableActions](version & "_" & tableNameToInsert),
                                dataToStore = 
                                    if stateTableEntryForSpark <> null then
                                        [Mode = "overwrite", Id = "versioned"]
                                    else 
                                        [Mode = "append", Id = "versioned"],
                                sparkComputeAction = Action.Sequence(
                                    {
                                        // new table creation action.
                                        if selectedVersion = null then
                                            Action.Sequence(
                                                {
                                                    TableAction.InsertRows(
                                                        getVersions,
                                                        #table({"Version"}, {{version}})),
                                                    (result) => Action.Return([Table  = result]),
                                                    (result) => Action.Sequence(
                                                        {
                                                            ValueAction.Replace(result[Table]{0}[Data], tableContentToInsert),
                                                            Action.Return(result)
                                                        }),
                                                    (result) => 
                                                        let
                                                            deltaLakeTable = DeltaLake.Table(
                                                                dataLakeFolders{[Name = tableNameToInsert]}[Content],
                                                                DeltaLake.DefaultOptions),
                                                            getVersions = Value.Versions(deltaLakeTable),
                                                            selectedVersion = Table.SelectRows(
                                                                getVersions,
                                                                each [Version] = result[Table]{0}[Version])
                                                        in
                                                            TableAction.UpdateRows(selectedVersion, {{"Published", each true}}),
                                                    SparkCompute[State.SparkComputeStoreActions](version, tableNameToInsert, dataToStore)
                                                }
                                            )
                                        else
                                            SparkCompute[State.SparkComputeStoreActions](
                                                version,
                                                tableNameToInsert,
                                                dataToStore)
                                    }),
                                dataLakeFolders = OneLake.Contents(onelakeTableUrl),
                                deltaLakeTable = DeltaLake.Table(
                                    dataLakeFolders{[Name = tableNameToInsert]}[Content],
                                    DeltaLake.DefaultOptions),
                                getVersions = Value.Versions(deltaLakeTable),
                                selectedVersion = getVersions{[Version = version]}?,
                                isTableReplace = dataLakeVersionParentFolder{[Name = version]}[Content]{[Name = tableNameToInsert & ReplaceMarker]}? <> null,
                                // Create a sub-version in DeltaLake connector for the table and insert the empty table with the schema information.
                                actions = Action.Sequence(
                                    {
                                        // if this is a case of table replacement, we will return the existing version.
                                        () => if selectedVersion <> null then 
                                                Action.Return([Table = Table.SelectRows(getVersions, each [Version] = version), alreadyPresent = true])
                                            else
                                                Action.Sequence({TableAction.InsertRows(getVersions, #table({"Version"}, {{version & ".1"}})), (result) => Action.Return([Table  = result, alreadyPresent = false])}),
                                        (result) => Action.Sequence(
                                            {
                                                Diagnostics.Trace(
                                                    TraceLevel.Information,
                                                    [
                                                        Name = "VersionedLakehouseTableInsertCreateEmptyDeltaTable",
                                                        Data = [],
                                                        SafeData = 
                                                        [
                                                            TableAlreadyPresent = Text.From(result[alreadyPresent]), 
                                                            FixedSchemaFlag = Text.From(FixedSchemaFix)
                                                        ]
                                                    ],
                                                    Action.DoNothing),
                                                // if table is already present it is a delta table and we need to do an insert row call.
                                                if result[alreadyPresent] and FixedSchemaFix then 
                                                    // if this is a case of table schema update, we can only achieve it 
                                                    // by ValueAction.Replace on the delta table.
                                                    if isTableReplace and DynamicSchemaEmptyTableFix then 
                                                        Action.Sequence({
                                                            ValueAction.Replace(result[Table]{0}[Data], tableContentToInsert),
                                                            TableAction.DeleteRows(
                                                                Table.SelectRows(
                                                                    dataLakeVersionParentFolder{[Name = version]}[Content],
                                                                    each [Name] = tableNameToInsert & ReplaceMarker))
                                                        })
                                                    else
                                                        TableAction.InsertRows(result[Table]{0}[Data], tableContentToInsert)
                                                // DeltaLake connector reports an error if InsertRows handler is used because 
                                                // the table currently is not an actual delta table.
                                                // TODO : Once current architectural limitation is addressed change to TableAction.InsertRows
                                                else 
                                                    ValueAction.Replace(result[Table]{0}[Data], tableContentToInsert),
                                                Action.Return(result)}),
                                        (result) =>
                                        let
                                            deltaLakeTable = DeltaLake.Table(
                                                dataLakeFolders{[Name = tableNameToInsert]}[Content],
                                                DeltaLake.DefaultOptions),
                                            getVersions = Value.Versions(deltaLakeTable),
                                            selectedVersion = Table.SelectRows(
                                                getVersions,
                                                each [Version] = result[Table]{0}[Version])
                                        in
                                        // Publish this version in delta lake to ensure the delta log with the schema 
                                        // is created, this allows us to have a view on this table.
                                        // For an existing table return the result from previous step, we don't want to publish the version yet.
                                            Action.Sequence({
                                                () => Diagnostics.Trace(
                                                    TraceLevel.Information,
                                                    [
                                                        Name = "VersionedLakehouseTableInsertSubVersionPublish",
                                                        Data = [],
                                                        SafeData = [Version = result[Table]{0}[Version]]
                                                    ],
                                                    Action.DoNothing),
                                                () => if result[alreadyPresent] then 
                                                    Action.Return(result) 
                                                    else 
                                                        Action.Sequence({
                                                            TableAction.UpdateRows(selectedVersion, {{"Published", each true}}),
                                                            (result) => Action.Return([Table=result, alreadyPresent = false])
                                                        }),
                                                (result) => Action.Return(result)
                                                }),
                                        (result) =>
                                        let
                                            deltaLakeTable = DeltaLake.Table(
                                                dataLakeFolders{[Name = tableNameToInsert]}[Content],
                                                DeltaLake.DefaultOptions),
                                            getVersions = Value.Versions(deltaLakeTable),
                                            insertAction = 
                                                if result[alreadyPresent] then 
                                                    Action.DoNothing
                                                else 
                                                    TableAction.InsertRows(getVersions, #table({"Version"}, {{version}}))
                                        in
                                            // Create the actual version in DeltaLake for this table 
                                            // or in case of table replacement don't do anything.
                                            insertAction
                                    })
                            in
                                if isSparkCompute then
                                    Diagnostics.Trace(
                                        TraceLevel.Information,
                                        [Name = "SparkComputeCase", Data=[]],
                                        sparkComputeAction
                                    )
                                else actions
                    }) else ...
            in
                if Table.RowCount(renamedColsInRowsToInsert) > 1 then error Extension.LoadString("MultiTableInsertInVersionNotSupported")
                else if not NameIsValid(tableNameToInsert) then error Extension.LoadString("InvalidTableName")
                else actions )
            in
                Connector.EvaluateQueryAndActionsForErrors(result, "VersionedLakehouseTableInsertError","VersionedLakehouseTableCreateError", "CreateVersionableView"),
    // Versioned lakehouse view, delete an existing table.
    OnDeleteRows = (selector) =>
         let
            result = Diagnostics.Trace(TraceLevel.Information, [Name = "CreateVersionableView/VersionedLakehouseTableDelete", Data= [], SafeData = [VersionName = version]], try
            let
                isSparkCompute = SparkCompute[IsSparkComputeEnabled](options),
                sparkComputeActions = 
                    if isSparkCompute then
                        SparkCompute[State.SparkComputeStoreActions](version, selectedTableIds{0}, [Mode = "overwrite"])
                    else 
                        Action.DoNothing,
                selectedTable = Table.SelectRows(content,selector),
                selectedTableIds = selectedTable[Id],
                dataLakeFolders = OneLake.Contents(onelakeTableUrl),
                isTablePresent = dataLakeFolders{[Name = selectedTableIds{0}]}? <> null,
                deltaTable = DeltaLake.Table(dataLakeFolders{[Name = selectedTableIds{0}]}[Content], DeltaLake.DefaultOptions),
                deltaTableVersions = Value.Versions(deltaTable),
                // TODO add multi table support in a version
                tableNameToDelete = selectedTableIds{0} & DeletedMarker,
                tableNameToReplaceSchema = selectedTableIds{0} & ReplaceMarker,
                adlsSource =  OneLake.Contents(onelakeFilesUrl & "/" & version),
                tableListFileToCreate = (tableName) => #table({"Name","Content"}, {{ tableName ,#table({},{})}}),
                // Create a tracker file which has a list of tables for a given version.
                actions =  Action.Sequence({
                    TableAction.InsertRows(adlsSource, tableListFileToCreate(tableNameToDelete)),
                    if DynamicSchemaEmptyTableFix and isTablePresent and deltaTableVersions{[Version = version]}? = null and not isSparkCompute
                        then  Action.Sequence({
                            TableAction.InsertRows(deltaTableVersions, #table({"Version"}, {{version}})),
                            // Create a tracker file which can be used to delect schema changes.
                            TableAction.InsertRows(adlsSource, tableListFileToCreate(tableNameToReplaceSchema))
                        })
                    else Action.DoNothing,
                    sparkComputeActions,
                    Action.DoNothing})
            in
                if Table.RowCount(selectedTable) > 1 then error Extension.LoadString("MultiTableDeleteInVersionNotSupported") else actions
            )
            in
                Connector.EvaluateQueryAndActionsForErrors(result, "VersionedLakehouseTableDeleteError","VersionedLakehouseDeleteExistingTableError", "CreateVersionableView")

    // no op for now, this code might be needed in the next iteration.
    // Versioned lakehouse view, update table.not being invoke might be needed later.
    /*
    OnUpdateRows = (updates, selector) =>
                let
                    result = Diagnostics.Trace(TraceLevel.Information, "Commit the version block from CreateVersionableView", try
                    let
                        adlsSource =  DataLake.Contents(onelakeUriRecord[AdlsUrl], onelakeUriRecord[Sas]),
                        deltaLakeTable = DeltaLake.Table(adlsSource),
                        getVersions = Value.Versions(deltaLakeTable)
                    in
                        Action.Sequence({
                            Action.Return(getVersions)
                        }))
                in
                    if (result[HasError]) then error Table.ViewError(result[Error]) else result[Value] */
]);

// We need to look at decimal types and ensure they are SQL compatible while writing.
// By default the M Parquet writer will output DECIMAL(57, 28) for Decimal.Type. This exceeds SQL Server's maximum precision of 38 digits,
// so we use facets to truncate the precision to allow us to read the file via SQL Server later.
AnnotateDecimalTypes = (table) =>
  let
    fields = Record.ToTable(Type.RecordFields(Type.TableRow(Value.Type(table)))),
    transformed = Table.TransformColumns(fields, {{"Value", (t) => if Type.NonNullable(t[Type]) <> Decimal.Type then t else [
        Type = Type.ReplaceFacets(t[Type], [NumericPrecisionBase = 10, NumericPrecision = 34, NumericScale = 6]),
        Optional = false]}}),
    newType = type table Type.ForRecord(Record.FromTable(transformed), false)
  in
    Value.ReplaceType(table, newType);

RefreshAction = (baseUrl, workspaceId, dwProperties, options, tableName as text, schemaName as nullable text) =>
if dwProperties <> null and options[MetadataRefresh]? = true then
    Action.Sequence({
        () => Action.Return(
            let
                tryRefresh = Diagnostics.Trace(TraceLevel.Information,
                    [Name = "RefreshMetadata", Data = [], SafeData = [ TableName = tableName, SchemaName = schemaName ]],
                    () => try RefreshMetadata(baseUrl, workspaceId, dwProperties, options[MetadataRefresh]?, tableName, schemaName),
                    true),
                refreshFailed = tryRefresh[HasError],
                finalStatus = if refreshFailed then "error" else tryRefresh[Value],
                level = if refreshFailed
                    then TraceLevel.Error
                else if finalStatus = "success" or finalStatus = "N/A"
                    then TraceLevel.Information
                else TraceLevel.Warning,
                statusTraceData = [
                    Name = "RefreshMetadata/Status",
                    Data = [],
                    SafeData = [FinalStatus=finalStatus, ErrorMessage=tryRefresh[Error]?[Message]? ]
                ]
            in
                if Diagnostics.Trace(level, statusTraceData, refreshFailed)
                    then error tryRefresh[Error]
                    else null),
        Action.DoNothing
    })
else Action.DoNothing;

Connector.EvaluateQueryAndActionsForErrors = (result as any, marker as text, errorMessageKey as text, callerName as text) =>
    if result[HasError] then
        error Table.ViewError(Utils[Connector.GenerateErrorRecord](marker, Extension.LoadString(errorMessageKey), callerName, result[Error]))
    else
        Connector.LogActionErrorsIfPresent(result[Value], marker, callerName, Extension.LoadString(errorMessageKey));

// Generate error records if an error occurs
Connector.LogActionErrorsIfPresent = (actions as any, marker as text, callerName as text, piiFreeLogMessage as text) =>
    Action.Sequence
        ({
            () => Action.Try(actions),
            (r) => if (r[HasError]) then
                        error Utils[Connector.GenerateErrorRecord](marker, piiFreeLogMessage, callerName, r[Error])
                    else Action.Return(r[Value])
        });

// Uncomment for testing
// [DataSource.Kind="Lakehouse"]
// shared Lakehouse.RefreshMetadata = (databaseId) => RefreshMetadata(Fabric.GetClusterUrl(PBIBaseUrl), [id = databaseId], true);

// TODO: Consider rewriting to use WebAction.Request instead of Web.Contents
RefreshMetadata = (baseUrl, workspaceId, dwProperties, delayBackgroundProcessing, targetTableName as text, schemaName as nullable text) =>
let
    dwId = dwProperties[id]?,
    rootUrl = Uri.Combine(baseUrl, Text.Format("/v1.0/myorg/lhdatamarts/#{0}", {dwId})),
    prefix = "MetadataRefresh/",
    startState = [Iteration = 1], // force IsRetry on all requests by claiming we start at a higher iteration
    finalTableName = if schemaName <> null then schemaName & "." & targetTableName else targetTableName,
    submitCommand = (iteration) =>
    let
        handlers = MetadataRefreshResponseHandlers(false),
        delayCommand = [datamartVersion = null, commands = {[#"$type" = "DelayBackgroundProcessingCommand"]}],
        delayContext = [Origin = Utils[NonPii]("RefreshMetadata/DelayBackgroundProcessing"), Iteration = Utils[NonPii](iteration)],
        delayResponse = Utils[Web.JsonContents](
            rootUrl,
            /*headers*/ WorkspacePrivateLink[GetPrivateLinkS2SHeader](workspaceId),
            handlers,
            /*jsonBody*/ delayCommand,
            startState,
            /*traceContext*/ delayContext
        ),
        refreshCommandDetails = [#"$type" = "MetadataRefreshExternalCommand", isDatasetRefreshRequired = false],
        tableNameIsNotNullOrBlank = targetTableName <> null and Text.Length(targetTableName) > 0,
        tableDefinition = [schema = schemaName, tableNames = {targetTableName}],
        refreshCommandWithTableDetails = if schemaName <> null then [tableDefinitions = {tableDefinition}] else [tableNames = {targetTableName}],
        refreshCommandWithTableName = if UseDmsTableApi and tableNameIsNotNullOrBlank then
            refreshCommandDetails & refreshCommandWithTableDetails
            else if UseDmsTableApi then 
            Diagnostics.Trace(
                TraceLevel.Warning, 
                [
                    Name = prefix & "SubmitCommand/FullMetadataSync/TableNameMissing",
                    Data = [],
                    SafeData = [TableName = targetTableName, UseDmsTableApiFeatureSwitch = Text.From(UseDmsTableApi), TableNameIsNotNullOrBlank = Text.From(tableNameIsNotNullOrBlank)]
                ],
                refreshCommandDetails
            )
            else refreshCommandDetails,
        batchTimeout = [timeout = Duration.ToText(#duration(0, 0, 0, MaxDMSBatchDuration))],
        refreshCommand = [datamartVersion = null, commands = {refreshCommandWithTableName}] & batchTimeout,
        refreshContext = [Origin = Utils[NonPii]("RefreshMetadata/MetadataRefreshSubmit"), Iteration = Utils[NonPii](iteration)],
        response = Utils[Web.JsonContents](
            rootUrl,
            /*headers*/ WorkspacePrivateLink[GetPrivateLinkS2SHeader](workspaceId),
            handlers,
            /*jsonBody*/ refreshCommand,
            startState,
            /*traceContext*/ refreshContext
        ),
        responseStatusCode =
            if DisableDmsDelayedBackgroudProcessing = false and delayBackgroundProcessing = true and delayResponse = "unreachable" 
            then 0 else Record.FieldOrDefault(Value.Metadata(response), "Response.Status", 0),
        errorDetails = response[error]?[pbi.error]?[details]?,
        lockConflictBatchId = if errorDetails <> null then try SelectKeysFromListOfRecordsForDMS(errorDetails, {"LockingBatchId"}, false)[LockingBatchId]? otherwise null else null,
        result = [StatusCode = responseStatusCode, ErrorCode = response[error]?[code]?, BatchId = response[batchId]?, LockingBatchId = lockConflictBatchId]
    in
        Diagnostics.Trace(if responseStatusCode <> 200 then TraceLevel.Warning else TraceLevel.Information,
            [Name = prefix & "SubmitCommand", Data = [], SafeData = result &
            [Iteration = iteration, TableName = targetTableName, UseDmsTableApiFeatureSwitch = Text.From(UseDmsTableApi),
            MetadataSyncConfigurtion = Utils[Value.ToText](MetadataSyncConfig)]],
            result),

    getInProgressBatch = (iteration) =>
    let
        getBatchContext = [Origin = Utils[NonPii]("RefreshMetadata/GetInProgressBatch"), Iteration = Utils[NonPii](iteration)],
        response = Utils[Web.JsonContents](
            rootUrl & "/batches",
            /*headers*/ WorkspacePrivateLink[GetPrivateLinkS2SHeader](workspaceId),
            /*additionalHandlers*/ [],
            /*jsonBody*/ null,
            startState,
            /*traceContext*/ getBatchContext
        ),
        asTable = Table.FromRecords(response[value], {"batchId", "progressState", "startTimeStamp"}, MissingField.Error),
        changedTypeForStartTimestamp = Table.TransformColumnTypes(asTable, {{"startTimeStamp", type datetime}}), // represent as datetime
        utcTimeWithoutZone = DateTimeZone.RemoveZone(DateTimeZone.UtcNow()), // remove zone from UTC time for comparison.
        batchesInPastOneDay = Table.SelectRows(changedTypeForStartTimestamp, each [startTimeStamp] > (utcTimeWithoutZone - #duration(1,0,0,0)) and [progressState] = "inProgress"), // get inprogress batches from past 24 hours
        inProgress = Table.Sort(batchesInPastOneDay, {{"startTimeStamp", Order.Descending}})
    in
        try inProgress{0}?[batchId]? catch (e) => Diagnostics.Trace(
            TraceLevel.Error,
            [Name=prefix & "GetInProgress", Data = [], SafeData = [Exception = Utils[Value.ToText](e)]],
            null),

    getResultStatus = (result, optional originatedFromLockConflict) =>
    let
        batchStatus = result[progressState]? ?? "(null)",
        batchId = result[batchId]?,
        status = Table.FromList(
            List.Combine(List.Transform(result[operationInformation], (oi) => oi[progressDetail][tablesSyncStatus])),
            Splitter.SplitByNothing()),
        progressDetail =  if batchStatus = "success" then try Table.ExpandRecordColumn(status, "Column1", {"tableName", "error", "tableSyncState", "sqlSyncState", "lastSuccessfulUpdate", "correctiveAction"})
            catch (e) => ThrowMetadataSyncErrors(prefix & "ProgressDetail", Extension.LoadString("MetadataRefreshParseResponseError"),
                [], [BatchId = batchId, ResponseForBatch = Utils[Value.ToText](result, 5)], e,
                {Utils[NonPii](dwId), Utils[NonPii](batchId), e[Message]})
            else
                let
                    errorResult = GenerateErrorCodeAndMessageForDMSBatch(result)
                in
                    ThrowMetadataSyncErrors(prefix & "BatchStatusError", Extension.LoadString("MetadataRefreshBatchError"),
                        [], [BatchId = batchId, ErrorCode = errorResult[ErrorCode], ResponseForBatch = Utils[Value.ToText](result) ], errorResult[ExceptionData] ?? result,
                        {Utils[NonPii](dwId), Utils[NonPii](batchId), Utils[NonPii](errorResult[ErrorCode]), Utils[NonPii](errorResult[ErrorMessage])}),

        //Calculate DMS Reported Batch Duration so it can be logged.
        getDMSReportedBatchDuration = (operationInformationDetails as any) => 
        try
            let 
                batchEndTimeUtc = operationInformationDetails{0}[endDateTimeUtc]?,
                batchStartTimeUtc = operationInformationDetails{0}[startDateTimeUtc]?,
                dmsReportedDuration = if ReportDMSBatchDuration then DateTime.From(batchEndTimeUtc) - DateTime.From(batchStartTimeUtc)
                    else -1
            in 
                dmsReportedDuration
        otherwise -1,
        tableDetail = Table.SelectRows(progressDetail, each [tableName] = finalTableName),
        withoutTableName = Table.RemoveColumns(tableDetail, {"tableName"}),
        failureRows = Table.SelectRows(tableDetail, each ([tableSyncState] = "Failure" or [sqlSyncState] = "Failure")),
        missingTable = finalTableName <> null and Table.IsEmpty(tableDetail),
        hasFailure = missingTable or Table.RowCount(failureRows) > 0,
        failureDetails = Table.First(failureRows)[error]?,
        correctiveAction = Table.First(failureRows)[correctiveAction]?,
        sqlFailureDetails = if LogSqlErrorCodesFromDMSResponse and failureDetails[details]? <> null then SelectKeysFromListOfRecordsForDMS(failureDetails[details]?, {"RootActivityId", "SqlErrorNumber", "SqlErrorClass", "SqlErrorState"}, true) else [],
        errorCode = if missingTable then "TableMissingInBatchFailure"
            else if correctiveAction <> null and targetTableName <> null and Text.Length(targetTableName) > 128 then "TableNameTooLongFailure"
            else "TableSyncFailure",

        dmsReportedErrorCode = Text.Format("#{0}|#{1}", {failureDetails[code]?, failureDetails[httpStatusCode]?}),
        failureStatus = if Value.Is(failureDetails, Record.Type) then [DMSReportedErrorCode = dmsReportedErrorCode] else [],
        failureDetailAsText = Utils[Value.ToText](failureDetails, 5),
        errorMessageWithoutStackTrace = if missingTable  then errorCode else Text.BeforeDelimiter(failureDetailAsText, "callStack"), // remove stack trace so we can log and raise this to end user.

        tracedFailure = Diagnostics.Trace(
            TraceLevel.Error,
            [
                Name= prefix & "TableSyncFailure",
                Data =  [],
                SafeData = [
                    BatchId = result[batchId]?,
                    TableName = finalTableName,
                    ErrorCode = errorCode,
                    ErrorDetail = failureDetailAsText,
                    CorrectiveAction = Utils[Value.ToText](correctiveAction),
                    LakehouseId = dwId
                ] & failureStatus & sqlFailureDetails
            ],
            Text.Format(Extension.LoadString("TableCreationFailureError"),{errorMessageWithoutStackTrace})
        ),
        finalResult = if (not originatedFromLockConflict and hasFailure)
                      then error Error.Record(Utils[NonPii]("DataSource.Error"), Utils[NonPii](Extension.LoadString("MetadataRefreshErrorWithDetail")), failureDetails, {Utils[NonPii](dwId), Utils[NonPii](result[batchId]?), Utils[NonPii](tracedFailure)})
                      else [Response = try Text.FromBinary(Json.FromValue(withoutTableName)) otherwise "<unable to get status>", Duration = getDMSReportedBatchDuration(result[operationInformation])]
    in
        finalResult,

    pollBatch = (batchId, optional originatedFromLockConflict) =>
    let
        pollCount = MetadataSyncConfig[PollingCount],
        exponentialBackoffMultiplier = MetadataSyncConfig[PollingDelayMultiplier],
        finalPollUrl = 
            if DMSUseLongPolling then 
                Diagnostics.Trace(TraceLevel.Information, [Name = prefix & "LongPollBatch", Data = [], 
                    SafeData = [BatchId = batchId]], rootUrl & "/events/Batch?resourceId=" & batchId & "&batchStateChangeOnly=true")
            else 
                Diagnostics.Trace(TraceLevel.Information, [Name = prefix & "PollBatch", Data = [],
                    SafeData = [BatchId = batchId]], rootUrl & "/batches/" & batchId),

        waitForResultLongPoll = Utils[Value.WaitFor](
            (iteration) =>
                let
                    jsonResponse = Utils[Web.JsonContents](
                        finalPollUrl,
                        /*headers*/ WorkspacePrivateLink[GetPrivateLinkS2SHeader](workspaceId),
                        /*additionalHandlers*/ MetadataRefreshResponseHandlers(true),
                        /*jsonBody*/ null,
                        startState,
                        /*traceContext*/ [Origin = Utils[NonPii]("RefreshMetadata/PollBatch")]
                    ),
                    responseStatus = Value.Metadata(jsonResponse)[Response.Status]?,
                    newState = jsonResponse[event]?[progressState]? ?? "(null)",
                    continuePolling = if responseStatus = 204 or responseStatus = 500 
                        then Diagnostics.Trace(TraceLevel.Information, [Name = "LongPoll/Continue", Data = [], SafeData = [LongPollResponse = responseStatus]], true) 
                    else false,
                    reponseToParse = jsonResponse[event]?,
                    finalStatus = try getResultStatus(reponseToParse, originatedFromLockConflict),
                    unableToSyncError = ThrowMetadataSyncErrors(prefix & "LongPollBatch/UnableToSyncTable", Extension.LoadString("MetadataRefreshUnableToSyncTable"), [],
                        [PollingIterationCount = iteration, TableName = finalTableName, PolledBatchId = batchId], [BatchId = batchId, LakehouseId = dwId], {Utils[NonPii](dwId), Utils[NonPii](batchId)})
                in
                    if iteration >= pollCount then
                        if UseDmsTableApi and originatedFromLockConflict = false
                                then unableToSyncError
                            else Diagnostics.Trace(TraceLevel.Warning,
                            [
                                Name = prefix & "LongPollBatch/MaxRetriesExceeded",
                                Data = [],
                                SafeData = [PollingIterationCount = iteration, TableName = finalTableName, PolledBatchId = batchId, LakehouseId = dwId]
                            ],
                            null)
                    else if continuePolling
                        then null
                    else if finalStatus[HasError]
                        then error finalStatus[Error]
                    else Diagnostics.Trace(TraceLevel.Information,
                        [
                            Name=prefix & "LongPoll",
                            Data=[],
                            SafeData=[
                                BatchState = newState,
                                BatchStatus = finalStatus[Value][Response],
                                IterationCount = iteration,
                                BatchId = batchId,
                                TableName = finalTableName,
                                DMSReportedBatchDuration = finalStatus[Value][Duration]
                            ]
                        ],
                        newState),
            (iteration) => #duration(0, 0, 0, Number.Power(exponentialBackoffMultiplier, iteration + 1)-1),
            pollCount),

        waitForResult = Utils[Value.WaitFor](
            (iteration) =>
                let
                    jsonResponse = Utils[Web.JsonContents](
                        finalPollUrl,
                        /*headers*/ WorkspacePrivateLink[GetPrivateLinkS2SHeader](workspaceId),
                        /*additionalHandlers*/ MetadataRefreshResponseHandlers(true),
                        /*jsonBody*/ null,
                        startState,
                        /*traceContext*/ [Origin = Utils[NonPii]("RefreshMetadata/PollBatch")]
                    ),
                    responseStatus = Value.Metadata(jsonResponse)[Response.Status]?,
                    newState = jsonResponse[progressState]? ?? "(null)",
                    continuePolling = responseStatus = 500 or newState = "inProgress",
                    reponseToParse = jsonResponse,
                    finalStatus = try getResultStatus(reponseToParse, originatedFromLockConflict),
                    unableToSyncError = ThrowMetadataSyncErrors(prefix & "PollBatch/UnableToSyncTable", Extension.LoadString("MetadataRefreshUnableToSyncTable"), [],
                        [PollingIterationCount = iteration, TableName = finalTableName, PolledBatchId = batchId], [BatchId = batchId, LakehouseId = dwId], {Utils[NonPii](dwId), Utils[NonPii](batchId)})
                in
                    if iteration >= pollCount then
                        if UseDmsTableApi and originatedFromLockConflict = false
                                then unableToSyncError
                            else Diagnostics.Trace(TraceLevel.Warning,
                            [
                                Name = prefix & "PollBatch/MaxRetriesExceeded",
                                Data = [],
                                SafeData = [PollingIterationCount = iteration, TableName = finalTableName, PolledBatchId = batchId, LakehouseId = dwId]
                            ],
                            null)
                    else if continuePolling
                        then null
                    else if finalStatus[HasError]
                        then error finalStatus[Error]
                    else Diagnostics.Trace(TraceLevel.Information,
                        [
                            Name=prefix & "Poll",
                            Data=[],
                            SafeData=[
                                BatchState = newState,
                                BatchStatus = finalStatus[Value][Response],
                                IterationCount = iteration,
                                BatchId = batchId,
                                TableName = finalTableName,
                                DMSReportedBatchDuration = finalStatus[Value][Duration]
                            ]
                        ],
                        newState),
            (iteration) => #duration(0, 0, 0, Number.Power(exponentialBackoffMultiplier, iteration + 1)-1),
            pollCount)
    in
        if DMSUseLongPolling then waitForResultLongPoll else waitForResult,

    // When we submit a request to refresh metadata, there may already be a metadata refresh
    // underway. If so, we get a LockConflict error. We then get the batchId for the in-progress refresh
    // and we poll for that refresh to finish. Once it's done, we try to submit another metadata
    // refresh request. If this, too, fails with a LockConflict then we again wait for the in-progress
    // refresh to be finished. Once that's done, we stop because our change should have been picked up
    // by the second refresh cycle.

    // Based on evidence in telemetry, if there's no "in-progress" operation, we'll try the metadata
    // refresh again without increasing the iteration.

    // The comparison of newState to "expected not to match" is to force evaluation of newState before
    // we try to submit a second refresh request.

    // DMS has published a new TableLevel API this means when doing metadata sync in case of lock conflicts we
    // need to try harder to get a lock so we can ensure the table is synced. For this reason we need to increase
    // the max number of tries to a larger value, currently set at 5
    // We will also poll a lower number of times as this is expected to be a faster operation.

    Submit = (iteration, optional originatedFromLockConflict) => let result = submitCommand(iteration) in
        if result[BatchId]? <> null then pollBatch(result[BatchId], originatedFromLockConflict)
        else if result[ErrorCode]? = "LockConflictException" or result[ErrorCode]? = "LockConflict" then LockConflict(iteration, result[LockingBatchId]?)
        else error Error.Record(Utils[NonPii]("DataSource.Error"), Utils[NonPii](Text.Format(Extension.LoadString("MetadataRefreshError"), {result[ErrorCode], result[StatusCode]})), ""),

    // 1. Since we encountered a lock conflict, check for any ongoing batch and poll it to completion
    //    As this batch might not be the one associated with the current request, the 'originatedFromLockConflict' flag
    //    true suggests that if the specific table isn't found, no error is thrown in getResultStatus.

    // 2. After this completes, we attempt to submit our request again, expecting to get our
    //    own batch this time, set originatedFromLockConflict = false indicating that the request
    //    isn't being made as a result of resolving a lock conflict.

    // 3. If no ongoing batches are found after a lock conflict, a brief wait is introduced before trying
    //    to submit the request again, with 'originatedFromLockConflict' set to false as we expect this
    //    attempt to be our own batch.

    LockConflict = (iteration, lockConflictBatchId) =>
        let
            maxIterationsForLockConflict = MetadataSyncConfig[MaxIterationCount] - 1,
            maxIterationsForNothingInProgress = MetadataSyncConfig[NothingInProgressIterationCount] - 1,
            inProgressBatchId = if lockConflictBatchId = null then getInProgressBatch(iteration) else lockConflictBatchId,
            newState = pollBatch(inProgressBatchId, true),
            nextIteration = Submit(iteration + 1, false),
            // Retry recursive and cross fingers.
            // We increment iteration to avoid infinite recursion and stack overflow.
            //
            nothingInProgress =
                Function.InvokeAfter(() => Submit(iteration + 1, false), Diagnostics.Trace(TraceLevel.Information, [Name = prefix & "LockConflict/NothingInProgress/Retry",
                Data = [], SafeData = [Iteration = iteration, NothingInProgressIterationCount = maxIterationsForNothingInProgress]], #duration(0, 0, 0, 5))),

            nothingInProgressError = ThrowMetadataSyncErrors(
                prefix & "LockConflict/NothingInProgress",
                Extension.LoadString("MetadataRefreshNothingInProgress"),
                [],
                [IterationCount = iteration, TableName = finalTableName, lakhouseId = dwId],
                [TableName = finalTableName, LakehouseId = dwId],
                {Utils[NonPii](dwId), finalTableName}
            ),
            unableToSyncError = ThrowMetadataSyncErrors(
                prefix & "LockConflict/UnableToSyncTable",
                Extension.LoadString("MetadataRefreshUnableToSyncTable"),
                [],
                [IterationCount = iteration, TableName = finalTableName, PolledBatchId = inProgressBatchId],
                [BatchId = inProgressBatchId, LakehouseId = dwId],
                {Utils[NonPii](dwId), Utils[NonPii](inProgressBatchId)}
            )
        in
            // Guard against infinite recursion.
            if inProgressBatchId = null then if iteration > maxIterationsForNothingInProgress then nothingInProgressError else nothingInProgress
            else let newState = pollBatch(inProgressBatchId, true) in
                if newState = "expected not to match" or iteration > maxIterationsForLockConflict then
                    if UseDmsTableApi then unableToSyncError else newState
                else nextIteration

in
    if dwId = null then "N/A" else Submit(0, false);

SelectKeysFromListOfRecordsForDMS = (details, keys, isTableSyncFailure as logical) =>
    Record.SelectFields(Record.Combine(List.Transform(details, (val) => Record.AddField([],val[code],if isTableSyncFailure then val[message] else val[detail]?[value]))), keys, MissingField.Ignore);

GenerateErrorCodeAndMessageForDMSBatch = (result) =>
let
    hasExceptionData = Record.HasFields(result, "exceptionData"),
    hasErrorData = Record.HasFields(result, "errorData"),
    exceptionData = result[exceptionData]? ?? result[errorData]?,
    errorMessage = if exceptionData <> null then Utils[Value.ToText](exceptionData, 5) else Utils[Value.ToText](result, 5),
    errorCode = if hasExceptionData then exceptionData[code]? else if hasErrorData then exceptionData[error]?[code]? else "UnkownError"
in
    [ErrorCode = errorCode, ErrorMessage = errorMessage, ExceptionData = exceptionData];

ThrowMetadataSyncErrors = (logName, errorMessage, data, safedata, errorRecord, variableListForError) =>
error Diagnostics.Trace(TraceLevel.Error, [Name = logName, Data = data, SafeData = safedata],
    Error.Record(
    Utils[NonPii]("DataSource.Error"),
    Utils[NonPii](errorMessage),
    errorRecord,
    variableListForError));

UniqueRequestHeader = "x-ms-client-request-id";
PrivateLinkCapacityHeader = "x-ms-src-capacity-id";
PublicApiSystemCallHeader = "x-ms-public-api-system-call";

PBICommonHeaderNames = {
    UniqueRequestHeader,
    "x-ms-client-session-id",
    "RequestId",
    "ActivityId"
};

/**
When reading data from Cache, the Lakehouse connector will directly access
the file using the cache key by leveraging AzureStorage.DataLakeContents function
and adding this to a binary buffer so any errors can be caught using the catch(e) method.
**/
GetDataFromCacheTable = (cacheLocation as record, cacheKey as text, caller as text, baseUrl as text) =>
let
    dataFromCacheTable =
        try LakehouseCacheFile(cacheLocation[WorkspaceId], cacheLocation[LakehouseId], cacheKey, Text.Contains(baseUrl, "MSIT"))
        catch(e) => Diagnostics.Trace(TraceLevel.Warning, [Name = "CacheAccessError", Data = [Exception = Utils[Value.ToText](e)],
            SafeData = [WorkspaceId = cacheLocation[WorkspaceId], LakehoueId = cacheLocation[LakehouseId]]], null),
    isPresent = dataFromCacheTable <> null and Binary.Length(dataFromCacheTable) > 0,
    stateData = if isPresent then
            try (Json.Document(dataFromCacheTable)) 
            catch(e) => Diagnostics.Trace(TraceLevel.Warning, [Name = "CacheJsonError", Data=[Error = Utils[Value.ToText](e)]], null) 
        else null,
    emptyStateData = [Data = null],
    cacheResult = if stateData <> null 
        then  [Data = stateData] 
        else emptyStateData,
    result = Diagnostics.Trace(TraceLevel.Information, [Name = "CacheSearch/" & caller, Data = [], SafeData = [KeyToSearch = cacheKey, ResultFound = Utils[Value.ToText](isPresent)]], cacheResult)
in
    if UseFileCache 
            and not WorkspacePrivateLink[IsWorkspacePLUrl](baseUrl) 
            and cacheLocation[WorkspaceId] <> null 
            and cacheLocation[LakehouseId] <> null then 
        result 
    else emptyStateData;

CacheTableAction = (workspaceId, lakehouseId, key as text, value as anynonnull, caller as text, baseUrl as text) =>
    let 
        cacheSrc = LakehouseCacheTable(workspaceId, lakehouseId, Text.Contains(Text.Lower(baseUrl), "msit")),
        cacheParentSrc = LakehouseCacheParentTable(workspaceId, lakehouseId, Text.Contains(Text.Lower(baseUrl), "msit")),
        isCacheFolderPresent = try cacheSrc <> null otherwise false,
        isPresent = try cacheSrc{[Name = key]} <> null otherwise false,
        cacheFolderCreateAction = if not isCacheFolderPresent then 
                Action.Sequence({
                    TableAction.InsertRows(cacheParentSrc, #table(type table [Name = text, Content = any], {{CacheParentFolder, #table({},{})}})),
                    Action.Return(cacheSrc)})
            else Action.Return(cacheSrc),
        // TODO Use TableAction.Update rows once the ADLS supports TableAction.UpdateRows for 'Date modified' 
        cacheTouchAction = Action.Sequence({
            ValueAction.Replace(cacheSrc{[Name = key]}[Content], Json.FromValue(value)),
            Action.DoNothing
        }),
        insertAction = Action.Sequence({
            cacheFolderCreateAction,
            (result) => TableAction.InsertRows(result, #table(type table [Name = text], {{key}})),
            Action.Return(cacheSrc),
            cacheTouchAction
        }),
        actions = Action.Sequence({
           () => if Diagnostics.Trace(TraceLevel.Information, [Name = "CacheCheck/" & caller, Data = [LakehouseId = key], SafeData = []], isPresent)
            then Diagnostics.Trace(TraceLevel.Information, [Name = "Cache/DataPresent/" & caller , Data = [LakehouseId = key]] , tryCacheActions(cacheTouchAction, "CacheTouch") )
            else Diagnostics.Trace(TraceLevel.Information, [Name = "Cache/DataInsert/" & caller, Data = [LakehouseId = key]] , tryCacheActions(insertAction, "CacheInsert"))
        })
    in
        actions;

CacheTableInsertBuilder = (cacheLocation as record, insertList as list, baseUrl as text) =>
let
 index = 0,
 size = List.Count(insertList),
 insertActions = List.Generate(
    () => [Index = 0, InsertAction = CacheTableAction(cacheLocation[WorkspaceId], cacheLocation[LakehouseId], insertList{0}[Id], insertList{0}[Info], insertList{0}[Key], baseUrl)], 
    each [Index] < size, 
    each [Index = [Index] + 1, InsertAction = CacheTableAction(cacheLocation[WorkspaceId], cacheLocation[LakehouseId], insertList{[Index] + 1}[Id],insertList{[Index] + 1}[Info], insertList{[Index] + 1}[Key], baseUrl)])
in
    if UseFileCache 
            and not WorkspacePrivateLink[IsWorkspacePLUrl](baseUrl) 
            and cacheLocation[WorkspaceId] <> null 
            and cacheLocation[LakehouseId] <> null then 
        Action.Sequence(List.Transform(insertActions, each [InsertAction])) 
    else Action.DoNothing;

GetCacheLocation = (options as record, optional workspaceId as nullable text, optional lakehouseId as nullable text) =>
let
    dlpPolicies = WorkspaceDlp[GetDlpPolicies](),    
    // Validate staging workspace if provided
    validatedStagingWorkspaceId = if options[StagingWorkspaceId]? <> null then 
        WorkspaceDlp[CheckWorkspaceAllowed](options[StagingWorkspaceId], dlpPolicies) 
        else null
in
    if options[IsModelStorage]? = true 
    then 
        [
            WorkspaceId = workspaceId,
            LakehouseId = lakehouseId
        ] 
    else 
        [
            WorkspaceId = validatedStagingWorkspaceId,
            LakehouseId = options[StagingLakehouseId]?
        ];

TrimCache = (cacheLocation as record, baseUrl) =>
let
    cacheSrc = LakehouseCacheTable(cacheLocation[WorkspaceId], cacheLocation[LakehouseId], Text.Contains(Text.Lower(baseUrl), "msit")),
    isCacheFolderPresent = try cacheSrc <> null otherwise false,
    // select files which have not been modified in the past 24 hours.
    cacheEntriesToBeTrimmed = Table.SelectRows(cacheSrc, each 
        (DateTimeZone.RemoveZone(DateTimeZone.UtcNow()) - [Date modified] > #duration(0, 0, 0, CacheTrimDuration))),
    // TODO - One SU02 is avaialbe use the date modified filter directly to delete the files.
    bufferedEntries = List.Buffer(cacheEntriesToBeTrimmed[Name]),
    deleteActions = (fileName) =>
        let 
            trimEntry = List.Contains(bufferedEntries , fileName)
        in 
            if trimEntry then
                Action.Sequence({ 
                    TableAction.DeleteRows(Table.SelectRows(cacheSrc, each [Name] = fileName)),
                    Action.DoNothing
                })
            else Action.DoNothing,

    withTrimActionColumn = Table.AddColumn(cacheSrc, "CacheTrimAction", each deleteActions([Name])),
    cacheTrimAction = Action.Sequence(withTrimActionColumn[CacheTrimAction])
in
    if UseFileCache and not WorkspacePrivateLink[IsWorkspacePLUrl](baseUrl) and isCacheFolderPresent then tryCacheActions(cacheTrimAction, "CacheTrim") else Action.DoNothing;

tryCacheActions = (actions, actionName) => Action.Sequence
        ({
            () => Action.Try(actions),
            (r) => if (r[HasError]) then
                        Diagnostics.Trace(TraceLevel.Warning, [Name = actionName, Data = [Exception = Utils[Value.ToText](r[Error])]], Action.DoNothing)
                    else Action.Return(r[Value])
        });

// -----------------------------------------------------
// | 2. OneLake Storage (which is adls storage)
// -----------------------------------------------------

GetServiceToken = (resource) =>
    let
        currentCredentials = Extension.CurrentCredential(),
        trimmedResource = Text.TrimEnd(resource, "/"),
        prop = "ServiceAccessToken:" & trimmedResource,
        propWithSlash = "ServiceAccessToken:" & trimmedResource & "/",
        tokenValue = Record.FieldOrDefault(currentCredentials[Properties], prop, Record.FieldOrDefault(currentCredentials[Properties], propWithSlash, null))
    in
        tokenValue;

OneLake.Contents = (entityUrl as text) =>
    Extension.InvokeWithCredentials(
        (datasource) =>
            let
                baseCredential = GetCredential(AadAdlsStorageResource),
                capacityId = Extension.CurrentApplication()[PBI_CapacityObjectId]?,
                s2sToken = GetServiceToken(AadAdlsStorageResource),
                plCredential = if capacityId <> null and s2sToken <> null
                    then [CapacityId = capacityId, ServiceAccessToken = s2sToken]
                    else []
            in
                baseCredential & plCredential,
        () => AzureStorage.DataLake(entityUrl, [HierarchicalNavigation=true, IsOneLake = true]));

OneLake.FileContents = (entityUrl as text) =>
    Extension.InvokeWithCredentials(
        (datasource) =>
            let
                baseCredential = GetCredential(AadAdlsStorageResource),
                capacityId = Extension.CurrentApplication()[PBI_CapacityObjectId]?,
                s2sToken = GetServiceToken(AadAdlsStorageResource),
                plCredential = if capacityId <> null and s2sToken <> null
                    then [CapacityId = capacityId, ServiceAccessToken = s2sToken]
                    else []
            in
                baseCredential & plCredential,
        () => AzureStorage.DataLakeContents(entityUrl));

// -----------------------------------------------------
// | 3. TDS Endpoint using SQL Connector
// -----------------------------------------------------

Sql.Contents = (serverInstance as text, dbname as text, options as record) =>
    Extension.InvokeWithCredentials(
        (datasource) => GetCredential(AadSqlResource),
        () =>
            let
                optionsToSelect = {"CommandTimeout", "CreateNavigationProperties"},
                finalOptionsList = if EnableHierarchicalNavigationSupport then 
                    optionsToSelect & {"HierarchicalNavigation"} 
                else 
                    optionsToSelect,
                curatedOptions = Record.SelectFields(options, finalOptionsList, MissingField.Ignore)
            in
                Sql.Database(serverInstance, dbname, [EnableCrossDatabaseFolding = true] & curatedOptions)
    );

Sql.TestConnection = (database as nullable record, lakehouseId as nullable text) =>
    Extension.InvokeWithCredentials(
        (datasource) => GetCredential(AadSqlResource),
        () =>
            let
                serverInstance = database[tdsEndpoint]?,
                dbname = database[name]?,
                ErrorMessageFormat = Extension.LoadString("NoSqlEndPoint"),
                result = if (serverInstance <> null) then Diagnostics.Trace(TraceLevel.Information, [Name = "TestConnection", Data = []],  DataSource.TestConnection(Sql.Database(serverInstance, dbname))) else
                    error Error.Record(Utils[NonPii]("DataSource.Error"), Utils[NonPii](ErrorMessageFormat), [])
            in
                try result catch (e) => error Diagnostics.Trace(TraceLevel.Error, [
                        Name = "SqlTestConnectionFailure",
                        Data = [ Exception = Utils[Value.ToText](e) ],
                        SafeData = [ LakehouseId = lakehouseId ]
                    ], e)
    );

Sql.ValidateInstance = (database as nullable record) =>
    Extension.InvokeWithCredentials(
        (datasource) => GetCredential(AadSqlResource),
        () =>
            let 
                serverInstance = database[tdsEndpoint]?,
                dbname = database[name]?,
                serverDetailsPresent = serverInstance <> null and dbname<> null,
                result =  List.Contains(Sql.Databases(serverInstance)[Name], dbname)
            in 
               if serverDetailsPresent then result 
               else Diagnostics.Trace(TraceLevel.Warning, [Name = "CachedSqlMissing", Data=[], SafeData = [DatabaseDetails = Utils[Value.ToText](database)]], false)
    );

// -----------------------------------------------------
// | 4. Utility
// -----------------------------------------------------

GetCredential = (resource) =>
    let
        currentCredentials = Extension.CurrentCredential(),
        trimmedResource = Text.TrimEnd(resource, "/"),
        prop = "AccessToken:" & trimmedResource,
        propWithSlash = "AccessToken:" & trimmedResource & "/",
        tokenValue = Record.FieldOrDefault(currentCredentials[Properties], prop, Record.FieldOrDefault(currentCredentials[Properties], propWithSlash, "")),
        finalTokenValue = if tokenValue = "" then Diagnostics.Trace(TraceLevel.Error, [Name = "GetCredential/CredentialPropertyNotFound", Data = [], SafeData = [CredentialProperty = Text.Combine({prop, propWithSlash}, ",")]], currentCredentials[access_token]) else tokenValue,
        credentialToReturn = currentCredentials & [access_token = finalTokenValue]
    in
        credentialToReturn;

Utility.CreateScope = () as text =>
    let
        appendix = "user_impersonation",
        scopeForStorage = Text.Format("#{1}/#{0}", {appendix, AadAdlsStorageResource}),
        scopeForSql = Text.Format("#{1}/#{0}", {appendix, AadSqlResource}),
        scopeForWorkspaces = Text.Format("#{1}/#{0}", {appendix, AadWorkspaceApiOAuthResource}),
        result = Text.Combine({scopeForWorkspaces, scopeForSql, scopeForStorage}, " ")
    in
        result;

Value.ConvertToNumber = (a) =>
  try Number.From(a) otherwise 3600;

// TODO: Figure out a way to make this work with bindings, probably leveraging Action.View
WithAfterAction = (table, afterAction, partitionedRefreshInput as record) => 
    let
        view = (tbl, functn, partitionedRefreshInput) => 
        Table.View(tbl, [
            OnInvoke = (function, args, index) =>
                if (function = Value.Versions) then
                    let
                        fileUrl = GenerateVersionTableBaseLocation(
                            partitionedRefreshInput[CacheLocation],
                            partitionedRefreshInput[BaseUrl])
                    in
                        //Partitioned Refresh Pattern, SelectRows followed by Value.Versions.
                        if EnablePartitionedRefresh and partitionedRefreshInput[Input]? <> null then
                            GetLakehouseTableVersions(
                                partitionedRefreshInput[OnelakeTableUrl],
                                fileUrl,
                                tbl,
                                Action.DoNothing,
                                [ OneLakeFilesPath = fileUrl ],
                                partitionedRefreshInput[CacheTableInsertRecord],
                                [], // empty options for Partitioned Refresh
                                [
                                    data = partitionedRefreshInput[Input],
                                    selectorFunction = functn,
                                    deltaSrc = partitionedRefreshInput[TableData],
                                    versionParentLocation = fileUrl,
                                    tableName = partitionedRefreshInput[TableId]
                                ]
                            )
                        else 
                            PostPublishAction(Value.Versions(tbl))
                else ...,
            OnSelectRows = (condition) => 
                let
                    selectedData = Table.SelectRows(tbl, condition),
                    additionalDetails = [
                        Input = selectedData
                    ],
                    combinedRecord = partitionedRefreshInput & additionalDetails
                in 
                    @view(selectedData, (row) => functn(row) and condition(row), combinedRecord),
            OnInsertRows = (rowsToInsert) => Action.Sequence({TableAction.InsertRows(tbl, rowsToInsert), afterAction}),
            OnUpdateRows = (updates, selector) => Action.Sequence({
                TableAction.UpdateRows(Table.SelectRows(tbl, selector), List.Transform(updates, each {[Name], [Function]})),
                afterAction
            }),
            OnDeleteRows = (selector) => Action.Sequence({TableAction.DeleteRows(Table.SelectRows(tbl, selector)), afterAction}),

            PostPublishAction = (versions) => Table.View(versions, [
                // TODO: look specifically for a Publish action
                OnUpdateRows = (updates, selector) => Action.Sequence({
                    TableAction.UpdateRows(Table.SelectRows(versions, selector), List.Transform(updates, each {[Name], [Function]})),
                    afterAction
                })
            ])
        ])
    in
        view(table, each true, partitionedRefreshInput);

MetadataRefreshResponseHandlers = (retryOn400 as logical) as record =>
    let
        metadataDelayFn = (iteration) => iteration * 5
    in [
        400 = if retryOn400 then Utils[RetryHandler](4, metadataDelayFn) else JsonHandler,
        403 = ErrorOrRefreshTokenHandler,
        500 = Utils[RetryHandler](4, metadataDelayFn),
        503 = Utils[RetryHandler](4, metadataDelayFn)
    ];

ErrorOrRefreshTokenHandler = (state) =>
    let
        result = try Utils[Web.DefaultErrorHandler](state),
        errorCode = result[Error]?[Detail]?[ErrorCode]? ?? ""
    in
        if errorCode = "TokenExpired" then AuthHandler(state) else error result[Error];

AuthHandler = (state) =>
    if state[Refreshed]? = true or not Web.TryRefreshToken() then Utils[Web.DefaultErrorHandler](state)
    else state & [Refreshed = true];

JsonHandler = (state) => state & [
    Response = Json.Document(state[Response]) meta Value.Metadata(state[Response]),
    Complete = true
];

Web.TryRefreshToken = () as logical =>
    let
        forceRefreshOfTokens = true
    in
        Extension.CurrentCredential(forceRefreshOfTokens) <> null; // Force refresh of token.

Lakehouse = [
    Type = "Custom",
    MakeResourcePath = (optional options) => if (options[IsModelStorage]? = true) then "LakehouseModelStorage" else "Lakehouse",
    ParseResourcePath = (resource) => { },
    RedactResourcePath = (resourcePath, safecategories) => resourcePath,
    Authentication = [
        Aad = [
            AuthorizationUri = AadAuthorizationUri,
            Resource = "",
            Scope = Utility.CreateScope(),
            DefaultClientApplication = [
                ClientId = "a672d62c-fc7b-4e81-a576-e60dc46e951d",
                ClientSecret = "",
                CallbackUrl = AadRedirectUrl
            ]
        ]
    ],
    ApplicationProperties = [
        PBIEndpointUrl = [PropertyType = Text.Type, IsRequired = false],
        PBI_CapacityObjectId = [PropertyType = Text.Type, IsRequired = false],
        PBI_ClusterUrl = [PropertyType = Text.Type, IsRequired = false]
    ],
    Label = Extension.LoadString("DataSourceLabel"),

     // valid DSRs
/*
{"protocol":"lakehouse","address":{"workspace":null,"lakehouse":null}}
{"protocol":"lakehouse","address":{"workspace":"685d9cf0-e359-48b3-983b-3c4babc37af6","lakehouse":null}}
{"protocol":"lakehouse","address":{"workspace":"685d9cf0-e359-48b3-983b-3c4babc37af6","lakehouse":"12345678-e359-48b3-983b-3c4babc37af5"}}
{"protocol":"lakehouse","address":{"workspace":"685d9cf0-e359-48b3-983b-3c4babc37af6","lakehouse":"12345678-e359-48b3-983b-3c4babc37af5", "table" : "NewTable"}}
*/
    DSRHandlers = [
        #"lakehouse" = [
            GetDSR = (optional options, optional navigation) =>
                let
                    workspace = navigation{0}?[workspaceId]?,
                    lakehouse = navigation{2}?[lakehouseId]?,
                    id = navigation{4}?[Id]?,
                    itemKind = navigation{4}?[ItemKind]?,
                    count = List.Count(navigation),
                    matchLakehouseWithId = List.FirstN({[workspaceId=workspace], "Data", [lakehouseId=lakehouse], "Data", [Id=id, ItemKind = itemKind], "Data"}, count),
                    isMatchValidLakehouseNavigation = List.FirstN(matchLakehouseWithId, count) = navigation,
                    isTableOrFileOrNull = itemKind = null or (itemKind <> null and (itemKind = "Table")),
                    isValid = Number.IsEven(count) and isMatchValidLakehouseNavigation and isTableOrFileOrNull,
                    address = if navigation = null then []
                        else if not isValid then ...
                        else Record.RenameFields(Record.Combine(List.RemoveItems(matchLakehouseWithId, {"Data"})), {{"workspaceId", "workspace"}, {"lakehouseId", "lakehouse"}, {"Id", "table"}}, MissingField.UseNull),
                    addressWithoutItemKind = if itemKind <> null then Record.RemoveFields(address, {"ItemKind"}) else address
                in
                    if (options[IsModelStorage]? = true) then ... else { [ protocol = "lakehouse", address = addressWithoutItemKind], options ?? [] },
            GetFormula = (dsr, optional options) =>
                let
                    address = ValidateAddressRecord(dsr[address]),
                    workspace = Record.FieldOrDefault(address, "workspace", null),
                    lakehouse = Record.FieldOrDefault(address, "lakehouse", null),
                    tableId = Record.FieldOrDefault(address, "table", null)
                in
                        if (workspace <> null) then
                            if (lakehouse <> null) then
                                if(tableId <> null) then
                                    () => Lakehouse.Contents(options){[workspaceId=workspace]}[Data]{[lakehouseId=lakehouse]}[Data]{[Id=tableId, ItemKind = "Table"]}[Data]
                                else
                                    () => Lakehouse.Contents(options){[workspaceId=workspace]}[Data]{[lakehouseId=lakehouse]}[Data]
                            else
                                () => Lakehouse.Contents(options){[workspaceId=workspace]}[Data]
                        else
                            () => Lakehouse.Contents(options),

            GetFriendlyName = (dsr) => "Lakehouse"
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
            lakehouse = Guid.Type,
            table = Text.Type
        ])
    in
        validated;

NameIsValid = (inputText as text) as logical =>
    let
        // foreach char in inputText, if char not in validCharacters then invalid else valid
        validCharacters = {"A".."Z","a".."z","0".."9","_"},
        invalidList = List.Difference(List.Distinct(Text.ToList(inputText)), validCharacters),
        isValid = List.IsEmpty(invalidList)
    in
        if IgnoreTableNameValidation then true else isValid;

ReduceAnd = (ast) => if ast[Kind] = "Binary" and ast[Operator] = "And" then List.Combine({@ReduceAnd(ast[Left]), @ReduceAnd(ast[Right])}) else {ast};

MatchFieldAccess = (ast) => if ast[Kind] = "FieldAccess" and ast[Expression] = RowExpression.Row then ast[MemberName] else ...;

MatchConstant = (ast) => if ast[Kind] = "Constant" then ast[Value] else ...;

MatchConstantForPartitionedRefresh = (ast, typeInformationForField as record) =>
    if ast[Kind] = "Constant" then
        if Type.Is(Value.Type(ast[Value]), typeInformationForField[Type]) then
            Text.From(ast[Value])
        else
            LogAndGenerateErrorForPartitionedRefreshAstValidation(
                [
                    TypeForFirstField = Utils[NonPii](GetTextValueForType(Value.Type(ast[Value]))),
                    TypeForSecondField = Utils[NonPii](GetTextValueForType(typeInformationForField[Type])),
                    FieldName = Utils[NonPii](typeInformationForField[FieldName])
                ],
                "MatchConstantForPartitionedRefresh",
                "PartitionedRefreshSelectorOperatorTypeMismatch"
            )
    else ...;

MatchIndex = (ast) => 
    if ast[Kind] = "Binary" and ast[Operator] = "Equals" then
        if ast[Left][Kind] = "FieldAccess" then
            Record.AddField([], MatchFieldAccess(ast[Left]), MatchConstant(ast[Right]))
        else
            Record.AddField([], MatchFieldAccess(ast[Right]), MatchConstant(ast[Left]))
    else ...;

MatchIndexForPartitionedRefresh = (ast, typeRecordForTable) => 
    if ast[Kind] = "Binary" and List.Contains(
        SupportedOperatorsForParitionedRefresh, ast[Operator])
    then 
        GenerateRecordFromAstPartitionedRefresh(ast, ast[Operator], typeRecordForTable)
    else
        LogAndGenerateErrorForPartitionedRefreshAstValidation(
            [
                SupportedOperators = Utils[Value.ToText](SupportedOperatorsForParitionedRefresh, 5),
                OperatorName = ast[Operator]
            ],
            "MatchIndexForPartitionedRefresh",
            "PartitionedRefreshSelectorInvalidOperatorList"
        );

GenerateRecordFromAstPartitionedRefresh = (ast, operatorName as text, typeRecordForTable as record) =>
    let
        fieldName = if ast[Left][Kind] = "FieldAccess" then
                MatchFieldAccess(ast[Left])
            else
                 MatchFieldAccess(ast[Right]),
        typeForField = Record.Field(typeRecordForTable, fieldName)[Type],
        fieldWithType = [FieldName = fieldName, Type = typeForField],
        constantValue = if ast[Left][Kind] = "FieldAccess" then
                MatchConstantForPartitionedRefresh(ast[Right], fieldWithType)
            else
                MatchConstantForPartitionedRefresh(ast[Left], fieldWithType)
    in
        GenerateRecordFromList({
            operatorName,
            fieldName,
            constantValue
        });

GenerateRecordFromList = (input) =>
    Record.Combine({
        Record.AddField([], "OperatorName", input{0}),
        Record.AddField([], "RecordKey", input{1}),
        Record.AddField([], input{1}, input{2})
    });

GetIndex = (selector, keys) => 
    Record.SelectFields(
        Record.Combine(
            List.Transform(
                ReduceAnd(
                    RowExpression.From(selector)),
                    (e) => MatchIndex(e)
            )), keys);

SelectorToRecord = (selector, typeRecordForTable) => 
    Record.Combine(
        ConvertToRecordForPartitionedRefresh(
            List.Transform(
                ReduceAnd(RowExpression.From(selector)),
                (e) => MatchIndexForPartitionedRefresh(e, typeRecordForTable)
            )));

LogAndGenerateErrorForPartitionedRefreshAstValidation = (
    errorDetail as record,
    markerName as text,
    errorMessageKey as text) =>
    error Diagnostics.Trace(
        TraceLevel.Error,
        [
            Name = markerName,
            Data = [],
            SafeData = errorDetail
        ],
        Error.Record(
            Utils[NonPii]("DataSource.Error"),
            Utils[NonPii](Extension.LoadString(errorMessageKey)),
            errorDetail,
            Record.FieldValues(errorDetail)
        )
    );

GetTextValueForType = (typeVal) =>
    if typeVal = type date then
        "date"
    else if typeVal = type datetime then 
        "datetime"
    else if typeVal = type text then
        "text"
    else if typeVal = type logical then
        "logical"
    else if typeVal = type number then
        "number"
    else if typeVal = type time then
        "time"
    else if typeVal = type datetimezone then
        "datetimezone"
    else if typeVal = type type then
        "type"
    else if typeVal = type any then
        "any"
    else if typeVal = type duration then
        "duration"
    else
        "Unsupported type";

/*
    This function takes in a List of records, which is a list representation of the selector function's ast.

    Each Record in this list has 3 fields:
        RecordKey - The name of the field passed in the AST for the selector function.
        OperatorName - The text representation of the operator from the AST
        <Actual FieldName> - The actual name of the field, which is the value of the 'RecordKey' field.

    The function will process this list and generate a record of the format
    [ <FieldName>_Start = <value>, <FieldName>_End = <value> ]

    This function will only allow a pattern of the form >= followed by <, 
    for example: if 'LessThan' is used before a 'Equals' then the function will report an error.

    TODO: Add support for 'each [Date] = "2024-02-15" and [Date] = "2024-02-16"' pattern.

    Examples:
    Input: 'each [Date] >= "2024-02-15" and [Date] < "2024-02-16"'
    Output: [Date_Start = "2024-02-15", Date_End = "2024-02-16"]

    Input: 'each [Date] < "2024-02-15" and [Date] < "2024-02-16"'
    Output: Error

    Input: 'each [Date] >= "2024-02-15" and [Date] >= "2024-02-16"'
    Output: Error
*/
ConvertToRecordForPartitionedRefresh = (source as list) =>
    List.Generate(
        () => [i = 0, value = [], previousFieldName = "", previousOperatorName = ""],
        each [i] < List.Count(source) + 1,
        each [
            i = [i] + 1,
            previousOperatorName = 
                if ([previousFieldName] <> ""
                    and [previousOperatorName] <> "GreaterThanOrEquals")
                    or ([previousFieldName] = source{[i]}[RecordKey]
                    and source{[i]}[OperatorName] <> "LessThan") then
                    error GenerateAndLogErrorForSelectorConversion(
                        {
                            source{[i]}[RecordKey],
                            [previousFieldName],
                            [previousOperatorName],
                            source{[i]}[OperatorName]
                        },
                        source)
                else 
                    source{[i]}[OperatorName],
            previousFieldName = source{[i]}[RecordKey],
            sourceName = source{[i]}[RecordKey],
            suffix = if i = 1 then "_Start" else "_End",
            value = if previousOperatorName <> null then
                    Record.RenameFields(source{[i]}, { sourceName, sourceName & suffix })
                else 
                    error GenerateAndLogErrorForSelectorConversion(null, source)
        ],
        each Record.RemoveFields([value], {"RecordKey", "OperatorName"}, MissingField.Ignore)
    );

GenerateAndLogErrorForSelectorConversion = (fieldWithOperators as nullable list, source as list) =>
    let
        detailsForTracingAndErrorRecord = if fieldWithOperators <> null then
                [
                    ErrorDetail =
                    [
                        FieldName = fieldWithOperators{0},
                        PreviousOperatorName = fieldWithOperators{2},
                        CurrentOperatorName = fieldWithOperators{3}
                    ],
                    ExtensionString = "SelectorFunctionInvalidOperatorCombinations",
                    SafeData = ErrorDetail & [ PreviousFieldName = fieldWithOperators{1} ],
                    ParameterList = Record.FieldValues(ErrorDetail)
                ]
            else
                [
                    ErrorDetail = [ Source = Utils[NonPii](Utils[Value.ToText](source, 5)) ],
                    ExtensionString = "SelectorFunctionInvalidOperatorError",
                    SafeData = [],
                    ParameterList = {}
                ]
    in
        Diagnostics.Trace(TraceLevel.Error,
            [
                Name = "ConvertToRecordForPartitionedRefresh",
                Data = [], 
                SafeData = detailsForTracingAndErrorRecord[SafeData]
            ],
            Error.Record(
                Utils[NonPii]("DataSource.Error"),
                Extension.LoadString(detailsForTracingAndErrorRecord[ExtensionString]),
                detailsForTracingAndErrorRecord[ErrorDetail],
                detailsForTracingAndErrorRecord[ParameterList])
        );

Handlers = (fn) => [
    GetExpression = () => fn("GetExpression", (table) => Value.Expression(Value.Optimize(table))),
    GetRows = () => fn("GetRows", (table) => table),
    GetRowCount = () => fn("GetRowCount", (table) => 5),
    GetType = () => fn("GetType", (table) => Value.Type(table)),

    OnAddColumns = (constructors) => fn("OnAddColumns", (table) => List.Accumulate(
        constructors,
        table,
        (state, item) => Table.AddColumn(state, item[Name], item[Function], item[Type]))),
    OnCombine = (tables, index) => fn("OnCombine", (table) => Table.Combine(List.ReplaceRange(tables, index, 1, {table}))),
    OnDistinct = (columns) => fn("OnDistinct", (table) => Table.Distinct(table, columns)),
    OnGroup = (keys, aggregates) => fn("OnGroup", (table) => Table.Group(table, keys, List.Transform(aggregates, each {[Name], [Function], [Type]}))),
    OnInvoke = (function, arguments, index) => fn("OnInvoke", (table) => Function.Invoke(function, List.ReplaceRange(arguments, index, 1, {table}))),
    OnPivot = (pivotValues, attributeColumn, valueColumn, aggregateFunction) => fn("OnPivot", (table) =>
        Table.Pivot(table, pivotValues, attributeColumn, valueColumn, aggregateFunction)),
    OnRenameColumns = (renames) => fn("OnRenameColumns", (table) => Table.RenameColumns(table, List.Transform(renames, each {[OldName], [NewName]}))),
    OnSelectColumns = (columns) => fn("OnSelectColumns", (table) => Table.SelectColumns(table, columns)),
    OnSelectRows = (selector) => fn("OnSelectRows", (table) => Table.SelectRows(table, selector)),
    OnSkip = (count) => fn("OnSkip", (table) => Table.Skip(table, count)),
    OnSort = (order) => fn("OnSort", (table) => Table.Sort(table, List.Transform(order, each {[Name], [Order]}))),
    OnTake = (count) => fn("OnTake", (table) => Table.FirstN(table, count)),
    OnUnpivot = (pivotColumns, attributeColumn, valueColumn) => fn("OnUnpivot", (table) =>
        Table.Unpivot(table, pivotColumns, attributeColumn, valueColumn)),
    OnTestConnection = () => fn("OnTestConnection", (table) => DataSource.TestConnection(table))
];

// Data Source UI publishing description
Lakehouse.Publish = [
    Name = "Lakehouse",
    SupportsDirectQuery = true,
    Category = "Fabric",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    SourceImage = Lakehouse.Icons,
    SourceTypeImage = Lakehouse.Icons
];

Lakehouse.Icons = [
    Icon16 = { Extension.Contents("Lakehouse16.png"), Extension.Contents("Lakehouse20.png"), Extension.Contents("Lakehouse24.png"), Extension.Contents("Lakehouse32.png") },
    Icon32 = { Extension.Contents("Lakehouse32.png"), Extension.Contents("Lakehouse40.png"), Extension.Contents("Lakehouse48.png"), Extension.Contents("Lakehouse64.png") }
];

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

Table.ToNavigationTable = try Extension.LoadFunction("Table.ToNavigationTable.pqm") otherwise error "Emodule not loaded";
Table.NavigationTableView = try Extension.LoadFunction("Table.NavigationTableView.pqm") otherwise error "Emodule not loaded";
// Load Utils module for common utilities
Utils = Extension.LoadFunction("Utils.pqm");
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
DeltaLake.Table =  try #shared[DeltaLake.Table] otherwise (binary, optional options) => error Error.Record("DataSource.Error", Extension.LoadString("DeltaModuleNotSupported"));
DeltaLake.Metadata  =  try #shared[DeltaLake.Metadata ] otherwise (binary, optional options) => error Error.Record("DataSource.Error", Extension.LoadString("DeltaMetadataNotSupported"));
Web.Contents = try #shared[Web.Contents] otherwise (url, optional options) => error Error.Record("DataSource.Error", "system error");
AzureStorage.DataLake = try #shared[AzureStorage.DataLake] otherwise (url, optional options) => error Error.Record("DataSource.Error", "system error");
Sql.Database = try #shared[Sql.Database] otherwise (server, database, optional options) => error Error.Record("DataSource.Error", "system error");
LakehouseUtils = Extension.LoadFunction("LakehouseUtils.pqm");
SqlGeneratorIdentifierFunction = () => error "Uninvokeable function.";
SqlGenerator = Extension.LoadFunction("SqlGenerator.pqm");
SqlView.Generator = try #shared[SqlView.Generator] catch(e) => 
    error Diagnostics.Trace(TraceLevel.Error, [Name = "ModuleLoadError", Data = [ExceptionDetails = Utils[Value.ToText](e)]], e);
DualTable.View = Extension.LoadFunction("DualTable.View.pqm");
SparkCompute = Extension.LoadFunction("SparkCompute.pqm", [
    LakehouseUtils = LakehouseUtils,
    SqlGenerator = SqlGenerator,
    SqlView.Generator = SqlView.Generator,
    DualTable.View = DualTable.View,
    SparkComputeUtils = SparkComputeUtils
])(SqlGeneratorIdentifierFunction);
SparkComputeUtils = Extension.LoadFunction("SparkComputeUtils.pqm",[
    Utils = Utils
]);
