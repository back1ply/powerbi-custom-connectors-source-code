[Version = "1.0.6"]
section DynatraceGrail;


OAuthBaseUrl = "https://sso.dynatrace.com:443/oauth2/";
authorize_uri = Uri.Combine(OAuthBaseUrl, "authorize");
token_uri = "https://sso.dynatrace.com:443/sso/oauth2/token";
client_id = "dt0s08.powerbi-connector-prod";
code_challenge_method = "S256";


// This is the expected Redirect URI for OAuth flows to work in the Power BI service.
redirect_uri = "https://oauth.powerbi.com/views/oauthredirect.html";

// Other OAuth settings
windowWidth = 720;
windowHeight = 1024;

GetEnvironment = (url as text) as text =>
    let
        _url_http_part = if Text.Contains(url, "://", Comparer.OrdinalIgnoreCase)= true then Text.AfterDelimiter(url,"://") else  url,
        _url =  if Text.Contains(_url_http_part, ".", Comparer.OrdinalIgnoreCase)= true then Text.BeforeDelimiter(_url_http_part,".") else _url_http_part,
        Adress_path = "https://" & _url & ".apps.dynatrace.com/platform/storage/query/v1/query:execute",
        Address = Uri.Parts(Adress_path)
    in
        if
            Address[Host] = ""
            or Address[Scheme] <> "https"
            or Address[Path] <> "/platform/storage/query/v1/query:execute"
            or Address[Query] <> []
            or Address[Fragment] <> ""
            or Address[UserName] <> ""
            or Address[Password] <> ""
            or (Address[Port] <> 80 and Address[Port] <> 443)
            or Text.EndsWith(url, ":80")
        then
            error "Invalid environment name"
        else
            Adress_path;

GetDataType = type function (
    url as (Uri.Type meta [
        Documentation.FieldCaption = "Dynatrace environment",
        Documentation.FieldDescription = "Enter your Dynatrace environment, for example: https://123environment.apps.dynatrace.com.",
        Documentation.SampleValues = {"https://123environment.apps.dynatrace.com"}
    ]),
    optional QueryInput as (type text meta [
        Documentation.FieldCaption = "Custom DQL Query",
        Documentation.FieldDescription = "Enter your custom DQL query.",
        Documentation.SampleValues = {"fetch bizevents | limit 10"},
        Formatting.IsMultiLine = true,
        Formatting.isCode = true
    ]),
    optional options as (
        type nullable [
            optional ScanGBParameter = (type number meta [
                Documentation.FieldCaption = "Read data limit (GB)",
                Documentation.FieldDescription = "Limit in gigabytes for the amount of data that will be scanned during read. Note: Increasing this limit can increase associated costs.",
                Documentation.SampleValues = {"500"}
            ]),
            optional MaxResultParameter = (type number meta [
                 Documentation.FieldCaption = "Record limit",
                 Documentation.FieldDescription = "The maximum number of result records that this query will return. Note: Increasing the maximum can result in longer run times.",
                 Documentation.SampleValues = {"1000000"}
            ]),
            optional MaxBytesParameter = (type number meta [
                 Documentation.FieldCaption = "Result size limit (MB)",
                 Documentation.FieldDescription = "The maximum number of result bytes that this query will return. Note: Increasing the maximum can affect performance.",
                 Documentation.SampleValues = {"10"}
            
            ]),
            optional SamplingParameter = (type number meta [
                 Documentation.FieldCaption = "Sampling",
                 Documentation.FieldDescription = "Results in the selection of a subset of Log or Span records.",
                 Documentation.AllowedValues = { 10, 100, 1000, 10000 }
            ])
        ] meta [
             Documentation.FieldCaption = "Advanced options",
             Documentation.FieldDescription = "Query limits. Maximum limits when fetching data."
        ]
    )
) as table meta [
        Documentation.Name = "Dynatrace Grail DQL",
        Documentation.LongDescription = "DQL Connector can be used to fetch data from Grail using DQL custom query or by selecting tables."
    ];

[DataSource.Kind="DynatraceGrail", Publish="DynatraceGrail.UI"]
shared DynatraceGrail.Contents = Value.ReplaceType(GrailNavTable, GetDataType);

GrailNavTable = (url as text, optional QueryInput as text, optional options as record) as table =>
    let
        source = #table(
            {"Name", "Data", "ItemKind", "ItemName", "IsLeaf"},
            {
                {"Logs", Grail_logs(url), "Table", "Table", true},
                {"BizEvents", Grail_bizevents(url), "Table", "Table", true},
                {"Events", Grail_events(url), "Table", "Table", true},
                {"Spans", Grail_spans(url), "Table", "Table", true}
            }
        ),
        navTable = Table.ToNavigationTable(source, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf"),
      // Process the custom query input
        CustomQueryTable = if Text.Length(Text.Combine(List.RemoveNulls({QueryInput})))  > 0 then
            let
                 queryTry = try ExecuteCustomQuery(url, QueryInput, options)
                  in

                    if queryTry[HasError] then
                let
                    err = queryTry[Error],
                    
                    errMsg = 
                        if Record.HasFields(err, "Message") then
                            let
                                msg = err[Message],
                                msgText = 
                                    if Value.Is(msg, type text) then msg
                                    else if Value.Is(msg, type record) then
                                        if Record.HasFields(msg, "Value") and Value.Is(msg[Value], type text) then msg[Value]
                                        else if Record.HasFields(msg, "Parameters") and Value.Is(msg[Parameters], type list) then
                                            Text.Combine(List.Transform(msg[Parameters], each "- " & Text.From(_)), "#(lf)")
                                        else "Unknown error structure in Message"
                                    else "Unknown error format"
                            in
                                msgText
                        else
                            "Unknown error"

                in
                    error "Dynatrace query failed. " & errMsg
                  else if Table.IsEmpty(queryTry[Value]) then
                 error "Query executed successfully but returned no data."
             else
                 queryTry[Value]


           else
            null
    in
        if CustomQueryTable <> null then
            CustomQueryTable
        else
           navTable
            ;

Grail_logs = (url as text)  as table =>
    let
    _dql_query = [
        query = "fetch logs, from:now() - 2d  | limit 1000",
        timezone = "UTC",
        locale = "en_US",
        requestTimeoutMilliseconds = 60000,
        maxResultRecords = 1000000
    ],
   _url = GetEnvironment(url),
    Source = Json.Document(Web.Contents(_url,
        [Headers=[
                #"Content-Type"="application/json",
                #"PowerBIQuery"="PowerBI_DQL_Query",
                #"Dt-Client-Context"="com.dynatrace.power_bi_connector"
                ],
        Content=Json.FromValue(_dql_query)])),
   result = Source[result],
   records = result[records],
   #"Converted to Table" =  Table.FromList(records, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
   NonEmptyColumn1 = if not Table.IsEmpty(#"Converted to Table") then List.First(Table.Column(#"Converted to Table", Text.Combine(Table.ColumnNames(#"Converted to Table")))) else [],
   ColumnNames = if NonEmptyColumn1 <> null then Record.FieldNames(NonEmptyColumn1) else {},
   ExpandColumn = if not List.IsEmpty(ColumnNames) then
                    Table.ExpandRecordColumn( #"Converted to Table", Text.Combine(Table.ColumnNames(#"Converted to Table")), ColumnNames)
                   else
                     #"Converted to Table"
in
    ExpandColumn;

Grail_events = (url as text)  as table =>
    let
    _dql_query = [
        query = "fetch events | limit 1000",
        timezone = "UTC",
        locale = "en_US",
        requestTimeoutMilliseconds = 60000,
        maxResultRecords = 1000000
    ],
   _url = GetEnvironment(url),
    Source = Json.Document(Web.Contents(_url,
        [Headers=[
                #"Content-Type"="application/json",
                #"PowerBIQuery"="PowerBI_DQL_Query",
                #"Dt-Client-Context"="com.dynatrace.power_bi_connector"
                ],
        Content=Json.FromValue(_dql_query)])),
   result = Source[result],
   records = result[records],
   #"Converted to Table" = Table.FromList(records, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
   NonEmptyColumn1 = if not Table.IsEmpty(#"Converted to Table") then List.First(Table.Column(#"Converted to Table", Text.Combine(Table.ColumnNames(#"Converted to Table")))) else [],
   ColumnNames = if NonEmptyColumn1 <> null then Record.FieldNames(NonEmptyColumn1) else {},
   ExpandColumn = if not List.IsEmpty(ColumnNames) then
                    Table.ExpandRecordColumn( #"Converted to Table", Text.Combine(Table.ColumnNames(#"Converted to Table")), ColumnNames)
                   else
                     #"Converted to Table"
in
ExpandColumn;

Grail_bizevents = (url as text)  as table =>
    let
    _dql_query = [
        query = "fetch bizevents | limit 1000",
        timezone = "UTC",
        locale = "en_US",
        requestTimeoutMilliseconds = 60000,
        maxResultRecords = 1000000
    ],
   _url = GetEnvironment(url),
    Source = Json.Document(Web.Contents(_url,
        [Headers=[
                #"Content-Type"="application/json",
                #"PowerBIQuery"="PowerBI_DQL_Query",
                #"Dt-Client-Context"="com.dynatrace.power_bi_connector"
                ],
        Content=Json.FromValue(_dql_query)])),
   result = Source[result],
   records = result[records],
   #"Converted to Table" = Table.FromList(records, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
   NonEmptyColumn1 = if not Table.IsEmpty(#"Converted to Table") then List.First(Table.Column(#"Converted to Table", Text.Combine(Table.ColumnNames(#"Converted to Table")))) else [],
   ColumnNames = if NonEmptyColumn1 <> null then Record.FieldNames(NonEmptyColumn1) else {},
   ExpandColumn = if not List.IsEmpty(ColumnNames) then
                    Table.ExpandRecordColumn( #"Converted to Table", Text.Combine(Table.ColumnNames(#"Converted to Table")), ColumnNames)
                   else
                     #"Converted to Table"
in
ExpandColumn;


Grail_spans = (url as text)  as table =>
    let
    _dql_query = [
        query = "fetch spans | limit 1000",
        timezone = "UTC",
        locale = "en_US",
        requestTimeoutMilliseconds = 60000,
        maxResultRecords = 1000000
    ],
   _url = GetEnvironment(url),
    Source = Json.Document(Web.Contents(_url,
        [Headers=[
                #"Content-Type"="application/json",
                #"PowerBIQuery"="PowerBI_DQL_Query",
                #"Dt-Client-Context"="com.dynatrace.power_bi_connector"
                ],
        Content=Json.FromValue(_dql_query)])),
   result = Source[result],
   records = result[records],
   #"Converted to Table" = Table.FromList(records, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
   NonEmptyColumn1 = if not Table.IsEmpty(#"Converted to Table") then List.First(Table.Column(#"Converted to Table", Text.Combine(Table.ColumnNames(#"Converted to Table")))) else [],
   ColumnNames = if NonEmptyColumn1 <> null then Record.FieldNames(NonEmptyColumn1) else {},
   ExpandColumn = if not List.IsEmpty(ColumnNames) then
                    Table.ExpandRecordColumn( #"Converted to Table", Text.Combine(Table.ColumnNames(#"Converted to Table")), ColumnNames)
                   else
                     #"Converted to Table"
in
ExpandColumn;

ExecuteCustomQuery = (url as text, query as text, optional options as record) as table =>
    let
    EmptyTable = Table.FromRecords({}, type table[ #"metric.key" = Text.Type ]),
    options = if options <> null then options else [],
    ScanGBParameterValue = if Record.HasFields(options, "ScanGBParameter") then options[ScanGBParameter] else null,
    MaxResultParameterValue = if Record.HasFields(options, "MaxResultParameter") and options[MaxResultParameter] <> null then options[MaxResultParameter] else 1000000,
    MaxBytesParameterValue = if Record.HasFields(options, "MaxBytesParameter") then options[MaxBytesParameter] else null,
    SamplingParameterValue = if Record.HasFields(options, "SamplingParameter") then options[SamplingParameter] else null,
    RemoveComments = Text.Combine(
    List.Transform(
        Text.Split(query, "#(lf)"), 
        each if Text.Contains(_, "//") then Text.BeforeDelimiter(_, "//") else _
    ), 
    "#(lf)"
    ),
    // Combine lines in case QueryInput is multi-line
    CombinedQuery = if RemoveComments <> null then Text.Combine(Text.Split(RemoveComments, "#(lf)"), " ") else null,
    _dql_query = [
        query = CombinedQuery,
        timezone = "UTC",
        locale = "en_US",
        requestTimeoutMilliseconds = 60000,
        maxResultRecords = MaxResultParameterValue,
        defaultScanLimitGbytes = ScanGBParameterValue,
        maxResultBytes = MaxBytesParameterValue,
        defaultSamplingRatio= SamplingParameterValue
    ],
   _url = GetEnvironment(url),
    Source = try Json.Document(Web.Contents(_url,
        [Headers=[
                #"Content-Type"="application/json",
                #"PowerBIQuery"="PowerBI_DQL_Query",
                #"Dt-Client-Context"="com.dynatrace.power_bi_connector"
                ],
        Content=Json.FromValue(_dql_query)])),

    response = if Source[HasError] then
            let
                errorDetail = try Source[Error][Message] otherwise "Unknown error",
                errorText = "Dynatrace API error: " & errorDetail & "; Possible issue: Invalid DQL query"
            in
                error errorText
        else
            Source[Value],

   result = response[result],
   records = result[records],
   #"Converted to Table" = Table.FromList(records, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
   NonEmptyColumn1 = if  Table.IsEmpty( #"Converted to Table") then List.First(Table.Column(EmptyTable, Text.Combine(Table.ColumnNames(EmptyTable)))) else  List.First(Table.Column(#"Converted to Table", Text.Combine(Table.ColumnNames(#"Converted to Table")))),
    ColumnNames = if NonEmptyColumn1 <> null then Record.FieldNames(NonEmptyColumn1) else {},
    ExpandColumn = if not List.IsEmpty(ColumnNames) then
                    Table.ExpandRecordColumn( #"Converted to Table", Text.Combine(Table.ColumnNames(#"Converted to Table")), ColumnNames)
                   else
                    EmptyTable
in
    ExpandColumn;

// Common functions
//
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
        newTableType = Type.AddTableKey(tableType, keyColumns, true) meta [
            NavigationTable.NameColumn = nameColumn,
            NavigationTable.DataColumn = dataColumn,
            NavigationTable.ItemKindColumn = itemKindColumn,
            Preview.DelayColumn = itemNameColumn,
            NavigationTable.IsLeafColumn = isLeafColumn
        ],
        navigationTable = Value.ReplaceType(table, newTableType)
    in
        navigationTable;


// Data Source Kind description
DynatraceGrail= [
    TestConnection = (dataSourcePath) => { "DynatraceGrail.Contents", dataSourcePath },
    Authentication = [
        OAuth = [
           StartLogin=StartLogin,
           FinishLogin=FinishLogin,
           Refresh=Refresh
        ]
    ],
    Label = "Dynatrace Grail DQL (OAuth2)"
];


// Data Source UI publishing description
DynatraceGrail.UI = [
    Beta = true,
    Category = "Other",
    ButtonText = { "Dynatrace Grail DQL", "Connect" },
    LearnMoreUrl = "https://learn.microsoft.com/en-us/power-query/connectors/dynatrace-grail-dql",
    SourceImage = DynatraceGrail.Icons,
    SourceTypeImage = DynatraceGrail.Icons
];


// Helper functions for OAuth2: StartLogin, FinishLogin, Refresh
StartLogin = (resourceUrl, state, display) =>
    let
                // We'll generate our code verifier using Guids
        plainTextCodeVerifier = Text.NewGuid() & Text.NewGuid(),
        codeVerifier =
            if (code_challenge_method = "plain") then
                plainTextCodeVerifier
            else if (code_challenge_method = "S256") then
                Base64Url.Encode(Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(plainTextCodeVerifier)))
            else
                error "Unexpected code_challenge_method",
        authorizeUrl = authorize_uri & "?" & Uri.BuildQueryString([
            response_type = "code",
            code_challenge_method = code_challenge_method,
            code_challenge = codeVerifier,
            client_id = client_id,  
            redirect_uri = redirect_uri,
            state = state
        ])
    in
        [
            LoginUri = authorizeUrl,
            CallbackUri = redirect_uri,
            WindowHeight = windowHeight,
            WindowWidth = windowWidth,
            Context = [CodeVerifier = plainTextCodeVerifier]
        ];

FinishLogin = (context, callbackUri, state) =>
    let
        // parse the full callbackUri, and extract the Query string
        parts = Uri.Parts(callbackUri)[Query],
        codeVerifier = context[CodeVerifier],
        // if the query string contains an "error" field, raise an error
        // otherwise call TokenMethod to exchange our code for an access_token
        result = if (Record.HasFields(parts, {"error", "error_description"})) then 
                    error Error.Record(parts[error], parts[error_description], parts)
                 else
                    TokenMethod("authorization_code", "code", parts[code], codeVerifier)
    in
        result;

Refresh = (resourceUrl, refresh_token) => TokenMethod("refresh_token", "refresh_token", refresh_token, null);

Base64Url.Encode = (s) => Text.Replace(Text.Replace(Text.BeforeDelimiter(Binary.ToText(s,BinaryEncoding.Base64),"="),"+","-"),"/","_");

TokenMethod = (grantType, tokenField, tokenValue, codeVerifier) =>
    let
        queryString = [
            grant_type = grantType,
            redirect_uri = redirect_uri,
            client_id = client_id
										
        ],
        queryWithCodeVerifier = if (codeVerifier <> null and not Record.HasFields(queryString, "code_verifier")) then Record.AddField(queryString, "code_verifier", codeVerifier) else queryString,
        queryWithToken = if (tokenValue <> null and not Record.HasFields(queryWithCodeVerifier, tokenField)) then Record.AddField(queryWithCodeVerifier, tokenField, tokenValue) else queryWithCodeVerifier,
        tokenResponse = Web.Contents(token_uri, [
            Content = Text.ToBinary(Uri.BuildQueryString(queryWithToken)),
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
  

DynatraceGrail.Icons = [
   Icon16 = { Extension.Contents("Dynatrace_Grail_DQL16.png"), Extension.Contents("Dynatrace_Grail_DQL20.png"), Extension.Contents("Dynatrace_Grail_DQL24.png"), Extension.Contents("Dynatrace_Grail_DQL32.png") },
    Icon32 = { Extension.Contents("Dynatrace_Grail_DQL32.png"), Extension.Contents("Dynatrace_Grail_DQL40.png"), Extension.Contents("Dynatrace_Grail_DQL48.png"), Extension.Contents("Dynatrace_Grail_DQL64.png") }
];

