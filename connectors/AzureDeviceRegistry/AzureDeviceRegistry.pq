// This file contains your Data Connector logic
[Version = "1.0.3"]
section AzureDeviceRegistry;
Diagnostics = Extension.LoadFunction("Diagnostics.pqm");
QueryHelper = Extension.LoadFunction("QueryHelper.pqm");
CommonFunctions = Extension.LoadFunction("CommonFunctions.pqm");
Diagnostics.LogValue = Diagnostics[LogValue];
Diagnostics.LogFailure = Diagnostics[LogFailure];
Asset.Query = QueryHelper[AssetQuery];
Asset.BasicSchema = QueryHelper[AssetSchema];
Device.Query = QueryHelper[DeviceQuery];
Device.BasicSchema = QueryHelper[DeviceSchema];

// common functions/constants
GenerateByPage = CommonFunctions[GenerateByPage];
AuthorizationUriForARG = CommonFunctions[AuthorizationUriForARG];//"https://login.microsoftonline.com/common/oauth2/authorize";
AzureResourceManagerUri = CommonFunctions[AzureResourceManagerUri] ;//"https://management.azure.com/";
AzureResourceGraphUri = CommonFunctions[AzureResourceGraphUri];//Uri.Combine(AzureResourceManagerUri, "/providers/Microsoft.ResourceGraph/resources");
TruncatedResultPageSize = CommonFunctions[TruncatedResultPageSize]; //100;
DefaultPageSize = CommonFunctions[DefaultPageSize]; //100;
MaxPageSize = CommonFunctions[MaxPageSize]; //1000;
SchemaTransformTable = CommonFunctions[SchemaTransformTable];
TableNames.Asset = CommonFunctions[TableNames.Asset];
TableNames.Device = CommonFunctions[TableNames.Device];
MaxNoOfCustomAttributes = CommonFunctions[MaxNoOfCustomAttributes];
MaxNoOfSubscriptions = CommonFunctions[MaxNoOfSubscriptions];
MaxNoOfNamespaces = CommonFunctions[MaxNoOfNamespaces];
ValidateIfTextContainsSpecialCharacters = CommonFunctions[ValidateIfTextContainsSpecialCharacters];

DefaultRequestHeaders = [
    #"Accept" = "application/json;odata.metadata=minimal",  // column name and values only
    #"OData-MaxVersion" = "4.0"                             // we only support v4
];

// Data Source Kind description
AzureDeviceRegistry = [
    Type = "Singleton",
    MakeResourcePath = () => "AzureDeviceRegistry",
    ParseResourcePath = (dataSourcePath) => { },
    TestConnection = (dataSourcePath) => {"AzureDeviceRegistry.Query", "Tenant"},
    Authentication = [
      Aad = [
            AuthorizationUri = Uri.Combine(GetEndpointConfig()[AzureActiveDirectory], "/common/oauth2/authorize"),
            Resource = GetEndpointConfig()[AzureResourceManagerResource]
        ]
    ],
    Label = Extension.LoadString("Title")
];

// Data Source UI publishing description
AzureDeviceRegistry.Publish = [
    Beta = true,
    Category = "Azure",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    SourceImage = AzureDeviceRegistry.Icons,
    SourceTypeImage = AzureDeviceRegistry.Icons
];

AzureDeviceRegistry.Icons = [
    Icon16 = { Extension.Contents("AzureDeviceRegistry16.png"), Extension.Contents("AzureDeviceRegistry20.png"), Extension.Contents("AzureDeviceRegistry24.png"), Extension.Contents("AzureDeviceRegistry32.png") },
    Icon32 = { Extension.Contents("AzureDeviceRegistry32.png"), Extension.Contents("AzureDeviceRegistry40.png"), Extension.Contents("AzureDeviceRegistry48.png"), Extension.Contents("AzureDeviceRegistry60.png") }
];

AdrType = type function(
    scope as (type text meta [
        Documentation.FieldCaption = Extension.LoadString("ScopeParamCaption"),
        Documentation.FieldDescription = Extension.LoadString("ScopeParamDescription"),
        Documentation.AllowedValues = { "Tenant", "Subscription"},
        Documentation.SampleValues = {Extension.LoadString("ScopeInputSample")}
    ]),
    optional subscriptions as (type text meta [
        Documentation.FieldCaption = Extension.LoadString("SubscriptionParamCaption"),
        Documentation.FieldDescription = Extension.LoadString("SubscriptionParamDescription"),
        Documentation.SampleValues = {Extension.LoadString("SubscriptionInputSample")}
    ]),
    optional namespaces as (type text meta [
        Documentation.FieldCaption = Extension.LoadString("NamespaceParamCaption"),
        Documentation.FieldDescription = Extension.LoadString("NamespaceParamDescription"),
        Documentation.SampleValues = {Extension.LoadString("NamespaceInputSample")}
    ]),
    optional customAttributes as (type text meta [
        Documentation.FieldCaption = Extension.LoadString("CustomAttributesParamCaption"),
        Documentation.FieldDescription = Extension.LoadString("CustomAttributesParamDescription"),
        Documentation.SampleValues = {Extension.LoadString("CustomAttributesInputSample")},
        Formatting.IsMultiLine = true
    ]),
    optional options as (type nullable [
           optional resultTruncated = (type logical meta [
            Documentation.FieldCaption = Extension.LoadString("ResultTruncatedParamCaption"),
            Documentation.FieldDescription = Extension.LoadString("ResultTruncatedParamDescription"),
            Documentation.AllowedValues = {true, false},
            Documentation.SampleValues = {true}
        ]),
        optional pagesize = (type number meta [
        Documentation.FieldCaption =Extension.LoadString("PagesizeParamCaption"),
        Documentation.FieldDescription =Extension.LoadString("PagesizeParamDescription"),
        Documentation.SampleValues = {Extension.LoadString("PagesizeParamInputSample")},
        Documentation.AllowedValues = {5,10,25,50,100,200,300,400,500, 600,700,800,900,1000},
        Documentation.DefaultValue = DefaultPageSize
        ])
     
    ] meta [
    Documentation.FieldCaption = Extension.LoadString("AdvancedOptionsLabel")
])
) as table meta [
        Documentation.Name = Extension.LoadString("Title"),
        Documentation.LongDescription = Extension.LoadString("LongerDescription"),
        Documentation.Examples = {[
            Description = Extension.LoadString("docExampleDescription"),
            Code = "AzureDeviceRegistry.Query(""resources"")",
            processedResult = Extension.LoadString("docExampleProcessedResult")
        ]}
    ];

[DataSource.Kind="AzureDeviceRegistry", Publish="AzureDeviceRegistry.Publish"]
shared AzureDeviceRegistry.Query = Value.ReplaceType(AdrNavTable, AdrType);

AdrNavTable = (scope as text, optional subscriptions as text, optional namespaces as nullable text, optional customAttributes as nullable text, optional options as nullable record) as table =>
    let
        parameters = ValidateAndParseParameters(
             Diagnostics.LogValue("Parameters.Scope", scope), 
             Diagnostics.LogValue("Parameters.Subscriptions", subscriptions), 
             Diagnostics.LogValue("Parameters.NameSpaces", namespaces),
             Diagnostics.LogValue("Parameters.CustomAttributes", customAttributes), 
             Diagnostics.LogValue("Parameters.Options", options)),
        scopeValue = parameters[Scope],
        subscriptionsList = parameters[Subscriptions],
        namespacesList = parameters[Namespaces],
        requiredCustomAttributesList = parameters[RequiredCustomAttributes],
        pageSizeValue = parameters[PageSize],
        resultTruncatedOptionValue =parameters[ResultTruncatedOption],
        assetSchema = GetSchema(TableNames.Asset, ValidateCostomAttributes(requiredCustomAttributesList, Asset.BasicSchema[Name])),
        deviceSchema = GetSchema(TableNames.Device, ValidateCostomAttributes(requiredCustomAttributesList, Device.BasicSchema[Name])),
         
        source = #table({"Name", "Data", "ItemKind", "ItemName", "IsLeaf"}, {
            { TableNames.Asset, AzureDeviceRegistry.Contents(TableNames.Asset, scopeValue, subscriptionsList, namespacesList, requiredCustomAttributesList, pageSizeValue, resultTruncatedOptionValue, assetSchema), "Table", "Table", true },
            { TableNames.Device, AzureDeviceRegistry.Contents(TableNames.Device, scopeValue, subscriptionsList, namespacesList, requiredCustomAttributesList, pageSizeValue, resultTruncatedOptionValue, deviceSchema), "Table", "Table", true }
        }),
        navTable = Table.ToNavigationTable(source, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        navTable;

AzureDeviceRegistry.Contents = ( tableName as text, scope as text, subscriptions as nullable list, namespaces as nullable list, requiredCustomAttributes as list,  pageSize as number,  resultTruncated as logical, optional schema as table) as table =>
    let 
        baseQuery = if(tableName = TableNames.Asset) then Asset.Query else if(tableName = TableNames.Device) then Device.Query else error "Invalid table name",
        query = ApplyNamespaceFilter(baseQuery, namespaces),
        completeTable = GenerateByPage((previous) => 
        let
            // if previous is null, then this is our first page of data
            nextToken = if (previous = null) then Diagnostics.LogValue("Start GetData For Table " & tableName,"") else Value.Metadata(previous)[SkipToken]?,
            pageCount = if (previous = null) then 1 else Value.Metadata(previous)[PageCount]?,
            // if NextToken was set to null by the previous call, we know we have no more 
            delay = Number.RandomBetween(1, 3),
            page = if (nextToken <> null) then
                    Function.InvokeAfter(() => 
                    let
                        pageCount = Diagnostics.LogValue("GetPage For Table " & tableName , pageCount),
                        getPage = GetPage(query, nextToken, pageCount, scope, subscriptions, requiredCustomAttributes, pageSize, resultTruncated, schema)
                    in
                        getPage,
                    #duration(0,0,0,delay)) 
                else Diagnostics.LogValue("End GetData For Table " & tableName, null)
        in
            page
        )
    in
        completeTable;

GetPage = (query as text, skipToken as text, pageCount as number, scope as nullable text,  subscriptions as nullable list,  requiredCustomAttributes as list, optional pageSize as number,  optional resultTruncated as logical, optional schema as table) as table =>
    let
        postData = BuildPostContent(query, skipToken, scope, subscriptions, pageSize, resultTruncated),
        response = WaitForResult(postData),
        body = if response[IsError] = false then response[Content] else null, 
        errorCheck = if response[IsError] then error response[Content] else null,
        nextSkipToken = if resultTruncated = true then null else GetSkipToken(body),
        resultTable = if errorCheck = null then Table.FromList(body[data]?, Splitter.SplitByNothing(), null, null, ExtraValues.Error) else null,
        processedResult = if errorCheck = null and not Table.IsEmpty(resultTable) then Table.ExpandRecordColumn(resultTable, "Column1", Record.FieldNames(Table.Column(resultTable, "Column1"){0})) else null,
        output = if processedResult = null then #table({"Results"}, {{"No results"}}) else ParseDynamicAttributes(processedResult, requiredCustomAttributes),
        applySchema = if (processedResult <> null and schema<>null) then SchemaTransformTable(output, schema, 2 ) else output
    in
       applySchema meta [SkipToken = nextSkipToken, PageCount = pageCount+1];

BuildPostContent = (query as text, skipToken as text, scope as text, optional subscriptions as nullable list, optional pageSize as number, optional resultTruncated as logical) =>
    let
        AddFieldOrNull = (rec, field, value) =>
        if (value <> null) then
            Record.AddField(rec, field, value)
        else
            rec,
        scopeForQuery = if IsNullOrEmpty(scope) then null else if scope = "Subscription" then "subscriptions" else if scope = "Namespace" then "namespace" else null,
        skip = null,
        top = null,
        processedQuery = Text.Replace(query, "#(lf)", ""),
        base = [query = processedQuery],
        baseOptions = [],
        // when there is a skiptoken need not pass top parameter
        optionsWithTop = AddFieldOrNull(baseOptions, "$top", if resultTruncated = true then TruncatedResultPageSize else if IsNullOrEmpty(skipToken) then pageSize else null),
        optionsWithSkipToken =  if IsNullOrEmpty(skipToken) = false then Record.AddField(optionsWithTop,"$skipToken", skipToken) else optionsWithTop,
        requestBodyWithOptions = if Record.FieldCount(optionsWithSkipToken) > 0 then Record.AddField(base, "options", optionsWithSkipToken) else base,
        requestBodyWithScope = AddFieldOrNull(requestBodyWithOptions, scopeForQuery, subscriptions),
        jsonBody = Json.FromValue(requestBodyWithScope)
    in
       jsonBody;

WaitForResult = (postData as binary) => 
    let
        apiUrl = Uri.Combine(GetEndpointConfig()[AzureResourceManager], "/providers/Microsoft.ResourceGraph/resources?api-version=2022-10-01"),
        waitForResult = Value.WaitFor(
            (iteration) =>
                let
                    result = Web.Contents(apiUrl, 
                        [Headers = [#"Content-Type" = "application/json"],
                        Content = postData,
                        ManualStatusHandling = {500, 400},
                        IsRetry = iteration > 0]),
                    status = Value.Metadata(result)[Response.Status],
                    body = Json.Document(result),
                    statusCode = Value.Metadata(result)[Response.Status],
                    errorMessage = if statusCode <> 200 then body[error][message] else "",
                    details = if statusCode <> 200 then Record.Field(body[error], "details") else {},
                    detailedErrorMessage = if statusCode <> 200 and List.IsEmpty(details) then "" else if List.IsEmpty(details) <> true then List.Accumulate(details, "", (state, current) => state & " " & current[message]) else "",
                    errorCheck = if statusCode <> 200 then errorMessage & " Details:" & detailedErrorMessage else null,
                    actualResult = if status = 500 then if iteration < 3 then null else [IsError = true, Content = errorCheck] else if status = 400 then [IsError = true, Content = errorCheck] else [IsError = false, Content = body]
                in
                    actualResult,
            (iteration) => #duration(0, 0, 0, Number.Power(2, iteration)), 3)
    in
        waitForResult;

Value.WaitFor = (producer as function, interval as function, optional count as number) as any =>
    let
        list = List.Generate(
            () => {0, null},
            (state) => state{0} <> null and (count = null or state{0} < count),
            (state) => if state{1} <> null then {null, state{1}} else {1 + state{0}, Function.InvokeAfter(() => producer(state{0}), interval(state{0}))},
            (state) => state{1})
    in
        List.Last(list);


GetWebContents = (url as text, optional options as record) =>
    let
        content = Web.Contents(url, options & [ManualStatusHandling = {400, 404, 408, 500, 504}]),
        json = Json.Document(content),
        httpStatus = Value.Metadata(content)[Response.Status],
        errorResponse = if (json = null) then null else
            let
                requestId = Record.FieldOrDefault(Value.Metadata(content)[Headers], "x-ms-request-id"),
                detail = [
                    status = httpStatus,
                    code = json[error]?[code]?,
                    message = json[error]?[message]?,
                    #"x-ms-request-id" = requestId
                ]
            in
                if (httpStatus = 400) then
                    error Error.Record(
                        "Bad Request",
                        json[error]?[message]?,
                        detail
                    )
                else if (httpStatus = 404) then
                    error Error.Record(
                        "DataSource.NotFound",
                        json[error]?[message]?,
                        detail
                    )
                else if (httpStatus = 408 or httpStatus = 504) then
                    error Error.Record(
                        "DataSource.Timeout",
                        json[error]?[message]?,
                        detail
                    )
                else if (httpStatus >= 500) then
                    error Error.Record(
                        "DataSource.Error",
                        json[error]?[message]?,
                        detail
                    )
                else
                    null
    in
        if (errorResponse <> null) then errorResponse else json;


EnvironmentConfiguration = [
    AzureActiveDirectory = Environment.FeatureSwitch("AzureActiveDirectoryUri", GlobalCloudConfiguration[AzureActiveDirectory]),
    AzureResourceManager = Environment.FeatureSwitch("AzureResourceManagerUri", GlobalCloudConfiguration[AzureResourceManager]),
    AzureResourceManagerResource = Environment.FeatureSwitch("AzureResourceManagerAadResource", GlobalCloudConfiguration[AzureResourceManagerResource])
];

GlobalCloudConfiguration = [
    AzureActiveDirectory = "https://login.microsoftonline.com",
    AzureResourceManager = "https://management.azure.com/",
    AzureResourceManagerResource = "https://management.core.windows.net"
];

// The Power BI service configuration for GCC (L2) has AAD configured for Azure Commercial but ARM configured for Azure Government.
// PBI doesn't support cross cloud connections, so we'll override the config settings to use global cloud endpoints for ARM when
// the current environment is using global cloud AAD.
GetEndpointConfig = () as record =>
    if (Text.StartsWith(EnvironmentConfiguration[AzureActiveDirectory], GlobalCloudConfiguration[AzureActiveDirectory])) then
        GlobalCloudConfiguration
    else
        EnvironmentConfiguration;

// In this implementation, 'response' will be the parsed body of the response after the call to Json.Document.
// Look for the '@odata.nextLink' field and simply return null if it doesn't exist.
GetSkipToken = (response) as nullable text => Record.FieldOrDefault(response, "$skipToken");
GetTotalRecords = (response) as nullable text => Record.Field(response, "totalRecords");
ProcessParam = (param as text) =>
    let
        paramList = Text.Split(param, ","),
        trimmedList = List.Transform(paramList, each Text.Trim(_))
    in
        trimmedList;

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

Extension.LoadFunction = (fileName as text) =>
  let
      binary = Extension.Contents(fileName),
      asText = Text.FromBinary(binary)
  in
      try
        Expression.Evaluate(asText, #shared)
      catch (e) =>
        error [
            Reason = "Extension.LoadFunction Failure",
            Message.Format = "Loading '#{0}' failed - '#{1}': '#{2}'",
            Message.Parameters = {fileName, e[Reason], e[Message]},
            Detail = [File = fileName, Error = e]
        ];

ParseDynamicAttributes = (data as table, optional requiredCustomAttributes as list)=>
let
     duplicateAttrbiutesColumn = Table.DuplicateColumn(data, "attributes", "attributesToParse"),
     NormalizeInfo = Table.TransformColumns(duplicateAttrbiutesColumn, {
          "attributesToParse", each ConvertToText(_)
    }),

    expandedTable = Table.ExpandRecordColumn(NormalizeInfo, "attributesToParse", requiredCustomAttributes),
    convertAttributesToText = ConvertColumnValuesToText(expandedTable, "attributes")
in
    convertAttributesToText;

// validate the parameters and return them as record.
ValidateAndParseParameters = (scope as text,  subscriptions as nullable text , namespaces as nullable text, requiredCustomAttributes as nullable text , options as nullable record) as record=>
let
    // validate the scope parameter if scope is Tenant, then subscriptions and namespaces should be empty
    scopeValue = if scope = "Tenant" and (IsNullOrEmpty(subscriptions) = false or  IsNullOrEmpty(namespaces) = false) then error Error.Record("Expression.Error", Extension.LoadString("InvalidParameterValuesForTenant"))  else scope,
    
    // make a list of subscriptions, Validate if scope is subscription, then subscriptions should not be empty and validate the count
    subscriptionValues = if scopeValue = "Tenant" then null else if scopeValue = "Subscription" and IsNullOrEmpty(subscriptions) then null else ProcessParam(subscriptions),
        
    // make a list of namespaces and validate the count
    namespacesList = if scopeValue = "Tenant" or IsNullOrEmpty(namespaces) then null else ValidateNamespaces(ProcessParam(namespaces)),
    
    // make a list of custom attributes and validate the count
     requiredCustomAttributesList = if IsNullOrEmpty(requiredCustomAttributes) then {} else Text.Split(Text.Lower(requiredCustomAttributes), ","),
     requiredCustomAttributeValues = 
        if List.Count(requiredCustomAttributesList) > MaxNoOfCustomAttributes then error Error.Record("Expression.Error", Extension.LoadString("InvalidNumberOfCustomAttributes") & Number.ToText(MaxNoOfCustomAttributes)) 
        else List.Transform(requiredCustomAttributesList, each Text.Lower(Text.Trim(_))),
    
    pageSize = if options = null or options[pagesize]? = null then DefaultPageSize else options[pagesize],
    pageSizeValue = if pageSize <= 0 or pageSize > MaxPageSize then DefaultPageSize else pageSize,
    resultTruncatedOptionValue = if options = null or options[resultTruncated]? = null then false else options[resultTruncated]
in
    [
        Scope = scopeValue,
        Subscriptions = subscriptionValues,
        Namespaces = namespacesList,
        RequiredCustomAttributes = requiredCustomAttributeValues,
        PageSize = pageSizeValue,
        ResultTruncatedOption = resultTruncatedOptionValue
    ];

ValidateCostomAttributes = (requiredCustomAttributes as list, standardColumns as list) as list =>
let
    standardColumnNames = List.Transform(standardColumns, each Text.Lower(_)),
    invalidCustomAttributes = List.Select(requiredCustomAttributes, each List.Contains(standardColumnNames, _) = true),
    errorMessage = if List.IsEmpty(invalidCustomAttributes) then null else "Invalid custom attributes: " & Text.Combine(invalidCustomAttributes, ", ")
in
    if errorMessage <> null then error Error.Record("Expression.Error", errorMessage) else requiredCustomAttributes;
    
ApplyNamespaceFilter = (query as text, namespaces as nullable list) =>
    let
        namespacesFilter = if namespaces = null then "" else " and id matches regex '(?i)namespaces/(" & Text.Combine(namespaces, "|") & ")/'",
        filteredQuery = Text.Replace(query, "#namespacefilter", namespacesFilter)
    in
        filteredQuery;

IsNullOrEmpty = (value) => if(value = null) then true else if Text.Trim(value) = "" then true else false;

ConvertColumnValuesToText = (data as nullable table, columnName as text)=>
let
    outputTable = 
        if data = null then 
            null 
        else 
            Table.TransformColumns(
                data, 
                {
                    {columnName, each 
                        if _ = null then 
                            null 
                        else if Value.Is(_, type record) then 
                            Text.FromBinary(Json.FromValue(_)) 
                        else 
                            Text.From(_),
                    type text}
                }
            )
in
    outputTable;

ConvertToText = (recordField as nullable record)=>
let
    outputText = if recordField=null then null else Record.RenameFields(recordField, List.Transform(Record.FieldNames(recordField), each {_, Text.Lower(Text.From(_))}))       
in  
    outputText;

// adds the custom attributes to the basic schema
GetSchema = (tableName as text, customeAttributes as list)=>
let
    customAttributeRows = Table.FromList(customeAttributes, Splitter.SplitByNothing(), {"Name"}),
    rowsWithTypeColumn =  Table.TransformColumns(customAttributeRows, {{"Name", each [Name = _, Type = type text]}}),
    splitNameIntoTwoColumns = Table.ExpandRecordColumn(rowsWithTypeColumn, "Name", {"Name", "Type"}),
    schemaTable = if tableName = TableNames.Asset then Table.Combine({Asset.BasicSchema, splitNameIntoTwoColumns}) else if tableName = TableNames.Device then Table.Combine({Device.BasicSchema, splitNameIntoTwoColumns}) else null
in
   schemaTable;

ValidateNamespaces = (namespaces as nullable list) =>
    let
        validNamespaces = 
        if namespaces = null then 
            null 
        else 
            let
                invalidNamespaceName = List.First(List.Select(namespaces, each ValidateIfTextContainsSpecialCharacters(_) = true), null),
                isValid = invalidNamespaceName = null,
                errorMessage = if isValid then null else  invalidNamespaceName & " " & Extension.LoadString("InvalidNamespaceName")
            in
                if errorMessage <> null then 
                    error Error.Record("Expression.Error", errorMessage) 
                else 
                    namespaces
    in
        validNamespaces;
       
