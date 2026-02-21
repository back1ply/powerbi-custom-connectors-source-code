// This file contains your Data Connector logic
[Version = "1.0.2"]
section ADPAnalytics;

EnvType = Extension.LoadString("EnvType");
Api_Env = Extension.LoadString(EnvType);
login_redirect_uri = Extension.LoadString("RedirectURL");
token_uri = Api_Env & Extension.LoadString("TokenURL");
authorize_uri = Api_Env & Extension.LoadString("AurhorizeURL");
metric_selection_uri= Api_Env & Extension.LoadString("MetricSelectionURL");
metric_details_uri = Api_Env & Extension.LoadString("MetricDetailsURL");
employee_details_uri= Api_Env & Extension.LoadString("EmployeeDetailsURL");

[DataSource.Kind="ADPAnalytics", Publish="ADPAnalytics.Publish"]
shared ADPAnalytics.Contents = () =>
let
     source = Web.Contents(metric_selection_uri,
    [
        Headers = [#"Content-Type"="application/json",#"Accept"="application/json", #"Culture"="en_us"],
        ManualStatusHandling = {401}
    ]),
    response = Json.Document(source),
    GetMetadata = Value.Metadata(source),
    GetResponseStatus = GetMetadata[Response.Status], 
    validateData = try response[selectedMetrics],
    selectedMetrics = if (GetResponseStatus=401) then error Extension.CredentialError(Credential.AccessDenied, "Your current session is expired, please 		         clear the permissions and Sign In again.") 
                      else 
                      if (validateData[HasError]) then error Extension.CredentialError("DataSource.Error", "Server is currently down, please try again 				 later.") 
                      else 
                      if (response[selectedMetrics]={}) then error Error.Record("DataSource.Error", "No metrics configured. Please configure the metrics 		      	 from your Power BI Data Manager by clicking on Manage Now on the Power BI tile under Data Mashup in Reports & Analytics and Sign In   		      	 again.")
                      else 
                      if (GetResponseStatus<>200) then error Error.Record("DataSource.Error", "Server is currently down, please again try later.") 
		      else response[selectedMetrics],
    listOfSelectedmetrics=selectedMetrics,
    NavigationTableOutline= #table({"sequence_number""metric_id","metric_desc", "Data", "ItemKind", "ItemName", "IsLeaf"},{}),
    listEachValue={},
    ListOfEntriesToNavigationTable = List.Generate(
    () => [i=-1,list2={}],  // initialize loop variables
    each [i] < List.Count(listOfSelectedmetrics),
    each [
    listEachValue=Record.ToList(listOfSelectedmetrics{i}),
    ListtoTable = Table.FromList(listEachValue, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    customMetricId=ListtoTable{2}[Column1],
    seqNumber=ListtoTable{0}[Column1],
    defaultmetricID=ListtoTable{1}[Column1],
    metricID=
    if customMetricId = ListtoTable{1}[Column1]
    then ListtoTable{1}[Column1]
    else  customMetricId,
    viewby=ListtoTable{3}[Column1],
    timeperiod=ListtoTable{4}[Column1],
    AOID=ListtoTable{5}[Column1],
    ORGOID=ListtoTable{6}[Column1],
    metric_detail_indicator=ListtoTable{8}[Column1],
    employee_detail_indicator=ListtoTable{7}[Column1],
    metric_name=ListtoTable{9}[Column1],
    filters=ListtoTable{10}[Column1],
    date_range = if ListtoTable{1}[Column1] = customMetricId then (if List.IsEmpty(filters) then "" else "' from '" & filters{0}[filterValues]{0}[value][code] & " to " & filters{0}[filterValues]{1}[value][code]) else "",
    viewByCode2 = try(ListtoTable{11}[Column1]) otherwise "",
    templistVariable=list2,
    metricDetailEntry={seqNumber,metricID,metric_name & " viewed by '"& viewby & "' by '" & timeperiod & date_range & "' | Metric Details",getMetricData(listOfSelectedmetrics{i}),"Table","Table","true"},
    employeeDetailEntry={seqNumber,metricID,metric_name & " viewed by '"& viewby & "' by '" & timeperiod & date_range & "' | Employee Details",getEmployeeData(listOfSelectedmetrics{i}),"Table","Table","true"},
    list2 =
    if metric_detail_indicator 
    then  metricDetailEntry
    else 
    employeeDetailEntry       
    , i=[i]+1 
    ]),

    FirstRowRemoved = List.Skip(ListOfEntriesToNavigationTable,1),
    ConvertNavTableFromList = Table.FromList(FirstRowRemoved, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    ExpandColumnFromConvertedTable = Table.ExpandRecordColumn(ConvertNavTableFromList, "Column1", {"list2"}, {"list2"}),
    ActualDataToDisplay = ExpandColumnFromConvertedTable[list2],
    ConvertToNavigationTable= #table({"sequence_number","metric_id","metric_desc", "Data", "ItemKind", "ItemName", "IsLeaf"},
   ActualDataToDisplay),
   // navTable = Table.ToNavigationTable( ConvertToNavigationTable, {"sequence_number"}, "metric_desc", "Data", "ItemKind", "ItemName", "IsLeaf")
    navTable = if GetResponseStatus=401 then error  Extension.CredentialError(Credential.AccessDenied,
    "Your login has expired. Please click Sign In below and login again.")   
    else Table.ToNavigationTable( ConvertToNavigationTable, {"sequence_number"}, "metric_desc", "Data", "ItemKind", "ItemName", "IsLeaf") 

in
navTable;


getMetricData=(metricRecord as record) =>
let
    recordList = Record.ToList(metricRecord),
    listToTable = Table.FromList(recordList, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    customMetricId = listToTable{2}[Column1],
    metricID=
    if customMetricId = listToTable{1}[Column1]
    then listToTable{1}[Column1]
    else  customMetricId,
    id = Number.ToText(metricID),
    url =metric_details_uri & id & "/read-by-filter-request",
    body = Text.FromBinary(Json.FromValue(metricRecord) as binary),
    access_token=  Extension.CurrentCredential()[access_token],
    response = getMetricDetailsResponse(url, body, access_token),
    validateData = try response[largeCard],
    largeCard = if validateData[HasError] then error Error.Record("DataSource.Error", "Something went wrong while fetching metric details for " &id& ". Please open a service ticket with ADP if you need any help.") else response[largeCard],
    chartData = largeCard[chartData],
    dataValues = chartData[dataValues],
    metricsData = if (List.IsEmpty(dataValues[rows])) then 
             error Error.Record("DataSource.Error", "There is no metric data available for the selected metric. Please check ""Metrics"" under Reports & Analytics > Analytics > Dashboards. Please open a service ticket with ADP if you need any help.")
             else dataValues,
    #"Converted to Table" = Record.ToTable(metricsData),
    columnHeader=Table.First(#"Converted to Table"),
    ColumnValue =columnHeader[Value],
    #"Converted to Table1" = Table.FromList(ColumnValue, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Expanded Column11" = Table.ExpandRecordColumn(#"Converted to Table1", "Column1", {"columnName"}, {"columnName"}),
    #"Transposed Table" = Table.Transpose(#"Expanded Column11"),
    #"Added Index2" = Table.AddIndexColumn(#"Expanded Column11", "Index", 0, 1),
    headerTable=Table.PromoteHeaders(#"Transposed Table"),
    allkeys=Table.ColumnNames(headerTable),
    #"Removed Columns" = Table.RemoveColumns(#"Converted to Table" ,{"Name"}),
    #"Removed Top Rows" = Table.Skip(#"Removed Columns",1),
    Value = #"Removed Top Rows"{0}[Value],
    #"Converted to Table2" = Table.FromList(Value, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Extracted Values" = Table.TransformColumns(#"Converted to Table2", {"Column1", each Text.Combine(List.Transform(_, Text.From), ","), type text}),
    #"Split Column by Delimiter" = Table.SplitColumn(#"Extracted Values", "Column1", Splitter.SplitTextByDelimiter(",", QuoteStyle.Csv)),
    #"Changed Type" = Table.TransformColumnTypes(#"Split Column by Delimiter",{}),
    #"Transposed Table1" = Table.Transpose(#"Changed Type"),
    #"Added Index" = Table.AddIndexColumn(#"Transposed Table1", "Index1", 0, 1),
    CompleteTable=Table.Join(#"Added Index2","Index",#"Added Index","Index1"),
    FinalTab = Table.RemoveColumns(CompleteTable,{"Index", "Index1"}),
    FinalTabTranspose = Table.Transpose(FinalTab),
    #"Promoted Headers" = Table.PromoteHeaders(FinalTabTranspose, [PromoteAllScalars=true]),
    FinalData = Table.TransformColumnTypes(#"Promoted Headers",getDataTypes(#"Converted to Table1"))
    
in
    FinalData ;


getMetricDetailsResponse=(url as text,body as text, access_token as text)  => 
 let
        Data = Web.Contents(url,[Headers = [#"Content-Type"="application/json"],Content=Text.ToBinary(body), ManualStatusHandling = 	 	 		       {400,401,403,404,500,502,503,504}]),
        Metadata = Value.Metadata(Data),
        ResponseStatusCode = Metadata[Response.Status],
        MetricDetailsResponse = 
                                if (ResponseStatusCode=401) then 
                                    error Extension.CredentialError(Credential.AccessDenied,"Your current session is expired, please clear the permissions 				    and Sign In again.") 
                                else if (ResponseStatusCode=400 or ResponseStatusCode=403 or ResponseStatusCode=404 or ResponseStatusCode=500 
					 or ResponseStatusCode=503 or ResponseStatusCode=504) then 
                                         error Error.Record("DataSource.Error", "Server is currently down, please try again later. 
					 Please open a service ticket with ADP if you need any help.") 
				else Json.Document(Data)
 in
    MetricDetailsResponse;


getEmployeeData=(employeeRecord as record) =>
let
    recordList = Record.ToList(employeeRecord),
    listToTable = Table.FromList(recordList, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    customMetricId = listToTable{2}[Column1],
    metricID=
    if customMetricId = listToTable{1}[Column1]
    then listToTable{1}[Column1]
    else  customMetricId,
    id = Number.ToText(metricID),
    url =employee_details_uri & id &"/async/worker-details-request",
    access_token=  Extension.CurrentCredential()[access_token],
    body = Text.FromBinary(Json.FromValue(employeeRecord) as binary),
    response = getEmpDetailsResponse(url,body,access_token),
    dataValues = response[dataValues],
    #"Converted to Table" = Record.ToTable(dataValues),
    columnHeader=Table.First(#"Converted to Table"),
    ColumnValue =columnHeader[Value],
    #"Converted to Table1" = Table.FromList(ColumnValue, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Expanded Column11" = Table.ExpandRecordColumn(#"Converted to Table1", "Column1", {"columnName"}, {"columnName"}),
    #"Transposed Table" = Table.Transpose(#"Expanded Column11"),
    #"Added Index2" = Table.AddIndexColumn(#"Expanded Column11", "Index", 0, 1),
    headerTable=Table.PromoteHeaders(#"Transposed Table"),
    allkeys=Table.ColumnNames(headerTable),
    #"Removed Columns" = Table.RemoveColumns(#"Converted to Table" ,{"Name"}),
    #"Removed Top Rows" = Table.Skip(#"Removed Columns",1),
    Value = #"Removed Top Rows"{0}[Value],
    #"Converted to Table2" = Table.FromList(Value, Splitter.SplitByNothing(), null, null, ExtraValues.Error),

    #"Extracted Values" = Table.TransformColumns(#"Converted to Table2", {"Column1", each Text.Combine(List.Transform(_, Text.From), "11:-:-11:-:11"), type text}),
    #"Split Column by Delimiter" = Table.SplitColumn(#"Extracted Values", "Column1", Splitter.SplitTextByDelimiter("11:-:-11:-:11", QuoteStyle.Csv)),
    #"Changed Type" = Table.TransformColumnTypes(#"Split Column by Delimiter",{}),
    #"Transposed Table1" = Table.Transpose(#"Changed Type"),
    #"Added Index" = Table.AddIndexColumn(#"Transposed Table1", "Index1", 0, 1),
    CompleteTable=Table.Join(#"Added Index2","Index",#"Added Index","Index1"),
    FinalTab = Table.RemoveColumns(CompleteTable,{"Index", "Index1"}),
    FinalTabTranspose = Table.Transpose(FinalTab),
    #"Promoted Headers" = Table.PromoteHeaders(FinalTabTranspose, [PromoteAllScalars=true]),
    FinalData = Table.TransformColumnTypes(#"Promoted Headers",getDataTypes(#"Converted to Table1"))
    
in
   FinalData;


getEmpDetailsResponse=(url as text,body as text, access_token as text)  => 
    let
        Source = Web.Contents(url, [Headers=[#"Content-Type"="application/json", #"roleCode"="Practitioner"], Content=Text.ToBinary(body), ManualStatusHandling = 	{400,401,403,404,500,502,503,504}]),
        GetMetadata = Value.Metadata(Source),
        ResponseStatus = GetMetadata[Response.Status],
        Output = 
                if (ResponseStatus=401) then 
                    error Extension.CredentialError(Credential.AccessDenied, "Your current session is expired, please clear the permissions and Sign In 		    again.") 
                else if (ResponseStatus=400 or ResponseStatus=403 or ResponseStatus=404 or ResponseStatus=500 or ResponseStatus=502 or ResponseStatus=503 or 		ResponseStatus=504) then 
                    error Error.Record("DataSource.Error", "Server is currently down while fetching employee details, Please open a service ticket with ADP if you need any help.")  
		else Json.Document(Source),
        ValidateData = try Output[dataValues],
        EmpDetailsResponse = if (ResponseStatus=200 and (Output=[] or ValidateData[HasError])) then error Error.Record("DataSource.Error", "Employee details 				for this metric do not exist. Please uncheck the selection from your Power BI Data Manager by clicking on Manage Now on the 				Power BI tile under Data Mashup in Reports & Analytics. Please open a service ticket with ADP if you need any help.") 
			    else Output
in
    EmpDetailsResponse;


Table.ToNavigationTable = (
table as table,
keyColumns as list,
nameColumn as text,
dataColumn as text,
itemKindColumn as text,
itemNameColumn as text,
isLeafColumn as text
) as table =>
let
    tableType = Value.Type(table),
    newTableType = Type.AddTableKey(tableType, keyColumns, true) meta 
    [
    NavigationTable.NameColumn = nameColumn, 
    NavigationTable.DataColumn = dataColumn,
    NavigationTable.ItemKindColumn = itemKindColumn, 
    Preview.DelayColumn = itemNameColumn, 
    NavigationTable.IsLeafColumn = isLeafColumn
    ],
    navigationTable = Value.ReplaceType(table, newTableType)
in
    navigationTable;


StartLogin = (resourceUrl, state, display) => 
let 
    authorizeUrl = authorize_uri & "?" & Uri.BuildQueryString([ 
    redirect_uri = login_redirect_uri, 
    state = state
    ])
       
in 
    [ 
    LoginUri = authorizeUrl, 
    CallbackUri = login_redirect_uri, 
    WindowHeight = 720, 
    WindowWidth = 1024, 
    Context = null 
    ]; 
 
 

FinishLogin = (context, callbackUri, state) =>
let
    parts = Uri.Parts(callbackUri)[Query],
    validateData = try parts[code],
    
    output = if(validateData[HasError]) then error Error.Record("DataSource.Error", "Subscription not found. Please subscribe to the ADP DataCloud Connector by clicking on ""Subscribe"" on the Power BI tile under Data Mashup in Reports & Analytics>Dashboard and Sign In again. Please open a service ticket with ADP if you need any help.")
    else TokenMethod(state, parts[code])
                   
in
    output;


TokenMethod = (state,code) =>
let      
    header= [#"Content-Type" = "application/json"],
    RequestBody = [
	state = state,
	code = code,
	redirect_uri = login_redirect_uri
	],

    tokenResponse = Web.Contents(token_uri, [Content = Json.FromValue(RequestBody), Headers=header]),
    body = Json.Document(tokenResponse),
    result = if (Record.HasFields(body, {"error", "error_description"})) then 
                error Error.Record(body[error], body[error_description], body)
             else 
                if (body=[]) then 
                    error Error.Record("DataSource.Error", "Your current session is expired, please clear the permissions and Sign In again.") 
                else
                    body
in
    result;

// refresh token 
Refresh = (dataSourcePath, refreshToken) =>
    let
        parts = Uri.Parts(login_redirect_uri)[Query]
    in
        RefreshTokenMethod(refreshToken);

RefreshTokenMethod = (code) =>
    let
        header = [#"Content-Type" = "application/json"],
	RequestBody = [
	refresh_token = code,
	redirect_uri = login_redirect_uri
	],
        tokenResponse = Web.Contents(token_uri, [Content = Json.FromValue(RequestBody), Headers = header]),
        body = Json.Document(tokenResponse),
        result =
            if (Record.HasFields(body, {"error", "error_description"})) then
                error Error.Record(body[error], body[error_description], body)
            else 
                if (body=[]) then 
                    error Error.Record("DataSource.Error", "Your current session is expired, please clear the permissions and Sign In again.") 
                else 
                    body
    in
        result;

getDataTypes = (dataTable as table) =>
    let
        // Text To Type Function
        // All the Datacloud supported Formats should be Mapped to respective Power BI data types here.
        #"Types Map" = Table.FromRows(
            {{"number", Int64.Type}, {"period", Text.Type}, {"currency", Currency.Type}, {"text", Text.Type}, {"numeric", Int64.Type}, {"numeric2", Decimal.Type}, {"date", Date.Type}, {"percentage", Decimal.Type}},
            Type.AddTableKey(type table [#"Json Type" = text, #"Actual Type" = type], {"Json Type"}, true)
        ),
        TextToType = (jsontype as text) as type => try (#"Types Map"{[#"Json Type" = jsontype]}[Actual Type]) otherwise Any.Type,

        // Types List
        #"Types table" = Table.TransformColumns(
            Table.ExpandRecordColumn(dataTable, "Column1", {"columnName", "columnDataTypeCode"}),
            {{"columnDataTypeCode", TextToType, type type}}
        ),
        TypeList = List.Zip({#"Types table"[columnName], #"Types table"[columnDataTypeCode]})
    in
        TypeList;

// Data Source Kind description
ADPAnalytics = [
    TestConnection = (dataSourcePath) => { "ADPAnalytics.Contents" },
    Authentication = [ 
    OAuth = [ 
    StartLogin=StartLogin, 
    FinishLogin=FinishLogin,
   // Logout=Logout,
    Refresh=Refresh
    ]
    ], 
    Label = Extension.LoadString("DataSourceLabel")
    ];
 
// Data Source UI publishing description
ADPAnalytics.Publish = [
    Beta = false,
    Category = "Other",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://communication.adpinfo.com/powerBI-DataCould",
    SourceImage = ADPAnalytics.Icons,
    SourceTypeImage = ADPAnalytics.Icons
    ];

ADPAnalytics.Icons = [
    Icon16 = { Extension.Contents("ADPLOGO.jpeg"), Extension.Contents("ADPLOGO.jpeg"), Extension.Contents("ADPLOGO.jpeg"), Extension.Contents("ADPLOGO.jpeg") },
    Icon32 = { Extension.Contents("ADPLOGO.jpeg"), Extension.Contents("ADPLOGO.jpeg"), Extension.Contents("ADPLOGO.jpeg"), Extension.Contents("ADPLOGO.jpeg") }
    ];

