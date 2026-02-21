[Version = "3.0.0"] // https://docs.microsoft.com/en-us/power-query/handlingversioning

section IndustrialAppStore;

// [IMPORTANT] KEEP THIS UP TO DATE WITH THE ABOVE VERSION
// this is sent to the API to indicate the version of this connector
version = "3.0.0";

Configuration = Json.Document(Extension.Contents("config.json"));

ias_enabled = Logical.From(Configuration[IAS][Enabled]);

ias_url = "https://appstore.intelligentplant.com";

datacore_url = Configuration[IAS][DataCoreURL];

// power platform api base url
pp_data_url = "https://powerbi.intelligentplant.com/";

// datasources path
gestalt_datasources_url = "api/data/datasources/";

// tags url
ias_tags = "api/data/tags/";

// [DEPRECATED] Endpoint used for Get Data function
ias_data_historical = "api/data/v2/history/";

// IAS historical processed data endpoint
ias_data_historical_processed = "api/data/v2/processed/";

// IAS historical plot data endpoint
ias_data_historical_plot = "api/data/v2/plot/";

// IAS historical raw data endpoint
ias_data_historical_raw = "api/data/v2/raw/";

ias_data_snapshot = "api/data/v2/snapshot/";

// Client Id;
client_id = Configuration[IAS][ClientId];

// Refresh token used in Authentication Refresh function
refresh_token = "";

// Access token URL
token_uri = ias_url & "/AuthorizationServer/OAuth/Token";

// Auth UrL
authorize_uri = ias_url & "/AuthorizationServer/OAuth/Authorize";

// log out uri
logout_uri = ias_url & "/Account/SsoEndSession";

// The URL in your app where users will be sent after authorization. See details below about redirect urls. 
// For M extensions, the redirect_uri must be "https://oauth.powerbi.com/views/oauthredirect.html".
redirect_uri = "https://oauth.powerbi.com/views/oauthredirect.html";

windowWidth = 720;
windowHeight = 1000;

allowedTimeUnits = {"s","m","h","d","y"};   //seconds, minutes, hours, days, years

allowedDataFunctions = {"avg", "max", "min", "interp"};

scopes = {
    "UserInfo", // Request access to App Store user profile.
    "DataRead", // Request access to App Store Connect data; user can control which sources the application can access.
    "AccountDebit" // Request ability to bill for usage.
};

default_no_data_found_response = "No data found, please check your parameters.";

default_no_licence_found_response = "No subscription available for this request.";

default_empty_table_header = "Industrial App Store";

// Input for specifying the tags to query
tag_name_input = type text meta [
    Documentation.FieldCaption = "Tags", 
    Documentation.FieldDescription = "A comma-separated list of tags to query.",
    Documentation.SampleValues = {"SINUSOID, PT-123456.PV"},
    Formatting.IsMultiLine = true,
    Formatting.IsCode = true
];


// Input for specifying a query start time
query_start_date_type_input = type text meta [
    Documentation.FieldCaption = "Start Date", 
    Documentation.FieldDescription = "The absolute or relative query start time. For maximum compatibility, absolute times should be specified using ISO 8601 format (i.e. yyyy-MM-dd hh:mm:ss).",
    Documentation.SampleValues = {"2021-03-01 19:30:00"}
];


// Input for specifying a query end time
query_end_date_type_input = type text meta [
    Documentation.FieldCaption = "End Date",  
    Documentation.FieldDescription = "The absolute or relative query end time. For maximum compatibility, absolute times should be specified using ISO 8601 format (i.e. yyyy-MM-dd hh:mm:ss).",
    Documentation.SampleValues = {"2021-04-01 19:30:00"}
];

// Input for selecting the sample interval to use in a generic historical data query
historical_query_sample_count_input = type number meta [
    Documentation.FieldCaption = "Sample Count",
    Documentation.FieldDescription = "The number of samples to request. The meaning of this parameter varies depending on the data function specified. For raw queries, this is the maximum number of samples to retrieve per tag. For aggregated queries, the query time range will be divided into this many equally-sized periods, and an aggregated value will be calculated for each period. For plot queries, this value represents the pixel width of the chart that will be displaying the resulting data, and the data source will return a best-fit line with an appropriate level of fidelity.",
    Documentation.SampleValues = "500"
];

// Input for selecting the maximum sample count in a RAW data query
raw_max_sample_count_input = type number meta [
    Documentation.FieldCaption = "Maximum Sample Count",
    Documentation.FieldDescription = "The maximum number of samples to retrieve per tag. Data sources can apply their own, more-restrictive limits.",
    Documentation.SampleValues = "100"
];

// Input for selecting the number of intervals in a PLOT data query
plot_intervals_input = type number meta [
    Documentation.FieldCaption = "Plot Width (Pixels)",
    Documentation.FieldDescription = "The width (in pixels) of the chart that the data will be displayed in. Plot query implementations are vendor-specific, but typically return 1-4 vales per pixel if the fidelity of the tags allow it.",
    Documentation.SampleValues = "500"
];

// Input for selecting the sample interval to use in an aggregated data query
processed_sample_interval_input = type text meta [
    Documentation.FieldCaption = "Sample Interval",
    Documentation.FieldDescription = "The interval that the aggregation will be applied at. Sample intervals are specified in the format '[quantity][unit]', where '[unit]' is a supported time unit: 'MS' (milliseconds) 'S' (seconds), 'M' (minutes), 'H' (hours), 'D' (days).",
    Documentation.SampleValues = "1h",
    Documentation.AllowedValues = { "1s", "1m", "1h", "1d", "7d", "30d" }
];

// Input for selecting the data function in an aggregated data query
processed_data_function_input = type text meta [
    Documentation.FieldCaption = "Data Function",
    Documentation.FieldDescription = "The data function to use when requesting data. You can specify any data function name that is supported by the underlying Industrial App Store Connect driver.",
    Documentation.SampleValues = "Avg",
    Documentation.AllowedValues = { "Avg", "Interp", "Max", "Min" }
];

// Input for selecting the tag value field to use
tag_value_display_field_numeric = "Numeric";
tag_value_display_field_text = "Text";
tag_value_display_field_input = type text meta 
[
    Documentation.FieldCaption = "Tag Value Field", 
    Documentation.FieldDescription = "The tag value field (numeric or text) to use. Use the numeric field for analogue tags, the text field for string tags, and whichever is appropriate for digital state tags, as both the numeric value and the name of the state will be returned by the Industrial App Store.",
    Documentation.AllowedValues = {tag_value_display_field_numeric, tag_value_display_field_text}
];


CheckNumberIsNotNegative = (input as number, inputType as text) => 
    let 
        err = Text.Format("#[inputType] cannot be a negative number.", [ inputType = inputType ]),
        result = if (input < 0)
                    then ValidationError(err)
                    else input
    in
        result;


// Returns the input back in Text type if it is valid, or raise an error if invalid
CheckAbsoluteTimeFormat = (input, timeType as text) =>
    let
        timeType = if timeType = "start" 
                        then "Start Date" 
                        else if timeType = "end" 
                            then "End Date" 
                            else "Start and End Date",
        parseResult = if (input <> null or input <> "") then try DateTimeZone.From(input) else null,
        result = if parseResult[HasError] 
                    then CheckRelativeTimeFormat(input, timeType) 
                    else if parseResult = null 
                        then ValidationError(Text.Format("#[timeType] cannot be empty.", [ timeType = timeType ] ))
                        else input
    in
        Text.From(result);

CheckRelativeTimeFormat = (input, timeType as text) =>
    let
        errorMessage = Text.Format("#[timeType] format is invalid.", [ timeType = timeType ]),
        result = 
            if (Text.Start(input, 1) <> "*")
                then ValidationError(errorMessage)
                else if (Text.Length(input) = 1 and input = "*") 
                    then input 
                    else if (Text.Start(input, 2) = "*-" and List.Contains(allowedTimeUnits, Text.End(input, 1)))
                        then if (CanParseNumberFromText(input, 2, 3))  //true if not a number
                            then input
                            else ValidationError(errorMessage)
                        else ValidationError(errorMessage)
    in
        Text.From(result);

CheckProcessedDataFunctionInput = (input as text) =>
    let
        err = "Invalid Data Function supplied. Data Function must be either 'avg', 'interp', 'max', or 'min'.",
        result = if (List.Contains(allowedDataFunctions, Text.Lower(input))) then input else ValidationError(err)
    in
        result;

// Returns the interval if valid and raises an error if invalid
CheckSampleIntervalInput = (input as text) => 
    let
        err ="Invalid Sample Interval supplied. Sample Intervals are specified in the format '[quantity][unit]', where '[unit]' must be a supported time unit: 's' (seconds), 'm' (minutes), 'h' (hours), 'd' (days), or 'y' (years).",
        result = if (List.Contains(allowedTimeUnits, Text.End(input, 1)) = false)
                    then ValidationError(err)
                else if (CanParseNumberFromText(input, 0, 1))
                    then input
                    else ValidationError(err)
    in 
        result;

// Returns true if number can be parsed from text
CanParseNumberFromText = (input as text, startIndex as number, excluded as number) =>
    let
        result = (try Number.IsNaN(Number.From(Text.Range(input, startIndex, Text.Length(input)-excluded))) otherwise true) = false
    in
        result;
        
// Format errors from Data Core into a proper table with detailed error
FormatErrors = (data_response as any) =>
    let 
        err = data_response[Content][errors],
        detail = data_response[Content][detail],
        errTable = if (Record.HasFields(data_response[Content], "errors"))
            then Table.ExpandListColumn(Table.FromRecords({err}), Record.FieldNames(err){0})
            else detail
    in 
        errTable;


BuildPlotRequestBody = (dsn as text, tags as text, start as text, end as text, interval as number) =>
    let
        tagList = List.Transform(Text.Split(tags, ","), each Text.Trim(_)),
        Content = Json.FromValue([
                    Tags = Record.FromList({tagList}, {dsn}),
                    StartTime = start,
                    EndTime = end,
                    Intervals = interval
                ])
    in
        Content;


BuildProcessedRequestBody = (dsn as text, tags as text, start as text, end as text, dataFunction as text, interval as text) =>
    let
        tagList = List.Transform(Text.Split(tags, ","), each Text.Trim(_)),
        Content = Json.FromValue([
                    Tags = Record.FromList({tagList}, {dsn}),
                    StartTime = start,
                    EndTime = end,
                    DataFunction = dataFunction,
                    SampleInterval = interval
                ])
    in
        Content;


BuildRawRequestBody = (dsn as text, tags as text, start as text, end as text, points as number) =>
    let
        tagList = List.Transform(Text.Split(tags, ","), each Text.Trim(_)),
        Content = Json.FromValue([
                    Tags = Record.FromList({tagList}, {dsn}),
                    StartTime = start,
                    EndTime = end,
                    PointCount = points
                ])
    in
        Content;


BuildSnapshotRequestBody = (dsn as text, tags as text) =>
    let
        tagList = List.Transform(Text.Split(tags, ","), each Text.Trim(_)),
        Content = Json.FromValue([
                    Tags = Record.FromList({tagList}, {dsn})
                ])
    in
        Content;


// Data Source Kind description
IndustrialAppStore = [
    // Test Connection Handler
    TestConnection = (dataSourcePath) => { "IndustrialAppStore.NavigationTable" },
    Authentication =  if (ias_enabled)
        then 
            [
                OAuth = [
                    StartLogin = IndustrialAppStore.StartLogin,
                    FinishLogin = IndustrialAppStore.FinishLogin,
                    Refresh = IndustrialAppStore.Refresh
                ]
            ]
        else 
            [
                Windows = []
            ],
    Label = "Industrial App Store"
];


[DataSource.Kind="IndustrialAppStore", Publish="IndustrialAppStore.Publish"]
shared IndustrialAppStore.NavigationTable = () as any => 
    let 
        dataSources = IndustrialAppStore.GetDataSources(datacore_url),

        // assign functions to each data source leaf
        withDataCol = Table.AddColumn(dataSources, "Data", (x) => IndustrialAppStore.DataSourceQueries(datacore_url, x[Name], x[UrlName], x[Type]), type function),

        // cleanedTable = Table.RemoveColumns(withDataCol, "UrlName"),

        withItemKind = Table.AddColumn(withDataCol, "ItemKind", each "Function", type text),
        withItemName = Table.AddColumn(withItemKind, "ItemName", each "Function", type text),
        withIsLeaf = Table.AddColumn(withItemName, "IsLeaf", each false, type logical), 

        navtable = Table.ToNavigationTable(withIsLeaf, {"UrlName"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        navtable;


// Data source actions/functions definitions
IndustrialAppStore.DataSourceQueries = (datacore_url as text, dsName as text, dsUrl as text, dsType as text) as table =>

     let
         BaseFunctions = #table(
            {"Name",  "Key",   "Data",  "ItemKind", "ItemName", "IsLeaf"},{
            {"Tag Search", "ias_tag_search", IndustrialAppStore.TagSearch(datacore_url, dsName, dsUrl), Table.Type, Table.Type, true},
            {"Get Snapshot", "ias_get_data_snapshot", IndustrialAppStore.GetSnapshot(datacore_url, dsName, dsUrl), Table.Type, Table.Type, true},
            {"Get Processed", "ias_get_data_processed", IndustrialAppStore.GetProcessed(datacore_url, dsName, dsUrl), Table.Type, Table.Type, true},
            {"Get Data", "ias_get_data", IndustrialAppStore.DataSearch(datacore_url, dsName, dsUrl), Table.Type, Table.Type, false}
        }),

        // if data source is A&E - add additional reports
        DsFunctions = if (dsType = "aa") then
                Table.InsertRows(
                    BaseFunctions,
                    Table.RowCount(BaseFunctions), // offset parameter; insert new node at the bottom of the table
                    {
                        [Name = "Reports", Key = "ias_ae_reports", Data = AEReports(datacore_url, dsName, dsUrl), ItemKind = "Folder", ItemName = "Folder", IsLeaf = false]
                    }
                )
            else
                Table.InsertRows(
                    BaseFunctions,
                    Table.RowCount(BaseFunctions), // offset parameter; insert new node at the bottom of the table
                    {
                        // [Name = "Get Processed", Key = "ias_getdata_processed", Data = IndustrialAppStore.GetProcessed(datacore_url, dsName, dsUrl), ItemKind = Table.Type, ItemName = Table.Type, IsLeaf = true],
                        [Name = "Get Plot", Key = "ias_get_data_plot", Data = IndustrialAppStore.GetPlot(datacore_url, dsName, dsUrl), ItemKind = Table.Type, ItemName = Table.Type, IsLeaf = true],
                        [Name = "Get Raw", Key = "ias_get_data_raw", Data = IndustrialAppStore.GetRaw(datacore_url, dsName, dsUrl), ItemKind = Table.Type, ItemName = Table.Type, IsLeaf = true]
                    }
                ),

        NavTable = Table.ToNavigationTable(DsFunctions, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
in
        NavTable;


// A&E data reports
AEReports = (datacore_url as text, dsName as text, dsUrl as text) as table =>

     let
         ChildTablePerDataSource = #table(
            { "Name",  "Key",   "Data",  "ItemKind", "ItemName", "IsLeaf" },{
            { "Bad Actors", "ias_aa_bad_actors", IndustrialAppStore.AEbadactors(datacore_url, dsName, dsUrl), Table.Type, Table.Type, true },
            { "Sequence of Events", "ias_aa_soe_metatag", IndustrialAppStore.SoE(datacore_url, dsName, dsUrl), Table.Type, Table.Type, true }
        }),
        NavTable = Table.ToNavigationTable(ChildTablePerDataSource, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
in
        NavTable;

// Get's a table of all the datasources that the user allowed power bi access to
// Returns a table with one column being the display name of each datasource, the other being the name needed for the url to query the datasource
IndustrialAppStore.GetDataSources = (datacore_url as text) as table => 
    let 
        url = Uri.Combine(datacore_url,  gestalt_datasources_url),
        content = Web.Contents(url),
		source = ReadJsonResponse(content),
        namedTable = if (List.IsEmpty(source) = true) then 
                        Table.FromRecords({[
                            Name = "No data sources available.", 
                            UrlName = "", 
                            Type = error Error.Record(
                                "DataSource.Error", 
                                "Manage access to data sources at https://appstore.intelligentplant.com/Security/Apps?appid=064fa04abe624c70a982e377a6c72850", "Data sources might be unavailable due to several reasons: The App Store Connect hosting the data source is offline, you are not authorised to access the data source, or you have not granted Industrial Connector permission to access the data source.")
                        ]})
                    else
                        ParseDataSources(source)
    in 
        namedTable;

// Parse a list of datasource retrieved from AppStore in IndustrialAppStore.GetDataSources method
ParseDataSources = (source) =>
    let
        listOfSources = List.Transform(source, (x) => x[Name][DisplayName]), // extract data source name
        urlList = List.Transform(source, (x) => x[Name][QualifiedName]), // extract fully qualified data source name

        dsnTypes = List.Transform(source, (x) => try x[Properties][Remote Type] otherwise x[TypeName]), // extract data source types 
        dsnTypes_parsed = List.Transform(dsnTypes, (x) => if x <> "DataCore.AlarmAnalysis.AlarmAnalysisDriver" then "process" else "aa"),

        zipped = List.Zip({listOfSources, urlList, dsnTypes_parsed}),
        tableOfSources = Table.FromRows(zipped),

        namedTable = Table.RenameColumns(tableOfSources,
            {
                { Table.ColumnNames(tableOfSources){0}, "Name" },
                { Table.ColumnNames(tableOfSources){1}, "UrlName" },
                { Table.ColumnNames(tableOfSources){2}, "Type" }
            })
    in
        namedTable;


// Tag Search function
IndustrialAppStore.TagSearch = (datacore_url as text, dataSourceName as text, dataSourceId as text) =>
    let 
        tagSearchInternal = (tagName as text, optional pageSize as number, optional pageNumber as number) =>
	        let 
                _tagName = if tagName = null or Text.Trim(tagName) = "" then "*" else Text.Trim(tagName),
                _pageSize = ConvertToPositiveInteger(if pageSize = null or pageSize < 1 then 10 else if pageSize > 100 then 100 else pageSize),
                _pageNumber = ConvertToPositiveInteger(if pageNumber = null or pageNumber < 1 then 1 else pageNumber),

                url = GetTagSearchUrl(
                    datacore_url,
                    dataSourceId,
                    _tagName, 
                    _pageSize, 
                    _pageNumber
                ), 
        
		        response = Web.Contents(url),
		        source = ReadJsonResponse(response),

		        outerTable = Table.FromRecords(source),

                final = if Table.IsEmpty(outerTable)
                    then // message if no tags were found
                        Table.FromRows({{Text.Combine({"No tags found matching query filter '", _tagName, "'"})}}, {"Industrial App Store"})
                    else 
                        IndustrialAppStore.ProcessTagTable(outerTable) meta [Documentation.Name = _tagName]
            in
	            final,
        
        // Adding all the metadata to be displayed in the navigation table

        // Tag filter input field
        TagNameType = type text meta 
        [
            Documentation.FieldCaption = "Tag Name", 
            Documentation.FieldDescription = "The tag name filter.",
            Documentation.LongDescription = "The tag name search filter. Use '*' as a wildcard e.g. 'PT-123*.PV'.",
            Documentation.SampleValues = {"PT-123*.PV", "Sinusoid", "LIC*"}
        ],

        // Page size input field
        SizeType = type number meta 
        [
            Documentation.FieldCaption = "Page Size",
            Documentation.FieldDescription = "The maximum number of tags to retrieve.",
            Documentation.LongDescription = "The maximum number of tags to retrieve. The maximum page size is 100 tags.",
            Documentation.AllowedValues = {10, 25, 50, 100}
        ],

        // Page number input field
        PageType = type number meta 
        [
            Documentation.FieldCaption = "Page Number",
            Documentation.FieldDescription = "The results page to retrieve.",
            Documentation.LongDescription = "The results page to retrieve.",
            Documentation.AllowedValues = {1, 2, 3, 4, 5}
        ],
        
        tagSearchFunctionSignatureWithMeta = type function(tagName as TagNameType, optional pageSize as SizeType, optional pageNumber as PageType) as table meta [
            Documentation.Name = "Find Tags", 
            Documentation.LongDescription = "Finds tags matching the specified filter from data source '" & dataSourceName & "'."
        ],
        outputFunction = Value.ReplaceType(tagSearchInternal, tagSearchFunctionSignatureWithMeta)

    in outputFunction;


// Snapshot query function
IndustrialAppStore.GetSnapshot = (datacore_url as text, dataSourceName as text, dataSourceId as text) =>
    let 
        getSnapshotInternal = (tags as text, optional display as text) =>
	        let 
                _display = if (display <> null) then display else tag_value_display_field_numeric,

                urltags = tags,

		        url = GetSnapshotValuesUrl(datacore_url),
                        
                requestBody = BuildSnapshotRequestBody(dataSourceId, urltags),

		        // make data request
                data_response = IndustrialAppStore.ProcessDataRequest(url, requestBody),

                final = if data_response[IsValid]
                    then
                        IndustrialAppStore.ProcessSnapshotResponse(Record.ToTable(data_response[Content]), _display) meta [Documentation.Name = tags]
                    else
                        FormatErrors(data_response) // display error
            in
	            final,
        
        getSnapshotFunctionSignatureWithMeta = type function(tags as tag_name_input, optional display as tag_value_display_field_input) as table meta 
        [
            Documentation.Name = "Get Snapshot Tag Values", 
            Documentation.LongDescription = "Gets snapshot (i.e. current) tag values from data source '" & dataSourceName & "'."
        ],
        outputFunction = Value.ReplaceType(getSnapshotInternal, getSnapshotFunctionSignatureWithMeta) 

    in outputFunction;


// [DEPRECATED] Get Data function
IndustrialAppStore.DataSearch = (datacore_url as text, dataSourceName as text, dataSourceId as text) =>
    let 
        // Adding all the metadata to be displayed in the navigation table
        
        getData_type = type function(tags as tag_name_input, 
            startDate as query_start_date_type_input, 
            endDate as query_end_date_type_input, 
            function as processed_data_function_input, 
            interval as processed_sample_interval_input, 
            optional numberOfPoints as historical_query_sample_count_input, 
            optional display as tag_value_display_field_input) 
        as table meta [
            Documentation.Name = "[Deprecated] Get Historical Data", 
            Documentation.LongDescription = "This function is deprecated and is available for backwards compatibility only. Use the 'Get Processed', 'Get Plot', or 'Get Raw' functions instead."
        ],
        
        getData_typed = Value.ReplaceType(PerformDataSearch_function(datacore_url, dataSourceId, true), getData_type) 

    in getData_typed;


// Historical processed/aggregated query function.
IndustrialAppStore.GetProcessed = (datacore_url as text, dataSourceName as text, dataSourceId as text) =>
    let 
        getProcessedInternal = (tags as text, startDate, endDate , dataFunction as text, interval as text, optional display as text) =>
	        let 
                _display = if (display <> null) then display else tag_value_display_field_numeric,

                urltags = tags,                

                startDate = CheckAbsoluteTimeFormat(startDate, "start"),

                endDate = CheckAbsoluteTimeFormat(endDate, "end"),

                interval = CheckSampleIntervalInput(interval),

                dataFunction = CheckProcessedDataFunctionInput(dataFunction),

                // construct data query
		        url = GetHistoricalProcessedQueryUrl(datacore_url),
                
                requestBody = BuildProcessedRequestBody(dataSourceId, urltags, startDate, endDate, dataFunction, interval),

                // make data request
                data_response = IndustrialAppStore.ProcessDataRequest(url, requestBody),

                final = if data_response[IsValid]
                    then
                        IndustrialAppStore.ProcessNormal(Record.ToTable(data_response[Content]), _display, tags) meta [Documentation.Name = tags]
                    else
                        FormatErrors(data_response) // display error
            in
	            final,
        
        // Adding all the metadata to be displayed in the navigation table

        getProcessedFunctionSignatureWithMeta = type function(
            tags as tag_name_input, 
            sd as query_start_date_type_input, 
            ed as query_end_date_type_input, 
            function as processed_data_function_input, 
            interval as processed_sample_interval_input, 
            optional display as tag_value_display_field_input) 
        as table meta [
            Documentation.Name = "Get Processed Tag Values", 
            Documentation.LongDescription = "Gets aggregated historical tag values from data source '" & dataSourceName & "'."
        ],
       
        outputFunction = Value.ReplaceType(getProcessedInternal, getProcessedFunctionSignatureWithMeta) 

    in outputFunction;

// Historical plot query function
IndustrialAppStore.GetPlot = (datacore_url as text, dataSourceName as text, dataSourceId as text) =>
    let 
        getPlotInternal = (tags as text, startDate, endDate, intervals as number, optional display as text) =>
	        let 
                _display = if (display <> null) then display else tag_value_display_field_numeric,

                urltags = tags,

                startDate = CheckAbsoluteTimeFormat(startDate, "start"),

                endDate = CheckAbsoluteTimeFormat(endDate, "end"),

                intervals = CheckNumberIsNotNegative(intervals, "Plot Width"),

		        url = GetHistoricalPlotQueryUrl(datacore_url),

                requestBody = BuildPlotRequestBody(dataSourceId, urltags, startDate, endDate, intervals),
        
                // make data request
                data_response = IndustrialAppStore.ProcessDataRequest(url, requestBody),

                final = if data_response[IsValid]
                    then
                        IndustrialAppStore.ProcessNormal(Record.ToTable(data_response[Content]), _display, tags) meta [Documentation.Name = tags]
                    else
                        FormatErrors(data_response) // display error
            in
	            final,
        
        // Adding all the metadata to be displayed in the navigation table

        getPlotFunctionSignatureWithMeta = type function(
            tags as tag_name_input, 
            sd as query_start_date_type_input, 
            ed as query_end_date_type_input, 
            intervals as plot_intervals_input, 
            optional display as tag_value_display_field_input) 
        as table meta [
            Documentation.Name = "Get Plot Tag Values", 
            Documentation.LongDescription = "Gets best-fit historical tag values from data source '" & dataSourceName & "' for visualization in a chart."
        ],
        
        outputFunction = Value.ReplaceType(getPlotInternal, getPlotFunctionSignatureWithMeta) 

    in outputFunction;

// Historical raw query function
IndustrialAppStore.GetRaw = (datacore_url as text, dataSourceName as text, dataSourceId as text) =>
    let 
        getRawInternal = (tags as text, startDate, endDate, points as number, optional display as text) =>
	        let 
                _display = if (display <> null) then display else tag_value_display_field_numeric,

                urltags = tags,              

                startDate = CheckAbsoluteTimeFormat(startDate, "start"),

                endDate = CheckAbsoluteTimeFormat(endDate, "end"),

                points = CheckNumberIsNotNegative(points, "Maximum Sample Count"),

		        url = GetHistoricalRawQueryUrl(datacore_url),

                requestBody = BuildRawRequestBody(dataSourceId, urltags, startDate, endDate, points),
        
		        // make data request
                data_response = IndustrialAppStore.ProcessDataRequest(url, requestBody),

                final = if data_response[IsValid]
                    then
                        IndustrialAppStore.ProcessNormal(Record.ToTable(data_response[Content]), _display, tags) meta [Documentation.Name = tags]
                    else
                        FormatErrors(data_response) // display error
            in
	            final,
        
        // Adding all the metadata to be displayed in the navigation table

        getRawFunctionSignatureWithMeta = type function(tags as tag_name_input, 
            sd as query_start_date_type_input, 
            ed as query_end_date_type_input, 
            points as raw_max_sample_count_input, 
            optional display as tag_value_display_field_input) 
        as table meta [
            Documentation.Name = "Get Raw Tag Values", 
            Documentation.LongDescription = "Gets raw, unprocessed historical tag values from data source '" & dataSourceName & "'."
        ],
        
        outputFunction = Value.ReplaceType(getRawInternal, getRawFunctionSignatureWithMeta) 

    in outputFunction;


// Bad Actor report function
IndustrialAppStore.AEbadactors = (datacore_url as text, dsName as text, qDsn as text) =>
    let

        BA_GetBadActorsFunction = (asset as text,
                                    optional startDate, 
                                    optional endDate, 
                                    optional eventType as text, 
                                    optional numberOfBAs as number) =>
	        let 
                startTime =  if startDate = null then "*-30d" else CheckAbsoluteTimeFormat(startDate, "start"),
                endTime = if endDate = null then "*" else CheckAbsoluteTimeFormat(endDate, "end"),
                evtType = if eventType = null then "ALM" else eventType,
                BAnum = if numberOfBAs = null 
                    then 5 
                    else 
                        if numberOfBAs > 99 // the query is limited at the IAS end as well but doesnt throw an error (TODO).
                            then 99 
                            else numberOfBAs,
                        
                query = BA_CompileBadActorReportQuery(datacore_url,
                                    qDsn,
                                    asset,
                                    startTime,
                                    endTime,
                                    evtType,
                                    BAnum),

                requestBody = BuildProcessedRequestBody(qDsn, query[tags], startTime, endTime, "INTERP", "1d"),
                
                // make data request
                data_response = IndustrialAppStore.ProcessDataRequest(query[url], requestBody),

                final = if data_response[IsValid]
                    then
                        IndustrialAppStore.ProcessBadActors(Record.ToTable(data_response[Content]), "Text", asset, false) meta [Documentation.Name = "???"]
                    else
                        FormatErrors(data_response) // display error
            in
	            final,
        
        // Adding all the metadata to be displayed in the navigation table

        // get available assets 
        assets = AE_GetAvailableAssets(datacore_url, qDsn),

        // Available assets dropdown
        Asset_control = type text meta 
        [
            Documentation.Name = "Asset",
            Documentation.FieldCaption = "Asset name",
            Documentation.FieldDescription = "Asset for which to calculate the bad actors for.",
            Documentation.AllowedValues = assets
        ],

        // Event type dropdown
        EventType_control = type text meta 
        [
            Documentation.Name = "Event type",
            Documentation.FieldCaption = "Report event type",
            Documentation.FieldDescription = "Event type for which to calculate the bad actors for.",
            Documentation.AllowedValues = { "ALM", "INT" }            
        ],

        // Page number input field
        NumberOfBadActors_control = type number meta 
        [
            Documentation.Name = "Report length", 
            Documentation.FieldCaption = "Number of bad actors", 
            Documentation.FieldDescription = "Number of bad actors in the report.",
            Documentation.SampleValues = {"5, 10, 25"}
        ],
             
        baReportFunction_type = type function(
                    asset as Asset_control,
                    optional sd as query_start_date_type_input, 
                    optional ed as query_end_date_type_input,
                    optional eventType as EventType_control, 
                    optional numberOfBAs as NumberOfBadActors_control)
                as table 
                    meta [Documentation.Name = dsName, Documentation.LongDescription = "Compiling bad actor report..."],
       
       baReportFunction_typed = Value.ReplaceType(BA_GetBadActorsFunction, baReportFunction_type) 

    in baReportFunction_typed;

// Sequence of Events report function
IndustrialAppStore.SoE = (datacore_url as text, dsName as text, qDsn as text) =>
    let

        SoE_GetSoEFunction = (asset as text,
                                    optional startDate, 
                                    optional endDate,
                                    optional filter as text,
                                    optional page as number,
                                    optional pageSize as number) =>
	        let
                pgSize = if pageSize = null then 30 else pageSize,
                startTime = if startDate = null then "*-30d" else CheckAbsoluteTimeFormat(startDate, "start"),
                endTime = if endDate = null then "*" else CheckAbsoluteTimeFormat(endDate, "end"),

                // construct SoE meta tag
                soe_metaTag = Text.Format(
                                    "#[asset]/Soe/#[eventsToSkip]-#[eventsToGet].#[filter]",
                                    [
                                        asset = asset,
                                        // soe takes number of records to skip rather than page number, simple calc can remedy that
                                        eventsToSkip = if page = null then 0 else ((page - 1) * pgSize),
                                        eventsToGet = pgSize,
                                        filter = if filter = null then "" else filter
                                    ]),

                // construct url
		        url = GetHistoricalProcessedQueryUrl(datacore_url),

                requestBody = BuildProcessedRequestBody(qDsn, soe_metaTag, startTime, endTime, "aa", "1d"),
        
                // make data request
		        data_response = IndustrialAppStore.ProcessDataRequest(url, requestBody),

                    final = if data_response[IsValid]
                        then
                            IndustrialAppStore.ProcessSOE(Record.ToTable(data_response[Content])) meta [Documentation.Name = soe_metaTag] 
                        else
                            FormatErrors(data_response) // display error
                in
	                final,
        
        // Adding all the metadata to be displayed in the navigation table

        // get available assets 
        assets = AE_GetAvailableAssets(datacore_url, qDsn),

        // Available assets dropdown
        Asset_control = type text meta 
        [
            Documentation.Name = "Asset",
            Documentation.FieldCaption = "Asset name",
            Documentation.FieldDescription = "Asset for which to calculate the bad actors for.",
            Documentation.AllowedValues = assets
        ],

        // Tag filter input field
        Filter_control = type text meta 
        [
            Documentation.Name = "Filter", 
            Documentation.FieldCaption = "SoE filter string", 
            Documentation.SampleValues = { "tag=LI*40", "eventType=ALM", "tag=LI*&alarmIdentifier=HIHI" }, 
            Documentation.FieldDescription = "Sequence of events filter."
        ],

        // Page number input field
        PageNumber_control = type number meta 
        [
            Documentation.Name = "Page Number", 
            Documentation.FieldCaption = "Page Number", 
            Documentation.SampleValues = {"1, 2"},
            Documentation.FieldDescription = "Resulting set page number."
        ],

        // Page size input field
        PageSize_control = type number meta 
        [
            Documentation.Name = "Page Size",
            Documentation.FieldCaption = "Page Size",
            Documentation.SampleValues = {"1, 25, 50"},
            Documentation.FieldDescription = "Number of events per page.",
            Documentation.LongDescription = "Number of events to display per page."
        ],
             
        soeReportFunction_type = type function(
                    asset as Asset_control,
                    optional sd as query_start_date_type_input, 
                    optional ed as query_end_date_type_input,
                    optional filter as Filter_control,
                    optional page as PageNumber_control,
                    optional pageSize as PageSize_control)
                as table 
                    meta [Documentation.Name = dsName, Documentation.LongDescription = "Getting SoE report..."],
       
       baReportFunction_typed = Value.ReplaceType(SoE_GetSoEFunction, soeReportFunction_type) 

    in baReportFunction_typed;


// Process bad actor reports
IndustrialAppStore.ProcessBadActors = (outerTable as table, display as text, asset as text, optional includeTtimestamp as logical) => 
    let
        innerTable = Record.ToTable(outerTable[Value]{0}),
        expandedTags = Table.ExpandRecordColumn(innerTable, "Value", {"TagName", "DisplayType", "Values"}, {"TagName", "DisplayType", "Values"}), // gets a row in table for each of the tags
        columns = Table.ToColumns(expandedTags),  // each col is a list 

        // check if any bad actors returned for the period requested
        jointRem = if(List.IsEmpty(columns{3}{0}))
                then "No bad actors found matching specified filters." //EmptyDataResponseToTable([], "No bad actors found")
                else ProcessNormal_inner(innerTable, "Text", asset, includeTtimestamp)
    in
        jointRem;

// Turns normal tags into desired table
IndustrialAppStore.ProcessNormal = (outerTable as table, display as text, tags as text, optional includeTtimestamp as logical, optional compat as logical) => 
    let 
        innerTable = if (compat = true)     //compatibility for GET DATA function
            then outerTable
            else Record.ToTable(outerTable[Value]{0}),
        processedTable = ProcessNormal_inner(innerTable, display, tags, includeTtimestamp)
    in
        processedTable;

ProcessNormal_inner = (outerTable as table, display as text, tags as text, optional includeTtimestamp as logical) => 
    let
        hasTags = Table.RowCount(outerTable) > 0,

        tagList = Text.Split(tags, ","),

        jointRem = if (hasTags)
            then innerFunction(outerTable, display, includeTtimestamp)
            else #table(List.InsertRange(tagList, 0, {"Sample Time"}), {List.Repeat({"N/A"}, List.Count(tagList) + 1)}),

        innerFunction = (outerTable as table, display as text, optional includeTtimestamp as logical) =>
        let
            expandedTags = Table.ExpandRecordColumn(outerTable, "Value", {"TagName", "DisplayType", "Values"}, {"TagName", "DisplayType", "Values"}), // gets a row in table for each of the tags

            columns = Table.ToColumns(expandedTags),  // each col is a list 

            // list of lists of all the numeric values for each tag
            valuesList = List.Transform(columns{3}, 
                (x) =>
                    if (x{0}[IsNumeric] and display = "Numeric") then List.Transform(x, (y as record) => y[NumericValue]) // if its numeric and numeric value requested
                    else List.Transform(x, (y as record) => y[TextValue])), // else use text value

            tagNames = outerTable[Name] as list, // List of all the tags returned from the query

            valuesTable = Table.FromColumns(valuesList), // creates table with all the tags values, without correct column names
            valuesTableNamed = Table.RenameColumns(valuesTable, List.Zip({Table.ColumnNames(valuesTable), tagNames})), // adds correct column names       

            valuesTableTyped = Table.TransformColumnTypes(valuesTableNamed, 
                List.Transform(Table.ColumnNames(valuesTableNamed), 
                    (x) => 
                        if (display = "Numeric" and (columns{3}{List.PositionOf(Table.ColumnNames(valuesTableNamed), x)}){0}[IsNumeric]) 
                        then {x, type number} 
                        else {x, type text} )), // sets the type of the column based on the IsNumeric field

            hasValues = List.IsEmpty(columns{3}{0}) = false,

            jointRem = if (hasValues) 
                then innerLevelFunction(columns, valuesTableTyped, includeTtimestamp)
                else #table(List.InsertRange(tagNames, 0, {"Sample Time"}), {List.Repeat({"N/A"}, List.Count(tagNames) + 1)}),

            //if the tag has no value this would not run and just return a table with the message tag has no value
            innerLevelFunction = (columns as list, valuesTableTyped as table, optional includeTtimestamp as logical) => 
                let
                    datesList = List.Transform(columns{3}{0}, (x) => (x[UtcSampleTime])), // list of all the timestamps of all the values
                        
                    datesTable = Table.RenameColumns(Table.SelectColumns(Table.FromList(datesList), {"Column1"}), {"Column1", "Sample Time"}), // Table of all the dates with the correct name
                    datesTableTyped = Table.TransformColumnTypes(datesTable, {"Sample Time", type datetime}), // sets the type of the datetime column
                        
                    valuesWIndex = Table.AddIndexColumn(valuesTableTyped, "joiner"), // adding indexed column to join the tables using
                    datesWIndex = Table.AddIndexColumn(datesTableTyped, "joiner"), // adding indexed column to join the tables using        

                    joint = if includeTtimestamp = null or includeTtimestamp = true then
                                Table.Join(datesWIndex, "joiner", valuesWIndex, "joiner") // joining tables
                        else
                                valuesWIndex,

                    jointRem = Table.RemoveColumns(joint, "joiner") // removing joiner column
                in
                    jointRem

            in
                jointRem
    in
        jointRem;

// Process snapshot query response into a table
IndustrialAppStore.ProcessSnapshotResponse = (outerTable as table, display as text) => 
    let 
        innerTable = Record.ToTable(outerTable[Value]{0}),

		//Expand each record to display the properties
		expanded = Table.ExpandRecordColumn(innerTable, "Value", {"UtcSampleTime","TextValue", "NumericValue"}),

		//Rename the sample time column
		#"Renamed Columns" = Table.RenameColumns(expanded,{{"UtcSampleTime", "Sample Time"}}),

		//Set it to a date time
		#"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns",{{"Sample Time", type datetime}}),
    
		//Rename the tag column
		#"Renamed Columns1" = Table.RenameColumns(#"Changed Type",{{"Name", "Tag"}}),

		//Set what to display based on user option
		checkText = if display <> "Text" and display <> "Both" then Table.RemoveColumns(#"Changed Type", "TextValue") else Table.RenameColumns(#"Changed Type", {{"TextValue", "Text Value"}}),
		checkNumeric = if display <> "Numeric" and display <> "Both" then Table.RemoveColumns(checkText, "NumericValue") else Table.RenameColumns(checkText, {{"NumericValue", "Numeric Value"}})

    in
        checkNumeric;

// Extracts and displays all data in an SOE tag (Will only work when parsing 1 SOE tag at a time)
IndustrialAppStore.ProcessSOE = (outerTable as table) =>
    let 
        innerTable = Record.ToTable(outerTable[Value]{0}),
        expandedTag = Table.RemoveColumns(Table.ExpandRecordColumn(innerTable, "Value", {"Values"}, {"Values"}), "Name"), // Expands columns and gets rid of unnecessary ones
        expandedList = Table.ExpandListColumn(expandedTag, "Values"), // Have a column of all the records in the values list
        expandedTextValue = Table.ExpandRecordColumn(expandedList, "Values", {"TextValue"}, {"TextValue"}), // further expands table to get to level with target JSON doc

        // if there is only 1 report and the Unit is 0 - filters dont match any data 
        // (reason for extracting unit in the AND expression is an assumption that if the first expression fails it doesnt need to extract the unit value)
        parsed = if Table.RowCount(expandedTextValue) = 1 and Table.ExpandRecordColumn(expandedList, "Values", {"Unit"}, {"Unit"}){0}[Unit] = "0"
            then "No records matched the speficied filters."
        else
            Table.FromRecords(List.Transform(Table.ToRows(expandedTextValue), (x) => Json.Document(x{0}))) //Parsing the json and putting it into a table
    in 
        parsed;

// Turns normal tags into desired table
IndustrialAppStore.ProcessTagTable = (outerTable as table) => 
    let 
        cleanedTable = Table.RemoveColumns(outerTable, {"UnitOfMeasure", "Properties", "IsMetaTag", "DigitalStates", "Id"}),
        NavTable = Table.ToNavigationTable(cleanedTable, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        NavTable;

// Perform data search function
PerformDataSearch_function = (datacore_url as text, qDsn as text, optional compat as logical) as function =>
    let 
        getData_function = (tags as text, 
                            startDate as text, 
                            endDate as text, 
                            dataFunction as text, 
                            interval as text, 
                            optional numberOfPoints as number, 
                            optional display as text) =>
	        let 
                _display = if (display <> null) then display else tag_value_display_field_numeric,

                startDate = CheckAbsoluteTimeFormat(startDate, "start"),

                endDate = CheckAbsoluteTimeFormat(endDate, "end"),

                interval = CheckSampleIntervalInput(interval),

                // construct url
		        url = if (compat = true)    //Get Data [Obsolete]
                then GetHistoricalQueryUrl(datacore_url,
                    qDsn, 
                    tags,
                    startDate, 
                    endDate, 
                    dataFunction, 
                    interval,
                    if numberOfPoints = null then 0 else numberOfPoints
                    )
                else GetHistoricalProcessedQueryUrl(datacore_url),       //AA or SoE asset search
                    
                requestBody = if (compat = true) 
                    then null
                    else BuildProcessedRequestBody(qDsn, tags, startDate, endDate, dataFunction, interval),
        
                // make data request
		        data_response = IndustrialAppStore.ProcessDataRequest(url, requestBody),

                final = if data_response[IsValid]
                    then
                        if Text.Contains(Text.Lower(tags), "/soe/") //decides whether to parse as an SOE tag or not
                            then 
                                IndustrialAppStore.ProcessSOE(Record.ToTable(data_response[Content])) meta [Documentation.Name = tags] 
                            else 
                                IndustrialAppStore.ProcessNormal(Record.ToTable(data_response[Content]), _display, tags, null, compat) meta [Documentation.Name = tags]
                    else
                        FormatErrors(data_response) // display error
            in
	            final
    in 
        getData_function;

// Data Source UI publishing description
IndustrialAppStore.Publish = [
    Beta = false,
    SupportsDirectQuery = false,
    Category = "Online Services",
    ButtonText = { "Industrial App Store", "Industrial App Store" },
    LearnMoreUrl = "https://appstore.intelligentplant.com",
    SourceImage = IndustrialAppStore.Icons,
    SourceTypeImage = IndustrialAppStore.Icons
];

// List of Icons
IndustrialAppStore.Icons = [
    Icon16 = { Extension.Contents("IndustrialAppStore16.png"), Extension.Contents("IndustrialAppStore20.png"), Extension.Contents("IndustrialAppStore24.png"), Extension.Contents("IndustrialAppStore32.png") },
    Icon32 = { Extension.Contents("IndustrialAppStore32.png"), Extension.Contents("IndustrialAppStore40.png"), Extension.Contents("IndustrialAppStore48.png"), Extension.Contents("IndustrialAppStore64.png") }
];

//
// OAuth2 flow definition
//

// code challang emethod; using plain for now as there is no way to hash S256
codeChallangeMethod = "plain";

// Authentication LogIn procedure.
IndustrialAppStore.StartLogin = (resourceUrl, state, display) =>
    let        
        codeVerifier = CreateCodeVerifier(), // generate our code verifier
        authorizeUrl = authorize_uri & "?" & Uri.BuildQueryString([
            client_id = client_id,
            code_challenge = CreateCodeChallange(codeVerifier),
            code_challenge_method = codeChallangeMethod,
            redirect_uri = redirect_uri,
            state = state,
            scope = IndustrialAppStore.GetScopeString(scopes),
            access_type = "offline",
            response_type = "code"
        ])
    in
        [
            LoginUri = authorizeUrl,
            CallbackUri = redirect_uri,
            WindowHeight = windowHeight,
            WindowWidth = windowWidth,
            Context = codeVerifier
        ];

// Finishes login procedure. To use implicit flow, token is already fetched in StartLogin and just extracted from the url here.
IndustrialAppStore.FinishLogin = (context, callbackUri, state) =>
    let
        // parse the full callbackUri, and extract the Query string
        parts = Uri.Parts(callbackUri)[Query],
        // if the query string contains an "error" field, raise an error
        // otherwise call TokenMethod to exchange our code for an access_token
        result = if (Record.HasFields(parts, {"error", "error_description"})) then 
                    error Error.Record(parts[error], parts[error_description], parts)
                 else
                    TokenMethod("authorization_code", parts[code], context)
    in
        result;
        
// AccessToken refresh handler
IndustrialAppStore.Refresh = (resourceUrl, refresh_token) => TokenMethod("refresh_token", refresh_token);

//
// Helper Functions
//

//checks if a value is null, and if it is, uses alternative value
Value.IfNull = (a, b) => if a <> null then a else b;


// Raises an error related to input validation.
ValidationError = (message as text, optional detail as text) => error Error.Record("Input Validation Error", message, detail);


// Rounds the specified number down to a whole number and, if the number is negative, converts it 
// to a positive number. 
ConvertToPositiveInteger = (num as number) as number =>
    let
        _num = Number.Abs(Number.RoundDown(num))
    in
        _num;


// Splits a comma-delimited string of tag names into a list, removving duplicates and throwing an 
// exception if no tag names are specified.
ParseTagNames = (tags as text) as list =>
    let
        _validationError = () => ValidationError("One or more tag names are required.", "You must specify one or more tag names as a comma-delimited list."),
        _tags = if tags = null or Text.Trim(tags) = "" then _validationError() else tags,
        _list = List.Distinct(List.Transform(List.Select(Text.Split(_tags, ","), (x) => Text.Trim(x) <> ""), (x) => Text.Trim(x))),
        _listFinal = if List.Count(_list) = 0 then _validationError() else _list
    in 
        _listFinal;


// Parses a timestamp, converts it to UTC, and returns it as an absolute string. If the timestamp 
// cannot be parsed (e.g. if it is a relative timestamp), the original value is returned unmodified.
ParseAbsoluteOrRelativeTimestamp = (timestamp as text) as text =>
    let
        _timestamp = if timestamp = null or Text.Trim(timestamp) = "" then ValidationError("Invalid timestamp.", "You must specify an absolute or relative timestamp.") else Text.Trim(timestamp),
        _relativeTimestamp = if Text.StartsWith(_timestamp, "*") then _timestamp else null,
        _absoluteTimestamp = try DateTimeZone.ToText(DateTimeZone.ToUtc(DateTimeZone.From(_timestamp, Culture.Current)), "yyyy-MM-ddTHH:mm:ss") otherwise ValidationError("Invalid absolute timestamp", "Absolute timestamps must be specified using the format 'yyyy-MM-dd hh:mm:ss'.")
    in
        if _relativeTimestamp <> null then _relativeTimestamp else _absoluteTimestamp;


// Parses the specified response context as JSON, or throws an error containing the response 
// content if it cannot be parsed as JSON.
ReadJsonResponse = (content as binary) =>
    let
        _json = Json.Document(content),
        _content = Text.FromBinary(content)
    in
        try _json otherwise error Error.Record("Unexpected Response", "Invalid JSON response received.", "Response: " & _content);


// Fire data request and return response JSON
IndustrialAppStore.ProcessDataRequest = (url as text, optional requestBody as binary) as record =>
    let
        // get response
        response = if requestBody <> null 
            then Web.Contents(      //POST Method
                url, 
                [
                    Content = requestBody,
                    Headers =[
                        #"Content-Type" = "application/json",
                        #"X-IndustrialConnector-Version" = version
                    ],
                    ManualStatusHandling = { 400, 401, 402, 403 }
                ]
            )
            else Web.Contents(      //GET Method (only for GET DATA function)
                url, 
                [
                    Headers =[
                        #"Content-Type" = "application/json",
                        #"X-IndustrialConnector-Version" = version
                    ],
                    ManualStatusHandling = { 400, 401, 402, 403 }
                ]
            ),
        response_code = Value.Metadata(response)[Response.Status], // get response code
        isValid = if response_code = 200 then true else false, // determine whether its valid
        data = [ Code = response_code, IsValid = isValid, Content = ReadJsonResponse(response) ]
    in
        data;

// Latest data API responses are indexed by dsn as well tag names
ParseHistoricalResponse_multidsn = (response as record, dsn as text) as table =>
    let
        outerTable = if Record.FieldCount(response) <> 0 // if null/empty is returned then its 402
                        then 
                            Record.ToTable(Table.Column(Table.FromRecords( { response } ), dsn){0})// this ugly statement is broken down below
                        else Table.FromRecords({})

    in
        outerTable;

// Original data API responses are indexed by tag only
ParseHistoricalResponse_singledsn = (response as record) as table =>
    let
        outerTable = if Record.FieldCount(response) <> 0 // if null/empty is returned then its 402
                        then Record.ToTable(response)
                        else Table.FromRecords({})
    in
        outerTable;

//Gets scope string
IndustrialAppStore.GetScopeString = (scopes as list, optional scopePrefix as text) as text =>
    let
        prefix = Value.IfNull(scopePrefix, ""),
        addPrefix = List.Transform(scopes, each prefix & _),
        asText = Text.Combine(addPrefix, " "),
        final = Text.Combine(asText, "&prompt=consent")
    in
        asText;

// Compiles empty table (with no data or no subscription message) for data response  
EmptyDataResponseToTable = (data_response as record, optional message as text) =>
    let 
        empty_table_response = if(message <> null)
            then Table.FromRows({{ message }}, { default_empty_table_header })
        else
            Table.FromRows({{ 
            (if Record.FieldCount(data_response) <> 0 
                then default_no_data_found_response 
                else default_no_licence_found_response) }}, 
            { default_empty_table_header })
    in
        empty_table_response;


//If multiple tags are entered turns them into a format understood by the data core api
GetTagNamesQueryString = (tags as text) =>
    let
        tagList = ParseTagNames(tags),
        queryString = List.Accumulate(tagList, "", (state, current) => state & "&tag=" & Uri.EscapeDataString(current))       
    in
        queryString;

// [DEPRECATED] For use with Get Data function
GetHistoricalQueryUrl = (datacore_url as text, dsn as text, tags as text, startDate as text, endDate as text, function as text, step as text, optional numberOfPoints as number) =>
    let
        dcValuesEndPoint = Uri.Combine(datacore_url, ias_data_historical),
        timestep = if (numberOfPoints <> null and numberOfPoints > 0) then 
                Uri.BuildQueryString([points = Number.ToText(ConvertToPositiveInteger(numberOfPoints))])
            else
                Uri.BuildQueryString([step = Uri.EscapeDataString(step)]),
        url = Uri.Combine(dcValuesEndPoint, dsn)
            & "?"
            & Uri.BuildQueryString([
                function = function, 
                start = ParseAbsoluteOrRelativeTimestamp(startDate), 
                end = ParseAbsoluteOrRelativeTimestamp(endDate)
            ])
            & "&" 
            & timestep
            & GetTagNamesQueryString(tags)
    in 
        url;

// Construct URL for historical processed data
GetHistoricalProcessedQueryUrl = (datacore_url as text) =>
    let
        url = Uri.Combine(datacore_url, ias_data_historical_processed)
    in 
        url;

// Construct URL for historical plot data
GetHistoricalPlotQueryUrl = (datacore_url as text) =>
    let
        url = Uri.Combine(datacore_url, ias_data_historical_plot)
    in 
        url;

// Construct URL for historical raw data
GetHistoricalRawQueryUrl = (datacore_url as text) =>
    let
        url = Uri.Combine(datacore_url, ias_data_historical_raw)
    in 
        url;

//Gets the url to query to get the values back
GetSnapshotValuesUrl = (datacore_url as text) =>
    let
        url = Uri.Combine(datacore_url, ias_data_snapshot)
    in url;

// Gets the url to query to get the values back
GetTagSearchUrl = (datacore_url as text, dataSourceId as text, tagName as text, pageSize as number, pageNumber as number) =>
    let
        dcTagsEndpoint = Uri.Combine(datacore_url, ias_tags),
        url = Uri.Combine(dcTagsEndpoint, dataSourceId) 
            & "?"
            & Uri.BuildQueryString([
                description = "*",
                unit = "*",
                pageSize = Number.ToText(ConvertToPositiveInteger(pageSize)),
                name = tagName,
                page =  Number.ToText(ConvertToPositiveInteger(pageNumber))
            ])
    in
        url;


// Compile bad actor report request
BA_CompileBadActorReportQuery = (datacore_url as text,
    qDsn as text, 
    asset as text, 
    startDate as text, 
    endDate as text,
    eventType as text, 
    numberOfBa as number) =>
    let
        // get meta tags string
        baMetaTags_string = BA_CompileMetaTags(asset, eventType, numberOfBa),
        url = GetHistoricalProcessedQueryUrl(datacore_url),
        query = [
            url = url,
            tags = baMetaTags_string
        ]
    in
        query;

// Create bada actor meta tag string
BA_CompileMetaTags = (asset as text, eventType as text, numberOfBa as number) =>
    let
        baAttributes = { "tag", "alarmIdentifier", "tagDescription", "count" }, // base meta tag attributes
        // create a list of meta tags, general format 'Oil Co/Osprey/ALM BA report/10.tag-a'
        baMetaTags = List.Transform(baAttributes, each Text.Format("#{0}/#{1} BA report/#{2}.#{3}-a", { asset, eventType, Number.ToText(numberOfBa), _ })),
        baMetaTags_string = Text.Combine(baMetaTags, ",")
    in
        baMetaTags_string;

AE_GetAvailableAssets = (datacore_url as text, qDsn as text) => 
    let
        assets_metaTag = "*/AA config/CompanyAssets.all",

        getData = PerformDataSearch_function(datacore_url, qDsn),
        asset_response = getData(assets_metaTag, "*-30d", "*", "aa", "1d", null, "Text"),
        assets = Table.Column(asset_response, assets_metaTag) // list of available assets
    in
        assets;

// Transform Core verifier value into code challange; S256 method is not fully implemented yet
// as Power Query doesnt have an out-of-the-box solution for 256 hashing.
// More info https://tools.ietf.org/html/rfc7636 (4)
CreateCodeChallange = (codeVerifier as text) =>
    let
        RandomStringInBytes = Text.ToBinary(codeVerifier, TextEncoding.Ascii), // convert text to bytes
        EncodedString = Binary.ToText(RandomStringInBytes, BinaryEncoding.Base64), // encode them to a string
        ReplaceString1 = Text.Replace(EncodedString, "+", "-"), // as per spec; replace + with -
        ReplaceString2 = Text.Replace(EncodedString, "/", "_"), // as per spec; replace / with _
        ReplaceString3 = Text.Remove(ReplaceString2,{"="}), // as per spec
        CodeChallange = if(codeChallangeMethod = "plain")
            then
                codeVerifier
            else
                ReplaceString3
    in
        CodeChallange;

// Create code verifier string.
// More info: https://tools.ietf.org/html/rfc7636#section-4
CreateCodeVerifier = () =>
    let 
        CodeVerifier = Text.NewGuid() & Text.NewGuid()
    in
        CodeVerifier;

// Navigation Table
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

// see "Exchange code for access token: POST /oauth/token" at https://cloud.ouraring.com/docs/authentication for details
// grantType:  Maps to the "grant_type" query parameter.
// tokenField: The name of the query parameter to pass in the code.
// code:       Is the actual code (authorization_code or refresh_token) to send to the service.
TokenMethod = (grantType, code, optional codeVerifier) =>
    let
        codeVerifier = if (codeVerifier <> null) then [code_verifier = codeVerifier] else [],
        codeParameter = if (grantType = "authorization_code") then [ code = code ] else [ refresh_token = code ],
        
        queryString = codeVerifier & codeParameter & [
            grant_type = grantType,
            redirect_uri = redirect_uri,
            client_id = client_id
        ],

        tokenResponse = Web.Contents(token_uri, [
            Content = Text.ToBinary(Uri.BuildQueryString(queryString)),
            Headers = [
                #"Content-type" = "application/x-www-form-urlencoded",
                #"Accept" = "application/json"
            ],
            ManualStatusHandling = {400} 
        ]),
        body = Json.Document(tokenResponse),
        result = if (Record.HasFields(body, {"error", "error_description"})) then 
                    error Error.Record(body[error], body[error_description], body)
                 else
                    body
    in
        result;


// 
// Load common library functions
// 
// TEMPORARY WORKAROUND until we're able to reference other M modules
Extension.LoadFunction = (name as text) =>
    let
        binary = Extension.Contents(name),
        asText = Text.FromBinary(binary)
    in
        Expression.Evaluate(asText, #shared);

Diagnostics = Extension.LoadFunction("Diagnostics.pqm");
Diagnostics.LogValue = Diagnostics[LogValue];
