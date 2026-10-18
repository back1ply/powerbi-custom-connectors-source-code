[Version = "1.0.4"]
section AzureDatabaseForMySQL;

ResourcePathSeparator = ";";
DEFAULT_PORT = "3306";

[DataSource.Kind = "AzureDatabaseForMySQL", Publish = "AzureDatabaseForMySQL.Publish"]
shared AzureDatabaseForMySQL.Database = Value.ReplaceType(AzureDatabaseForMySQL.DatabaseImpl, AzureDatabaseForMySQLDatabaseType);

AzureDatabaseForMySQL.DatabaseImpl = (server as text, database as text) =>
    Extension.InvokeWithCredentials(
        (datasource) => Extension.CurrentCredential(), () => MySQL.Database(server, database, [ReturnSingleDatabase = true])
    );

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

AzureDatabaseForMySQLDatabaseType =
    let
        FunctionType = Type.ForFunction(
            [
                Parameters = [
                    server = type text meta [
                        Documentation.FieldCaption = Extension.LoadString("serverFieldName"),
                        Documentation.SampleValues = {"azuremysql.mysql.database.azure.com:3306"}
                    ],
                    database = type text meta [
                        Documentation.FieldCaption = Extension.LoadString("databaseFieldName")
                    ]
                ],
                ReturnType = type table
            ],
            2
        ),
        AddMetadata = Value.ReplaceMetadata(
            FunctionType,
            [
                Documentation.Name = "Azure Database for MySQL",
                Documentation.Caption = Extension.LoadString("ButtonTitle"),
                Documentation.LongDescription = Extension.LoadString("ButtonHelp")
            ]
        )
    in
        AddMetadata;

// Data Source Kind description
AzureDatabaseForMySQL = [
    Type = "Custom",
    MakeResourcePath = MakeResourcePath,
    ParseResourcePath = ParseResourcePath,
    TestConnection = (resourcePath) => {"AzureDatabaseForMySQL.Database"} & ParseResourcePath(resourcePath),
    Authentication = [
        UsernamePassword = []
    ],
    SupportsEncryption = true
];

// Data Source UI publishing description
AzureDatabaseForMySQL.Publish = [
    Category = "Azure",
    ButtonText = {Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp")},
    SourceImage = AzureDatabaseForMySQL.Icons,
    SourceTypeImage = AzureDatabaseForMySQL.Icons
];

AzureDatabaseForMySQL.Icons = [
    Icon16 = {
        Extension.Contents("AzureDatabaseForMySQL_16.png"),
        Extension.Contents("AzureDatabaseForMySQL_20.png"),
        Extension.Contents("AzureDatabaseForMySQL_32.png"),
        Extension.Contents("AzureDatabaseForMySQL_40.png")
    },
    Icon32 = {
        Extension.Contents("AzureDatabaseForMySQL_32.png"),
        Extension.Contents("AzureDatabaseForMySQL_48.png"),
        Extension.Contents("AzureDatabaseForMySQL_64.png"),
        Extension.Contents("AzureDatabaseForMySQL_80.png")
    }
];
