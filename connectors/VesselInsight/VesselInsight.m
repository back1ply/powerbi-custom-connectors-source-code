[Version = "1.0.6"]
section VesselInsight;

[DataSource.Kind = "VesselInsight", Publish = "VesselInsight.Publish"]
// define the connector's datasource
shared VesselInsight.Contents = () =>
    let
        // get the asset tree roots from Galore, but limit the request to only few levels
        /* TODO: The current behavior is lazy but has an issue: when expanding a node on the 
           navigation tree, PowerBI would try to evaluate the children, and will invoke a subsequent
           request to expand their "edges" - resulting in multiple HTTP request sent when expanding nodes 
           (one for each child). 
           The end goal should be to send the HTTP request to load children only after the node is expanded, but
           so far we have not found a way to do this.
        */
        edgesRoot = VIServices.GaloreLoadEdges("~/", 2, "all")[edges],
        // create the navigation table using data from the Galore tree structure
        // we will create two Level-1 items: Galore Data, and Advanced
        // Galore Data will show items from Galore's asset tree
        dataNodesRootTable = createNavTableObject(List.Transform(edgesRoot, each galoreEdgeToNavTableRow(_, "all"))),
        dataNodesRootRow = createNavTableDataRow(
            Extension.LoadString("TreeNodeGaloreDataLabel"), "Galore_Data_Root", dataNodesRootTable, "Folder", false
        ),
        // fetch asset views from API
        viewList = VIServices.FetchAssetViews(),
        // create the navigation table using data from asset view
        assetViewRootTable = createNavTableObject(List.Transform(viewList, each createAssetViewData(_))),
        assetViewRootRow = createNavTableDataRow(
            Extension.LoadString("AssetViewLabel"), "Asset_Root", assetViewRootTable, "Folder", false
        ),
        customTqlTable = createNavTableObject(
            {
                createNavTableDataRow(
                    Extension.LoadString("TreeNodeAdvancedTqlLabel"),
                    "custom_tql_query",
                    galoreCustomDataQuery(),
                    "Function",
                    true
                )
            }
        ),
        advancedRootRow = createNavTableDataRow(
            Extension.LoadString("TreeNodeAdvancedLabel"), "advanced_node_root", customTqlTable, "Folder", false
        ),
        customVoyageTable = createNavTableObject(
            {
                createNavTableDataRow(
                    Extension.LoadString("TreeNodeVoyageImoLabel"), "IMO", VoyageServices.GaloreVoyage(), "Function", true
                ),
                createNavTableDataRow(
                    Extension.LoadString("TreeNodeVoyageLocationDecoderLabel"),
                    "locationDecoder",
                    VoyageServices.Decoder(),
                    "Function",
                    true
                ),
                createNavTableDataRow(
                    Extension.LoadString("TreeNodeVoyageHistoryLabel"), "History", VoyageServices.VoyageHistory(), "Function", true
                ),
                createNavTableDataRow(
                    Extension.LoadString("TreeNodeLocationHistoryLabel"),
                    "locationHistory",
                    VoyageServices.LocationHistory(),
                    "Function",
                    true
                )
            }
        ),
        voyageRow = createNavTableDataRow(
            Extension.LoadString("TreeNodeVoyageLabel"), "Voyage", customVoyageTable, "Folder", false
        ),
        navigationT = createNavTableObject({dataNodesRootRow, advancedRootRow, voyageRow, assetViewRootRow})
    in
        navigationT;

// based on asset view, fetch vessel and sensor information
createAssetViewData = (assetView as text) =>
    let
        edgesRoot = VIServices.GaloreLoadEdges("~/", 2, assetView)[edges],
        // create the navigation table using data from the Galore tree structure based on asset view
        // Galore Data will show items from Galore's asset tree
        dataNodesRootTable = createNavTableObject(
            List.Transform(edgesRoot, each galoreEdgeToNavTableRow(_, assetView))
        )
    in
        createNavTableDataRow(assetView, assetView, dataNodesRootTable, "Folder", false);

// Referred by the Navigation Table (the "Advanced" node) for calling a TQL
galoreCustomDataQuery = () =>
    let
        functionReturn = executeQuerySelector,
        // wrap the documentation object around the function for the UI to show info and suggestions
        functionReturnExplained = Value.ReplaceType(functionReturn, galoreCustomDataQueryType)
    in
        functionReturnExplained;

executeQuerySelector = (galoreQueryText as text) =>
    let
        resp =
            if (
                Text.Contains(galoreQueryText, "*")
                and ((Text.Contains(galoreQueryText, "[") and Text.Contains(galoreQueryText, "]")) <> true)
            ) then
                VIServices.ExecuteGaloreFleetTqlQuery(galoreQueryText)
            else
                VIServices.ExecuteGaloreTqlQuery(galoreQueryText)
    in
        resp;

// Referred by the Navigation Table in each of the Assets' tree timeseries node, for getting the data on a particular asset
galoreEdgeDataQuery = (nodeId as text, isStateEventLog as logical, path as text, optional oldNodePathRecord as any) =>
    let
        functionReturn = (
            optional interval as text,
            optional timeDimensionType as text,
            optional startDate as text,
            optional endDate as text,
            optional customPipe as text,
            optional useOldStyle as logical
        ) =>
            let
                timeDimensionTypeValue =
                    if (timeDimensionType = null or timeDimensionType = "") then
                        "latest"
                    else
                        Text.Lower(timeDimensionType),
                inputValidationError =
                // validate time mode
                if (
                    timeDimensionTypeValue <> "latest"
                    and timeDimensionTypeValue <> "period"
                    and timeDimensionTypeValue <> "custom"
                ) then
                    error
                        Error.Record(
                            Extension.LoadString("InvalidParameters"),
                            null,
                            Extension.LoadString("InvalidParametersMesg")
                        )
                    // validate parameters for mode "Latest"
                else if (
                    timeDimensionTypeValue = "latest"
                    and (
                        (startDate <> null and startDate <> "")
                        or (endDate <> null and endDate <> "")
                        or (customPipe <> null and customPipe <> "")
                    )
                ) then
                    error
                        Error.Record(
                            Extension.LoadString("InvalidParameters"),
                            null,
                            Extension.LoadString("InvalidParametersMesg2")
                        )
                    // validate parameters for mode "Period"
                else if (timeDimensionTypeValue = "period" and ((startDate = null or startDate = "") or (endDate = null or endDate = ""))) then
                    error
                        Error.Record(
                            Extension.LoadString("InvalidParameters"),
                            null,
                            Extension.LoadString("InvalidParametersMesg3")
                        )
                else if (timeDimensionTypeValue = "period" and (customPipe <> null and customPipe <> "")) then
                    error
                        Error.Record(
                            Extension.LoadString("InvalidParameters"),
                            null,
                            Extension.LoadString("InvalidParametersMesg4")
                        )
                    // validate parameters for mode "Custom"
                else if (
                    timeDimensionTypeValue = "custom"
                    and ((startDate <> null and startDate <> "") or (endDate <> null and endDate <> ""))
                ) then
                    error
                        Error.Record(
                            Extension.LoadString("InvalidParameters"),
                            null,
                            Extension.LoadString("InvalidParametersMesg5")
                        )
                else if (timeDimensionTypeValue = "custom" and (customPipe = null or customPipe = "")) then
                    error
                        Error.Record(
                            Extension.LoadString("InvalidParameters"),
                            null,
                            Extension.LoadString("InvalidParametersMesg6")
                        )
                else
                    null,
                // generate the TQL query based on the parameters
                timeValue =
                    if (timeDimensionTypeValue = "latest") then
                        "|> takebefore now 1"
                    else if (timeDimensionTypeValue = "period") then
                        "|> takefrom " & startDate & " |> taketo " & endDate
                    else
                        customPipe,
                //Work Around: For state node, with 1m, 1d interval the api/Query response is not uniform. for now dont pass any interval,
                intervalValue = if (interval = null or interval = "" or isStateEventLog) then "" else interval,
                galoreQuery = "[""input #" & nodeId & " " & intervalValue & " " & timeValue & """]",
                galoreQueryResult =
                    if inputValidationError <> null then
                        inputValidationError
                    else if (isStateEventLog) then
                        VIServices.ExecuteGaloreStateTqlQuery(galoreQuery, path, oldNodePathRecord)
                    else
                        VIServices.ExecuteGaloreTqlQuery(galoreQuery, useOldStyle, oldNodePathRecord)
            in
                galoreQueryResult,
        // wrap the documentation object around the function for the UI to show info and suggestions
        functionReturnExplained = Value.ReplaceType(functionReturn, galoreEdgeDataQueryType)
    in
        functionReturnExplained;

// creates a row in the Navigation Table for information on a single vessel
createVesselInfoRow = (edgeTarget as any) =>
    let
        attributes = if Record.HasFields(edgeTarget, "attributes") then edgeTarget[attributes] else error "Attributes field is missing",
        processedAttributes = Record.TransformFields(attributes, {
            { "particulars", each if _ = null or _ = "" then {} else try Json.Document(_) otherwise _ }
        }),
        attributeNames = Record.FieldNames(processedAttributes),
        attributeValues = Record.FieldValues(processedAttributes),
        nodeName = "Vessel Info (" & edgeTarget[name] & ")",
        rowData = () => let rdata = Table.FromRows({attributeValues}, attributeNames) in rdata,
        result = {
            createNavTableDataRow(nodeName, "Node_" & edgeTarget[nodeId] & "_Vessel_Info", rowData, "Function", true)
        }
    in
        result;

// creates a row in the Navigation Table for information on all vessels
createAllVesselsInfoRow = (vesselEdges as list) =>
    let
        processedEdges = List.Transform(
            vesselEdges,
            each
                [
                    displayName = if Record.HasFields(_[target][attributes], "displayName") then
                        _[target][attributes][displayName]
                    else
                        _[target][displayName],
                    paths = if Record.HasFields(_[target][attributes], "paths") then _[target][attributes][paths] else
                        "",
                    imageURL = if Record.HasFields(_[target][attributes], "imageURL") then
                        _[target][attributes][imageURL]
                    else
                        "",
                    imo = if Record.HasFields(_[target][attributes], "imo") then _[target][attributes][imo] else "",
                    particulars = if Record.HasFields(_[target][attributes], "particulars") then
                        try
                            Json.Document(_[target][attributes][particulars])
                        otherwise
                            _[target][attributes][particulars]
                    else
                        "",
                    typeSizeID = if Record.HasFields(_[target][attributes], "typeSizeID") then
                        _[target][attributes][typeSizeID]
                    else
                        "",
                    connectionStatus = if Record.HasFields(_[target][attributes], "connectionStatus") then
                        _[target][attributes][connectionStatus]
                    else
                        ""
                ]
        ),
        columnNames = {"Display Name", "Paths", "Image URL", "IMO", "Particulars", "TypeSizeID", "Connection Status"},
        attributeValues = List.Transform(processedEdges, each Record.FieldValues(_)),
        nodeName = Extension.LoadString("VesselInfoAll"),
        rowData = () => let rdata = Table.FromRows(attributeValues, columnNames) in rdata,
        result = {createNavTableDataRow(nodeName, "Node_Vessel_Info_AllVessels", rowData, "Function", true)}
    in
        result;

// Creates a row in the Navigation table from a Galore asset (edge)
galoreEdgeToNavTableRow = (edge as any, assetView as text, optional nodePath as text) =>
    let
        edgeTarget = edge[target],
        nodeAttributes = edgeTarget[attributes],
        nodeType = Text.Lower(nodeAttributes[nodeType]),
        isTimeSeriesNode = nodeType = "timeseries",
        isStateEventLog = nodeType = "stateeventlog",
        isVessel = IsVessel(nodeAttributes),
        isFleet = Text.Lower(edgeTarget[name]) = "fleet",

        // the fleet node is called "Fleet"
        hasEdges = ((not isTimeSeriesNode) and (not isStateEventLog)) and edgeTarget[hasEdges],
        // limitation: cannot be timeseries node and have children at the same time
        isLeaf = not hasEdges,
        isStreaming = if (isLeaf) then nodeAttributes[streamLink] <> "" else false,

        // If the vessel template is changed, expection is that every node in the vessel is a legacyNodeId as an attribute
        legacyNodeId = GetLegacyNodeId(nodeAttributes, edgeTarget[nodeId]),

        // if we have edges in the sub-edges list, this means that we've already loaded the child edges,
        // Work Around: US id: 150879. For state node, galore api( /v1/api/Query) response does not contain the display path in metadata. For now pass path from here.
        nodePath = Json.Document(nodeAttributes[paths]){0},
        oldPathRecord = GetOldNodePathRecord(nodeAttributes),
        // specify the data for this row:
        //      if this is a leaf row, the data will be a function
        //      if this is a parent row, the data will be another navigation table
        // the source of data is the [edges] field of the current edge
        childNavTableDataRowsSource =
            try
                VIServices.GaloreLoadEdges("#" & edgeTarget[nodeId], 2, assetView, nodePath)[edges] catch (e) =>
                    error e[Message],
        // not loaded yet, we need to load the next level
        // when this edge has sub-edges, we recursively call the function itself for each of the sub-edges, in order to create the subtree for this item
        childNavTableDataRows = List.Transform(
            childNavTableDataRowsSource, each try @galoreEdgeToNavTableRow(_, assetView, nodePath) otherwise null
        ),
        // add a null row when there's an error
        // generate a vessel info row if this is a vessel or a fleet node
        vesselInfoRow =
            if ((not isVessel) and (not isFleet)) then
                {}
                // if this is not a vessel or fleet, insert nothing
            else if (isVessel) then
                createVesselInfoRow(edgeTarget)
                // if this is a vessel, insert a vessel info node
            else
                createAllVesselsInfoRow(edgeTarget[edges]),
        // if this is Fleet, insert all vessels info node
        // clean up null rows and add vessel info row
        childNavTableDataRowsFinal = List.RemoveNulls(
        // filter out the null rows (rows with errors)
        List.InsertRange(childNavTableDataRows, 0, vesselInfoRow)),
        rowData =
            if (not isStreaming and isLeaf) then
                null
            else if (hasEdges) then
                createNavTableObject(childNavTableDataRowsFinal)
                // this is a parent, we create a child navigation table for it
            else
                galoreEdgeDataQuery(edgeTarget[nodeId], isStateEventLog, nodePath, oldPathRecord),
        // this is a leaf node, we create a data query function row
        itemKind = if isLeaf then "Function" else "Folder",
        // when preview delay is disabled, all folders show as tables for some reason
        result =
            if (not isStreaming and isLeaf) then
                null
            else
                createNavTableDataRow(edge[displayName], "Node_" & legacyNodeId, rowData, itemKind, isLeaf)
    in
        result;

IsVessel = (attributes as record) as logical =>
    let
        IsVessel = 
            Record.HasFields(attributes, "nodeDefinitionId") and 
            attributes[nodeDefinitionId] = Extension.LoadString("VIVessel")
    in
        IsVessel;

GetLegacyNodeId = (attributes, defaultId) =>
    if Record.HasFields(attributes, "legacyNodeId") then
        attributes[legacyNodeId]
    else
        defaultId;
// Function to safely extract v1NodePath from nodeAttributes
GetOldNodePathRecord = (nodeAttributes as record) as any =>
    let
        ExtractFirstMatchingRecord = 
            if Record.HasFields(nodeAttributes, "paths2") then 
                let
                    parsedPaths = Json.Document(nodeAttributes[paths2]),
                    pathExists = (parsedPaths is list) and List.Count(parsedPaths) >= 2,
                    filteredRecord = if pathExists then
                        FilterV1Record(parsedPaths)
                    else
                        null
                in
                    filteredRecord
            else 
                null
    in
        ExtractFirstMatchingRecord;
FilterV1Record = (parsedPaths as list) as record =>
    let
        filteredRecords = List.Select(
            parsedPaths,
            each let
                views = Record.Field(_, "Views"),
                recordsContainingV1Views = List.Contains(views, "v1")
            in
                recordsContainingV1Views
        ),
        firstRecord = List.First(filteredRecords, null)
    in
        firstRecord;

// Creates a row object for the navigation table row's data, using a list of sub-rows (for nested navigation structure)
createNavTableObject = (dataRows as list) =>
    let
        enablePreviewDelay = false,
        // required in order to enable functions preview,  reference https://github.com/Microsoft/DataConnectors/issues/30
        tobjects = Table.FromRows(dataRows, {"Name", "Key", "Data", "ItemKind", "ItemName", "IsLeaf"}),
        typedTable = Table.TransformColumnTypes(
            tobjects,
            {
                {"Name", type text},
                {"Key", type text},
                {"ItemKind", type text},
                {"ItemName", type text},
                {"IsLeaf", type logical}
            }
        ),
        navtableResult = Table.ToNavigationTable(
            typedTable, {"Key"}, "Name", "Data", "ItemKind", if enablePreviewDelay then "ItemName" else "", "IsLeaf"
        )
    in
        navtableResult;

fetchStateEventById = (stateId as any, statemeta as any) =>
    let
        selectRow = List.Select(statemeta, each _[state] = stateId),
        // Table.SelectRows(statemeta, each ([state] = stateId)),
        result = List.First(selectRow, [state = null, description = null, color = null, label = null])
    in
        result;

// --------------------------------------------------------------------------------------------
// Handling authentication for the connector
// --------------------------------------------------------------------------------------------
VesselInsight = [
    TestConnection = (dataSourcePath) => {"VesselInsight.Contents"},
    Label = Extension.LoadString("DataSourceLabel"),
    // Define the authentication mechanism
    Authentication = [
        // Describe OAuth authentication and hook up the necessary functions
        OAuth = [
            StartLogin = VIAuth.StartLogin,
            FinishLogin = VIAuth.FinishLogin,
            Refresh = VIAuth.Refresh,
            Logout = VIAuth.Logout
        ]
    ]
];

// --------------------------------------------------------------------------------------------
// Publishing information to the Power BI UI
// Data Source UI publishing description
VesselInsight.Publish = [
    Beta = false,
    Category = "Other",
    ButtonText = {Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp")},
    LearnMoreUrl = "https://powerbi.microsoft.com/",
    SourceImage = VesselInsight.Icons,
    SourceTypeImage = VesselInsight.Icons
];

VesselInsight.Icons = [
    Icon16 = {
        Extension.Contents("VI_16.png"),
        Extension.Contents("VI_20.png"),
        Extension.Contents("VI_24.png"),
        Extension.Contents("VI_32.png")
    },
    Icon32 = {
        Extension.Contents("VI_32.png"),
        Extension.Contents("VI_40.png"),
        Extension.Contents("VI_48.png"),
        Extension.Contents("VI_64.png")
    }
];

// TEMPORARY WORKAROUND until PowerQuery M is able to reference other M modules
// This function will just load a text file and evaluate it
Extension.LoadFunction = (name as text) =>
    let
        binary = Extension.Contents(name), asText = Text.FromBinary(binary)
    in
        Expression.Evaluate(asText, #shared);

galoreCustomDataQueryType = Extension.LoadFunction("Documentation.galoreCustomDataQueryType.pqm");
galoreEdgeDataQueryType = Extension.LoadFunction("Documentation.galoreEdgeDataQueryType.pqm");
voyageIMOType = Extension.LoadFunction("Documentation.voyage.pqm");
voyageHistoryType = Extension.LoadFunction("Documentation.voyageHistory.pqm");
voyageAisType = Extension.LoadFunction("Documentation.voyageAis.pqm");

Table.ToNavigationTable = Extension.LoadFunction("Table.ToNavigationTable.pqm");

createNavTableDataRow = Extension.LoadFunction("Table.createNavTableDataRow.pqm");
convertNumericTimestampToDateTime = Extension.LoadFunction("Util.convertNumericTimestampToDateTime.pqm");

VIAuth = Extension.LoadFunction("VIAuth.pqm");

VIAuth.StartLogin = VIAuth[StartLogin];
VIAuth.FinishLogin = VIAuth[FinishLogin];
VIAuth.Refresh = VIAuth[Refresh];
VIAuth.Logout = VIAuth[Logout];

VIServices = Extension.LoadFunction("VIServices.pqm");

VIServices.FetchAssetViews = VIServices[FetchAssetViews];
VIServices.GaloreLoadEdges = VIServices[GaloreLoadEdges];
VIServices.ExecuteGaloreTqlQuery = VIServices[ExecuteGaloreTqlQuery];
VIServices.ExecuteGaloreStateTqlQuery = VIServices[ExecuteGaloreStateTqlQuery];
VIServices.ExecuteGaloreFleetTqlQuery = VIServices[ExecuteGaloreFleetTqlQuery];

VoyageServices = Extension.LoadFunction("VoyageServices.pqm");

VoyageServices.GaloreVoyage = VoyageServices[GaloreVoyage];
VoyageServices.Decoder = VoyageServices[Decoder];
VoyageServices.VoyageHistory = VoyageServices[VoyageHistory];
VoyageServices.LocationHistory = VoyageServices[LocationHistory];

