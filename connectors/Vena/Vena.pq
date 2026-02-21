// This file contains the Data Connector logic for the Vena connector

// Version Information for Microsoft certification and easy tracking
[Version = "1.1.0"]

// Connector Metadata
// Version: 1.1.0
// Description: This connector retrieves data from Vena, providing access to your data via Power BI.

section Vena;

pbic_version = "1.1.0";  // The version used by the connector internally
[DataSource.Kind="Vena", Publish="Vena.Publish"]
shared Vena.Contents = Value.ReplaceType(VenaImpl, VenaInputs);

// Defines the inputs the connector expects 
VenaInputs = type function (
    source as (type text meta [
        Documentation.FieldCaption = "Source Region",
        Documentation.FieldDescription = "The Region Where Your Vena Data Is Hosted.",
        Documentation.AllowedValues = {
            //For drop down options
            "https://ca3.vena.io",
            "https://ca4.vena.io",
            "https://eu1.vena.io",
            "https://eu2.vena.io",
            "https://eu3.vena.io",
            "https://us1.vena.io",
            "https://us2.vena.io",
            "https://us3.vena.io",
            "https://us4.vena.io",
            "https://us5.vena.io"
        }
    ]),
    optional modelQuery as (type text meta [
        Documentation.FieldCaption = "Model Query",
        Documentation.FieldDescription = "MQL Query For Your Hierarchies/Intersections.            " 
                                          & "Leaving This Field Blank Will Retrieve All Members And Intersections.",
        Documentation.SampleValues = { "dimension(..." }//Suggested input
    ]),
    optional apiVersion as (type text meta [
        Documentation.FieldCaption = "Endpoint version",
        Documentation.FieldDescription = "The format you want to pull Vena data in.  V2 now includes operators.",
        Documentation.AllowedValues = { "v1", "v2" }
    ]))
    as table meta [
        Documentation.Name = "Vena " & pbic_version,
        Documentation.LongDescription = "Vena"
    ];

VenaImpl = (source as text, optional modelQuery as text,optional apiVersion as text) as table =>
    let
        VenaBasic = 
        let
            Credentials = Extension.CurrentCredential(),
            apiUser = Credentials[Username],
            apiKey = Credentials[Password],
            b64 = Binary.ToText(Text.ToBinary(apiUser & ":" & apiKey), BinaryEncoding.Base64)
        in
            "Basic " & b64,


        apiVersion = if Value.Equals(apiVersion, null) then "" else apiVersion,
        CodeDTO = CodeDTO.Fetch(),
        Main = Expression.Evaluate(CodeDTO[Main.pqm], #shared),
        Utils = Expression.Evaluate(CodeDTO[Utils.pqm], #shared),

        result =
        let
            keyParam = let
                Credentials = Extension.CurrentCredential(),
                originalString = Credentials[Username],
                splitString = Text.Split(originalString, "."),
                delimiterCount = List.Count(splitString) - 1,
                extractedString = 
                    if delimiterCount = 0 then
                        // Case where there's no delimiter
                        originalString
                    else
                        // Case with multiple delimiters, choose the tenant ID (the second part)
                        // apiUser format: {user ID}.{tenant ID}
                        List.Last(splitString)
            in
                extractedString,

            splitNameParam = "insights_export-api_pbi-connector",    // split name

            // Get the Split Auth token from the splitConfig API
            authToken =
                let
                    splitConfigURL = source & "/api/splitConfig",
                    headers = [
                        Accept = "application/json"
                    ],

                    response = try Web.Contents(splitConfigURL, [Headers = headers, IsRetry = true]) otherwise null,

                    token = 
                        if response = null then
                            ""
                        else
                            try
                                let
                                    responseText = Text.FromBinary(response),
                                    parsedResponse = Json.Document(responseText),
                                    tokenValue = parsedResponse[token]
                                in
                                    tokenValue
                            otherwise ""
                in
                    token,

            headers = [
                Accept = "application/json",
                Authorization = authToken
            ],

            // Make the API GET request with error handling to fetch the treatment
            // (Use RelativePath, Query, and CredentialQuery to avoid logging PII)
            response = try Web.Contents(
                source,
                [
                    Headers = headers,
                    RelativePath = "/split-evaluator/client/get-treatment-with-config",
                    Query = [
                        #"split-name" = splitNameParam
                    ],
                    CredentialQuery = [
                        key = keyParam
                    ],
                    IsRetry = true
                ]
            ) otherwise null,

            // Check if the response is null due to a connection issue
            defaultPageSize = "120000", // default page size for paginated export API
            splitResult =
                if response = null then
                    [ ConfigType = "streaming", PageSize = defaultPageSize ]
                else
                    try
                        let
                            // Get the status code from the response metadata
                            statusCode = Value.Metadata(response)[Response.Status],
                            responseText = Text.FromBinary(response),

                            // Parse the JSON response based on the status code
                            resultRecord =
                                if statusCode = 200 then
                                    let
                                        parsedResponse = Json.Document(responseText),
                                        configText = try parsedResponse[config] otherwise null,
                                        configJson = try Json.Document(configText) otherwise [],
                                        configType = try configJson[type] otherwise "streaming",
                                        pageSize = try configJson[pageSize] otherwise defaultPageSize
                                    in
                                        if Value.Is(pageSize, type number) then
                                            [ ConfigType = configType, PageSize = pageSize ]
                                        else 
                                            [ ConfigType = configType, PageSize = defaultPageSize ]
                                else
                                    [ ConfigType = "streaming", PageSize = defaultPageSize ]
                        in
                            resultRecord
                    otherwise [ ConfigType = "streaming", PageSize = defaultPageSize ],

            configType = splitResult[ConfigType],
            pageSize = Text.From(splitResult[PageSize]) // in case PageSize is stored as a number in Split
        in
            Main(source, VenaBasic, Utils, pbic_version, apiVersion, configType, pageSize, modelQuery)
    in
        result;


CodeDTO.Fetch = () => [
                        Main.pqm = Text.FromBinary(Extension.Contents("Main.pqm")),
                        Utils.pqm = Text.FromBinary(Extension.Contents("Utils.pqm"))
                      ];

// Data Source Kind description
Vena = [
    TestConnection = (dataSourcePath) =>
    let
        json = Json.Document(dataSourcePath),
        source = json[source]
    in
        {"Vena.Contents", source},

    Authentication = [
        UsernamePassword = [
            UsernameLabel = "apiUser",
            PasswordLabel = "apiKey",
            Label = "Application Token"
        ]
    ],
    Label = Extension.LoadString("DataSourceLabel")
];

// Data Source UI publishing description
Vena.Publish = [
    Category = "Other",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://www.venasolutions.com/platform/microsoft/insights",
    SourceImage = Vena.Icons,
    SourceTypeImage = Vena.Icons
];

Vena.Icons = [
    Icon16 = { Extension.Contents("Vena16.png"), Extension.Contents("Vena20.png"), Extension.Contents("Vena24.png"), Extension.Contents("Vena32.png") },
    Icon32 = { Extension.Contents("Vena32.png"), Extension.Contents("Vena40.png"), Extension.Contents("Vena48.png"), Extension.Contents("Vena64.png") }
];
