[ Version = "1.0.2", Requires = [ Legacy = "[0.0,)", Extensibility = "[0.0,)", Kusto = "[0.0,)", Environment = "[0.0,)" ] ]
section MicrosoftSentinel;

valueOrDefault = (value, default) => if (value <> null) then value else default;

MicrosoftSentinelCluster = "https://api.securityplatform.microsoft.com/lake/kql";

_MicrosoftSentinel.ContentsDocs =
    let
        clusterType = type text meta [
            Documentation.FieldCaption = Extension.LoadString("MicrosoftSentinel.Contents.Cluster.Name"),
            Documentation.SampleValues = { Extension.LoadString("MicrosoftSentinel.Contents.Cluster.Sample") },
            Documentation.DefaultValue = MicrosoftSentinelCluster
        ],
        databaseType = type text meta [
            Documentation.FieldCaption = Extension.LoadString("MicrosoftSentinel.Contents.Database.Name"),
            Documentation.SampleValues = { Extension.LoadString("MicrosoftSentinel.Contents.Database.Sample") }
        ],
        tableOrQueryType = type text meta [
            Documentation.FieldCaption = Extension.LoadString("MicrosoftSentinel.Contents.TableOrQuery"),
            Documentation.SampleValues = { Extension.LoadString("MicrosoftSentinel.Contents.TableOrQuery.Sample2"), Extension.LoadString("MicrosoftSentinel.Contents.TableOrQuery.Sample1") },
            Formatting.IsMultiLine = true,
            Formatting.IsCode = true
        ],
        maxRowsType = type number meta [
            Documentation.FieldCaption = Extension.LoadString("MicrosoftSentinel.Contents.MaxRows"),
            Documentation.SampleValues = { Extension.LoadString("MicrosoftSentinel.Contents.MaxRows.Sample") }
        ],
        maxSizeType = type number meta [
            Documentation.FieldCaption = Extension.LoadString("MicrosoftSentinel.Contents.MaxSize"),
            Documentation.SampleValues = { Extension.LoadString("MicrosoftSentinel.Contents.MaxSize.Sample") }
        ],
        noTruncateType = type logical meta [
            Documentation.FieldCaption = Extension.LoadString("MicrosoftSentinel.Contents.NoTruncate"),
            Documentation.SampleValues = { Extension.LoadString("MicrosoftSentinel.Contents.NoTruncate.Sample") }
        ],
        additionalSetStatementsType = type text meta [
            Documentation.FieldCaption = Extension.LoadString("MicrosoftSentinel.Contents.AdditionalSetStatements"),
            Documentation.SampleValues = { Extension.LoadString("MicrosoftSentinel.Contents.AdditionalSetStatements.Sample") }
        ],
        startTimeType = type text meta [
            Documentation.FieldCaption = Extension.LoadString("MicrosoftSentinel.Contents.StartTime"),
            Documentation.SampleValues = { Extension.LoadString("MicrosoftSentinel.Contents.StartTime.Sample") }
        ],
        endTimeType = type text meta [
            Documentation.FieldCaption = Extension.LoadString("MicrosoftSentinel.Contents.EndTime"),
            Documentation.SampleValues = { Extension.LoadString("MicrosoftSentinel.Contents.EndTime.Sample") }
        ],

        _Kusto.OptionsRecord = type [
            optional MaxRows=maxRowsType, 
            optional MaxSize=maxSizeType, 
            optional NoTruncate=noTruncateType,
            optional AdditionalSetStatements=additionalSetStatementsType,
            optional start=startTimeType,
            optional end=endTimeType
        ] meta [
            Documentation.FieldCaption = Extension.LoadString("MicrosoftSentinel.Contents.Options")
        ],
        t = type function (
            cluster as clusterType,
            optional database as databaseType,
            optional tableOrQuery as tableOrQueryType,
            optional options as _Kusto.OptionsRecord
            ) as table
    in 
        t meta [
            Documentation.Description = Extension.LoadString("MicrosoftSentinel.Contents.Function.Description"),
            Documentation.DisplayName = Extension.LoadString("MicrosoftSentinel.Contents.Function.DisplayName"),
            Documentation.Caption = Extension.LoadString("MicrosoftSentinel.Contents.Function.Caption"),
            Documentation.Name = Extension.LoadString("MicrosoftSentinel.Contents.Function.Name"),
            Documentation.LongDescription = Extension.LoadString("MicrosoftSentinel.Contents.Function.LongDescription"),
            Documentation.Examples = {[
                Description = Extension.LoadString("MicrosoftSentinel.Contents.Examples.Description"),
                Code = Extension.LoadString("MicrosoftSentinel.Contents.Examples.Code"),
                Result = Extension.LoadString("MicrosoftSentinel.Contents.Examples.Result")
            ]}
        ];

StringToDateTime = (value as text) =>
    let
        trimmedValue = Text.Trim(value),
        lastChar = Text.End(trimmedValue, 1),
        isTimeOffset = lastChar = "h" or lastChar = "d",
        result = if isTimeOffset then
            let
                numericPart = Number.FromText(Text.RemoveRange(trimmedValue, Text.Length(trimmedValue) - 1, 1)),
                offsethours = if lastChar = "h" then numericPart
                                else if lastChar = "d" then numericPart * 24
                                else 0,
                offset = #duration(0, offsethours, 0, 0),
                now = DateTimeZone.UtcNow()
            in
                now - offset
        else
            DateTime.FromText(trimmedValue)
    in
        result;

// AAD resource / scope resolved from Environment
AadResource = "4500ebfb-89b6-4b14-a480-7f749797bfcd";

AzureDataExplorerContents = (cluster as text, optional database as text, optional query as text, optional options as record) =>
    Extension.InvokeWithCredentials(
        (dataSource) => Extension.CurrentCredential(), 
        () => AzureDataExplorer.Contents(cluster, database, query, options));

MicrosoftSentinelImpl = (cluster as text, optional database as text, optional query as text, optional options as record) =>
    let
        _options = options ?? [],
        start = if options[start] <> null then StringToDateTime(options[start]) else null,
        end = if options[end] <> null then StringToDateTime(options[end]) else DateTimeZone.UtcNow(),
        _optionsWithTime = _options & [ AdditionalRequestFields = [ StartTime=start, EndTime=end ] ],
        result = AzureDataExplorerContents(cluster, database, query, _optionsWithTime)
    in
        result;

[DataSource.Kind = "MicrosoftSentinel", Publish = "MicrosoftSentinel.Publish"]
shared MicrosoftSentinel.Contents =  Value.ReplaceType(MicrosoftSentinelImpl, _MicrosoftSentinel.ContentsDocs);

MicrosoftSentinel =
[
    Type = "Custom",
    MakeResourcePath = (cluster) => cluster,
    ParseResourcePath = (resourcePath) => { resourcePath },    
    TestConnection = (resourcePath) => {"MicrosoftSentinel.Contents", resourcePath},
    Authentication = [
        Aad = [
            AuthorizationUri = "https://login.microsoftonline.com/common/oauth2/authorize",
            Resource = AadResource,
            Scope = ".default"
        ]
    ],
    Label = Extension.LoadString("MicrosoftSentinel.ResourceLabel")
];

MicrosoftSentinel.Publish =
[
    Beta = true,
    Category = "Other",
    SupportsDirectQuery = true,
    ButtonText = { Extension.LoadString("MicrosoftSentinel.Contents.ButtonText"), Extension.LoadString("MicrosoftSentinel.Contents.ButtonTextHelp") },
    SourceImage =   Sentinel.Icons,
    SourceTypeImage = Sentinel.Icons
];

Sentinel.Icons = [
    Icon16 = { Extension.Contents("Sentinel16.png"), Extension.Contents("Sentinel20.png"), Extension.Contents("Sentinel24.png"), Extension.Contents("Sentinel32.png")},
    Icon32 = { Extension.Contents("Sentinel32.png"), Extension.Contents("Sentinel40.png"), Extension.Contents("Sentinel48.png"), Extension.Contents("Sentinel64.png") }
];

AzureDataExplorer.Contents = try #shared[AzureDataExplorer.Contents] otherwise error "ADX function not loaded";
