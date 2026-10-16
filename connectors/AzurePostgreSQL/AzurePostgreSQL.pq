// Connector that mocks PostgreSQL
[Version = "1.3.2"]
section AzurePostgreSQL;

AzurePostgresResourceRecord = [
    global = "https://ossrdbms-aad.database.windows.net",
    germany = "https://ossrdbms-aad.database.cloudapi.de",
    gcc = "https://ossrdbms-aad.database.usgovcloudapi.net",
    gcc_high = "https://ossrdbms-aad.database.usgovcloudapi.net",
    gcc_dod = "https://ossrdbms-aad.database.usgovcloudapi.net",
    china = "https://ossrdbms-aad.database.chinacloudapi.cn"
];
DefaultCloud = "global";
Cloud = Environment.FeatureSwitch("Cloud", DefaultCloud);
AzurePostgresResource = Record.FieldOrDefault(
    AzurePostgresResourceRecord, Cloud, Record.Field(AzurePostgresResourceRecord, DefaultCloud)
);

ResourcePathSeparator = ";";

[DataSource.Kind = "AzurePostgreSQL", Publish = "AzurePostgreSQL.Publish"]
shared AzurePostgreSQL.Database = Value.ReplaceType(AzurePostgreSQL.DatabaseImpl, AzurePostgreSQLDataBaseType);

AzurePostgreSQL.DatabaseImpl = (server as text, database as text, optional options as record) =>
    let
        validatedOptions = ValidateOptions(options, OptionsMap),
        result = InvokePostgresSqlDatabaseImpl(server, database, validatedOptions)
    in
        result;

InvokePostgresSqlDatabaseImpl = (server as text, database as text, optional options as record) =>
    Extension.InvokeWithCredentials(
        (datasource) => Extension.CurrentCredential(), () => PostgreSQL.Database(server, database, options)
    );

OptionsMap = #table(
    {"Name", "Type", "Default", "Validate", "Hidden"},
    {{"CommandTimeout", type nullable duration, null, each _ = null or _ >= Duration.From(0.0), false}}
);

ValidateOptions = (options, validOptionsMap) as record =>
    let
        VisibleKeys = Table.SelectRows(validOptionsMap, each not [Hidden])[Name],
        ValidKeys = Table.Column(validOptionsMap, "Name"),
        InvalidKey = List.First(List.Difference(Record.FieldNames(options), ValidKeys)),
        InvalidKeyText = Text.Format(
            Extension.LoadString("InvalidOptionsKey"), {InvalidKey, Text.Combine(VisibleKeys, ",")}
        ),
        ValidateValue = (name, optionType, default, validate, value) =>
            if
                (value is null and (Type.IsNullable(optionType) or default <> null))
                or (Type.Is(Value.Type(value), optionType) and validate(value))
            then
                null
            else
                Text.Format(Extension.LoadString("InvalidOptionsValue"), {name, value}),
        InvalidValues = List.RemoveNulls(
            Table.TransformRows(
                validOptionsMap,
                each
                    ValidateValue(
                        [Name], [Type], [Default], [Validate], Record.FieldOrDefault(options, [Name], [Default])
                    )
            )
        ),
        DefaultOptions = Record.FromTable(
            Table.RenameColumns(Table.SelectColumns(validOptionsMap, {"Name", "Default"}), {"Default", "Value"})
        ),
        NullNotAllowedFields = List.RemoveNulls(
            Table.TransformRows(
                validOptionsMap,
                each
                    if not Type.IsNullable([Type]) and null = Record.FieldOrDefault(options, [Name], [Default]) then
                        [Name]
                    else
                        null
            )
        ),
        NormalizedOptions = DefaultOptions & Record.RemoveFields(options, NullNotAllowedFields, MissingField.Ignore),
        Result =
            if null = options then
                DefaultOptions
            else if null <> InvalidKey then
                error Error.Record("Expression.Error", InvalidKeyText)
            else if not List.IsEmpty(InvalidValues) then
                error Error.Record("Expression.Error", List.First(InvalidValues))
            else
                NormalizedOptions
    in
        Result;

MakeResourcePath = (server as text, database as text) as text => server & ResourcePathSeparator & database;

ParseResourcePath = (resourcePath as text) as list =>
    let
        resourcePathValue = Text.Split(resourcePath, ResourcePathSeparator),
        resourcePathList = List.ReplaceValue(
            resourcePathValue,
            List.First(resourcePathValue),
            Text.Lower(List.First(resourcePathValue)),
            Replacer.ReplaceText
        )
    in
        resourcePathList;

AzurePostgreSQLDataBaseType =
    let
        CommandTimeoutType = type nullable duration meta [
            Documentation.FieldCaption = Extension.LoadString("CommandTimeoutCaption"),
            Documentation.SampleValues = {#duration(0, 1, 2, 3)}
        ],
        FunctionType = Type.ForFunction(
            [
                Parameters = [
                    server = type text meta [
                        Documentation.FieldCaption = Extension.LoadString("ServerParameterCaption"),
                        Documentation.FieldDescription = Extension.LoadString("ServerParameterCaptionDescription"),
                        Documentation.SampleValues = {"my-pg-sql-server.database.windows.net"}
                    ],
                    database = type text meta [
                        Documentation.FieldCaption = Extension.LoadString("DatabaseParameterCaption"),
                        Documentation.FieldDescription = Extension.LoadString("DatabaseParameterCaptionDescription"),
                        Documentation.SampleValues = {"my-database"}
                    ],
                    options = type [optional CommandTimeout = CommandTimeoutType] meta [
                        Documentation.FieldCaption = Extension.LoadString("OptionsParameterCaption")
                    ]
                ],
                ReturnType = type table
            ],
            2
        ),
        AddMetadata = Value.ReplaceMetadata(
            FunctionType,
            [
                Documentation.Name = Extension.LoadString("AzurePostgreSQL_Name"),
                Documentation.Caption = Extension.LoadString("AzurePostgreSQL_Caption"),
                Documentation.Description = Extension.LoadString("AzurePostgreSQL_Description"),
                Documentation.LongDescription = Extension.LoadString("AzurePostgreSQL_LongDescription")
            ]
        )
    in
        AddMetadata;

// Data Source Kind description
AzurePostgreSQL = [
    Type = "Custom",
    MakeResourcePath = MakeResourcePath,
    ParseResourcePath = ParseResourcePath,
    TestConnection = (resourcePath) => {"AzurePostgreSQL.Database"} & ParseResourcePath(resourcePath),
    Authentication = [
        // Key = [],
        UsernamePassword = [],
        // Windows = [],
        // Anonymous = []
        Aad = [
            AuthorizationUri = Uri.Combine(
                Environment.FeatureSwitch("AzureActiveDirectoryUri", "https://login.microsoftonline.com"),
                "/common/oauth2/authorize"
            ),
            Resource = AzurePostgresResource
        ]
    ],
    SupportsEncryption = true
];

// Data Source UI publishing description
AzurePostgreSQL.Publish = [
    Category = "Database",
    ButtonText = {Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp")},
    SourceImage = AzurePostgreSQL.Icons,
    SourceTypeImage = AzurePostgreSQL.Icons
];

AzurePostgreSQL.Icons = [
    Icon16 = {
        Extension.Contents("AzurePostgreSQL16.png"),
        Extension.Contents("AzurePostgreSQL20.png"),
        Extension.Contents("AzurePostgreSQL24.png"),
        Extension.Contents("AzurePostgreSQL32.png")
    },
    Icon32 = {
        Extension.Contents("AzurePostgreSQL32.png"),
        Extension.Contents("AzurePostgreSQL40.png"),
        Extension.Contents("AzurePostgreSQL48.png"),
        Extension.Contents("AzurePostgreSQL64.png")
    }
];
