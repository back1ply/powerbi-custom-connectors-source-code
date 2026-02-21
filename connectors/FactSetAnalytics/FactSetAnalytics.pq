// x-release-please-start-version
[Version = "2.6.0"]
section FactSetAnalytics;

Settings = [
    // Constants
    ApiHost = "https://api.factset.com",
    LongRunningDefaultDelay = 5,
    XFactSetConnectorVersion = "powerbi/enterprise/2.6.0",
    OAuth = [
        DialogLabel = "Using FactSet Login",
        ClientId = "power-bi-pkce",
        RedirectUri = "https://oauth.powerbi.com/views/oauthredirect.html",
        WellKnownUrl = "https://auth.factset.com/.well-known/openid-configuration",
        Scope = "",
        WindowHeight = 1000,
        WindowWidth = 1200
    ],
    ConnectorTitle = "FactSet",
    ConnectorHelp = "Connect to FactSet"
];
// x-release-please-end


// Functions
ApiLoader = Extension.LoadFunction("util-api-loader.pqm");
Stach = Extension.LoadFunction("convert-stach.pqm");
Request = Extension.LoadFunction("request-request.pqm");
LongRunning = Extension.LoadFunction("request-long-running.pqm");
Pagination = Extension.LoadFunction("request-pagination.pqm");

// Analytics Helper Code
Analytics.AdditionalHeadersBase = [ #"X-FactSet-Connector-Version" = Settings[XFactSetConnectorVersion]];
Analytics.AdditionalHeadersFromCi = Extension.LoadString("AdditionalHeadersFromCi");
Analytics.AdditionalHeaders = if Analytics.AdditionalHeadersFromCi <> "null" then Record.Combine({Analytics.AdditionalHeadersBase, Json.Document(Text.FromBinary(Extension.Contents(Analytics.AdditionalHeadersFromCi)))})
                        else Analytics.AdditionalHeadersBase;

Analytics.Constants = [
    LOOKUPS_URL = Settings[ApiHost] & "/analytics/lookups/v2/",
    LOOKUPS_V3_URL = Settings[ApiHost] & "/analytics/lookups/v3",
    ENGINES_URL = Settings[ApiHost] & "/analytics/engines/v2/",
    ENGINES_V3_URL = Settings[ApiHost] & "/analytics/engines/",
    AdditionalHeaders = Analytics.AdditionalHeaders,
    calcUnitId = "1"
];

Analytics = [
    Utils = Extension.LoadFunction("api-factset-analytics-util.pqm"),
    Request = Extension.LoadFunction("api-factset-analytics-request.pqm"),
    Constants = Analytics.Constants
];

// Analytics Engines V3 Deprecated Calculation Functions
Analytics.Engines.V3.CalculationFunctionsDeprecated = Extension.LoadFunction("api-factset-analytics-calculations-deprecated.pqm");


// Data Source Kind description
// https://learn.microsoft.com/en-us/power-query/handling-data-access
FactSetAnalytics = [
    TestConnection = (dataSourcePath) as list => {"FactSetAnalytics.ConnectionCheck"},
    Authentication = [
        OAuth = Extension.LoadFunction("util-oauth.pqm"),
        UsernamePassword = [
            UsernameLabel = "Username-Serial",
            PasswordLabel = "API Key",
            Label = "API Key"
        ]
    ]
];

// Test Connection Check
[DataSource.Kind = "FactSetAnalytics"]
shared FactSetAnalytics.ConnectionCheck = () =>
    Web.Contents(
        // TODO: need to change to some actual common test endpoint
        "https://api.factset.com/analytics/engines/pa/v3/frequencies",
        [
            Headers = [
                #"Accept" = "application/json",
                #"X-FactSet-Connector-Version" = Settings[XFactSetConnectorVersion]
            ]
        ]
    );

// Data Source UI publishing description
FactSetAnalytics.Publish = [
    Category = "Other",
    ButtonText = {Settings[ConnectorTitle], Settings[ConnectorHelp]},
    LearnMoreUrl = "https://developer.factset.com",
    SourceImage = FactSetAnalytics.Icons,
    SourceTypeImage = FactSetAnalytics.Icons
];

FactSetAnalytics.Icons = [
    Icon16 = {
        Extension.Contents("Factset16.png"),
        Extension.Contents("Factset20.png"),
        Extension.Contents("Factset24.png"),
        Extension.Contents("Factset32.png")
    },
    Icon32 = {
        Extension.Contents("Factset32.png"),
        Extension.Contents("Factset40.png"),
        Extension.Contents("Factset48.png"),
        Extension.Contents("Factset64.png")
    }
];

ApiList = {
    "api-factset-analytics.pqm",
    "api-factset-irn.pqm",
    "api-formula.pqm"
};

LoadedApis = ApiLoader(ApiList);

// Entrypoint for the Power BI 'Get Data' GUI
// https://learn.microsoft.com/en-us/power-query/handling-navigation-tables
[DataSource.Kind = "FactSetAnalytics", Publish = "FactSetAnalytics.Publish"]
shared FactSetAnalytics.Contents = () as table =>
    FactSetAnalytics.CreateNavigationTable(
        List.Combine({LoadedApis[Name], {"Utilities"}}),
        List.Combine({LoadedApis[Key], {"Utilities"}}),
        List.Combine({LoadedApis[Data], {FactSetAnalytics.Utilities()}}),
        List.Combine({LoadedApis[ItemKind], {"Folder"}}),
        List.Combine({LoadedApis[ItemName], {"Folder"}}),
        List.Combine({LoadedApis[IsLeaf], {false}})
    );

FactSetAnalytics.CreateNavigationTable = (name, key, data, itemKind, itemName, isLeaf) as table =>
    let
        rows = List.Zip({name, key, data, itemKind, itemName, isLeaf}),
        objects = Table.FromRows(rows, {"Name", "Key", "Data", "ItemKind", "ItemName", "IsLeaf"}),
        NavTable = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        NavTable;

FactSetAnalytics.ToNavigationTable = (navData) as table =>
        let
            objects = #table(
                {"Name", "Key", "Data", "ItemKind", "ItemName", "IsLeaf"},
                navData
            ),
            NavTable = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
        in
            NavTable;

FactSetAnalytics.Utilities = () as table =>
    FactSetAnalytics.ToNavigationTable(
        {
            {"ConvertToTable", "FactSet.Utilities.ConvertToTable", FactSetAnalytics.Utilities.ConvertToTable, "Function", "Function", true},
            {"DeepMergeRecords", "FactSet.Utilities.DeepMergeRecords", FactSetAnalytics.Utilities.DeepMergeRecords, "Function", "Function", true},
            {"UnpivotOtherColumns", "FactSet.Utilities.UnpivotOtherColumns", FactSetAnalytics.Utilities.UnpivotOtherColumns, "Function", "Function", true},
            {"ThrottledFunctionIterator", "FactSet.Utilities.ThrottledFunctionIterator", FactSetAnalytics.Utilities.ThrottledFunctionIterator, "Function", "Function", true},
            {"StachV2RowOrganizedTable", "FactSet.Utilities.StachV2RowOrganizedTable", FactSetAnalytics.Utilities.Stach.V2.RowOrganizedTable, "Function", "Function", true},
            {"StachV2ColumnOrganizedTable", "FactSet.Utilities.StachV2ColumnOrganizedTable", FactSetAnalytics.Utilities.Stach.V2.ColumnOrganizedTable, "Function", "Function", true}
        }
    );

// ==================================================================
//
// FactSet Analytics Entry Point for backwards compatibility
//
// ==================================================================
AnalyticsFunctions = LoadedApis[Functions]{List.PositionOf(LoadedApis[Name],"Analytics")};

[DataSource.Kind="FactSetAnalytics"]
shared FactSetAnalytics.Functions = () as table =>
    let
        NavTable = FactSetAnalytics.ToNavigationTable(
            {
                {"Datastore v1", "v1Datastore", FactSetAnalytics.DataStore.V1.NavTable(), "Folder", "Folder", false},
                {"Engines v2", "v2", FactSetAnalytics.Engines.V2.NavTable(), "Folder", "Folder", false},
                {"Engines v3", "v3", FactSetAnalytics.Engines.V3.NavTable(), "Folder", "Folder", false}
            }
        )
    in
        NavTable;

// ==================================================================
//
// FactSet Analytics DataStore V1
//
// ==================================================================

FactSetAnalytics.DataStore.V1.NavTable = () as table =>
    let
        NavTable = FactSetAnalytics.ToNavigationTable(
            {
                {"v1GetSwivel", "FactSetAnalytics.v1Datastore.GetSwivel", AnalyticsFunctions[Datastore.V1.GetSwivel], "Function", "Function", true},
                {"v1GetSwivelAsOfDate", "FactSetAnalytics.v1Datastore.GetSwivelAsOfDate", AnalyticsFunctions[Datastore.V1.GetSwivelAsOfDate], "Function", "Function", true}
            }
        )
    in
        NavTable;

// ==================================================================
//
// FactSet Analytics Engines V2
//
// ==================================================================

FactSetAnalytics.Engines.V2.NavTable = () as table =>
    let
        NavTable = FactSetAnalytics.ToNavigationTable(
            {
                {"PA", "PA", FactSetAnalytics.Engines.V2.PA.NavTable(), "Folder", "Folder", false},
                {"SPAR", "SPAR", FactSetAnalytics.Engines.V2.SPAR.NavTable(), "Folder", "Folder", false},
                {"Vault", "Vault", FactSetAnalytics.Engines.V2.Vault.NavTable(), "Folder", "Folder", false},
                {"GetAccounts", "FactSetAnalytics.v2.GetAccounts", AnalyticsFunctions[v2.GetAccounts], "Function", "Function", true}
            }
        )
    in
        NavTable;

FactSetAnalytics.Engines.V2.PA.NavTable = () as table =>
    let
        NavTable = FactSetAnalytics.ToNavigationTable(
            {
                {"RunPACalculation", "FactSetAnalytics.v2.RunPACalculation", AnalyticsFunctions[v2.RunPACalculation], "Function", "Function", true},
                {"RunPAMultiPortCalculation", "FactSetAnalytics.v2.RunPAMultiPortCalculation", AnalyticsFunctions[v2.RunPAMultiPortCalculation], "Function", "Function", true},
                {"GetPAColumns", "FactSetAnalytics.v2.GetPAColumns", AnalyticsFunctions[v2.GetPAColumns], "Function", "Function", true},
                {"GetPAColumnById", "FactSetAnalytics.v2.GetPAColumnById", AnalyticsFunctions[v2.GetPAColumnById], "Function", "Function", true},
                {"GetPAColumnStatistics", "FactSetAnalytics.v2.GetPAColumnStatistics", AnalyticsFunctions[v2.GetPAColumnStatistics], "Function", "Function", true},
                {"GetPAComponents", "FactSetAnalytics.v2.GetPAComponents", AnalyticsFunctions[v2.GetPAComponents], "Function", "Function", true},
                {"GetPAComponentById", "FactSetAnalytics.v2.GetPAComponentById", AnalyticsFunctions[v2.GetPAComponentById], "Function", "Function", true},
                {"ConvertPADatesToAbsoluteFormat", "FactSetAnalytics.v2.ConvertPADatesToAbsoluteFormat", AnalyticsFunctions[v2.ConvertPADatesToAbsoluteFormat], "Function", "Function", true},
                {"GetPADocuments", "FactSetAnalytics.v2.GetPADocuments",  AnalyticsFunctions[v2.GetPADocuments], "Function", "Function", true},
                {"PACurrencies", "FactSetAnalytics.v2.PACurrencies", AnalyticsFunctions[v2.PACurrencies](), "Table", "Table", true},
                {"PAFrequencies", "FactSetAnalytics.v2.PAFrequencies", AnalyticsFunctions[v2.PAFrequencies](), "Table", "Table", true},
                {"PAGroups", "FactSetAnalytics.v2.PAGroups", AnalyticsFunctions[v2.PAGroups](), "Table", "Table", true}
            }
        )
    in
        NavTable;

FactSetAnalytics.Engines.V2.SPAR.NavTable = () as table =>
    let
        NavTable = FactSetAnalytics.ToNavigationTable(
            {
                {"RunSPARCalculation", "FactSetAnalytics.v2.RunSPARCalculation", AnalyticsFunctions[v2.RunSPARCalculation], "Function", "Function", true},
                {"RunSPARMultiPortCalculation", "FactSetAnalytics.v2.RunSPARMultiPortCalculation", AnalyticsFunctions[v2.RunSPARMultiPortCalculation], "Function", "Function", true},
                {"GetSPARComponents", "FactSetAnalytics.v2.GetSPARComponents", AnalyticsFunctions[v2.GetSPARComponents], "Function", "Function", true},
                {"GetSPARDocuments", "FactSetAnalytics.v2.GetSPARDocuments", AnalyticsFunctions[v2.GetSPARDocuments], "Function", "Function", true},
                {"SPARFrequencies", "FactSetAnalytics.v2.SPARFrequencies", AnalyticsFunctions[v2.SPARFrequencies](), "Table", "Table", true}
            }
        )
    in
        NavTable;

FactSetAnalytics.Engines.V2.Vault.NavTable = () as table =>
    let
        NavTable = FactSetAnalytics.ToNavigationTable(
            {
                {"RunVaultCalculation", "FactSetAnalytics.v2.RunVaultCalculation", AnalyticsFunctions[v2.RunVaultCalculation], "Function", "Function", true},
                {"GetVaultComponents", "FactSetAnalytics.v2.GetVaultComponents", AnalyticsFunctions[v2.GetVaultComponents], "Function", "Function", true},
                {"GetVaultComponentById", "FactSetAnalytics.v2.GetVaultComponentById", AnalyticsFunctions[v2.GetVaultComponentById], "Function", "Function", true},
                {"GetVaultConfigurations", "FactSetAnalytics.v2.GetVaultConfigurations", AnalyticsFunctions[v2.GetVaultConfigurations], "Function", "Function", true},
                {"GetVaultConfigurationById", "FactSetAnalytics.v2.GetVaultConfigurationById", AnalyticsFunctions[v2.GetVaultConfigurationById], "Function", "Function", true},
                {"ConvertVaultDatesToAbsoluteFormat", "FactSetAnalytics.v2.ConvertVaultDatesToAbsoluteFormat", AnalyticsFunctions[v2.ConvertVaultDatesToAbsoluteFormat], "Function", "Function", true},
                {"GetVaultDocuments", "FactSetAnalytics.v2.GetVaultDocuments", AnalyticsFunctions[v2.GetVaultDocuments], "Function", "Function", true},
                {"VaultFrequencies", "FactSetAnalytics.v2.VaultFrequencies", AnalyticsFunctions[v2.VaultFrequencies](), "Table", "Table", true}
            }
        )
    in
        NavTable;


// ==================================================================
//
// FactSet Analytics Engines V3
//
// ==================================================================

FactSetAnalytics.Engines.V3.NavTable = () as table =>
    let
        NavTable = FactSetAnalytics.ToNavigationTable(
            {
                {"PA", "PA", FactSetAnalytics.Engines.V3.PA.NavTable(), "Folder", "Folder", false},
                {"SPAR", "SPAR", FactSetAnalytics.Engines.V3.SPAR.NavTable(), "Folder", "Folder", false},
                {"Vault", "Vault", FactSetAnalytics.Engines.V3.Vault.NavTable(), "Folder", "Folder", false},
                {"Lookups", "Lookups", FactSetAnalytics.Engines.V3.Lookups.NavTable(), "Folder", "Folder", false}
            }
        )
    in
        NavTable;

FactSetAnalytics.Engines.V3.PA.NavTable = () as table =>
    let
        NavTable = FactSetAnalytics.ToNavigationTable(
            {
                {"v3RunPACalculation", "FactSetAnalytics.v3.RunPACalculation", Analytics.Engines.V3.CalculationFunctionsDeprecated[RunPACalculation], "Function", "Function", true},
                {"v3RunPAMultiPortCalculation", "FactSetAnalytics.v3.RunPAMultiPortCalculation", Analytics.Engines.V3.CalculationFunctionsDeprecated[RunPAMultiPortCalculation], "Function", "Function", true},
                {"v3GetAllPACalculations", "FactSetAnalytics.v3.GetAllPACalculations", AnalyticsFunctions[v3.GetAllPACalculations], "Function", "Function", true},
                {"v3GetPAColumnStatistics", "FactSetAnalytics.v3.GetPAColumnStatistics", AnalyticsFunctions[v3.GetPAColumnStatistics], "Function", "Function", true},
                {"v3GetPAColumns", "FactSetAnalytics.v3.GetPAColumns", AnalyticsFunctions[v3.GetPAColumns], "Function", "Function", true},
                {"v3GetPAColumnById", "FactSetAnalytics.v3.GetPAColumnById", AnalyticsFunctions[v3.GetPAColumnById], "Function", "FUnction", true},
                {"v3GetPAComponents", "FactSetAnalytics.v3.GetPAComponents", AnalyticsFunctions[v3.GetPAComponents], "Function", "Function", true},
                {"v3GetPAComponentById", "FactSetAnalytics.v3.GetPAComponentById", AnalyticsFunctions[v3.GetPAComponentById], "Function", "Function", true},
                {"v3ConvertPADatesToAbsoluteFormat", "FactSetAnalytics.v3.ConvertPADatesToAbsoluteFormat",AnalyticsFunctions[v3.ConvertPADatesToAbsoluteFormat], "Function", "Function", true},
                {"v3PAFrequencies", "FactSetAnalytics.v3.PAFrequencies", AnalyticsFunctions[v3.PAFrequencies](), "Table", "Table", true},
                {"v3PAGroups", "FactSetAnalytics.v3.PAGroups", AnalyticsFunctions[v3.PAGroups](), "Table", "Table", true},
                {"v3GetPADocuments", "FactSetAnalytics.v3.GetPADocuments", AnalyticsFunctions[v3.GetPADocuments], "Function", "Function", true},
                {"v3GetPAGroupingFrequencies", "FactSetAnalytics.v3.GetPAGroupingFrequencies", AnalyticsFunctions[v3.GetPAGroupingFrequencies], "Function", "Function", true},
                {"v3GetPAPricingSources", "FactSetAnalytics.v3.GetPAPricingSources",AnalyticsFunctions[v3.GetPAPricingSources], "Function", "Function", true }
            }
        )
    in
        NavTable;

FactSetAnalytics.Engines.V3.SPAR.NavTable = () as table =>
    let
        NavTable = FactSetAnalytics.ToNavigationTable(
            {
                {"v3RunSPARCalculation", "FactSetAnalytics.v3.RunSPARCalculation", Analytics.Engines.V3.CalculationFunctionsDeprecated[RunSPARCalculation], "Function", "Function", true},
                {"v3RunSPARMultiPortCalculation", "FactSetAnalytics.v3.RunSPARMultiPortCalculation", Analytics.Engines.V3.CalculationFunctionsDeprecated[RunSPARMultiPortCalculation], "Function", "Function", true},
                {"v3GetAllSPARCalculations","FactSetAnalytics.v3.GetAllSPARCalculations", AnalyticsFunctions[v3.GetAllSPARCalculations], "Function", "Function", true},
                {"v3GetSPARBenchmarkById", "FactSetAnalytics.v3.GetSPARBenchmarkById", AnalyticsFunctions[v3.GetSPARBenchmarkById], "Function", "Function", true},
                {"v3GetSPARComponents", "FactSetAnalytics.v3.GetSPARComponents", AnalyticsFunctions[v3.GetSPARComponents], "Function", "Function", true},
                {"v3GetSPARComponentById", "FactSetAnalytics.v3.GetSPARComponentById", AnalyticsFunctions[v3.GetSPARComponentById], "Function", "Function", true},
                {"v3SPARFrequencies", "FactSetAnalytics.v3.SPARFrequencies", AnalyticsFunctions[v3.SPARFrequencies](), "Table", "Table", true},
                {"v3GetSPARDocuments", "FactSetAnalytics.v3.GetSPARDocuments", AnalyticsFunctions[v3.GetSPARDocuments], "Function", "Function", true},
                {"v3GetSPARAccountsReturnType", "FactSetAnalytics.v3.GetSPARAccountsReturnType", AnalyticsFunctions[v3.GetSPARAccountsReturnType], "Function", "Function", true}
            }
        )
    in
        NavTable;

FactSetAnalytics.Engines.V3.Vault.NavTable = () as table =>
    let
        NavTable = FactSetAnalytics.ToNavigationTable(
            {
                {"v3RunVaultCalculation", "FactSetAnalytics.v3.RunVaultCalculation", Analytics.Engines.V3.CalculationFunctionsDeprecated[RunVaultCalculation], "Function", "Function", true},
                {"v3GetVaultComponents", "FactSetAnalytics.v3.GetVaultComponents", AnalyticsFunctions[v3.GetVaultComponents], "Function", "Function", true},
                {"v3GetVaultComponentById", "FactSetAnalytics.v3.GetVaultComponentById",  AnalyticsFunctions[v3.GetVaultComponentById], "Function", "Function", true},
                {"v3GetVaultConfigurations", "FactSetAnalytics.v3.GetVaultConfigurations", AnalyticsFunctions[v3.GetVaultConfigurations], "Function", "Function", true},
                {"v3GetVaultConfigurationById", "FactSetAnalytics.v3.GetVaultConfigurationById",  AnalyticsFunctions[v3.GetVaultConfigurationById], "Function", "Function", true},
                {"v3ConvertVaultDatesToAbsoluteFormat", "FactSetAnalytics.v3.ConvertVaultDatesToAbsoluteFormat", AnalyticsFunctions[v3.ConvertVaultDatesToAbsoluteFormat], "Function", "Function", true},
                {"v3VaultFrequencies", "FactSetAnalytics.v3.VaultFrequencies", AnalyticsFunctions[v3.VaultFrequencies](), "Table", "Table", true},
                {"v3GetVaultDocuments", "FactSetAnalytics.v3.GetVaultDocuments",  AnalyticsFunctions[v3.GetVaultDocuments], "Function", "Function", true},
                {"v3GetAllVaultCalculations", "FactSetAnalytics.v3.GetAllVaultCalculations", AnalyticsFunctions[v3.GetAllVaultCalculations], "Function", "Function", true}
            }
        )
    in
        NavTable;

FactSetAnalytics.Engines.V3.Lookups.NavTable = () as table =>
    let
        NavTable = FactSetAnalytics.ToNavigationTable(
            {
                {"v3GetAccounts", "FactSetAnalytics.v3.GetAccounts", AnalyticsFunctions[v3.GetAccounts], "Function", "Function", true},
                {"v3GetCurrencies", "FactSetAnalytics.v3.GetCurrencies", AnalyticsFunctions[v3.GetCurrencies](), "Table", "Table", true}
            }
        )
    in
        NavTable;

FactSetAnalytics.Request =
    (endpoint as text, optional options as record) =>
        let
            basePath = Record.FieldOrDefault(options, "BasePath", Settings[ApiHost]),
            xHeader = Record.FieldOrDefault(options, "Headers", [#"X-FactSet-Connector-Origin" = "Request"]),
            requestOptions = Record.Combine({options ?? [], [
                RelativePath = endpoint,
                Headers = xHeader
            ]}),
            result = Request[Request](basePath, requestOptions)
        in
            result;

FactSetAnalytics.Utilities.ConvertToTable = Extension.LoadFunction("util-convert-to-table.pqm");
FactSetAnalytics.Utilities.DeepMergeRecords = Extension.LoadFunction("util-deep-merge.pqm");
FactSetAnalytics.Utilities.UnpivotOtherColumns = Extension.LoadFunction("util-unpivot-other-columns.pqm");
FactSetAnalytics.Utilities.ThrottledFunctionIterator = Extension.LoadFunction("util-throttled-function-iterator.pqm");

// https://learn.microsoft.com/en-us/power-query/helper-functions#tabletonavigationtable
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

FactSetAnalytics.Utilities.Stach.V2.RowOrganizedTable = Stach[StachV2RowOrganizedTable];
FactSetAnalytics.Utilities.Stach.V2.ColumnOrganizedTable = Stach[StachV2ColumnOrganizedTable];

// https://learn.microsoft.com/en-us/power-query/samples/trippin/7-advancedschema/readme#refactoring-common-code-into-separate-files
Extension.LoadFunction = (fileName as text) =>
    let
        binary = Extension.Contents(fileName), asText = Text.FromBinary(binary)
    in
        try
            Expression.Evaluate(
                asText,
                Record.Combine(
                    {
                        #shared,
                        [
                            LongRunning = LongRunning,
                            Pagination = Pagination,
                            Extension.LoadFunction = Extension.LoadFunction,
                            Settings = Settings,
                            FactSetAnalytics.ToNavigationTable = FactSetAnalytics.ToNavigationTable,
                            Analytics = Analytics,
                            FactSetAnalytics.Request = FactSetAnalytics.Request,
                            FactSetAnalytics.Utilities.ConvertToTable = FactSetAnalytics.Utilities.ConvertToTable,
                            FactSetAnalytics.Utilities.DeepMergeRecords = FactSetAnalytics.Utilities.DeepMergeRecords,
                            FactSetAnalytics.Utilities.UnpivotOtherColumns = FactSetAnalytics.Utilities.UnpivotOtherColumns,
                            FactSetAnalytics.Utilities.ThrottledFunctionIterator = FactSetAnalytics.Utilities.ThrottledFunctionIterator,
                            FactSetAnalytics.Utilities.Stach.V2.RowOrganizedTable = FactSetAnalytics.Utilities.Stach.V2.RowOrganizedTable,
                            FactSetAnalytics.Utilities.Stach.V2.ColumnOrganizedTable = FactSetAnalytics.Utilities.Stach.V2.ColumnOrganizedTable
                        ]
                    }
                )
            ) catch (e) =>
                error
                    [
                        Reason = "Extension.LoadFunction Failure",
                        Message.Format = "Loading '#{0}' failed - '#{1}': '#{2}'",
                        Message.Parameters = {fileName, e[Reason], e[Message]},
                        Detail = [File = fileName, Error = e]
                    ];