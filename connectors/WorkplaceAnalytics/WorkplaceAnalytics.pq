//------------------------------------------------------------
// Copyright (c) Microsoft Corporation.  All rights reserved.
//------------------------------------------------------------
[Version = "3.1.0"]
section WorkplaceAnalytics;

// This is currently pointed at the PPE environment.
// to change this locally, substitute these values:
// Local: https://localhost:44300/
// PROD (Nova): https://api.analysis.insights.svc.cloud.microsoft/
// GCC (Nova): https://api.gcc.analysis.insights.svc.cloud.microsoft/
// GCC - High (Nova): https://api.analysis.insights.svc.usgovcloud.microsoft/
// GCC - DoD (Nova): https://api.analysis.dod.insights.svc.usgovcloud.microsoft/
// When testing on PPE, make sure to add the tenantId header to the GetHeader definition as well. Also hardcode the Authentication Resource as specified in the code.
// Nova PPE requires an additional resource string to be added.
// If you're trying to capture traffic with Fiddler to look at the API results, it wont work with localhost addresses unless you change them to localhost.fiddler
// Also - at the bottom of this file, there is a resource URI token that must be changed when testing locally. This does not need to be changed for other environments.
// Resource strings: you only need to change this for Local. Change the Resource value in the VivaInsights Authentication section with the following string.
// Local: "83649322-5ddc-469b-a1cb-09364798fba8"

// We define 2 "View" functions in this connector:
// 1. VivaInsightsImpl - Row level data download view that returns incremental data from the service. This is the view that should be used for the majority of use cases and is the one that will be called when users select a query.
// 2. VivaInsightsGetResultsImpl - This is a more flexible view that allows users to specify their own parameters for the VivaInsights API. This view is used for calling specific viva insights API.

// Enables caching.
Extension.Cache = try #shared[Extension.Cache] otherwise () => [Metadata = [Serialized = (key, ctor) => ctor()]];

// List of environments supported
Environments = [
    global = "global",
    gcc = "gcc",
    gcc_high = "gcc_high",
    gcc_dod = "gcc_dod"
];

NovaAPIBaseUri = [
    global      = "https://api.analysis.insights.svc.cloud.microsoft/",
    gcc         = "https://api.gcc.analysis.insights.svc.cloud.microsoft/",
    ppe         = "https://api.analysis.insights.svc.cloud.microsoft/",
    gcc_high    = "https://api.analysis.insights.svc.usgovcloud.microsoft/",
    gcc_dod     = "https://api.analysis.dod.insights.svc.usgovcloud.microsoft/"
];

// DebugMode set to true enables diagnostics trace logs
DebugMode = false;

// Helper function to get the resource of a specific environment
Utility.GetUrlWithEnv = (baseUrlList as record, env as text, default as text) as text =>
    let
        baseUrl = Record.FieldOrDefault(baseUrlList, env, default)
    in
        baseUrl;

// FeatureSwitch that defaults to the global cloud
Env = Environment.FeatureSwitch("Cloud", Environments[global]);

// If the env we receive is null or empty we will resort to default environment. 
// Environment override is safe to allow here because the APIs are all authenticated and the environment only controls the base url, so there is no risk of leaking data between environments.
SetGetResultsEnvironment = (optional getResultsEnvironment as text) as text => 
    if (getResultsEnvironment = null or getResultsEnvironment = "") then Env else getResultsEnvironment;

// Derives the Nova environment from the scale unit prefix.
// Falls back to the module-level Env (from FeatureSwitch) if no prefix matches.
GetEnvFromScaleUnit = (scaleUnit as nullable text) as text =>
    if scaleUnit = null then Env
    else if Text.StartsWith(scaleUnit, "novagch", Comparer.OrdinalIgnoreCase) then Environments[gcc_high]
    else if Text.StartsWith(scaleUnit, "novadod", Comparer.OrdinalIgnoreCase) then Environments[gcc_dod]
    else if Text.StartsWith(scaleUnit, "novagcc", Comparer.OrdinalIgnoreCase) then Environments[gcc]
    else Env;

// The getNextPage function takes a single argument and is expected to return a nullable table
// This function is from: https://docs.microsoft.com/en-us/power-query/helperfunctions#tablegeneratebypage
Table.GenerateByPage = (getNextPage as function) as table =>
    let        
        listOfPages = List.Generate(
            () => getNextPage(null),            // get the first page of data
            (lastPage) => lastPage <> null,     // stop when the function returns null
            (lastPage) => getNextPage(lastPage) // pass the previous page to the next function call
        ),
        // concatenate the pages together
        tableOfPages = Table.FromList(listOfPages, Splitter.SplitByNothing(), {"Column1"}),
        firstRow = tableOfPages{0}?
    in
        // if we didn't get back any pages of data, return an empty table
        // otherwise set the table type based on the columns of the first page
        if (firstRow = null) then
            Table.FromRows({})
        else        
            Value.ReplaceType(
                Table.ExpandTableColumn(tableOfPages, "Column1", Table.ColumnNames(firstRow[Column1])),
                Value.Type(firstRow[Column1])
            );

// --------------------------------------------------------------------
// Globals
// --------------------------------------------------------------------

Endpoints = [
    API_REPORT_SUMMARY = (tenantId as text, scopeId as text) => "v1/tenants/" & tenantId & "/scopes/" & scopeId & "/reports/summary?sortByLatestExecuted=true&searchString=",
    API_SIGNED_IN_USER =  "api/Users/SignedInUser",
    API_ROW_DATALOAD = (tenantId as text, scopeId as text, reportId as text) => "v1.0/tenants/" & tenantId & "/scopes/" & scopeId & "/reports/" & reportId & "/result",
    API_ROW_DATALOAD_AND_TABLE = (tenantId as text, scopeId as text, reportId as text, tableName as text) => "v1.0/tenants/" & tenantId & "/scopes/" & scopeId & "/reports/" & reportId & "/result/" & tableName 
];

CacheKeys = [
    SIGNED_IN_USER = () => "SignedInUser",
    DATALOAD_SCHEMA = (reportId as text, optional tableName as text) => if tableName <> null then "DataloadReportSchema" & reportId & "/tableName" & tableName else "DataloadReportSchema" & reportId
];

AcceptHeaders = [
    CSV = "text/csv",
    JSON = "application/json",
    PARQUET = "application/vnd.apache.parquet",
    // Multi-value Accept used for data fetches: the connector advertises both formats it can
    // parse and the server picks one, signaling its choice via the response Content-Type.
    DATA = "application/vnd.apache.parquet, text/csv"
];

// --------------------------------------------------------------------
// Endpoint Selection Functions
// --------------------------------------------------------------------

GetEndpoint = (endpointUri as text, baseUrl as text) as text => baseUrl & endpointUri;

// Dynamically determines which base url to use based on provided scopeId (for VivaInsights.Data function)
// We also handle the case in which the user passes <scopeId>/<jobId> as the scopeId parameter.
// And to solve the refresh credential problem, we will also accept an alternativeScopeId parameter to be used when the scopeId is hardcoded to "VivaInsightsEmbedded"
// Examples of valid calls ParseScopeIdAndPopulateDatasourceViva("<scopeId", null), ParseScopeIdAndPopulateDatasourceViva("<scopeId>/<jobId>", null), ParseScopeIdAndPopulateDatasourceViva("VivaInsightsEmbedded", "<alternativeScopeId>")
ParseScopeIdAndPopulateDatasourceViva = (scopeId as text, optional alternativeScopeId as text, optional alternativeTenantId, optional alternativeScaleUnit) as record =>
    let 
        targetUrl = Utility.GetUrlWithEnv(NovaAPIBaseUri, GetEnvFromScaleUnit(alternativeScaleUnit), NovaAPIBaseUri[global]),
        actualScope = if scopeId = "VivaInsightsEmbedded" then alternativeScopeId else scopeId,
        auxiliaryScopeId = actualScope,
        hasDelimiter = Text.Contains(auxiliaryScopeId, "/"),
        parsedScopeId  = if hasDelimiter then List.First(Text.Split(auxiliaryScopeId, "/")) else auxiliaryScopeId,
        additionalJobId = if hasDelimiter then List.Last(Text.Split(auxiliaryScopeId, "/")) else null
    in
        [
            Url = targetUrl,
            ScopeId = parsedScopeId,
            AdditionalJobId = additionalJobId,
            AlternativeTenantId = alternativeTenantId,
            AlternativeScaleUnit = alternativeScaleUnit
        ];

// We receive the data source as a JSON string. 
// This function parses the JSON and returns the provided scopeId.
ExtractScopeIdFromDataSourcePath = (jsonString as text) as text =>
    let
        jsonDataSource = Json.Document(jsonString)
    in 
        jsonDataSource[scopeId];

// This function parses the JSON and returns the provided alternativeScaleUnit if present and null otherwise.
ExtractScaleUnitFromDataSourcePath = (jsonString as text) =>                                                     
    Json.Document(jsonString)[alternativeScaleUnit]?;

ExtractEnvironmentFromDataSourcePath = (jsonString as text) as text =>
    let
        jsonDataSource = Json.Document(jsonString)
    in
        jsonDataSource[environment];

// --------------------------------------------------------------------
// Connector Implementation
// --------------------------------------------------------------------

WPAImplementation  = let
    // Increment version when changing code.
    CONNECTOR_VERSION = "3.1.0",

    // Helper function for deserializing
    ReadResponseDataType = (apiType as text) as type =>
        let 
            typeMap = #table(type table [ApiType = text, ResultingType = text], {
                { "System.Double", type nullable Double.Type },
                { "DoubleType", type nullable Double.Type },
                { "FloatType", type nullable Double.Type },
                { "System.Int64", type nullable Int64.Type },
                { "System.Int32", type nullable Int32.Type },
                { "IntegerType", type nullable Int32.Type },
                { "System.Int16", type nullable Int16.Type },
                { "ShortType", type nullable Int16.Type },
                { "System.UInt64", type nullable Number.Type },
                { "System.UInt32", type nullable Number.Type },
                { "System.UInt16", type nullable Number.Type },
                { "System.Byte", type nullable Byte.Type },
                { "System.Single", type nullable Single.Type },
                { "System.Decimal", type nullable Decimal.Type },
                { "System.Data.SqlDecimal", type nullable Decimal.Type },
                { "System.TimeSpan", type nullable Duration.Type },
                { "System.DateTime", type nullable DateTime.Type },
                { "TimestampType", type nullable DateTime.Type },
                { "System.String", type nullable Text.Type },
                { "System.Object", type nullable Text.Type },
                { "System.Guid", type nullable Text.Type },
                { "StringType", type nullable Text.Type },
                { "System.Boolean", type nullable Logical.Type },
                { "BooleanType", type nullable Logical.Type },
                { "System.SByte", type nullable Logical.Type }
            }),
            convertedType = typeMap{[ApiType = apiType]}?[ResultingType]?
        in
            convertedType ?? (
                error Error.Record(
                    "DataSource.Error",
                    Text.Format("Unsupported date type '#{0}'", {apiType}))
                ),

    // --------------------------------------------------------------------
    // Shared Function Parameter Definitions
    // --------------------------------------------------------------------
    
    // Defines the parameters for the VivaInsights.Data function.
    VivaInsightsParameters = let
        scopeId = type text meta [
            Documentation.FieldCaption = Extension.LoadString("ScopeIdCaption"),
            Documentation.FieldDescription = Extension.LoadString("ScopeIdDescription"),
            Documentation.SampleValues = {Extension.LoadString("SampleScopeId")}
        ],
        jobName = type text meta [
            Documentation.FieldCaption =  Extension.LoadString("JobNameCaption"),
            Documentation.FieldDescription = Extension.LoadString("JobNameDescription"),
            Documentation.SampleValues = {Extension.LoadString("SampleJobName")}
        ],
        jobId = type text meta [
            Documentation.FieldCaption = Extension.LoadString("JobIdCaption"),
            Documentation.FieldDescription = Extension.LoadString("JobIdDescription"),
            Documentation.SampleValues = {Extension.LoadString("SampleJobId")},
            Formatting.IsMultiLine = true
        ],
        schemaType = type text meta [
            Documentation.FieldCaption = Extension.LoadString("SchemaTypeCaption"),
            Documentation.FieldDescription = Extension.LoadString("SchemaTypeDescription"),
            Documentation.AllowedValues = {Extension.LoadString("SchemaTypePivotedValue")}
        ],
        tableName = type text meta [
            Documentation.FieldCaption = Extension.LoadString("TableNameCaption"),
            Documentation.FieldDescription = Extension.LoadString("TableNameDescription"),
            Documentation.SampleValues = {Extension.LoadString("SampleTableName")}
        ],
        options = type [
            optional SchemaType = schemaType,
            optional TableName = tableName
        ] meta [
            Documentation.FieldCaption = Extension.LoadString("AdvancedParametersValue")
        ]
        in
            type function (scopeId as scopeId, optional jobName as jobName, optional jobId as jobId, optional options as options) as table meta [
                Documentation.Name = Extension.LoadString("DocumentationName"),
                Documentation.LongDescription = Extension.LoadString("LongDescription"),
                Documentation.Examples = {[
                    Description = Extension.LoadString("ExampleDescription"),
                    Code = Extension.LoadString("ExampleCode"),
                    Result = Extension.LoadString("ExampleResult")
            ]}],

    VivaInsightsGetResultsParameters = let
        options = type nullable record,
        env = type nullable text
    in
        type function (optional options as options, optional env as env) as any,

    // --------------------------------------------------------------------
    // Networking, Request Creation, & Response Parsing
    // --------------------------------------------------------------------

    // Executes a web request, forces evaluation and returns the result or the error message.
    // The parser is selected from the response Content-Type rather than a caller-supplied hint:
    // the connector advertises which formats it accepts (see AcceptHeaders) and the server
    // signals its choice on the wire. Today CSV, Parquet, and JSON are supported.
    ExecuteRequest = (url as text, options as record) =>
        let
            content = Web.Contents(url, options & [ManualStatusHandling = {400}]),

            // Binary.Buffer forces evaluation of `content` before any metadata access,
            // otherwise the request can be issued a second time.
            bufferedResponse = Binary.Buffer(content),
            responseHeaders = Value.Metadata(content)[Headers],

            // Normalize Content-Type to a bare media type. HTTP header names are case-insensitive
            // on the wire, so look the field up case-insensitively. Strip parameters (e.g.,
            // "; charset=utf-8"), trim whitespace, and lowercase the media type. Text.Split is used
            // rather than Text.BeforeDelimiter because the latter returns "" when the delimiter is
            // absent, which would mis-dispatch parameter-free Content-Type headers (e.g.,
            // "application/json", "text/csv", "application/vnd.apache.parquet") that the server
            // emits without a charset parameter.
            contentTypeHeaderName = List.First(List.Select(Record.FieldNames(responseHeaders), each Comparer.OrdinalIgnoreCase(_, "Content-Type") = 0), null),
            rawContentType = if contentTypeHeaderName <> null then Record.Field(responseHeaders, contentTypeHeaderName) else "",
            contentType = Text.Lower(Text.Trim(List.First(Text.Split(rawContentType, ";"), ""))),

            // Wrap only the document parsers in `try`, so an unexpected Content-Type surfaces
            // its specific error message instead of the generic "Invalid response" fallback.
            parsedResponse =
                if contentType = AcceptHeaders[CSV] then
                    [Data = try Csv.Document(bufferedResponse) otherwise error "Invalid response", Headers = responseHeaders, ContentType = contentType]
                else if contentType = AcceptHeaders[PARQUET] then
                    [Data = try Parquet.Document(bufferedResponse) otherwise error "Invalid response", Headers = responseHeaders, ContentType = contentType]
                else if contentType = AcceptHeaders[JSON] then
                    try Json.Document(bufferedResponse) otherwise error "Invalid response"
                else
                    error "Unexpected Content-Type: " & contentType,

            httpStatus = Value.Metadata(content)[Response.Status],

            // We specifically handle some errors here and return the error records to the caller.
            // Server contract: 4xx responses return application/json. The JSON-shape guard is
            // defensive in case a misbehaving proxy or server returns a non-JSON 400, so we
            // surface a generic error rather than throwing inside the field accessor.
            errorResponse =
                if (bufferedResponse <> null and httpStatus = 400) then
                    if contentType = AcceptHeaders[JSON] then
                        error Error.Record(
                            "Bad request",
                            parsedResponse[error]?[message]?,
                            [
                                Error = try Record.Field(parsedResponse[error], "@message") otherwise null,
                                Code = parsedResponse[error]?[code]?
                            ]
                        )
                    else
                        error "Bad request"
                else
                    if (httpStatus = 400) then
                        error "Invalid response"
                    else null
        in
            if (errorResponse <> null) then errorResponse else parsedResponse,
    
    // Checks PBI cache for value before executing the fallback function. No response or error handling is performed here.
    ExecuteCacheRequest = (key as text, fallbackFunction as any) =>
        let
            cachedValue = Json.Document(Extension.Cache()[Metadata][Serialized](key, () => Json.FromValue(fallbackFunction())))
        in
            cachedValue,

    // Calls GetJobList twice, separates the response into two sets of MyJobs and AllJobs. Optionally, filter for a search string by job name. 
    // If no jobs are found with the desired name, return all jobs.
    FilterAndSeparateJobs = (dataSourceInfo as record, optional jobName as text) =>
        let
            tenantId = GetTenantId(dataSourceInfo[Url], dataSourceInfo[ScopeId]),
            scaleUnit = GetScaleUnit(dataSourceInfo[Url], dataSourceInfo[ScopeId]),
            baseQueryAllJobs = GetEndpoint(Endpoints[API_REPORT_SUMMARY](tenantId, dataSourceInfo[ScopeId]), dataSourceInfo[Url]),
            searchName = Text.Combine({"searchString", jobName}, "="),
            queryAllJobs = if jobName = null then baseQueryAllJobs 
                           else AddQueryUrl(baseQueryAllJobs, searchName, "&"),
            allJobs = ExecuteRequest(queryAllJobs, [Headers = GetHeaders([scopeId = dataSourceInfo[ScopeId]], true, scaleUnit), Content = Text.ToBinary("null")]),
            allJobsRecord = if Value.Type(allJobs[Response]) = Record.Type then allJobs[Response] 
                            else null,
            allJobsList = if allJobsRecord <> null then {allJobsRecord} 
                          else ExtractListFromJobsJSON(allJobs),
            jobsResult = [AllJobs = allJobsList]
        in
           jobsResult,

    // Executes a request to the SignedInUser API if the value is not already cached.
    GetSignedInUserData = (baseUrl as text, scopeId as text) =>
        let
            // Defines the network request to get SignedInUser data. 
            // This function is nested inside "GetSignedInUserData" to force all calls to check the cache first.
            ExecuteSignedInUserQuery = (baseUrl as text, scopeId as text) =>
                let
                    opts = [Headers = GetHeaders([scopeId = scopeId], false)],
                    url = GetEndpoint(Endpoints[API_SIGNED_IN_USER], baseUrl),
                    json = try ExecuteRequest(url, opts) otherwise null
                in
                    if (json = null) then null else json
        in
            ExecuteCacheRequest(CacheKeys[SIGNED_IN_USER](), () => ExecuteSignedInUserQuery(baseUrl, scopeId)),

    // Gets the current scale unit from the SignedInUser API.
    GetScaleUnit = (baseUrl as text, scopeId as text) =>
        let
            signedInUserResponse = GetSignedInUserData(baseUrl, scopeId)
        in
            if (signedInUserResponse = null or signedInUserResponse[ScaleUnit] = null) then null else signedInUserResponse[ScaleUnit],

    // Gets the current TenantId from the SignedInUserAPI.
    GetTenantId = (baseUrl as text, scopeId as text) =>
        let
            signedInUserResponse = GetSignedInUserData(baseUrl, scopeId)
        in
            try
                List.First(signedInUserResponse[Scopes])[Scope][TenantId]
            otherwise
                null,
    
    // Get (or create) a correlation id to help with logging on the service side.
    GetActivityId = () =>
        let 
            activityId = if (Diagnostics.ActivityId <> null) then Text.From(Diagnostics.ActivityId()) else Text.NewGuid()
        in
            activityId,

    // Returns headers used on our API calls. Can receive optional extra headers as a separate record to be combined
    // For testing on PPE, add test tenant id header
    GetHeaders = (extraHeaders as record, usingRowLevelApi as logical, optional scaleUnit as text) =>
    let
        GetTestTenantId = "[Nova TenantId]",

        baseHeaders = Record.Combine({[#"api-Version" = "1.0", #"correlationId" = GetActivityId(), #"x-ms-client-version" = CONNECTOR_VERSION], extraHeaders}),

        finalHeaders = if not usingRowLevelApi then Record.Combine({extraHeaders, [#"Content-Type" = "application/json"]}) else extraHeaders
    in
        if scaleUnit = null then finalHeaders else Record.AddField(finalHeaders, "X-Nova-Scaleunit", scaleUnit),
    
    // Adds a query to an URL. Specify either ? or & separator accordingly if its the first query or not
    AddQueryUrl = (url, parameter, separator) => Text.Combine({url, parameter}, separator),

    // Call producer after interval passes, repeat count times or untill producer returns non-null. Returns either null or the first instance of producer to give a result
    Value.WaitFor = (producer as function, interval as function, optional count as number) as any =>
        let
            list = List.Generate(
                () => {0, null},
                (state) => state{0} <> null and (count = null or state{0} < count),
                (state) => if state{1} <> null then {null, state{1}} else {1 + state{0}, Function.InvokeAfter(() => producer(), interval())},
                (state) => state{1})
        in
            List.Last(list),

    // Keeps retrying a web request every second for 10 minutes or until it returns the expected value
    WaitAndRetryRequest = (url as text, options as record, expectedValue) =>
        let
            waitForResult = Value.WaitFor(
                () =>
                    let
                        // IsRetry is needed, otherwise PowerBI will be stuck waiting without actually retrying the call
                        result = ExecuteRequest(url, options & [IsRetry = true]), 
                        actualResult = if result = expectedValue then true else null
                    in
                        actualResult,
                () => #duration(0, 0, 0, 5),
                600)
        in
            if waitForResult = true then true else false,

    // Read the response from the GetJobList API and return it in list of job records form
    ExtractListFromJobsJSON = (json) as list =>
        let
            outerList = json[Response],
            f = (_) =>
                let
                    name = if _[Name] <> null then _[Name] else "Unknown",
                    reportId = if _[ReportId] <> null then _[ReportId] else "Unknown",
                    rec = [Name = name, ReportId = reportId, JobId = reportId, ItemKind = type table] 
                in
                    rec,
            innerList = List.RemoveMatchingItems(List.Transform(outerList, f), {null})
        in
            innerList,
           
    // --------------------------------------------------------------------
    // View Functions
    // --------------------------------------------------------------------
    
    // Main view for Row-Level Dataload API
    RowLevelDataView = (datasourceRecord as record, jobId as text, schemaType as text, optional tableName as text) =>
        let
            // For this function to be called, the request must be in Nova with a valid jobId
            scopeId = datasourceRecord[ScopeId],
            baseUrl = datasourceRecord[Url],
            usingRowLevelApi = true,

            // Get Scale Unit information (unless it is already provided in the datasource record)
            currentScaleUnit = if datasourceRecord[AlternativeScaleUnit] <> null then datasourceRecord[AlternativeScaleUnit] else GetScaleUnit(baseUrl, scopeId),
            tenantId = if datasourceRecord[AlternativeTenantId] <> null then datasourceRecord[AlternativeTenantId] else GetTenantId(baseUrl, scopeId),

            // Steps:
            // 1. Get "cached schema" since it won't change.
            // 2. Use Query Folding function to load actual data. The server picks Parquet or CSV
            //    via Accept negotiation; ExecuteRequest dispatches the parser on response Content-Type.
            endpoint = if tableName <> null then GetEndpoint(Endpoints[API_ROW_DATALOAD_AND_TABLE](tenantId, scopeId, jobId, tableName), baseUrl) else GetEndpoint(Endpoints[API_ROW_DATALOAD](tenantId, scopeId, jobId), baseUrl),
            schemaInfo = GetSchema(endpoint, currentScaleUnit, scopeId),
            reportSchema = schemaInfo[SchemaTable]?,
            reportSchemaTypes = schemaInfo[SchemaTypes]?,

            // Functions

            // Gets the table schema from the cache (if availabe), otherwise requests the schema from the API.
            GetSchema = (schemaUrl as text, scaleUnit as text, scopeId as text) =>
                let
                    // Parses schema from API response into a PowerQuery table object with 0 rows.
                    ParseRawDataloadSchemaResponse = (schemaJson) =>
                        let
                            columnNames = List.Transform(schemaJson, (element) => element[Name]),
                            columnDataTypes = List.Transform(schemaJson, (element) => ReadResponseDataType(Text.From(element[DataType]))),
                            zippedSchema = List.Zip({columnNames, columnDataTypes}),
                            schemaTable = #table(columnNames, {}),
                            typedSchemaTable = Table.TransformColumnTypes(schemaTable, zippedSchema, "")
                        in
                            [SchemaTypes = zippedSchema, SchemaTable = typedSchemaTable],
                    
                    // Send API request when the cache doesn't already contain the requested schema.
                    // Returns parsed schema.
                    ExecuteSchemaRequest = () =>
                        let
                            schemaHeaders = GetHeaders([#"Accept" = AcceptHeaders[JSON]], usingRowLevelApi, scaleUnit),
                            rawSchema = ExecuteRequest(schemaUrl, [Headers = schemaHeaders])
                        in
                            rawSchema,
                    
                    // Check cache, otherwise send API request.
                    rawSchema = ExecuteCacheRequest(CacheKeys[DATALOAD_SCHEMA](jobId, tableName), ExecuteSchemaRequest),
                    parsedSchema = ParseRawDataloadSchemaResponse(rawSchema)
                in
                    parsedSchema,
            
            // Gets data table from API.
            GetData = (dataUrl as text, scaleUnit as text, scopeId as text, optional startDate as text, optional endDate as text) =>
                let
                    // If available, returns the continuation token in a Dataload API response.
                    CheckForNextPage = (optional headers as record) => if (headers <> null) then Record.FieldOrDefault(headers, "X-ContinuationToken") else null,

                    // Append queries to base Dataload API url.
                    BuildDataQueryUrl = (baseUrl as text, optional continuationToken as text) =>
                        let
                            continuationTokenQuery = if continuationToken <> null then "continuationToken=" & continuationToken else null,
                            startDateQuery = if startDate <> null then "startTime=" & startDate else null,
                            endDateQuery = if endDate <> null then "endTime=" & endDate else null,
                            availableQueries = Text.Combine({continuationTokenQuery, startDateQuery, endDateQuery}, "&")
                        in
                            if availableQueries = "" then baseUrl else baseUrl & "?" & availableQueries,
                    
                    // Executes a Web.Contents() GET request for a single page of the dataset.
                    // Advertises both Parquet and CSV; the server picks one and signals its choice
                    // via the response Content-Type, which ParseRawData then dispatches on.
                    ExecuteDataPageRequest = (optional continuationToken as text) =>
                        let
                            acceptHeader = [#"Accept" = AcceptHeaders[DATA]],

                            headers = GetHeaders(acceptHeader, usingRowLevelApi, scaleUnit),
                            requestUrl = BuildDataQueryUrl(dataUrl, continuationToken),
                            response = ExecuteRequest(requestUrl, [Headers = headers])
                        in
                            response,

                    // For CSV pages, promote headers and apply schema-driven types.
                    // For Parquet pages, the table is already fully typed by Parquet.Document and is returned as-is.
                    ParseRawData = (page as record) =>
                        if page[ContentType] = AcceptHeaders[PARQUET] then
                            page[Data]
                        else
                            let
                                promotedHeaders = Table.PromoteHeaders(page[Data])
                            in
                                if reportSchemaTypes = null then promotedHeaders
                                else
                                    let
                                        orderedColumns = List.Transform(reportSchemaTypes, (item) => item{0}),
                                        orderedDataTable = Table.ReorderColumns(promotedHeaders, orderedColumns, MissingField.Error),
                                        dataWithTypes = Table.TransformColumnTypes(orderedDataTable, reportSchemaTypes, "")
                                    in
                                        dataWithTypes,

                    // Calls the Dataload API as many times as necessary to fetch the full dataset associated with the provided jobId.
                    ExecuteDataRequest = () =>
                        Table.GenerateByPage((previous) =>
                            let
                                continuationToken = if previous <> null then Value.Metadata(previous)[ContinuationToken]? else null,
                                currentPage = if (continuationToken = null and previous <> null) then null else ExecuteDataPageRequest(continuationToken),

                                parsedDataPage = if (currentPage <> null) then ParseRawData(currentPage) else null,
                                nextToken = CheckForNextPage(currentPage[Headers]?)
                            in
                                parsedDataPage meta [ContinuationToken = nextToken]
                        ),

                    dataTable = ExecuteDataRequest()
                in
                    dataTable,

            // Support for query folding.
            DataloadQueryFolding = (state as record) => Table.View(null, [
                        GetType = () => if reportSchema <> null then Value.Type(reportSchema) else Value.Type(GetRows()),
                        GetRows = () =>
                            let
                                // Build and send request to the Dataload API.
                                requestResults = GetData(endpoint, currentScaleUnit, scopeId, state[StartDate]?, state[EndDate]?),

                                // Further filter the returned data table if possible.
                                startDate = DateTime.FromText(state[StartDate]?),
                                endDate = DateTime.FromText(state[EndDate]?),
                                startDateOperatorText = state[StartDateOperator]?,
                                endDateOperatorText = state[EndDateOperator]?,
                                filteredResults = if startDate <> null and startDateOperatorText <> null and endDate <> null and endDateOperatorText <> null then
                                        if startDateOperatorText = "GreaterThan" and endDateOperatorText = "LessThan" then Table.SelectRows(requestResults, each [MetricDate] > startDate and [MetricDate] < endDate)
                                        else if startDateOperatorText = "GreaterThanOrEquals" and endDateOperatorText = "LessThan" then Table.SelectRows(requestResults, each [MetricDate] >= startDate and [MetricDate] < endDate)
                                        else if startDateOperatorText = "GreaterThan" and endDateOperatorText = "LessThanOrEquals" then Table.SelectRows(requestResults, each [MetricDate] > startDate and [MetricDate] <= endDate)
                                        else if startDateOperatorText = "GreaterThanOrEquals" and endDateOperatorText = "LessThanOrEquals" then Table.SelectRows(requestResults, each [MetricDate] >= startDate and [MetricDate] <= endDate)
                                        else requestResults
                                    else if startDate <> null and startDateOperatorText <> null then
                                        if startDateOperatorText = "GreaterThan" then Table.SelectRows(requestResults, each [MetricDate] > startDate)
                                        else if startDateOperatorText = "GreaterThanOrEquals" then Table.SelectRows(requestResults, each [MetricDate] >= startDate)
                                        else requestResults
                                    else if endDate <> null and endDateOperatorText <> null then
                                        if endDateOperatorText = "LessThan" then Table.SelectRows(requestResults, each [MetricDate] < endDate)
                                        else if endDateOperatorText = "LessThanOrEquals" then Table.SelectRows(requestResults, each [MetricDate] <= endDate)
                                        else requestResults
                                    else requestResults
                            in                             
                                filteredResults,

                        OnSelectRows = (selector) =>
                            let
                                // We need to convert DateTime data into a string compatible with the Dataload API.
                                ConvertDateToString = (invocationExpression) => 
                                    let
                                        // Put datetime from query into a standard format for query URL.
                                        year = Text.From(invocationExpression{0}[Value]),
                                        month = Text.From(invocationExpression{1}[Value]),
                                        day = Text.From(invocationExpression{2}[Value])
                                    in
                                        // Ex. 2022-06-07
                                        Text.Combine({year, month, day}, "-"),
                                
                                // Parse the rowExpression tree for a single date selector.
                                ParseSingleDateSelector = (rowExpression) =>
                                    let
                                        // Example PowerQuery captured here: Table.SelectRows(dataTable, each [MetricDate] > #datetime(2021, 12, 19))
                                        expressionKind = rowExpression[Kind]?,
                                        operator = rowExpression[Operator]?,
                                        leftName = rowExpression[Left]?[MemberName]?,
                                        leftKind = rowExpression[Left]?[Kind]?,
                                        rightKind = rowExpression[Right]?[Kind]?,

                                        dateString = if rightKind = "Invocation" then ConvertDateToString(rowExpression[Right][Arguments])
                                                    else if rightKind = "Constant" then DateTime.ToText(rowExpression[Right][Value], [Format="yyyy-MM-dd"]) else ...
                                    in
                                        // We only want to capture selectors with the [MetricDate] column.
                                        // If conditions aren't met, throw an error to fallback to the standard M Engine calculation.
                                        // More details: https://docs.microsoft.com/en-us/power-query/handlingqueryfolding
                                        if expressionKind = "Binary" and leftKind = "FieldAccess" and leftName = "MetricDate"
                                        then if (operator = "GreaterThan" or operator = "GreaterThanOrEquals") 
                                                then [StartDate = dateString, StartDateOperator = operator]
                                                else if (operator = "LessThan" or operator = "LessThanOrEquals") 
                                                    then [EndDate = dateString, EndDateOperator = operator]
                                                    else ...
                                        else ...,

                                // Parse the rowExpression tree for a compound date selector.
                                // Specifically, we support setting an upper and lower bound on the [MetricDate] column.
                                ParseCompoundDateSelector = (rowExpression) =>
                                    let
                                        // Incremental refresh can create an upper and lower bound on time. This handles the case where both are included in the rowExpression.
                                        // Split compound expression into two single operator rowExpressions.
                                        compoundOperator = rowExpression[Operator]?,
                                        leftKind = rowExpression[Left]?[Kind]?,
                                        leftOperator = rowExpression[Left]?[Operator]?,
                                        rightKind = rowExpression[Right]?[Kind]?,
                                        rightOperator = rowExpression[Right]?[Operator]?,

                                        // Parse the upper and lower time bounds separately. If anything goes wrong, throw error to fallback to the standard M Engine calculation.
                                        // rowExpressions that we don't want to handle in query folding are caught in ParseSingleDateSelector().
                                        leftState = try ParseSingleDateSelector(rowExpression[Left]?) otherwise ...,
                                        rightState = try ParseSingleDateSelector(rowExpression[Right]?) otherwise ...
                                    in
                                        // Combine each state since no updated keys should overlap (one updates StartDate, the other updates EndDate).
                                        leftState & rightState,

                                // Try parsing the rowExpression. If the selector isn't supported, we fall back to the standard M Engine implementation.
                                rowExpression = RowExpression.From(selector),
                                updatedState = try ParseSingleDateSelector(rowExpression) 
                                        otherwise try ParseCompoundDateSelector(rowExpression) 
                                            otherwise ...
                            in
                                @DataloadQueryFolding(state & updatedState)
            ])
        in
            DataloadQueryFolding([StartDate=null, EndDate=null, StartDateOperator=null, EndDateOperator=null]),       

    VivaInsightsNavigation = (datasourceInformation as record, optional jobName as text, optional schemaType as text) =>
        let
            GetJobs = (scopeId as text) => FilterAndSeparateJobs(datasourceInformation, jobName)[AllJobs],
                    
            // In order to have the dropdown where we separate the queries by category, we need to have our main navigation table have navtables
            // as elements (See https://github.com/microsoft/DataConnectors/blob/master/samples/NavigationTable/NavigationTable.pq). So we have 
            // separate functions to generate the elements, but they route their items to the same RowLevelDataView. 

            // In order to reuse code, we have to assign an ID (like the reportId) to all elements of the table. This uses 1-2-3-4, assuming these cant be 
            // real job IDs
            GenerateAllIFQList = (scopeId as text) => GetJobs(scopeId),
            
            // Generates the first level of items for the Navigation Table
            GenerateClasses = (scopeId as text) =>
                let
                    classes = {[Name = "All Custom Queries", ItemKind = "Folder", ReportId = "1", JobId = "1"]}
                in
                    classes,

            // Fills the elements created by GenerateClasses
            PopulateClasses = (datasourceInformation as record, tableId as text, schemaType as text) =>
                let     
                    tableElements = GenerateAllIFQList,
                    tableDataSource = RowLevelDataView
                in
                    NavigationTableFromList(tableElements, tableDataSource, datasourceInformation),

            // Generic Helpers
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
                    navigationTable,

            // This came mostly from the Kusto powerbi connector 
            // For the navigation table capabilities, listFunction should generate the items of the table, and dataFunction should be the behaviour to
            // be called when the item is selected.
            NavigationTableFromList = (listFunction as function, dataFunction as function, datasourceInformation as record, optional isLeaf as logical) as table =>
                    let
                        _isLeaf = if (isLeaf = null) then true else isLeaf,
                        itemKind = if (_isLeaf) then "Table" else "Database",
                        View = (state) => Table.View(null, [
                        
                            GetType = () => 
                                let
                                    tableType = type table [ Name = text, JobId = text , ItemKind = text, Data = table, ItemName = text, IsLeaf = logical ],
                                    withKey = Type.AddTableKey(tableType, {"JobId"}, true)
                                in
                                    withKey meta
                                    [
                                        NavigationTable.NameColumn = "Name",
                                        NavigationTable.DataColumn = "Data",
                                        NavigationTable.ItemKindColumn = "ItemKind",
                                        Preview.DelayColumn = "ItemName",
                                        NavigationTable.IsLeafColumn = "IsLeaf"
                                    ],

                            GetRows = () =>                           
                                    let
                                        list = listFunction(datasourceInformation[ScopeId]),
                                        withName = Table.FromRecords(list, {"Name", "JobId", "ItemKind"}),
                                        withData = Table.AddColumn(withName, "Data", each dataFunction(datasourceInformation, [JobId], schemaType)),
                                        withItemName = Table.AddColumn(withData, "ItemName", each "Table"),
                                        withIsLeaf = Table.AddColumn(withItemName, "IsLeaf", each isLeaf),
                                        navTable = Table.ToNavigationTable(withIsLeaf, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
                                    in
                                        navTable,
                            OnSelectRows = (selector) =>
                                let
                                    condition = RowExpression.From(selector),
                                    kind = condition[Kind],
                                    leftKind = condition[Left][Kind],
                                    member = condition[Left][MemberName],
                                    value = condition[Right][Value]
                                in
                                    if (kind = "Binary" and leftKind = "FieldAccess" and member = "JobId") then
                                        Table.FromRecords({[
                                            Name = value,
                                            Data = dataFunction(datasourceInformation, value, schemaType),
                                            ItemKind = "Table",
                                            ItemName = value,
                                            IsLeaf = true
                                        ]})
                                    else
                                        ...
                                    ])
                in
                    View(null),
                    
            navigationView = NavigationTableFromList(GenerateClasses, PopulateClasses, datasourceInformation, false)
        in
            navigationView,   
   
    //-------------------------------------------
    // Shared Function Parameter Handlers
    //-------------------------------------------
    
    /* Method for calling a generic API, with customizable options, optional responseType and optional environment (will default to prod).
    *  options: The options desired for the API call. 
    *     options.Query: Used to set the value of query parameters in the api call
    *     options.RelativePath: Used to set the value of the relative path that will be appended to the base url
    *     options.Content: Content for the request (request type will be set to POST by Web.Contents if this field is set)
    *  env: The environment to call (prod, ppe, dev, gcc, ...)
    */
    VivaInsightsGetResultsImpl = (optional options as record, optional env as text) =>
    let
        // Logic to get the complete base url
        novaUrl = Utility.GetUrlWithEnv(NovaAPIBaseUri, SetGetResultsEnvironment(env), NovaAPIBaseUri[global]),

        // Filtering elements that we allow the user to pass (based on https://learn.microsoft.com/en-us/powerquery-m/web-contents#about)
        filteredOptions = if options <> null then Record.SelectFields(options, {"Headers", "Query", "RelativePath", "Content"}, MissingField.Ignore) else [],

        // Get any headers from filtered options
        optionsHeaders = Record.FieldOrDefault(filteredOptions, "Headers", []),

        // For security reasons we restrict the headers that we allow the user to pass. In the future we might extend this list without breaking backward compatibility.
        filteredOptionHeaders = Record.SelectFields(optionsHeaders, {"scopeId", "tenantId", "x-nova-scaleunit"}, MissingField.Ignore),

        // Get the headers by calling GetHeaders with scopeId and any extra headers
        headers = GetHeaders(filteredOptionHeaders, false),

        // Function to combine the headers
        transformHeaders = (old_headers as record) => Record.Combine({old_headers, headers}), 

        // Update options with the headers
        updatedOptions = if Record.HasFields(options, "Headers") then Record.TransformFields(options, {{"Headers", transformHeaders}}) else Record.AddField(options, "Headers", Record.Combine({Record.FieldOrDefault(options, "Headers", []), headers})),

        // Execute the request received
        response = Web.Contents(novaUrl, updatedOptions)
    in
        Value.ReplaceMetadata(response, []),
    
    // Responsible for calling the correct "View" function based on the parameters provided by the user.
    // This function is intended to parse arguments for the "VivaInsights.Data" shared function.
    VivaInsightsImpl = (scopeId as text, optional jobName as text, optional jobId as text, optional options as record) =>
        let
            // Parse parameters.
            dataSourceInformation = ParseScopeIdAndPopulateDatasourceViva(scopeId, options[alternativeScopeId]?, options[alternativeTenantId]?, options[alternativeScaleUnit]?),
            schemaType = Extension.LoadString("SchemaTypePivotedValue"), // Post 3/23 DQ Is deprecated so only pivoted schema is supported.
            tableName = if options[TableName]? = null then null else options[TableName],
            
            // In this case, if the user enters a scopeId with the format <scopeId>/<jobId>, we want to use the jobId provided by the user. Unless the jobId parameter has already been provided in the UI.
            jobId = if jobId <> null then jobId else dataSourceInformation[AdditionalJobId],

            // Select the correct "View" function depending on the provided parameters. Invalid parameter combinations should throw an error.
            finalView = 
                // Case 1: No jobId or jobName provided. We want to return the TenantId to show connection is possible, but we don't want to return any data.
                if jobId = null and jobName = null then GetTenantId(dataSourceInformation[Url], dataSourceInformation[ScopeId])
                // Case 2: jobName provided but no jobId. This means the user wants to search and select a job.
                else if jobId = null and jobName <> null then VivaInsightsNavigation(dataSourceInformation, jobName, schemaType)
                // Case 3: jobId provided (either directly by the user, or selected from the navigation). In this case we want to return the data for the job provided.
                else RowLevelDataView(dataSourceInformation, jobId, schemaType, tableName)
        in
            finalView
in
    [
        VivaInsightsImpl = VivaInsightsImpl,
        VivaInsightsGetResultsImpl = VivaInsightsGetResultsImpl,
        VivaInsightsGetResultsParameters = VivaInsightsGetResultsParameters,
        VivaInsightsType = VivaInsightsParameters
    ];

// Entry Point - Note that this cannot change, or older reports will stop working.
[DataSource.Kind = "VivaInsights", Publish = "VivaInsights.Publish"]
shared VivaInsights.Data = Value.ReplaceType(WPAImplementation[VivaInsightsImpl], WPAImplementation[VivaInsightsType]);

[DataSource.Kind = "VivaInsightsApi"]
shared VivaInsightsApi.GetResults = Value.ReplaceType(WPAImplementation[VivaInsightsGetResultsImpl], WPAImplementation[VivaInsightsGetResultsParameters]);

GetAuthorizationUrlFromWwwAuthenticateGetResults = (baseUrl as text) as text => 
    let
        // Sending an unauthenticated request to workplace analytics service root returns
        // a 302 status with WWW-Authenticate header in the response. The value will
        // contain the correct authorization_uri. Handling 401 as well for future changes in service.
        // 
        // Example:
        // Bearer authorization_uri="https://login.microsoftonline.com/{tenant_guid}/oauth2/authorize"
        responseCodes = {302, 401},
        endpointResponse = Web.Contents(baseUrl, [
            ManualCredentials = true,
            ManualStatusHandling = responseCodes
        ])
    in
        if (List.Contains(responseCodes, Value.Metadata(endpointResponse)[Response.Status]?)) then
            let
                headers = Record.FieldOrDefault(Value.Metadata(endpointResponse), "Headers", []),

                wwwAuthenticate = Record.FieldOrDefault(headers, "WWW-Authenticate", ""),
                authorizationUri = if (wwwAuthenticate <> "") then
                let
                    split = Text.Split(Text.Trim(wwwAuthenticate), " ")
                in
                    List.First(List.Select(split, each Text.Contains(_, "authorization_uri=")), null)
                else
                    Record.FieldOrDefault(headers, "Location", null)
            in
                if (authorizationUri <> null) then
                    // Trim and replace the double quotes inserted before the url OWIN returns 
                    if (wwwAuthenticate <> "") then
                        Text.Replace(Text.Trim(Text.Trim(Text.AfterDelimiter(authorizationUri, "=")), ","), """", "")
                    else
                        let
                            authUriParts = Uri.Parts(authorizationUri)
                        in
                            "https://" & Text.Combine({authUriParts[Host], authUriParts[Path]})
                else
                    error Error.Record("Error", Extension.LoadString("Error_UnexpectedAuthenticateHeader"), [
                        #"WWW-Authenticate" = wwwAuthenticate
                    ])
        else
            error Error.Unexpected(Extension.LoadString("Error_UnexpectedAuthorizationUrlDiscovery"));


GetAuthorizationUrlFromWwwAuthenticate = (dataSource as text) as text => 
    let
        // Sending an unauthenticated request to workplace analytics service root returns
        // a 302 status with WWW-Authenticate header in the response. The value will
        // contain the correct authorization_uri. Handling 401 as well for future changes in service.
        // 
        // Example:
        // Bearer authorization_uri="https://login.microsoftonline.com/{tenant_guid}/oauth2/authorize"
        url = ParseScopeIdAndPopulateDatasourceViva(dataSource)[Url],

        responseCodes = {302, 401},
        endpointResponse = Web.Contents(url, [
            ManualCredentials = true,
            ManualStatusHandling = responseCodes
        ])
    in
        if (List.Contains(responseCodes, Value.Metadata(endpointResponse)[Response.Status]?)) then
            let
                headers = Record.FieldOrDefault(Value.Metadata(endpointResponse), "Headers", []),

                wwwAuthenticate = Record.FieldOrDefault(headers, "WWW-Authenticate", ""),
                authorizationUri = if (wwwAuthenticate <> "") then
                let
                    split = Text.Split(Text.Trim(wwwAuthenticate), " ")
                in
                    List.First(List.Select(split, each Text.Contains(_, "authorization_uri=")), null)
                else
                    Record.FieldOrDefault(headers, "Location", null)
            in
                if (authorizationUri <> null) then
                    // Trim and replace the double quotes inserted before the url OWIN returns 
                    if (wwwAuthenticate <> "") then
                        Text.Replace(Text.Trim(Text.Trim(Text.AfterDelimiter(authorizationUri, "=")), ","), """", "")
                    else
                        let
                            authUriParts = Uri.Parts(authorizationUri)
                        in
                            "https://" & Text.Combine({authUriParts[Host], authUriParts[Path]})
                else
                    error Error.Record("Error", Extension.LoadString("Error_UnexpectedAuthenticateHeader"), [
                        #"WWW-Authenticate" = wwwAuthenticate
                    ])
        else
            error Error.Unexpected(Extension.LoadString("Error_UnexpectedAuthorizationUrlDiscovery"));

GetResourceFromDataSourcePathGetResults = (baseUrl as text) as text =>
    let
        resourceUrl = baseUrl
    in
        Text.TrimEnd(resourceUrl, "/");

// Data Source Kind description for VivaInsights shared function.
VivaInsights = [
    Type = "Custom",
    // MakeResoucePath allows us to use the alternativeScopeId parameter (that was previously not part of the datasource path).
    MakeResourcePath = (scopeId, optional options) =>
        let
            scaleUnit = if options <> null then options[alternativeScaleUnit]? else null,
            path =
                if scopeId = "VivaInsightsEmbedded" then
                    if (options <> null and options[alternativeScopeId]? <> null) then
                        if scaleUnit <> null then
                            [ scopeId = options[alternativeScopeId], alternativeScaleUnit = scaleUnit ]
                        else
                            [ scopeId = options[alternativeScopeId] ]
                    else error Error.Record(
                        "DataSource.Error",
                        "AlternativeScopeId parameter was not provided."
                    )
                else
                    if scaleUnit <> null then
                        [ scopeId = scopeId, alternativeScaleUnit = scaleUnit ]
                    else
                        [ scopeId = scopeId ]
        in
            Text.FromBinary(Json.FromValue(path)),
    ParseResourcePath = (resourcePath) => {resourcePath},
    TestConnection = (dataSourcePath) => {"VivaInsights.Data", ExtractScopeIdFromDataSourcePath(dataSourcePath), null, null, [alternativeScaleUnit = ExtractScaleUnitFromDataSourcePath(dataSourcePath)]},
    Authentication = [
        Aad = [
            AuthorizationUri = (dataSource) => 
                let
                    parsedDataSource = ExtractScopeIdFromDataSourcePath(dataSource)
                in
                    GetAuthorizationUrlFromWwwAuthenticate(parsedDataSource),
            Resource = (dataSource) => "9d827643-d003-4cca-9dc8-71213a8f1644", // 1P App: Workplace Analytics
                // When testing PPE, hardcode the resource to be equal to "01f9d889-ee31-41cb-85fa-3ad7e0981fa1"                
            Label = Extension.LoadString("AuthenticationLabel")
        ]
    ],
    IsKnownEndpoint = (resource) => true,
    Label = Extension.LoadString("DataSourceLabel")
];

VivaInsightsApi = [
    Type = "Custom",
    MakeResourcePath = (optional env as text) => SetGetResultsEnvironment(env),
    ParseResourcePath = (resourcePath) => {resourcePath},
    TestConnection = (dataSourcePath) => {"VivaInsightsApi.GetResults", [], dataSourcePath},
    Authentication = [  
        Aad = [
            AuthorizationUri = (dataSource) => 
                let
                    url = Utility.GetUrlWithEnv(NovaAPIBaseUri, SetGetResultsEnvironment(dataSource), NovaAPIBaseUri[global])
                in
                    GetAuthorizationUrlFromWwwAuthenticateGetResults(url),
            Resource = (dataSource) => 
                let
                    url = Utility.GetUrlWithEnv(NovaAPIBaseUri, SetGetResultsEnvironment(dataSource), NovaAPIBaseUri[global])
                in
                    GetResourceFromDataSourcePathGetResults(url),
            Label = Extension.LoadString("AuthenticationLabel")
        ]
    ],
    IsKnownEndpoint = (resource) => true,
    Label = Extension.LoadString("DataSourceLabel")
];

// Data Source UI publishing description
VivaInsights.Publish = [
    Beta = false,
    Category = Extension.LoadString("Category"),
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    SupportsDirectQuery = false,
    SourceImage = VivaInsights.Icons,
    SourceTypeImage = VivaInsights.Icons
];

VivaInsights.Icons = [
    Icon16 = { Extension.Contents("VivaInsights_logo_16px.png"), Extension.Contents("VivaInsights_logo_20px.png"), Extension.Contents("VivaInsights_logo_24px.png"), Extension.Contents("VivaInsights_logo_32px.png") },
    Icon32 = { Extension.Contents("VivaInsights_logo_40px.png"), Extension.Contents("VivaInsights_logo_48px.png"), Extension.Contents("VivaInsights_logo_64px.png"), Extension.Contents("VivaInsights_logo_80px.png") }
];

/*
This code section is required for leveraging the Diagnostics.pqm functions for logging information to the Diagnostics.Trace.
Instructions for using Diagnostics.Trace
1 - Enable tracing in the Diagnostics tab in Power BI Desktop
2 - Make sure that your calls to Diagnostics.LogValue(...) are being evaluated, M language is lazy by default so if it's not evaluated no message will be written in the logs.
3 - After running the sideloaded version of the connector with the LogValue changes, go to Power BI Desktop settings -> Diagnostics -> There will be a hyperlink to open your traces folder, there you'll find the logged messages.
*/

Extension.LoadFunction = (name as text) =>
    let
        binary = Extension.Contents(name),
        asText = Text.FromBinary(binary)
    in
        Expression.Evaluate(asText, #shared);

// Diagnostics module contains multiple functions. We can take the ones we need.
Table.ChangeType = Extension.LoadFunction("Table.ChangeType.pqm");
Diagnostics = Extension.LoadFunction("Diagnostics.pqm");
Diagnostics.LogValue = 
    if DebugMode
    then Diagnostics[LogValue]
    else (prefix, value) => value;
Diagnostics.LogFailure = Diagnostics[LogFailure];
Diagnostics.WrapHandlers = Diagnostics[WrapHandlers];
Diagnostics.ValueToText = Diagnostics[ValueToText];
Diagnostics.ValueToText2 = Diagnostics[ValueToText2];