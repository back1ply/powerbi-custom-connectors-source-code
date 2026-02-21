// Data Connector logic for Cognite Data Fusion.
[Version = "1.0.2"]
section CogniteDataSource;

CogniteDefaults = [
    Project = "publicdata",
    Organization = "publicdata",
    // Cognite Authorization Server Client ID for Power BI
    ClientId = "548c922d-45ad-49ef-903d-7dce423450b1",
    AuthUrl = "https://auth.cognite.com/oauth2/auth",
    TokenUrl = "https://auth.cognite.com/oauth2/token",
    Audience = "https://cognitedata.com",
    RedirectUrl = "https://oauth.powerbi.com/views/oauthredirect.html",
    Scope = "email openid profile offline_access",
    ApiVersion = "v1",
    DMApiVersion = "20230821",
    // To avoid Power BI giving Invalid URI: The Uri scheme is too long.
    MaxUriSize = 800,
    // Is it possible to read this value from the section above?
    Version = "1.0.2"
];

// Construct service Url from the project and organization
createUrls = (project as text, organization as text) =>
    let
        // If organization is set, validate if the project exists in the organization
        projectItem = GetEnvironmentFromOrganization(organization, project),
        // Project name w/o query parameters
        beforeQueryParams = Text.BeforeDelimiter(project, "?"),
        // if the project contains a path, we get the base project name
        baseProjectName = Text.BeforeDelimiter(beforeQueryParams, "/")
    in
        [ApiUrl = projectItem[apiUrl], ProjectName = baseProjectName];

// CogniteDataSource.Contents defines the connector.
// It is composed of CogniteDataSourceImpl and CogniteDataSourceType
// CogniteDataSourceImpl is the connector implementation
// CogniteDataSourceType annotates the function parameter with caption/description and default values
[DataSource.Kind = "CogniteDataSource", Publish = "CogniteDataSource.UI"]
shared CogniteDataSource.Contents = Value.ReplaceType(CogniteDataSourceImpl, CogniteDataSourceType);

// Annotations for the connector. Changing items in this list must be reflected in CogniteImpl's arguments
CogniteDataSourceType = type function (
    project as (
        type text meta [
            Documentation.FieldCaption = Extension.LoadString("ProjectName"),
            Documentation.FieldDescription = Extension.LoadString("ProjectDescription"),
            Documentation.SampleValues = {CogniteDefaults[Project]}
        ]
    ),
    organization as (
        type text meta [
            Documentation.FieldCaption = Extension.LoadString("Organization"),
            Documentation.FieldDescription = Extension.LoadString("OrganizationDescription"),
            Documentation.SampleValues = {CogniteDefaults[Organization]}
        ]
    )
) as table meta [
    Documentation.Name = Extension.LoadString("CogniteDataFusion"),
    Documentation.LongDescription = Extension.LoadString("CogniteDataFusion")
];

windowWidth = 900;
windowHeight = 700;

Base64UrlEncodeWithoutPadding = (hash as binary) as text =>
    let
        base64Encoded = Binary.ToText(hash, BinaryEncoding.Base64),
        base64UrlEncoded = Text.Replace(Text.Replace(base64Encoded, "+", "-"), "/", "_"),
        withoutPadding = Text.TrimEnd(base64UrlEncoded, "=")
    in
        withoutPadding;

StartLogin = (dataSourcePath, state, display) =>
    let
        json = Json.Document(dataSourcePath),
        codeVerifier = Text.NewGuid() & Text.NewGuid(),
        codeChallenge = Base64UrlEncodeWithoutPadding(
            Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(codeVerifier, TextEncoding.Ascii))
        ),
        urls = createUrls(json[project], json[organization]),

        AuthorizeUrl = CogniteDefaults[AuthUrl]
            & "?"
            & Uri.BuildQueryString(
                [
                    client_id = CogniteDefaults[ClientId],
                    state = state,
                    redirect_uri = CogniteDefaults[RedirectUrl],
                    scope = CogniteDefaults[Scope],
                    audience = CogniteDefaults[Audience],
                    organization_hint = json[organization],
                    code_challenge_method = "S256",
                    code_challenge = codeChallenge,
                    response_type = "code"
                ]
            )
    in
        [
            LoginUri = AuthorizeUrl,
            CallbackUri = CogniteDefaults[RedirectUrl],
            WindowHeight = windowHeight,
            WindowWidth = windowWidth,
            Context = [code_verifier = codeVerifier]
        ];

TokenMethod = (
    grant_type,
    authCode,
    optional context,
    optional project,
    optional organization,
    optional project_name
) =>
    let
        CodeVerifier = if (context <> null) then [code_verifier = context[code_verifier]] else [],
        Parameters =
            if (grant_type = "authorization_code") then
                [redirect_uri = CogniteDefaults[RedirectUrl], code = authCode]
            else
                [refresh_token = authCode],
        Response = Web.Contents(
            CogniteDefaults[TokenUrl],
            [
                Content = Text.ToBinary(
                    Uri.BuildQueryString(
                        [
                            client_id = CogniteDefaults[ClientId],
                            scope = CogniteDefaults[Scope],
                            grant_type = grant_type
                        ] & Parameters & CodeVerifier
                    )
                ),
                Headers = [#"Content-type" = "application/x-www-form-urlencoded", #"Accept" = "application/json"]
            ]
        ),
        // insert exisiting refresh token into response or else PowerBi will fail the authentication
        RefreshToken = if (grant_type = "authorization_code") then [] else [refresh_token = authCode],
        Parts = Json.Document(Response) & [
                    Project = project,
                    Organization = organization,
                    ProjectName = project_name
                ]
    in
        Parts;

FinishLogin = (clientApplication, dataSourcePath, context, callbackUri, state) =>
    let
        json = Json.Document(dataSourcePath),
        Parts = Uri.Parts(callbackUri)[Query],
        urls = createUrls(json[project], json[organization]),
        code =
            if Record.HasFields(Parts, "code") then
                Parts[code]
            else
                error Error.Record("DataSource.Error", Parts[error_description])
    in
        TokenMethod(
            "authorization_code",
            code,
            context,
            json[project],
            json[organization],
            urls[ProjectName]?
        );

Refresh = (dataSourcePath, refreshToken) =>
    let
        json = Json.Document(dataSourcePath),
        urls = createUrls(json[project], json[organization])
    in
        TokenMethod(
            "refresh_token",
            refreshToken,
            null,
            json[project],
            json[organization],
            urls[ProjectName]
        );

// Data Source Kind description.
CogniteDataSource = [
    Type = "Custom",
    MakeResourcePath = (project, organization) =>
        let
            path = [project = project, organization = organization]
        in
            Text.FromBinary(Json.FromValue(path)),
    ParseResourcePath = (resourcePath as text) =>
    let
        json = Json.Document(resourcePath)
    in
        { json[project], json[organization]? },
        
    // This is a magic function which power bi uses to test the connection.
    // https://learn.microsoft.com/en-us/power-query/samples/trippin/9-testconnection/readme
    // dataSourcePath is actually a json object which contains the configuration.
    TestConnection = (dataSourcePath) =>
        let
            json = Json.Document(dataSourcePath)
        in
            {"CogniteDataSource.Contents", json[project], json[organization]},

    Authentication = [
        OAuth = [
            StartLogin = StartLogin,
            FinishLogin = FinishLogin,
            Label = Extension.LoadString("DataSourceLabel"),
            Refresh = Refresh
        ]
    ]
];

// Data Source UI publishing description
CogniteDataSource.UI = [
    Category = "Other",
    ButtonText = {Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp")},
    LearnMoreUrl = "https://docs.cognite.com/",
    SourceImage = CogniteDataSource.Icons,
    SourceTypeImage = CogniteDataSource.Icons
];

CogniteDataSource.Icons = [
    Icon16 = {
        Extension.Contents("CDF16.png"),
        Extension.Contents("CDF20.png"),
        Extension.Contents("CDF24.png"),
        Extension.Contents("CDF32.png")
    },
    Icon32 = {
        Extension.Contents("CDF32.png"),
        Extension.Contents("CDF40.png"),
        Extension.Contents("CDF48.png"),
        Extension.Contents("CDF64.png")
    }
];

CogniteDataSourceImpl = (project as text, organization as text) =>
    let
        // Check if the project name is valid and has valid query parameters
        project =
            if isCleanInputField(project, false) then
                project
            else
                error
                    Error.Record(
                        "Expression.Error", Extension.LoadString("InvalidProjectError"), [
                            #"Project" = project
                        ]
                    ),
        // Check if the organization is valid
        organization =
            if isCleanInputField(organization, false) then
                organization
            else
                error
                    Error.Record(
                        "Expression.Error",
                        Extension.LoadString("InvalidOrganizationError"),
                        [
                            #"Organization" = organization
                        ]
                    ),
        // Create URLs
        urls = createUrls(project, organization),
        navTable =
            if
                project <> null
                and organization <> null
                and isUrl(urls[ApiUrl])
                and hasCDFAccess(project)
            then
                let
                    objects = #table(
                        {"Name", "Key", "Data", "ItemKind", "ItemName", "IsLeaf"},
                        {
                            {"GraphQL", "GraphQL", GraphQL, "Function", GraphQL, true},
                            {"PostCDF", "PostCDF", PostCDF, "Function", PostCDF, true},
                            {"GetCDF", "GetCDF", GetCDF, "Function", GetCDF, true},
                            {"ODataCDF", "ODataCDF", GetODataFeed, "Feed", GetODataFeed, true},
                            {
                                "ODataDataModel",
                                "ODataDataModel",
                                GetDataModelODataFeed,
                                "Feed",
                                GetDataModelODataFeed,
                                true
                            }
                        }
                    ),
                    NavTable = Table.ToNavigationTable(
                        objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf"
                    )
                in
                    NavTable
            else
                error Error.Record("DataSource.Error", "No access to CDF project " & project)
    in
        navTable;

GraphQL = Value.ReplaceType(GraphQLImpl, GraphQLType);
GraphQLImpl = (space as text, datamodel as text, version as text, query as text, optional variables as nullable text) as table =>
    let
        organization = Extension.CurrentCredential()[Properties][Organization]?,
        project =
            if Record.HasFields(Extension.CurrentCredential()[Properties], "ProjectName") then
                Extension.CurrentCredential()[Properties][ProjectName]
            else
                Extension.CurrentCredential()[Properties][Project]?,
        urls = createUrls(project, organization),
        apiUrl = urls[ApiUrl],
        request_url = apiUrl
            & "/api/v1/projects/"
            & project
            & "/userapis/spaces/"
            & space
            & "/datamodels/"
            & datamodel
            & "/versions/"
            & version
            & "/graphql",

        // validate if the variables is valid JSON
        variablesRecord = if variables <> null then
            try
                Json.Document(variables)
            otherwise
                error Error.Record("CogniteConnectorError", "Invalid JSON in variables", variables)
        else
            [],

        Source =
            if Text.Contains(query, "$cursor") then
                GetAllGraphQLPagesByCursor(request_url, query, variablesRecord)
            else
                // no paging
                GetGraphQLPage(request_url, query, variablesRecord, null)
    in
        Source;

GraphQLType = type function (
    space as (
        type text meta [
            Documentation.FieldDescription = "Data model space",
            Documentation.SampleValues = {"Movie"}
        ]
    ),
    datamodel as (
        type text meta [
            Documentation.FieldDescription = "Data model name",
            Documentation.SampleValues = {"MovieDM"}
        ]
    ),
    version as (
        type text meta [
            Documentation.FieldDescription = "Data model version",
            Documentation.SampleValues = {"7"}
        ]
    ),
    query as (
        type text meta [
            Documentation.FieldDescription = Extension.LoadString("GraphQLQueryDescription"),
            Documentation.SampleValues = {Extension.LoadString("GraphQLQuerySample")},
            Formatting.IsMultiLine = true,
            Formatting.IsCode = true
        ]
    ),
    optional variables as (
        type text meta [
            Documentation.FieldDescription = Extension.LoadString("GraphQLVariablesDescription"),
            Documentation.SampleValues = {Extension.LoadString("GraphQLVariablesSample")},
            Formatting.IsMultiLine = true,
            Formatting.IsCode = true
        ]
    )
) as table meta [
    Documentation.Name = "GraphQL",
    Documentation.LongDescription = "GraphQL queries"
];

PostCDF = Value.ReplaceType(PostCDFImpl, PostCDFType);
PostCDFImpl = (url as text, body as text) as table =>
    let
        organization = Extension.CurrentCredential()[Properties][Organization]?,
        project =
            if Record.HasFields(Extension.CurrentCredential()[Properties], "ProjectName") then
                Extension.CurrentCredential()[Properties][ProjectName]
            else
                Extension.CurrentCredential()[Properties][Project]?,
        urls = createUrls(project, organization),
        apiUrl = urls[ApiUrl],
        request_url = apiUrl & "/api/v1/projects/" & project & url
    in
        GetAllPagesByCursor(request_url, body);

PostCDFType = type function (
    url as (
        type text meta [
            Documentation.FieldDescription = "API path of url",
            Documentation.SampleValues = {"/assets/list", "/timeseries/list"}
        ]
    ),
    body as (
        type text meta [
            Documentation.FieldDescription = "Body of the POST request",
            Documentation.SampleValues = {"{""limit"": 1000}"},
            Formatting.IsMultiLine = true,
            Formatting.IsCode = true
        ]
    )
) as table meta [
    Documentation.Name = "PostCDF",
    Documentation.LongDescription = "CDF REST API POST request"
];

GetCDF = Value.ReplaceType(GetCDFImpl, GetCDFType);
GetCDFImpl = (url as text) as table =>
    let
        organization = Extension.CurrentCredential()[Properties][Organization]?,
        project =
            if Record.HasFields(Extension.CurrentCredential()[Properties], "ProjectName") then
                Extension.CurrentCredential()[Properties][ProjectName]
            else
                Extension.CurrentCredential()[Properties][Project]?,
        urls = createUrls(project, organization),
        apiUrl = urls[ApiUrl],
        request_url = if url = "/token/inspect" then apiUrl & "/api/v1" & url else apiUrl
            & "/api/v1/projects/"
            & project
            & url
    in
        GetAllPagesByCursor(request_url);

GetCDFType = type function (
    url as (
        type text meta [
            Documentation.FieldDescription = "API path of url",
            Documentation.SampleValues = {"/assets", "/timeseries"}
        ]
    )
) as table meta [
    Documentation.Name = "GetCDF",
    Documentation.LongDescription = "CDF REST API GET request"
];

TimeseriesAggregateType = type function (
    Tags as (
        type list meta [
            Documentation.FieldDescription = Extension.LoadString("TimeseriesAggregateTagsDescription"),
            Documentation.SampleValues = {"tag1"}
        ]
    ),
    Granularity as (
        type text meta [
            Documentation.FieldDescription = Extension.LoadString("TimeseriesAggregateGranularityDescription"),
            Documentation.SampleValues = {"1d"}
        ]
    ),
    Start as (
        type datetimezone meta [
            Documentation.FieldDescription = Extension.LoadString("TimeseriesAggregateStartDescription"),
            Documentation.SampleValues = {"1-Jan-2018"}
        ]
    ),
    optional End as (
        type datetimezone meta [
            Documentation.FieldDescription = Extension.LoadString("TimeseriesAggregateEndDescription"),
            Documentation.SampleValues = {"1-Jan-2020"}
        ]
    )
) as table meta [
    Documentation.Name = Extension.LoadString("TimeseriesAggregate"),
    Documentation.LongDescription = Extension.LoadString("TimeseriesAggregateDescription")
];

TimeseriesAggregate = (TimeSeriesAggregatesFunction as function) as function =>
    let
        ReplacementFunction = (
            Tags as list, Granularity as text, Start as datetimezone, optional End as datetimezone
        ) as table =>
            let
                Tags = List.Transform(Tags, (x) => Uri.EscapeDataString(x)),
                partitions = PartitionTags(Tags),
                // The query returns a record with a table that we can expand later.
                query = (Tags as text) =>
                    [Expandable = TimeSeriesAggregatesFunction(Uri.EscapeDataString(Tags), Granularity, Start, End)],
                // Apply query to list of partitions
                aggregates = List.Transform(partitions, query),
                // Combine the result. We use Table.Expand* instead of Table.Combine in order to handle a high number
                // of tables and avoid duplicate queries.
                recordsTable = Table.FromRecords(aggregates),
                firstTable = List.First(aggregates)[Expandable],
                columnNames = Table.ColumnNames(firstTable),
                result = Table.ExpandTableColumn(recordsTable, "Expandable", columnNames),
                // Result has lost its type, so use type of first table in aggregates
                typedResult = Value.ReplaceType(result, Value.Type(firstTable))
            in
                typedResult
    in
        Value.ReplaceType(ReplacementFunction, TimeseriesAggregateType);

// Accepts a list of tags of Text type. Yields a list with comma separated tags
// Example: input={"1","2","3","4","5"}, output={"1,2,3,4","5"}
// Splits this list into multiple partitions (lists) and concatenates the text elements in each partition with ',' delimiters.
// The maximum size of a partition is defined in CogniteDefaults, and is used to restrict the size of each request to CDF.
PartitionTags = (InputTagList as list) as list =>
    let
        maxTagSize = List.Max(List.Transform(InputTagList, Text.Length)) + 3,
        // Add 3 for one escaped comma per tag, i.e %2C
        partitions = Number.IntegerDivide(CogniteDefaults[MaxUriSize], maxTagSize),
        nTags = List.Count(InputTagList),
        partitionSize = List.Min({nTags, partitions}),
        partitioned = List.Split(InputTagList, partitionSize),
        joinPartitionTextWithComma = (tagList as list) as text => Text.Combine(tagList, ","),
        stringsJoinedPerPartition = List.Transform(partitioned, joinPartitionTextWithComma)
    in
        stringsJoinedPerPartition;

GetODataFeed = Value.ReplaceType(GetODataFeedImpl, GetODataFeedType);
GetODataFeedImpl = (url as text, optional apiVersion as text) as table =>
    let
        organization = Extension.CurrentCredential()[Properties][Organization]?,
        project =
            if Record.HasFields(Extension.CurrentCredential()[Properties], "ProjectName") then
                Extension.CurrentCredential()[Properties][ProjectName]
            else
                Extension.CurrentCredential()[Properties][Project]?,
        urls = createUrls(project, organization),
        apiUrl = urls[ApiUrl],
        apiVersion = if apiVersion <> null then apiVersion else CogniteDefaults[ApiVersion],
        path = Text.Combine({"/odata", apiVersion, "projects", url}, "/"),
        queryUrl = Text.Combine({apiUrl, path}),
        headers = [#"x-cdp-app" = "CogniteDataSourcePowerBIConnector:" & CogniteDefaults[Version]],
        source = OData.Feed(
            queryUrl, null, [Concurrent = true, Implementation = "2.0", MaxUriLength = 32768, Headers = headers]
        ),
        rowsToReplace = Table.SelectRows(
            source, each Record.HasFields(_, {"Name"}) and [Name] = "TimeseriesAggregate"
        ),
        resultTable =
            if Table.RowCount(rowsToReplace) = 1 then
                let
                    rowToReplace = rowsToReplace{0},
                    timeseriesAggregate = TimeseriesAggregate(rowToReplace[Data]),
                    offset = Table.PositionOf(source, rowToReplace, 0, "Name"),
                    // Modify the OData table to include custom TimeseriesAggregate function
                    source2 = Table.RemoveMatchingRows(source, {[Name = "TimeseriesAggregate"]}, "Name"),
                    source3 = Table.InsertRows(
                        source2,
                        offset,
                        {
                            [
                                Name = "TimeseriesAggregate",
                                Data = timeseriesAggregate,
                                Signature = Value.ToText(timeseriesAggregate)
                            ]
                        }
                    )
                in
                    Value.ReplaceType(source3, Value.Type(source))
            else
                source
    in
        resultTable;

GetODataFeedType = type function (
    url as (
        type text meta [
            Documentation.FieldDescription = "URL of the OData endpoint (starting from the project name)",
            Documentation.SampleValues = {"publicdata/Timeseries"},
            Formatting.IsMultiLine = false,
            Formatting.IsCode = false
        ]
    ),
    optional apiVersion as (
        type text meta [
            Documentation.FieldDescription = "OData API version",
            Documentation.SampleValues = {CogniteDefaults[ApiVersion]},
            Formatting.IsMultiLine = false,
            Formatting.IsCode = false
        ]
    )
) as table meta [
    Documentation.Name = "GetODataFeed",
    Documentation.LongDescription = "CDF OData Feed"
];

GetDataModelODataFeed = Value.ReplaceType(GetDataModelODataFeedImpl, GetDataModelODataFeedType);
GetDataModelODataFeedImpl = (space as text, datamodel as text, version as text, optional apiVersion as text) =>
    let
        usedApiVersion = if apiVersion <> null then apiVersion else CogniteDefaults[DMApiVersion],
        organization = Extension.CurrentCredential()[Properties][Organization]?,
        project =
            if Record.HasFields(Extension.CurrentCredential()[Properties], "ProjectName") then
                Extension.CurrentCredential()[Properties][ProjectName]
            else
                Extension.CurrentCredential()[Properties][Project]?,
        urls = createUrls(project, organization),
        apiUrl = urls[ApiUrl],
        request_url = project & "/models/spaces/" & space & "/datamodels/" & datamodel & "/versions/" & version
    in
        GetODataFeed(request_url, usedApiVersion);

GetDataModelODataFeedType = type function (
    space as (
        type text meta [
            Documentation.FieldDescription = "Data model space",
            Documentation.SampleValues = {"Movie"}
        ]
    ),
    datamodel as (
        type text meta [
            Documentation.FieldDescription = "Data model name",
            Documentation.SampleValues = {"MovieDM"}
        ]
    ),
    version as (
        type text meta [
            Documentation.FieldDescription = "Data model version",
            Documentation.SampleValues = {"7"}
        ]
    ),
    optional apiVersion as (
        type text meta [
            Documentation.FieldDescription = "OData API version",
            Documentation.SampleValues = {CogniteDefaults[DMApiVersion]}
        ]
    )
) as table meta [
    Documentation.Name = "GetDataModelODataFeed",
    Documentation.LongDescription = "Get OData feed from DataModel"
];

GetEnvironmentFromOrganization = (org as text, proj as text) as record =>
    let
        // https://auth.cognite.com/api/v1/orgs/<org>/projects
        // returns a JSON list of projects in the organization including the API url.
        // Extract the base project name without query parameters
        beforeQueryParams = Text.BeforeDelimiter(proj, "?"),
        // if the project contains a path, we get the base project name
        baseProjectName = Text.BeforeDelimiter(beforeQueryParams, "/"),
        url =
            if org <> null then
                "https://auth.cognite.com/api/v1/orgs/" & org & "/projects"
            else
                error Error.Record("DataSource.Error", "Organization not set. Re-login and specify organization."),
        responseCodes = {200, 401},
        endpointResponse = Web.Contents(url, [ManualStatusHandling = responseCodes])
    in
        if (List.Contains({200}, Value.Metadata(endpointResponse)[Response.Status]?)) then
            let
                result = Json.Document(endpointResponse),
                // Extract the API url from the item where the project name matches the input project name.
                // The API url is the base URL for the service.
                projectItem = List.First(List.Select(result[items], each _[name] = baseProjectName), null)
            in
                if (projectItem <> null) then
                    projectItem
                else
                    error
                        Error.Record(
                            "DataSource.Error",
                            Extension.LoadString("ProjectMissingError"),
                            [
                                #"Organization" = org,
                                #"Project" = proj
                            ]
                        )
        else
            null;

// Read all pages of data.
// After every page, we check the "Cursor" record on the metadata of the previous request.
// Table.GenerateByPage will keep asking for more pages until we return null.
GetAllPagesByCursor = (url as text, optional payload as text) as table =>
    let
        RawPages =
            Table.GenerateByPage(
                (previous) =>
                    let
                        // if previous is null, then this is our first page of data
                        nextCursor =
                            if previous = null then
                                null
                            else
                                Value.Metadata(previous)[Cursor]?,

                        // if nextCursor was set to null by the previous call, we know we have no more data
                        // if previous = null it's the first page
                        page =
                            if previous = null then
                                // first page
                                GetPage(url, null, payload)
                            else if nextCursor <> null then
                                // pages
                                GetPage(url, nextCursor, payload)
                            else
                                // last page
                                null
                    in
                        page
            ),

        // There are some cases where the API returns a cursor but there is no more data
        // Here we drop empty rows, where every field is null
        CleanedPages =
            Table.SelectRows(
                RawPages,
                each List.NonNullCount( Record.ToList(_) ) > 0
            )
    in
        CleanedPages;

GetAllGraphQLPagesByCursor = (url as text, payload as text, variables as record) as table =>
    Table.GenerateByPage(
        (previous) =>
            let
                // if previous is null, then this is our first page of data
                nextCursor = if (previous = null) then null else Value.Metadata(previous)[Cursor]?,
                // if nextCursor was set to null by the previous call, we know we have no more data
                // if previous = null it's the first page
                page =
                    if previous = null then
                        // first page
                        GetGraphQLPage(url, payload, variables, null)
                    else if (nextCursor <> null) then
                        // pages
                        let
                            items = GetGraphQLPage(url, payload, variables, nextCursor),
                            pageitems = if Table.RowCount(items) = 0
                            // return null instead of empty table
                            then
                                null
                            else
                                items
                        in
                            pageitems
                    else
                        // last page
                        null
            in
                page
    );

GetPage = (url as text, optional cursor as text, optional payload as text) as table =>
    let
        headers = [
            #"Content-Type" = "application/json",
            #"x-cdp-app" = "CogniteDataSourcePowerBIConnector:" & CogniteDefaults[Version]
        ],
        // Append cursor to URL if needed
        url_with_cursor =
            if cursor <> null and payload = null and Text.Contains(url, "?") then
                Text.Combine({url, "&cursor=", cursor})
            else if cursor <> null and payload = null then
                Text.Combine({url, "?cursor=", cursor})
            else
                url,
        // Extract cluster from URL
        cluster = Text.BeforeDelimiter(Text.AfterDelimiter(url, "https://"), "."),

        // validate if the payload is valid JSON
        validatePayload = if payload <> null then
            try
                Json.Document(payload)
            otherwise
                error Error.Record("CogniteConnectorError", "Invalid JSON body", payload)
        else
            null,

        // Status codes that won't raise an error automatically, so we can fetch the error message from the response
        statusToRaise = {400, 403, 429, 500},
        // build the request for the different cases

        request = [
            Headers = headers,
            ManualStatusHandling = statusToRaise
        ]
            & (
                // POST request with cursor
                if validatePayload <> null and cursor <> null then
                    [Content = Json.FromValue(Record.AddField(validatePayload, "cursor", cursor))]
                    // POST request without cursor
                else if validatePayload <> null then
                    [Content = Json.FromValue(validatePayload)]
                    // GET request -> no Content
                else
                    []
            ),
        response = Web.Contents(url_with_cursor, request),
        // Parse the response
        responseMetadata = Value.Metadata(response),
        responseHeaders = Record.FieldOrDefault(responseMetadata, "Headers", []),
        requestId = Record.FieldOrDefault(responseHeaders, "x-request-id", null),
        code = responseMetadata[Response.Status],
        responseJson = Json.Document(response),
        errorDetails = Record.FieldOrDefault(responseJson, "error", null),
        errorMessage =
            if Record.HasFields(errorDetails, "message") then
                errorDetails[message]
            else if Value.Is(errorDetails, type text) then
                errorDetails
            else
                null,
        raiseMessage =
            if errorDetails <> null then
                errorMessage & " | code: " & Text.From(code) & " | X-Request-ID: " & requestId & " | cluster: " & cluster
            else
                null,
        result =
            if errorDetails <> null and List.Contains(statusToRaise, code) then
                error Error.Record("CogniteAPIError", raiseMessage, errorDetails)
            else if List.Contains(statusToRaise, code) then
                error
                    Error.Record(
                        "CogniteAPIError",
                        "HTTP error " & Text.From(code),
                        Text.FromBinary(Json.FromValue(responseJson))
                    )
            else
                // if we got this far, we have a valid response
                // let's try to post-process the response to make it more tabular and easier to work with in Power BI
                // but if this fails, we'll throw an error and mention the particular endpoint is not supported yet
                try
                    let
                        // special handling for some endpoints (need to check what other endpoints return a weird structure)
                        // DMS query -> '/models/instances/query'
                        preProcessing =
                            if Text.EndsWith(url, "/models/instances/query") then
                                let
                                    // Get all field names
                                    Fields = Record.FieldNames(responseJson),
                                    // Convert each field into a table and rename columns
                                    FieldTables = List.Transform(
                                        Fields,
                                        each
                                            let
                                                FieldTable = Record.ToTable(Record.Field(responseJson, _)),
                                                RenamedTable = Table.RenameColumns(
                                                    FieldTable, {{"Name", "resultExpression"}, {"Value", _}}
                                                )
                                            in
                                                RenamedTable
                                    ),
                                    // Merge all tables together based on resultExpression
                                    MergedTable = List.Accumulate(
                                        List.Skip(FieldTables, 1),
                                        List.First(FieldTables),
                                        (state, current) =>
                                            Table.Join(
                                                state, "resultExpression", current, "resultExpression",
                                                JoinKind.Inner
                                            )
                                    )
                                in
                                    // this is a table with 1 or more items (depending on the query)
                                    MergedTable
                            else
                                // this is a record
                                responseJson,
                        // case 1 - normal API response
                        case =
                            if (Type.Is(Value.Type(preProcessing), type record)) then
                                "record"
                                // case 2 - table
                            else if (Type.Is(Value.Type(preProcessing), type table)) then
                                "table"
                            else
                                error
                                    Error.Record(
                                        "CogniteConnectorError",
                                        "Unsupported response type: " & Value.Type(preProcessing)
                                    ),
                        // In case the nextCursor is in a table, we need special logic to inject it into the next request
                        // so we won't be supporting that for now
                        nextCursor = if case = "record" then GetCursor(preProcessing) else null,
                        data =
                            if case = "record" then
                                let
                                    // confirm if the items field is present and if it is a list
                                    finalData =
                                        if
                                            Record.HasFields(preProcessing, "items")
                                            and Type.Is(Value.Type(preProcessing[items]), type list)
                                        then
                                            Table.FromRecords(preProcessing[items], null, MissingField.UseNull)
                                        else
                                            Table.FromRecords({preProcessing}, null, MissingField.UseNull)
                                in
                                    finalData
                            else
                                preProcessing
                    in
                        data meta [Cursor = nextCursor]
                    otherwise error Error.Record("CogniteConnectorError", "Unsupported endpoint: " & url)
    in
        result;

GetGraphQLPage = (url as text, payload as text, variables as record, optional cursor as text) as table =>
    let
        headers = [
            #"Content-Type" = "application/json",
            #"x-cdp-app" = "CogniteDataSourcePowerBIConnector:" & CogniteDefaults[Version]
        ],
        // Extract cluster from URL
        cluster = Text.BeforeDelimiter(Text.AfterDelimiter(url, "https://"), "."),
        // cursor is a special variable and should not be included in the variables record
        validateVariables =
            if Record.HasFields(variables, "cursor") then
                error
                    Error.Record(
                        "CogniteConnectorError",
                        "'cursor' is a reserved variable name and cannot be included in the variables field."
                    )
            else
                variables,
        variablesUpdated = validateVariables & (if cursor <> null then [cursor = cursor] else []),
        // Status codes that won't raise an error automatically, so we can fetch the error message from the response
        statusToRaise = {400, 403, 429, 500},
        postData = Json.FromValue([query = payload, variables = variablesUpdated]),
        response = Web.Contents(url, [
            Headers = headers,
            Content = postData
        ]),
        // Parse the response
        responseMetadata = Value.Metadata(response),
        responseHeaders = Record.FieldOrDefault(responseMetadata, "Headers", []),
        requestId = Record.FieldOrDefault(responseHeaders, "x-request-id", null),
        code = responseMetadata[Response.Status],
        responseJson = Json.Document(response),
        errorDetails = Record.FieldOrDefault(responseJson, "error", null),
        errorMessage =
            if Record.HasFields(errorDetails, "message") then
                errorDetails[message]
            else if Value.Is(errorDetails, type text) then
                errorDetails
            else
                null,
        raiseMessage =
            if errorDetails <> null then
                errorMessage & " | code: " & Text.From(code) & " | X-Request-ID: " & requestId & " | cluster: " & cluster
            else
                null,
        data =
            if errorDetails <> null and List.Contains(statusToRaise, code) then
                error Error.Record("CogniteAPIError", raiseMessage, errorDetails)
            else if List.Contains(statusToRaise, code) then
                error Error.Record("CogniteAPIError", "HTTP error " & Text.From(code), responseJson)
            else if Record.HasFields(responseJson, "data") then
                responseJson[data]
            else if Record.HasFields(responseJson, "errors") then
                // passing a string works best for the error messages
                error
                    Error.Record(
                        "CogniteAPIError", "GraphQL error", Text.FromBinary(Json.FromValue(responseJson[errors]))
                    )
            else
                error
                    Error.Record(
                        "CogniteConnectorError",
                        "Unknown error parsing query result",
                        // passing a string works best for the error messages
                        Text.FromBinary(Json.FromValue(responseJson))
                    ),
        listName = Record.FieldNames(data){0},
        listItems = Record.Field(data, listName),
        items = listItems[items],
        result =
            if List.Count(items) = 0 then
                Table.FromList(items, Splitter.SplitByNothing(), {listName}, null, ExtraValues.Error)
            else
                let
                    converted_to_table = Table.FromList(
                        items, Splitter.SplitByNothing(), {listName}, null, ExtraValues.Error
                    ),
                    fieldNames = Record.FieldNames(items{0}),
                    resulttable = Table.ExpandRecordColumn(converted_to_table, listName, fieldNames)
                in
                    resulttable,
        nextCursor = GetCursorGraphQL(listItems)
    in
        result meta [Cursor = nextCursor];

GetCursor = (response) as nullable text => Record.FieldOrDefault(response, "nextCursor", null);
GetCursorGraphQL = (response) as nullable text =>
    let
        pageInfo = Record.FieldOrDefault(response, "pageInfo", null),
        hasNextPage = Record.FieldOrDefault(pageInfo, "hasNextPage", false),
        cursor = if hasNextPage = true then Record.FieldOrDefault(pageInfo, "endCursor", null) else null
    in
        cursor;

// Validation functions
isUrl = (input as text) => Text.StartsWith(input, "https://");

isCleanInputField = (input as text, optional allowQuery as logical) =>
    let
        // allowQuery defaults to false
        allowQuery = if allowQuery = null then false else allowQuery,
        // Check if the input field contains a URL
        hasUrl = isUrl(input),
        // Check if the input field contains a path
        hasPath = Text.Contains(input, "/"),
        // If query parameters are not allowed, check if the input field contains a query parameter
        hasQuery = if allowQuery then false else Text.Contains(input, "?"),
        // Check if the input field is a URL or contains a path or contains a query parameter
        hasInvalidChars = hasUrl or hasPath or hasQuery
    in
        not hasInvalidChars;

hasCDFAccess = (project as text) =>
    let
        token = GetCDF("/token/inspect"),
        projects = token{0}[projects],
        projectList = Table.FromList(projects, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
        projectNames = Table.ExpandRecordColumn(projectList, "Column1", {"projectUrlName"}, {"projectUrlName"}),
        projectItem = List.First(List.Select(projectNames, each _[projectUrlName] = project), null),
        nameList = Table.ExpandRecordColumn(
            projectList, "Column1", {"projectUrlName"}, {"projectUrlName"}
        )[projectUrlName],
        // for the case where the project name contains a query parameter
        projectBeforeQueryParams = Text.BeforeDelimiter(project, "?"),
        hasAccess = if List.Contains(nameList, projectBeforeQueryParams) then true else false
        //Error.Record("DataSource.Error", "No access to CDF project " & project)
    in
        hasAccess;

//
// Load common library functions
//
// TEMPORARY WORKAROUND until we're able to reference other M modules
Extension.LoadFunction = (name as text) =>
    let
        binary = Extension.Contents(name), asText = Text.FromBinary(binary)
    in
        Expression.Evaluate(asText, #shared);

Value.ToText = Extension.LoadFunction("Value.ToText.pqm");

Table.GenerateByPage = Extension.LoadFunction("Table.GenerateByPage.pqm");
Table.ToNavigationTable = Extension.LoadFunction("Table.ToNavigationTable.pqm");
