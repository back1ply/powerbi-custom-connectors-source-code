[Version="2.0.34"]
section Databricks;

TrustedAadDomains = {".azuredatabricks.net", ".databricks.azure.cn", ".databricks.azure.us"};
TrustedAWSDomains = {".databricks.com", ".databricks.us"};
TrustedOAuthDomains = {".databricks.com", ".databricks.us", ".azuredatabricks.net", ".databricks.azure.cn", ".databricks.azure.us"};
TrustedAadIssuerDomains = {"login.microsoftonline.com", "sts.windows.net", "login.chinacloudapi.cn", "sts.chinacloudapi.cn", "login.microsoftonline.us", "login.microsoftonline.de"};

//Indicates the level of SQL-92 supported by the driver.
Config_SqlConformance = 8;

DriverName = "Simba Spark ODBC Driver";

// For boolean feature flags
Value.ConvertToLogical = (v) => v <> null and v <> "" and Logical.From(v);
UseAdbcByDefault = Value.ConvertToLogical(Environment.FeatureSwitch("TenantSetting_UseAdbcByDefault", false));
CancelAdbcQueryExplicitly = Value.ConvertToLogical(Environment.FeatureSwitch("MashupFlight_EnableAdbcSoftCancelDatabricks", false));

NewImplementationGUID = "d28f8efe-7b5c-4957-8388-7e58263db5ea";

[DataSource.Kind="Databricks", Publish="Databricks.Publish"]
shared Databricks.Catalogs = Value.ReplaceType(DatabricksCatalogsImpl, AzureDatabricksType);

[DataSource.Kind="Databricks"]
shared Databricks.Contents = Value.ReplaceType(DatabricksLegacyImpl, AzureDatabricksType);

[DataSource.Kind="Databricks"]
shared Databricks.Query = Value.ReplaceType(DatabricksQueryImpl, DatabricksQueryType);

// DatabricksMultiCloud
[DataSource.Kind="DatabricksMultiCloud", Publish="DatabricksMultiCloud.Publish"]
shared DatabricksMultiCloud.Catalogs = Value.ReplaceType(DatabricksCatalogsImpl, DatabricksMultiCloudType);

[DataSource.Kind="DatabricksMultiCloud"]
shared DatabricksMultiCloud.Query = Value.ReplaceType(DatabricksQueryImpl, DatabricksQueryType);

AzureDatabricksType = DatabricksType(false);

DatabricksMultiCloudType = DatabricksType(true);

// This assumes for label `MyLabel` there is a `MultiCloudMyLabel` in the resources.resx
// loads either `MyLabel` or `MultiCloudMyLabel` from resources.resx based on i
loadString = (stringName as text, isMultiCloud as logical) => if isMultiCloud then Extension.LoadString("MultiCloud" & stringName) else Extension.LoadString(stringName);

// Wrapper function to provide additional UI customization.
DatabricksType = (isMultiCloud as logical) =>
    let
        AutomaticProxyDiscoveryFlag.Disabled = "disabled" meta [
            Documentation.Name = "AutomaticProxyDiscoveryFlag.Disabled",
            Documentation.Caption = Extension.LoadString("AutomaticProxyDiscoveryFlagDisabledLabel")
        ],
        AutomaticProxyDiscoveryFlag.Enabled = "enabled" meta [
            Documentation.Name = "AutomaticProxyDiscoveryFlag.Enabled",
            Documentation.Caption = Extension.LoadString("AutomaticProxyDiscoveryFlagEnabledLabel")
        ]
    in
        type function (
            host as (type text meta [
                Documentation.FieldCaption = Extension.LoadString("ServerHostNameLabel"),
                Documentation.FieldDescription = Extension.LoadString("ServerHostNameHelp"),
                Documentation.SampleValues = { "example.azuredatabricks.net" }
            ]),
            httpPath as (type text meta [
                Documentation.FieldCaption = Extension.LoadString("HttpPathLabel"),
                Documentation.FieldDescription = Extension.LoadString("HttpPathHelp"),
                Documentation.SampleValues = { "/sql/1.0/warehouses/abcdef1234567890" }
            ]),
            optional options as (type nullable [
                optional Catalog = (type text meta [
                    Documentation.FieldCaption = Extension.LoadString("CatalogLabel"),
                    Documentation.FieldDescription = Extension.LoadString("CatalogHelp")
                ]),
                optional Database = (type text meta [
                    Documentation.FieldCaption = Extension.LoadString("DatabaseLabel"),
                    Documentation.FieldDescription = Extension.LoadString("DatabaseHelp")

                ]),
                optional QueryTags = (type text meta [
                    Documentation.FieldCaption = Extension.LoadString("QueryTagsLabel"),
                    Documentation.FieldDescription = Extension.LoadString("QueryTagsHelp"),
                    Documentation.SampleValues = { "tag1:value1,tag2:value2" }
                ]),
                optional EnableAutomaticProxyDiscovery = (type text meta [
                    Documentation.FieldCaption = Extension.LoadString("EnableAutomaticProxyDiscoveryFlagsLabel"),
                    Documentation.FieldDescription = Extension.LoadString("EnableAutomaticProxyDiscoveryFlagsHelp"),
                    Documentation.AllowedValues = { AutomaticProxyDiscoveryFlag.Enabled, AutomaticProxyDiscoveryFlag.Disabled }
                ]),
                optional Implementation = (type text meta [
                    Documentation.FieldCaption = Extension.LoadString("ImplementationLabel"),
                    Documentation.FieldDescription = Extension.LoadString("ImplementationHelp"),
                    Documentation.AllowedValues = {
                        "2.0" meta [ Documentation.Caption = "2.0 - ADBC" ],
                        null  meta [ Documentation.Caption = "System Default" ]
                    },
                    Documentation.DefaultValue = "2.0"
                ]),
                optional Protocol = (type text meta [
                    Documentation.FieldCaption = Extension.LoadString("ProtocolLabel"),
                    Documentation.FieldDescription = Extension.LoadString("ProtocolHelp"),
                    Documentation.AllowedValues = {
                        null meta [ Documentation.Caption = "Default" ],
                        "rest" meta [ Documentation.Caption = "REST (SEA)" ]
                    },
                    Documentation.DefaultValue = null
                ])
            ] meta [
                Documentation.FieldCaption = Extension.LoadString("AdvancedOptionsLabel")
            ])
        ) as table meta [
            Documentation.Name = loadString("DataSourceName", isMultiCloud)
        ];
        
DatabricksQueryType = 
    type function (
        host as (type text meta [
            Documentation.FieldCaption = Extension.LoadString("ServerHostNameLabel"),
            Documentation.FieldDescription = Extension.LoadString("ServerHostNameHelp"),
            Documentation.SampleValues = { "example.azuredatabricks.net" }
        ]),
        httpPath as (type text meta [
            Documentation.FieldCaption = Extension.LoadString("HttpPathLabel"),
            Documentation.FieldDescription = Extension.LoadString("HttpPathHelp"),
            Documentation.SampleValues = { "/sql/1.0/warehouses/abcdef1234567890" }
        ]),
        optional options as (type nullable record meta [
            Documentation.FieldCaption = Extension.LoadString("AdvancedOptionsLabel")
        ])
    ) as DatabricksQueryInstanceType meta [
        Documentation.Name = Extension.LoadString("QueryDataSourceName"),
        Documentation.LongDescription = Extension.LoadString("QueryDataSourceDescription")
    ];

DatabricksQueryInstanceType = type function (
        sqlQuery as (type text meta [
            Documentation.FieldCaption = Extension.LoadString("SqlQueryLabel"),
            Documentation.FieldDescription = Extension.LoadString("SqlQueryHelp"),
            Documentation.SampleValues = { "SELECT ... FROM ... " },
            Formatting.IsMultiLine = true,
            Formatting.IsCode = true
        ])
    ) as table meta [
        Documentation.Name = Extension.LoadString("QueryDataSourceInstanceName"),
        Documentation.LongDescription = Extension.LoadString("QueryDataSourceInstanceDescription")
    ];

DatabricksCatalogsImpl = (host as text, httpPath as text, optional options as record) as table =>
    let
        optionsRecord = if options = null then [] else options,
        defaultOptions = [
            UseNativeQuery = "2",
            EnableMultipleCatalogsSupport = "1"
        ],
        
        finalOptions = defaultOptions & optionsRecord,
        
        optionsString = Text.Combine(
            List.Transform(
                Record.FieldNames(finalOptions),
                each _ & "=" & Text.From(Record.Field(finalOptions, _))
            ),
            ", "
        ),
        
        tracedOptions = Diagnostics.Trace(
            TraceLevel.Information, [
                Name = "Databricks/QueryType",
                Data = [],
                SafeData = [QueryType = "Databricks.Catalogs", QueryOptions = optionsString]
            ],
            finalOptions
        ),
        
        catalogs = DatabricksFunction(host, httpPath, tracedOptions),

        // Only apply RenameSparkCatalog for ODBC -- ADBC handles the rename inside GetDatabases.
        // Also skip when a default schema is provided (we get tables directly, not catalogs).
        implementation = optionsRecord[Implementation]?,
        useAdbc = if implementation = "1.0" then false 
            else ((implementation = "2.0" or UseAdbcByDefault or implementation = NewImplementationGUID)),
        hasDefaultSchema = optionsRecord[Database]? <> null,
        catalogsWithRenamedSpark = if hasDefaultSchema or useAdbc then
            catalogs
        else
            RenameSparkCatalog(catalogs)
    in
        catalogsWithRenamedSpark;

DatabricksLegacyImpl = (host as text, httpPath as text, optional options as record) as table =>
    let
        optionsRecord = if options = null then [] else options,
        defaultOptions = [
            EnableMultipleCatalogsSupport = "0",
            EnablePKFK = 0
        ],

        finalOptions = defaultOptions & optionsRecord,
        
        optionsString = Text.Combine(
            List.Transform(
                Record.FieldNames(finalOptions),
                each _ & "=" & Text.From(Record.Field(finalOptions, _))
            ),
            ", "
        ),
        
        tracedOptions = Diagnostics.Trace(
            TraceLevel.Information, [
                Name = "Databricks/QueryType",
                Data = [],
                SafeData = [QueryType = "Databricks.Contents", QueryOptions = optionsString]
            ],
            finalOptions
        )
    in
        DatabricksFunction(host, httpPath, tracedOptions);

DatabricksQueryImpl = (host as text, httpPath as text, optional options as record) as function =>
    let
        optionsRecord = if options = null then [] else options,
        defaultOptions = [
            UseNativeQuery = "1",
            EnableMultipleCatalogsSupport = "1"
        ],

        finalOptions = defaultOptions & optionsRecord,
        
        optionsString = Text.Combine(
            List.Transform(
                Record.FieldNames(finalOptions),
                each _ & "=" & Text.From(Record.Field(finalOptions, _))
            ),
            ", "
        ),
        
        tracedOptions = Diagnostics.Trace(
            TraceLevel.Information, [
                Name = "Databricks/QueryType",
                Data = [],
                SafeData = [QueryType = "Databricks.Query", QueryOptions = optionsString]
            ],
            finalOptions
        ),

        queryFn = (sqlQuery as text) => let
            nonEmptyQuery = 
                if sqlQuery = null or sqlQuery = "" then 
                    error Error.Record("DataSource.Error", Extension.LoadString("ErrorExpectedSqlString"))
                else
                    sqlQuery
            in
                DatabricksFunction(host, httpPath, tracedOptions, sqlQuery),

        typedQueryFn = Value.ReplaceType(queryFn, DatabricksQueryInstanceType)
    in 
        typedQueryFn;

DatabricksFunction = (host as text, httpPath as text, options as record, optional sqlQuery as text) as table =>
 let
        //Default to ADBC for now
        implementation = options[Implementation]?,

        useAdbc = if implementation = "1.0" then false 
            else (implementation = "2.0" or UseAdbcByDefault),
        
        // Centralized query wrapping - wrap for both ODBC and ADBC
        wrappedSqlQuery = if sqlQuery = null then null else SafeWrapQuery(sqlQuery, options),

        databricksFn = if useAdbc then DatabricksAdbc 
            else DatabricksODBC,
        driverType = if useAdbc  then "ADBC" else "ODBC"
    in
         Diagnostics.Trace(
            TraceLevel.Information, [
                Name = "Databricks/Implementation",
                Data = [],
                SafeData = [Implementation = implementation, UseAdbcByDefault = UseAdbcByDefault, DriverType = driverType]
            ],
            databricksFn(host, httpPath, options, wrappedSqlQuery)
        );

DatabricksODBC = (host as text, httpPath as text, options as record, optional wrappedSqlQuery as text) as table =>
    let
        Credential = Extension.CurrentCredential(),
        AuthenticationMode = Credential[AuthenticationKind],
        ValidatedHost = ValidateAnyHost(host),

        AuthConnectionString =
            if AuthenticationMode = "UsernamePassword" then
                if Credential[Username] = "token" then
                    [
                        AuthMech = 3,
                        UID = Credential[Username],
                        PWD = Credential[Password]
                    ]
                else
                    [
                        AuthMech = 11,
                        AUTH_FLOW = 1,
                        Auth_Client_ID = Credential[Username],
                        Auth_Client_Secret = Credential[Password],
                        Auth_Scope = "sql"
                    ]
            else if AuthenticationMode = "Key" then
                [
                    // Although AuthMech=11 happens to work, this is not intended behavior and
                    // any resulting error messages cannot be processed by the driver.
                    // Token authentication should be done via UID="token";PWD=<token>
                    // for proper authentication failure handling.
                    AuthMech = 3,
                    UID = "token",
                    PWD = Credential[Key]
                ]
            else if AuthenticationMode = "OAuth" then
                [
                    AuthMech = 11,
                    Auth_Flow = 0,
                    Auth_AccessToken = Credential[access_token]
                ]
            else
                // Should not be reachable.
                error Extension.CredentialError("DataSource.UnsupportedAuthenticationKind", Text.Format("Unsupported authentication mode #{0}", AuthenticationMode)),

        ValidatedOptions = ValidateAdvancedOptions(options),

        OptionOdbcFields = OdbcFieldsFromOptions(ValidatedOptions),

        HasSchema = ValidatedOptions[Database]? <> null,

        ShowSystemSchemas = if ValidatedOptions[ShowSystemSchemas]? = true then 1 else 0,
        UseCachedResult = if ValidatedOptions[SSP_use_cached_result]? = null then true else ValidatedOptions[SSP_use_cached_result],

	// Trace Databricks endpoint type
        EndpointType =
            if Text.Contains(httpPath, "sql/1.0/warehouses") or Text.Contains(httpPath, "sql/1.0/endpoints") then "DatabricksSQL"
            else if Text.Contains(httpPath, "sql/protocolv1") then "DatabricksCluster"
            else "Other",

        ConnectionString = [
            Driver = DriverName,
            Host = ValidatedHost,
            HTTPPath = Diagnostics.Trace(TraceLevel.Information, [Name="ConnectionString", Data = [], SafeData = [EndpointType=EndpointType]], httpPath),
            Port = 443,
            ThriftTransport = 2,
            SparkServerType = 3,
            SSL = 1,
            UseNativeQuery = 0,
            UserAgentEntry = "PowerBI",
            UseSystemTrustStore = 1,
            RowsFetchedPerBlock = 200000,
            LCaseSspKeyName = 0,
            ApplySSPWithQueries = 0,
            DefaultStringColumnLength=65535,
            DecimalColumnScale = 10,
            UseUnicodeSqlCharacterTypes = 1,
            SSP_spark.sql.thriftserver.metadata.table.singleschema = Logical.ToText(HasSchema),
            ShowLocalTempSchemasInSQLTablesSchemasOnly = ShowSystemSchemas,
            ShowGlobalTempSchemasInSQLTablesSchemasOnly = ShowSystemSchemas,
            // many proxies/vpns ssl certificate do not have CRL distribution points
            AllowMissingCRLDistributionPoints = 1,
            TokenRenewLimit = 10,
            UseWincrypt = 1,
            SSP_use_cached_result = Logical.ToText(UseCachedResult)
        ] & OptionOdbcFields,

        DefaultConfig = BuildOdbcConfig(),

        SqlCapabilitiesNativeQuery = DefaultConfig[SqlCapabilities] & [
            LimitClauseKind = LimitClauseKind.Limit,
            FractionalSecondsScale = 3,
            SupportsNumericLiterals = true,
            SupportsStringLiterals = true,
            SupportsOdbcDateLiterals = true,
            SupportsOdbcTimeLiterals = true,
            SupportsOdbcTimestampLiterals = true,
            Sql92Translation = "PassThrough",
            // Allows Limit0 as schema inference query of native query
            SupportsLimitZero = true
        ],

        SqlCapabilities = if wrappedSqlQuery = null then
            SqlCapabilitiesNativeQuery & [
            StringLiteralEscapeCharacters = { { "\", "\\" }, { "'", "\'"} }
            ]
        else
            SqlCapabilitiesNativeQuery,

        // Enable SqlBindColumn by default. Based on the test it has about 
        // 2 to 3x imporovemnt on import mode for large tables.
        SqlApiBindCol_Default = true,

        SQLGetFunctions = [
            // Disable using parameters in the queries that get generated.
            // We enable numeric and string literals which should enable
            // literals for all constants.
            SQL_API_SQLBINDPARAMETER = false,
            SQL_API_SQLBINDCOL = if ValidatedOptions[SQL_API_SQLBINDCOL]? <> null then 
                    ValidatedOptions[SQL_API_SQLBINDCOL] 
                else 
                    SqlApiBindCol_Default
        ],

        SQLStringFunctions = ODBC[Flags]({
            // These are currently disabled but supported by the backend. To be directly enabled in driver in future"
            // ODBC[SQL_FN_STR][SQL_FN_STR_BIT_LENGTH],
            // ODBC[SQL_FN_STR][SQL_FN_STR_CHAR_LENGTH],
            // ODBC[SQL_FN_STR][SQL_FN_STR_CHARACTER_LENGTH],
            // ODBC[SQL_FN_STR][SQL_FN_STR_OCTET_LENGTH],
            // ODBC[SQL_FN_STR][SQL_FN_STR_POSITION],
            // ODBC[SQL_FN_STR][SQL_FN_STR_REPLACE],
            // ODBC[SQL_FN_STR][SQL_FN_STR_SPACE],

            ODBC[SQL_FN_STR][SQL_FN_STR_ASCII],
            ODBC[SQL_FN_STR][SQL_FN_STR_CHAR],
            ODBC[SQL_FN_STR][SQL_FN_STR_CONCAT],
            // ODBC[SQL_FN_STR][SQL_FN_STR_DIFFERENCE],  Not supported
            // ODBC[SQL_FN_STR][SQL_FN_STR_INSERT], Not supported
            ODBC[SQL_FN_STR][SQL_FN_STR_LCASE],
            ODBC[SQL_FN_STR][SQL_FN_STR_LEFT],
            ODBC[SQL_FN_STR][SQL_FN_STR_LENGTH],
            ODBC[SQL_FN_STR][SQL_FN_STR_LOCATE],
            // ODBC[SQL_FN_STR][SQL_FN_STR_LOCATE_2], LOCATE is supported
            ODBC[SQL_FN_STR][SQL_FN_STR_LTRIM],
            ODBC[SQL_FN_STR][SQL_FN_STR_REPEAT],
            ODBC[SQL_FN_STR][SQL_FN_STR_RIGHT],
            ODBC[SQL_FN_STR][SQL_FN_STR_RTRIM],
            ODBC[SQL_FN_STR][SQL_FN_STR_SOUNDEX],
            ODBC[SQL_FN_STR][SQL_FN_STR_SUBSTRING],
            ODBC[SQL_FN_STR][SQL_FN_STR_UCASE]
        }),

        SQLNumericFunctions = ODBC[Flags]({
            // These are currently disabled but supported by the backend. To be directly enabled in driver in future"
            // ODBC[SQL_FN_NUM][SQL_FN_NUM_COT]
            ODBC[SQL_FN_NUM][SQL_FN_NUM_ABS],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_ACOS],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_ASIN],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_ATAN],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_ATAN2],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_CEILING],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_COS],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_DEGREES],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_EXP],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_FLOOR],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_LOG],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_LOG10],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_MOD],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_PI],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_POWER],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_RADIANS],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_RAND],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_ROUND],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_SIGN],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_SIN],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_SQRT],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_TAN]
           // ODBC[SQL_FN_NUM][SQL_FN_NUM_TRUNCATE], not supported
        }),

        SQLGetInfo = DefaultConfig[SQLGetInfo] & [
            SQL_SQL92_PREDICATES = ODBC[SQL_SP][All],
            SQL_AGGREGATE_FUNCTIONS = ODBC[SQL_AF][All],
            SQL_NUMERIC_FUNCTIONS = SQLNumericFunctions,
            SQL_STRING_FUNCTIONS = SQLStringFunctions,

            // Needed for SQL_SVE_COALESCE, SQL_SVE_CASE or SQL_SVE_NULLIF
            // Improves the DAX DATE query push down to utilized COALESCE function
            SQL_SQL92_VALUE_EXPRESSIONS = 6
        ],

        // Fix for data type mismatch.
        SQLColumns = (catalogName, schemaName, tableName, columnName, source) =>
            let
                OdbcSqlTypeName.VARCHAR = "varchar",
                OdbcSqlTypeName.CHAR = "char",
                OdbcSqlTypeName.DECIMAL = "decimal",

                FixDataTypeName = (dataTypeName) =>
                    if Text.Contains(dataTypeName, "varchar") then
                        OdbcSqlTypeName.VARCHAR
                    else if Text.Contains(dataTypeName, "char") then
                        OdbcSqlTypeName.CHAR
                    else if Text.Contains(dataTypeName, "decimal") then
                        OdbcSqlTypeName.DECIMAL
                    else
                        dataTypeName,
                Transform = Table.TransformColumns(source, { { "TYPE_NAME", FixDataTypeName }})
            in
                Transform,

        SupportsIncrementalNavigation = Record.FieldOrDefault(ValidatedOptions, "SupportsIncrementalNavigation", true),
        EnableAutomaticProxyDiscovery = Record.FieldOrDefault(ValidatedOptions, "EnableAutomaticProxyDiscovery", false),
        CancelQueryExplicitly = Record.FieldOrDefault(ValidatedOptions, "CancelQueryExplicitly", true),

        Options = [
            // View the tables grouped by their schema names.
            HierarchicalNavigation = not HasSchema,

            SupportsIncrementalNavigation = SupportsIncrementalNavigation,

            // Controls whether your connector allows native SQL statements.
            HideNativeQuery = true,

            // Allows the M engine to select a compatible data type.
            SoftNumbers = true,

            // Allows conversion of numeric and text types to larger types.
            TolerateConcatOverflow = true,

            // Enables client-side connection pooling for the ODBC driver.
            ClientConnectionPooling = true,

            // Tells Power BI that it can't quietly drop the connection
            CancelQueryExplicitly = CancelQueryExplicitly,

            // Improves DAX DAY, MONTH, YEAR filter push down
            TryRecoverDateDiff = true,
            TryRecoverCoalesce = true,

            // Handlers for ODBC driver capabilities.
            SqlCapabilities = SqlCapabilities,
            SQLColumns = SQLColumns,
            SQLGetFunctions = SQLGetFunctions,
            SQLGetInfo = SQLGetInfo,
            OnError = OnOdbcError,
            OnExecuteSql = (sql) => "/*ActivityId: " & Diagnostics.ActivityId() & " CorrelationId: " & Diagnostics.CorrelationId() & " */" & sql
        ],

        // Connection string properties used for encrypted connections.
        CommonOptions = [
            // The Databricks driver is shipped with Power BI
            UseEmbeddedDriver = true,
            CredentialConnectionString = AuthConnectionString
        ],

        // DefaultTypeParameters is only supported on Odbc.DataSource
        DataSourceOptions = [
            DefaultTypeParameters = [DECIMAL = [Precision = 38, Scale = 6]]
        ],

        ProxyOptions = if EnableAutomaticProxyDiscovery then
            let
            ProxyUriRecord = Web.DefaultProxy(host),
            ops = if Record.FieldCount(ProxyUriRecord) > 0 then
                let
                    UriRecord = Uri.Parts(ProxyUriRecord[ProxyUri]),
                    proxyOptions = [
                        UseProxy = 1,
                        ProxyHost = UriRecord[Host],
                        ProxyPort = UriRecord[Port],
                        // This option helps in providing better ssl cert related errors.
                        // 
                        // simba odbc driver even if cert revocation info is missing in the cert will do cert revocation check.
                        // this causes cert validation failure.
                        //
                        // short term solution: for now end users may need to set `CheckCertRevocation=0` manually in the config file
                        // C:\Program Files\Microsoft Power BI Desktop\bin\ODBC Drivers\Simba Spark ODBC Driver\microsoft.sparkodbc.ini
                        // long-term solution: Simba needs to change the internal behaviour of ODBC driver to avoid cert revocation check
                        // if cert revocation cert info is missing in the cert
                        AllowDetailedSSLErrorMessages = 1
                    ]
                in 
                    proxyOptions
                else []
            in
               ops 
        // if automatic proxy discovery is not enabled return nothing.
        else [],

        GetInvocation = (ast, function, count) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = function and List.Count(ast[Arguments]) = count
                then ast[Arguments]
                else ...,
        Function = (name) => [Kind = "Function", Name=name],
        Argument = (expr) => [Expression = expr, Type = null],
        ApproxDistinctCount = (expr) => [Kind = "Invocation", Function = Function("approx_count_distinct"), Arguments = {Argument(expr)}, Type = Int64.Type],
        Struct = (exprs) => [Kind = "Invocation", Function = Function("struct"), Arguments = exprs, Type = null],
        AstOptions = [
            AstVisitor = [
                Functions = { Table.ApproximateRowCount },
                Invocation = (visitor, rowType, groupKeys, invocation) =>
                    let
                        tarc = GetInvocation(invocation, Table.ApproximateRowCount, 1),
                        td = GetInvocation(tarc{0}, Table.Distinct, 1),
                        sc = GetInvocation(td{0}, Table.SelectColumns, 2)
                    in
                        if groupKeys <> null and sc{0} = RowExpression.Row and sc{1}[Value]? is list then
                            ApproxDistinctCount(Struct(List.Transform(sc{1}[Value], (c) => Argument(visitor(RowExpression.Column(c))))))
                        else ...
            ]
        ],
        Databases = Odbc.DataSource(ConnectionString & ProxyOptions, Options & CommonOptions & AstOptions & DataSourceOptions),

        Metadata = Value.Metadata(Value.Type(Databases)),

        WithSchema = if HasSchema then
            Table.SelectRows(Databases, each [Schema] = OptionOdbcFields[Schema])
        else
            Databases,

        DataSourceOrQuery = if wrappedSqlQuery = null then
            WithSchema
        else
            DatabricksQuery(ConnectionString, CommonOptions, wrappedSqlQuery)


        // TODO: Convert complex data types. Our current implementation is broken, and
        // not in a shippable state due to poor deserialization of Hive-flavored json.
        // It would require a change in the Thrift server to unblock this.
in
    DataSourceOrQuery;


DatabricksQuery = (connectionString as record, options as record, wrappedSqlQuery as text) as table =>
    Odbc.Query(connectionString, wrappedSqlQuery, options);

// Ensures no valid DDL/DML can be executed
SafeWrapQuery = (query as text, options as record, optional limit as number) =>
    let
        // Only use DetectQueryType for ADBC
        // ODBC doesn't support stored procedures, so always wrap
        implementation = options[Implementation]?,
        isADBC = if implementation = "1.0" then false else (implementation = "2.0" or implementation = NewImplementationGUID or UseAdbcByDefault),

        wrappedQuery =
            if isADBC then
                // ADBC: Use DetectQueryType to conditionally wrap
                let
                    detection = DetectQueryType(query, options)
                in
                    if detection[ShouldWrap] then
                        Text.Format(QueryBase, [Query = query])
                    else
                        query
            else
                // ODBC: Always wrap (no stored procedures support)
                Text.Format(QueryBase, [Query = query])
    in
        wrappedQuery;

QueryBase = 
"SELECT * 
FROM (
#[Query]
)";

RenameSparkCatalog = (catalogs as table) as table =>
    let
        // For DBR 8 and earlier clusters, the driver retains the legacy 'SPARK' catalog.
        // In DBR 9 and later, the name of the Hive Metastore catalog is 'hive_metastore'.
        // To provide forward compatibility, we rename 'SPARK' to 'hive_metastore'.
        defaultHiveMetastoreCatalog = "hive_metastore",
        isSparkCatalog = Table.RowCount(catalogs) = 1 and catalogs{[Name = "SPARK"]}? <> null,
        renamedSparkCatalog = catalogs{[Name = "SPARK"]} & [Name = defaultHiveMetastoreCatalog],
        renamedSparkTable = Table.FromRecords({ renamedSparkCatalog }),
        navTableType = Value.Type(catalogs),
        renamedSparkNavTable = Value.ReplaceType(renamedSparkTable, navTableType),

        catalogsWithRenamedSpark = if isSparkCatalog then
                renamedSparkNavTable
            else
                catalogs
    in
        catalogsWithRenamedSpark;

// Handles ODBC errors.
OnOdbcError = (errorRecord as record) =>
    let
        ErrorMessage = errorRecord[Message],

        IsDriverNotInstalled = Text.Contains(ErrorMessage, "doesn't correspond to an installed ODBC driver"),

        OdbcError = errorRecord[Detail][OdbcErrors]{0},
        OdbcErrorMessage = OdbcError[Message],
        OdbcErrorCode = OdbcError[NativeError],
        OdbcErrorSqlState = OdbcError[SQLState],

        IsOdbcError = errorRecord[Detail]? <> null and errorRecord[Detail][OdbcErrors]? <> null,

        // ThriftExtension has its own set of error codes that overlap with ODBC errors.
        IsThriftError = Text.Contains(OdbcErrorMessage, "[ThriftExtension]"),

        // ODBC SSL errors
        IsEncryptionError = List.Contains({6, 1130, 1160}, OdbcErrorCode),

        // ODBC server can not be reached on the given host/port
        IsODBCUnreachable = OdbcErrorCode = 1020,

        // When an access token expires, the connector returns a "SQLState 08006" error.
        OAuthTokenExpired = IsOdbcError and (OdbcErrorSqlState = "08006"),

        TokenExpiredError = ((IsThriftError and OdbcErrorCode = 10) or OAuthTokenExpired) and Extension.CurrentCredential(true) <> null,

        // Workaround, requires fix from Simba's side. Error 14 is a generic Thrift error.
        InvalidTokenError = IsThriftError and OdbcErrorCode = 14 and Text.Contains(OdbcErrorMessage, "Unauthorized/Forbidden"),

        IsSQLStateInvalidCredential = OdbcErrorSqlState = "28000",

        HasCredentialError = IsSQLStateInvalidCredential or
            (IsThriftError and OdbcErrorCode <> 7 and OdbcErrorCode <> 14),

        // Required credential settings missing
        MissingCredentialsError = OdbcErrorCode = 11570,

        DataSourceMissingClientLibrary = "DataSource.MissingClientLibrary",

        DataSourceError = "DataSource.Error"

    in
        if IsDriverNotInstalled then
            error Error.Record(DataSourceMissingClientLibrary, Extension.LoadString("ErrorMissingClientLibrary"))
        else if not IsOdbcError then
            error errorRecord
        else if IsEncryptionError then
            // Report error to trigger option to fallback to unencrypted connection.
            error Extension.CredentialError(Credential.EncryptionNotSupported)
        else if IsODBCUnreachable then
            error Error.Record(DataSourceError, Extension.LoadString("ErrorOdbcCouldNotConnect"))
        else if TokenExpiredError then
            true // refreshes access token
        else if HasCredentialError or InvalidTokenError then
            error Extension.CredentialError(Credential.AccessDenied, OdbcErrorMessage)
        else if MissingCredentialsError then
            error Extension.CredentialError(
                Credential.AccessDenied, Extension.LoadString("ErrorOdbcAccessDenied"))
        else
            error errorRecord;

// Returns the host if it is a valid host name for any domain. Throws an error otherwise.
ValidateAnyHost = (host as text) as text =>
    let
        parsedHost = try Uri.Parts("scheme://" & host)[Host] otherwise null
    in
        if parsedHost <> null and host = parsedHost then
            host
        else
            error Error.Record("Error", Text.Format(Extension.LoadString("ErrorInvalidHost"), {host}));

// Returns a validated host name for trusted AAD domains. Throws an error if the domain is not on the approved list.
ValidateTrustedAadHost = (host as text) as text =>
    let
        parsedHost = ValidateAnyHost(host),
        isTrusted = List.MatchesAny(TrustedOAuthDomains, (domain) => Text.EndsWith(parsedHost, domain))
    in
        if isTrusted then
            parsedHost
        else
            error Error.Record("Error", Text.Format(Extension.LoadString("ErrorAadInvalidDomain"), {host}));

ValidateTrustedOAuthHost = (host as text) as text =>
    let
        parsedHost = ValidateAnyHost(host),
        isTrusted = List.MatchesAny(TrustedOAuthDomains, (domain) => Text.EndsWith(parsedHost, domain))
    in
        if isTrusted then
            parsedHost
        else
            error Error.Record("Error", Text.Format(Extension.LoadString("ErrorOAuthInvalidDomain"), {host}));

GetAuthorizationUrlFromWellKnown = (url as text) as text =>
    let
        // Expecting a 302 redirect to the well-known OAuth URL.
        responseCodes = {302},
        endpointResponse = Web.Contents(url, [
            ManualCredentials = true,
            ManualStatusHandling = responseCodes
        ])
    in
        if (List.Contains(responseCodes, Value.Metadata(endpointResponse)[Response.Status]?)) then
            let
                headers = Record.FieldOrDefault(Value.Metadata(endpointResponse), "Headers", []),
                wellKnownUrl = Record.FieldOrDefault(headers, "Location", ""),
                
                // Check if the host is one of the known AAD domains
                isAadIssuerDomain = List.Contains(TrustedAadIssuerDomains, Uri.Parts(wellKnownUrl)[Host]),

                // Fetch the JSON content from the well-known URL
                wellKnownContent = Web.Contents(wellKnownUrl),
                jsonContent = Json.Document(wellKnownContent),
                
                // Extract the authorization endpoint from the JSON content
                authorizationUri = jsonContent[authorization_endpoint]

            in
                if (authorizationUri <> null) and Text.EndsWith(authorizationUri, "authorize") and isAadIssuerDomain then
                    authorizationUri
                else
                    error Error.Record("Error", "Invalid authorization endpoint.", [
                        #"Location" = wellKnownUrl
                    ])
        else
            error Error.Record("Error", "Redirect to well-known URL failed.", [
                Response.Status = Value.Metadata(endpointResponse)[Response.Status]?
            ]);


GetAuthorizationUrlFromLocation = (url as text) as text =>
    let
        // Sending an unauthenticated request to /aad/auth returns
        // a 302 status with Location header in the response.
        // The value will contain the correct authorization_uri, plus a query string we
        // drop and substitute for our own.
        // Example:
        //   Location: https://login.microsoftonline.com/{tenant_guid}/oauth2/authorize?...
        responseCodes = {302},
        endpointResponse = Web.Contents(url, [
            ManualCredentials = true,
            ManualStatusHandling = responseCodes
        ])
    in
        if (List.Contains(responseCodes, Value.Metadata(endpointResponse)[Response.Status]?)) then
            let
                headers = Record.FieldOrDefault(Value.Metadata(endpointResponse), "Headers", []),
                location = Record.FieldOrDefault(headers, "Location", ""),
                splitQuery = Text.Split(Text.Trim(location), "?"),
                authorizationUri = List.First(splitQuery, null)
            in
                if (authorizationUri <> null) and Text.EndsWith(authorizationUri, "authorize") then
                    authorizationUri
                else
                    error Error.Record("Error", Extension.LoadString("ErrorAadInvalidLocation"), [
                        #"Location" = location
                    ])
        else
            error Error.Record("Error", Extension.LoadString("ErrorAadRedirectFailed"), [
                Response.Status = Value.Metadata(endpointResponse)[Response.Status]?
            ]);

// True iff the given warehouse id (as a 16-char zero-padded hex string) belongs
// to the special class of warehouses that should be routed through ADBC + SEA.
// Warehouse ids are stored internally as Longs and exposed to customers as
// 16-char zero-padded hex; the qualifying range is [2, 100_000_000].
//
// Lexicographic comparison on equal-length lowercase hex strings is identical
// to numeric comparison: ASCII orders 0..9 < a..f correctly, and zero-padding
// aligns positional weights. The explicit length check guards against shorter
// or longer inputs being mis-classified (e.g. a path with trailing junk).
//
// Range source: sqlgateway/common/src/main/scala/EndpointId.scala
IsSpecialWarehouse = (warehouseIdHex as text) as logical =>
    let
        normalized = Text.Lower(warehouseIdHex)
    in
        Text.Length(normalized) = 16
        and normalized >= "0000000000000002"
        and normalized <= "0000000005f5e100";

// Builds the descriptor returned by TestConnection. The warehouse id is
// extracted from either the /sql/1.0/warehouses/ or the /sql/1.0/endpoints/
// http path form. For warehouses in the special ADBC + SEA routing range
// (id in [2, 100_000_000]), appends [Implementation = "2.0", Protocol = "rest"]
// so Service / gateway refresh routes those warehouses through ADBC + SEA.
BuildTestConnectionResult = (functionName as text, dataSourcePath as text) as list =>
    let
        json = Json.Document(dataSourcePath),
        Host = json[host],
        HTTPPath = json[httpPath],
        WarehousePrefix = "/sql/1.0/warehouses/",
        EndpointPrefix = "/sql/1.0/endpoints/",
        WarehouseId =
            if Text.StartsWith(HTTPPath, WarehousePrefix)
            then Text.Range(HTTPPath, Text.Length(WarehousePrefix))
            else if Text.StartsWith(HTTPPath, EndpointPrefix)
            then Text.Range(HTTPPath, Text.Length(EndpointPrefix))
            else "",
        isSpecialWarehouse = IsSpecialWarehouse(WarehouseId)
    in
        if isSpecialWarehouse then
            { functionName, Host, HTTPPath, [Implementation = "2.0", Protocol = "rest"] }
        else
            { functionName, Host, HTTPPath };

// Data Source Kind description.
Databricks = [

    Authentication = [
        Aad = [
            AuthorizationUri = (dataSourcePath as text) =>
                let
                    json = Json.Document(dataSourcePath),
                    _host = json[host],
                    HTTPPath = json[httpPath],

                    ValidatedHost = ValidateTrustedAadHost(_host),

                    HTTPPathParts = Text.Split(HTTPPath, "/"),
                    OrgIdPos = List.PositionOf(HTTPPathParts, "o") + 1,
                    OrgId = HTTPPathParts{OrgIdPos},

                    PathHasOrgId = OrgIdPos > 0,

                    // Eagerly evaluate ValidatedHost: failure in Text.Format obfuscates the error
                    AssertHostValid = ValidatedHost <> null, // true or error

                    ClusterUri =
                        if IsAWSEndpoint(ValidatedHost) then
                           Text.Format("https://#{0}/oidc/custom/.well-known/openid-configuration", {ValidatedHost})
                        else if AssertHostValid and PathHasOrgId then
                            Text.Format("https://#{0}/aad/auth?o=#{1}", {ValidatedHost, OrgId})
                        else
                            Text.Format("https://#{0}/aad/auth", {ValidatedHost}),
                    
                    AuthUriResult = 
                        if IsAWSEndpoint(ValidatedHost) then
                            GetAuthorizationUrlFromWellKnown(ClusterUri)
                        else 
                             GetAuthorizationUrlFromLocation(ClusterUri)
                in
                    AuthUriResult,

            Resource = "2ff814a6-3304-4ab8-85cb-cd0e6f879c1d",
            Label = Extension.LoadString("AzureActiveDirectoryLabel")
        ],
        Key = [
            KeyLabel = Extension.LoadString("PersonalAccessTokenLabel"),
            Label = Extension.LoadString("PersonalAccessTokenLabel")
        ],
        UsernamePassword = [
            UsernameLabel = Extension.LoadString("ClientIDLabel"),
            PasswordLabel = Extension.LoadString("ClientSecretLabel"),
            Label = Extension.LoadString("ClientCredentialsLabel")
        ]
    ],

        // Needed for use with Power BI Service.
    TestConnection = (dataSourcePath) =>
        BuildTestConnectionResult("Databricks.Contents", dataSourcePath),

    DSRHandlers = [
        // {"protocol":"databricks-sql","address":{"host":"hostAddress","path":"sql/path"}}
        #"databricks-sql" = [
            GetDSR = (host, httpPath, optional options) =>
            {
                [protocol = "databricks-sql", address = [host = host, path = httpPath ]],
                if options = null then [] else options
            },

            GetFormula = (dsr, optional options) =>
                if options = null then
                    () => Databricks.Catalogs(dsr[address][host], dsr[address][path])
                else
                    () => Databricks.Catalogs(dsr[address][host], dsr[address][path], options),

            GetFriendlyName = (dsr) => "Azure Databricks"
        ]
    ]
];

DatabricksMultiCloud = [

    Authentication = [  
        OAuth =  [
            StartLogin = OidcStartLogin,
            FinishLogin = OidcFinishLogin,
            Refresh = OidcRefresh,
            Label = Extension.LoadString("OIDCLabel")
        ],
        Key = [
            KeyLabel = Extension.LoadString("PersonalAccessTokenLabel"),
            Label = Extension.LoadString("PersonalAccessTokenLabel")
        ],
        UsernamePassword = [
             UsernameLabel = Extension.LoadString("ClientIDLabel"),
            PasswordLabel = Extension.LoadString("ClientSecretLabel"),
            Label = Extension.LoadString("ClientCredentialsLabel")
        ]
    ],
    TestConnection = (dataSourcePath) =>
        BuildTestConnectionResult("DatabricksMultiCloud.Catalogs", dataSourcePath),
    DSRHandlers = [
        // {"protocol":"databricks-multicloud","address":{"host":"hostAddress","path":"sql/path"}}
        #"databricks-multicloud" = [
            GetDSR = (host, httpPath, optional options) =>
            {
                [protocol = "databricks-multicloud", address = [host = host, path = httpPath ]],
                if options = null then [] else options
            },

            GetFormula = (dsr, optional options) =>
                if options = null then
                    () => DatabricksMultiCloud.Catalogs(dsr[address][host], dsr[address][path])
                else
                    () => DatabricksMultiCloud.Catalogs(dsr[address][host], dsr[address][path], options),

            GetFriendlyName = (dsr) => "Databricks"
        ]
    ]
];

// Azure Data Source UI publishing description.
Databricks.Publish = [
    Category = "Database",
    SupportsDirectQuery = true,

    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },

    SourceImage = Databricks.Icons,
    SourceTypeImage = Databricks.Icons,
    
    NativeQueryProperties = [
        NavigationSteps = {
            [
                Indices = {
                    [
                        FieldDisplayName = "Catalog",
                        IndexName = "Name"
                    ],
                    [
                        ConstantValue = "Database",
                        IndexName = "Kind"
                    ]
                },
                FieldAccess = "Data"
            ]
        },

        DefaultOptions = [
            EnableFolding = true
        ]
    ]
];

// Multi Cloud Data Source UI publishing description.
DatabricksMultiCloud.Publish = [
    Category = "Database",
    SupportsDirectQuery = true,

    ButtonText = { Extension.LoadString("MultiCloudButtonTitle"), Extension.LoadString("MultiCloudButtonHelp") },

    SourceImage = Databricks.Icons,
    SourceTypeImage = Databricks.Icons,
    
    NativeQueryProperties = [
        NavigationSteps = {
            [
                Indices = {
                    [
                        FieldDisplayName = "Catalog",
                        IndexName = "Name"
                    ],
                    [
                        ConstantValue = "Database",
                        IndexName = "Kind"
                    ]
                },
                FieldAccess = "Data"
            ]
        },
        DefaultOptions = [
            EnableFolding = true
        ]
    ]
];

Databricks.Icons = [
    Icon16 = { Extension.Contents("Databricks16.png"), Extension.Contents("Databricks20.png"), Extension.Contents("Databricks24.png"), Extension.Contents("Databricks32.png") },
    Icon32 = { Extension.Contents("Databricks32.png"), Extension.Contents("Databricks40.png"), Extension.Contents("Databricks48.png"), Extension.Contents("Databricks64.png") }
];

OIDCInHouseClientId = "power-bi";
OIDCInHouseRedirectUri = "https://oauth.powerbi.com/views/oauthredirect.html";
OIDCInHouseScopesToRequest = "sql offline_access";

IsAzureEndpoint = (host) => 
    let
        parsedHost = ValidateAnyHost(host),
        isTrustedAzureEndpoint = List.MatchesAny(TrustedAadDomains, (domain) => Text.EndsWith(parsedHost, domain))
    in
        isTrustedAzureEndpoint;
        
IsAWSEndpoint = (host) => 
    let
        parsedHost = ValidateAnyHost(host),
        isTrustedAWSEndpoint = List.MatchesAny(TrustedAWSDomains, (domain) => Text.EndsWith(parsedHost, domain))
    in
        isTrustedAWSEndpoint;

GetOIDCAppInfo = (dataSourcePath) => 
    let

        dataSource = Json.Document(dataSourcePath),
        host = ValidateTrustedOAuthHost(dataSource[host]),

        clientAppInfo = if IsAWSEndpoint(host) or IsAzureEndpoint(host) then 
            [ClientId = OIDCInHouseClientId, RedirectUri = OIDCInHouseRedirectUri, Scope = OIDCInHouseScopesToRequest]
        else
            error Error.Record("Datasource.Error", Text.Format(Extension.LoadString("ErrorInvalidHost"), {host}))
    in
        clientAppInfo;

OidcGetEndpoint = (dataSourcePath) => 
    let 
        dataSource = Json.Document(dataSourcePath),
        host = ValidateTrustedOAuthHost(dataSource[host]),

        auth_endpoint = if IsAWSEndpoint(host) or IsAzureEndpoint(host) then 
                Text.Format("https://#{0}/oidc/v1", {host})
            else 
                error Error.Record("Error", Text.Format(Extension.LoadString("ErrorInvalidHost"), {host}))
    in
        auth_endpoint;

OidcParseRedirect = (callbackResponse) => 
    let
        validateParts = each _,
        parts = Uri.Parts(callbackResponse)[Query],
        validatedParts = validateParts(parts)
    in 
        validatedParts;

OidcTokenRequest = (dataSourcePath, params) => 
    let
        tokenUrl = OidcGetEndpoint(dataSourcePath) & "/token",

        response = Web.Contents(
            tokenUrl, 
            [
                Content = tokenQuery,
                Headers = [
                    #"Content-type" = "application/x-www-form-urlencoded",
                    #"Accept" = "application/json"
                ]
            ]
        ),

        tokenQuery = Text.ToBinary(Uri.BuildQueryString(params)),

        token = Json.Document(response)
    in
        token;

OidcStartLogin = (clientApplication, dataSourcePath, state, display) => 
    let
        authorizeUrl = OidcGetEndpoint(dataSourcePath) & "/authorize?",
        url = authorizeUrl & oidcQuery,
        
        Base64UrlEncode = (binaryData as binary) =>
            let
                unescapedStr = Binary.ToText(binaryData, BinaryEncoding.Base64),
                // https://www.oauth.com/oauth2-servers/pkce/authorization-request/
                base64EncodedAsTextEscaped = Text.Replace(Text.Replace(Text.Replace(unescapedStr, "+", "-"), "/", "_"), "=", "")
            in
                base64EncodedAsTextEscaped,

        // Note: Crypto and CryptoAlgorithm are not publicly documented on Microsoft M language documentation
        // these APIs can only be used inside Custom Data Connectors (verified with Microsoft)
        
        // Authorization PKCE verifier
        codeVerifier = Text.NewGuid() & Text.NewGuid(),
        // Authorization PKCE challenge
        codeChallenge = Base64UrlEncode(Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(codeVerifier, TextEncoding.Ascii))),

        clientApp = GetOIDCAppInfo(dataSourcePath),
        
        redirectUri = clientApp[RedirectUri],
        clientId = clientApp[ClientId],
        scope = clientApp[Scope],
        oidcQuery = Uri.BuildQueryString([
            client_id = clientId,
            scope = scope,
            response_type = "code",
            state = state,
            code_challenge = codeChallenge,
            code_challenge_method = "S256",
            redirect_uri = redirectUri
        ])
    in
        [
            LoginUri = url,
            CallbackUri = redirectUri,
            WindowHeight = 780,
            WindowWidth = 980,
            Context = [CodeVerifier = codeVerifier, ClientApp = clientApp]
        ];

OidcFinishLogin = (clientApplication, dataSourcePath, context, callbackUri, state) => 
    let    
        parts = OidcParseRedirect(callbackUri),
        codeVerifier = context[CodeVerifier],
        clientApp = context[ClientApp],
        clientId = clientApp[ClientId],
        redirectUri = clientApp[RedirectUri],
        token = OidcTokenRequest(dataSourcePath, [
            client_id = clientId,
            grant_type = "authorization_code",
            code = parts[code],
            code_verifier = codeVerifier,
            redirect_uri = redirectUri
        ])
    in
        token;

OidcRefresh = (clientApplication, dataSourcePath, oldCredentials) =>
    let
        refreshToken = oldCredentials[refresh_token],
        clientApp = GetOIDCAppInfo(dataSourcePath),
        token = OidcTokenRequest(dataSourcePath, [
            grant_type = "refresh_token",
            client_id = clientApp[ClientId],
            refresh_token = refreshToken
        ])
    in
        token;

BuildOdbcConfig = () as record =>
    let
        defaultConfig = [
            SqlCapabilities = [],
            SQLGetInfo = []
        ],

        withSqlConformance =
            if (Config_SqlConformance <> null) then
                let
                    caps = defaultConfig[SQLGetInfo] & [
                        SQLGetInfo = [
                            SQL_SQL_CONFORMANCE = Config_SqlConformance
                        ]
                    ]
                in
                    defaultConfig & caps
            else
                defaultConfig
    in
        withSqlConformance;

ModuleIdentifier = () => ...;

// Identity for SqlView folding. Sign ONLY on the required connection params (host, httpPath)
// -- never on optional parameters. The optional Catalog/Database (and other options) still flow
// into the live connection string, but if they were part of this Signature then two
// Databricks.Catalogs sources on the SAME warehouse with different default Catalog/Database would
// get distinct identities, and a join between them would not fold -- Power BI would run two
// separate SELECTs and join locally. Keying only on {host, httpPath} lets same-warehouse sources
// share one identity so cross-catalog joins fold into a single native query (tables are 3-part
// `catalog`.`schema`.`table` qualified in the folded SQL, so the default catalog/schema is not
// needed for correctness).
MakeUniqueIdentifier = (host, httpPath) => [Module=ModuleIdentifier, Signature=[Host=host, Path=httpPath]];

AllStatementProperties = [];

GetDefaultCatalogAndSchema = (validatedOptions as record) as record =>
    let
        DefaultSchema = validatedOptions[Database]?,
        DefaultCatalog = validatedOptions[Catalog]?
    in
        [Catalog = DefaultCatalog, Schema = DefaultSchema];

HandleAdbcError = (operation as function) =>
    try operation() catch (e) =>
        let
            errorMessage = e[Message],
            errorDetail = e[Detail],
            
            isAuthError = Text.Contains(errorMessage, "Forbidden") or Text.Contains(errorMessage, "Unauthorized"),
            handledError = if isAuthError then
                error Extension.CredentialError("AccessDenied", errorMessage)
            else
                error e
        in
            handledError;

DatabricksAdbc = (host as text, httpPath as text, options as nullable record, optional wrappedSqlQuery as text) =>
    let
        Credential = Extension.CurrentCredential(),
        ValidatedOptions = ValidateAdvancedOptions(options),
        EnableAutoQueryTags = Record.FieldOrDefault(ValidatedOptions, "EnableAutoQueryTags", true),
        PlatformVersion = GetPlatformVersion(),
        ConnectionString = GetAdbcConnectionString(host, httpPath, ValidatedOptions),
        CredentialConnectionString = GetAdbcCredentialConnectionString(Credential),
        ProtocolProperty =
            if PlatformVersion >= 153 then
                let
                    protocol = ValidatedOptions[Protocol]?
                in
                    if protocol <> null and protocol <> "" then
                        [#"adbc.databricks.protocol" = protocol]
                    else
                        []
            else
                [],
        UserQueryTagsConnectionProperty =
            if PlatformVersion < 153 then
                let
                    userQueryTags = ValidatedOptions[QueryTags]?
                in
                    if userQueryTags <> null and userQueryTags <> "" then
                        [#"adbc.databricks.ssp_query_tags" = userQueryTags]
                    else
                        []
            else
                [],
        AllStatementProperties = [],
        EnableActivityDiagnostics = Record.FieldOrDefault(options, "EnableActivityDiagnostics", "enabled") = "enabled",
        FinalConnectionString = ConnectionString & CredentialConnectionString & ProtocolProperty & UserQueryTagsConnectionProperty,
        adbcConnectionOptions =
            if PlatformVersion >= 157 and CancelAdbcQueryExplicitly then
                [ConnectionPoolType = 2, CancelQueryExplicitly = true]
            else
                [ConnectionPoolType = 2],
        AdbcConnectionOptions = Diagnostics.Trace(
            TraceLevel.Information, [
                Name = "Databricks/CancelAdbcQueryExplicitly",
                Data = [],
                SafeData = [
                    CancelAdbcQueryExplicitly = CancelAdbcQueryExplicitly,
                    CancelQueryExplicitly = adbcConnectionOptions[CancelQueryExplicitly]?
                ]
            ],
            adbcConnectionOptions
        ),
        Connection = HandleAdbcError(() =>
            Adbc.Connection(AdbcDriver, FinalConnectionString, [], AdbcConnectionOptions)
        ),
        GetCatalogProperty = (executionOptions as nullable record) as record =>
            if executionOptions <> null and executionOptions[Catalog]? <> null then
                [adbc.get_metadata.target_catalog = executionOptions[Catalog]]
            else
                [],
        GetQueryTagsProperty = () as record =>
            if PlatformVersion >= 153 then
                let
                    userQueryTags = ValidatedOptions[QueryTags]?,
                    finalQueryTags = if EnableAutoQueryTags then
                        let
                            correlationId = try Diagnostics.CorrelationId() otherwise null,
                            activityId = try Diagnostics.ActivityId() otherwise null
                        in
                            AddDefaultQueryTags(userQueryTags, correlationId, activityId)
                    else
                        userQueryTags
                in
                    if finalQueryTags <> null and finalQueryTags <> "" then
                        [#"adbc.databricks.query_tags" = finalQueryTags]
                    else
                        []
            else
                [],
        GetStatementProperties = (executionOptions as nullable record) as record =>
            GetCatalogProperty(executionOptions) & GetQueryTagsProperty(),
        ExecuteQuery = (sql, optional options) =>
            let
                sqlWithOptionalComment = if EnableActivityDiagnostics then
                    "/*ActivityId: " & Diagnostics.ActivityId() & " CorrelationId: " & Diagnostics.CorrelationId() & " */" & sql
                    else
                    sql,
                connectionOptions = [
                    ConnectionProperties = [],
                    StatementProperties = GetStatementProperties(options),
                    IsMetadata = options[IsMetadata]?
                ]
            in
                HandleAdbcError(() =>
                    Connection[ExecuteQuery](sqlWithOptionalComment, null, connectionOptions)
                ),
        ExecuteThriftApi = (thriftApi, statementProperties) =>
            let
                connectionOptions = [
                    ConnectionProperties = [],
                    IsMetadata = true
                ] & statementProperties
            in
                HandleAdbcError(() =>
                    Connection[ExecuteQuery](thriftApi, null, connectionOptions)
                ),
        GetData = (query as text, resultType as type, context) => CreateDataTable(query, resultType, context, ExecuteQuery), 
        CreateDataTable = (query as text, resultType as type, context, executeQuery) =>
            Table.View(null, [
                GetType = () => resultType,
                GetRows = () =>
                    let
                        data = executeQuery(query, context[[Catalog],[IsMetadata]]?),
                        oldNames = Table.ColumnNames(data),
                        newNames = Table.ColumnNames(#table(resultType, {})),
                        renamed = Table.RenameColumns(data, List.Zip({oldNames, newNames})),
                        durationIndexes = GetDurationColumnIndexes(resultType),
                        dataWithDuration = ApplyDurationFrom(renamed, durationIndexes)
                    in
                        dataWithDuration,
                ValidateGetRows = true
            ]),   
        GetDurationColumnIndexes = (tableType as type) as list =>
            let
                schema = Type.TableSchema(tableType),
                durationTypes = Table.SelectRows(schema,each [TypeName] = "Duration.Type"),
                durationIndexes = Table.Column(durationTypes,"Position")
            in
                durationIndexes,
        ApplyDurationFrom = (table as table, durationIndexes as list) as table =>
            let
                columnNames = Table.ColumnNames(table),
                durationColumns = List.Transform(durationIndexes, each columnNames{_}),
                transformedTable = Table.TransformColumns(
                    table,
                    List.Transform(durationColumns, each {_, CreateDurationFromTicks})
                )
            in
                transformedTable,
        CreateDurationFromTicks = (ticks as nullable number) =>
            let 
                totalSeconds = ticks / 1000,
                days = Number.IntegerDivide(totalSeconds, 86400),  // Calculate days (1 day = 86400 seconds)
                remainingSecondsAfterDays = Number.Mod(totalSeconds, 86400),
                hours = Number.IntegerDivide(remainingSecondsAfterDays, 3600),  // Calculate hours (1 hour = 3600 seconds)
                remainingSecondsAfterHours = Number.Mod(remainingSecondsAfterDays, 3600),
                minutes = Number.IntegerDivide(remainingSecondsAfterHours, 60),  // Calculate minutes (1 minute = 60 seconds)
                seconds = Number.Mod(remainingSecondsAfterHours, 60),  // Remaining seconds
                result = #duration(days, hours, minutes, seconds)
            in
                result,
        UniqueIdentifier = MakeUniqueIdentifier(host, httpPath),
        generator = DatabricksSqlGenerator(),
        SqlGenerator = SqlView.Generator(UniqueIdentifier, generator, GetData),
        // Resolve a FK-related table from path = {catalog, schema, table}.
        // AdbcDatabases has two shapes: the hierarchical GetDatabases tree (no default schema,
        // levels keyed [Name]) and the flat GetTablesWithMetadata list (default schema set,
        // rows keyed {Catalog, Schema, Item}). Only the hierarchical [Name] walk is broken by a
        // default schema -- it fails with "The key didn't match any rows in the table.
        // Key=[Name=<catalog>]". Keep that original walk unchanged for the (already working)
        // no-default-schema path, and only for the default-schema case resolve via GetTable,
        // the shape-independent loader both paths ultimately call.
        ResolveRelatedTable = if Defaults[Schema] <> null then
            (path) => GetTable(context, path{0}, path{1}, path{2})
        else
            (path) => AdbcDatabases{[Name=path{0}]}[Data]{[Name=path{1}]}[Data]{[Name=path{2}]}[Data],
        NavPropGenerator = if Tables.NavigationPropertyGenerator = null or ValidatedOptions[EnablePKFK]? = 0 then null else
            Tables.NavigationPropertyGenerator(null, ResolveRelatedTable),
        context = [
            Connection = Connection,
            ExecuteQuery = ExecuteQuery,
            ExecuteThriftApi = ExecuteThriftApi,
            SqlGenerator = SqlGenerator,
            NavPropGenerator = NavPropGenerator,
            ValidatedOptions = ValidatedOptions
        ],
        Defaults = GetDefaultCatalogAndSchema(ValidatedOptions),
        AdbcDatabases = if Defaults[Schema] <> null then
            GetTablesWithMetadata(context, Defaults[Schema])
        else GetDatabases(context, null),
        DataSourceOrQuery = if wrappedSqlQuery = null then
            AdbcDatabases
        else
            let
                catalog = ValidatedOptions[Catalog]?
            in
                NativeQuery(context, catalog, wrappedSqlQuery)
     in
        DataSourceOrQuery;

AdjustNativeTypes = (tableType as type) as type =>
    let
        rowType = Type.TableRow(tableType),
        rowFields = Record.ToTable(Type.RecordFields(rowType)),
        adjusted = Table.TransformColumns(rowFields, {{"Value", (field) =>
            let
                originalType = field[Type],
                connectorType = Text.Upper(Value.Metadata(originalType)[#"Spark:DataType:SqlName"]?) ?? "NOTFOUND",
                adjustedType = if Text.StartsWith(connectorType, "DECIMAL") then "DECIMAL"
                    else if Text.StartsWith(connectorType, "STRUCT") or Text.StartsWith(connectorType, "ARRAY") or Text.StartsWith(connectorType, "MAP") then "STRING"
                    else if Text.StartsWith(connectorType, "INTERVAL") then "INTERVAL"
                    else if Text.StartsWith(connectorType, "STRING") or Text.StartsWith(connectorType, "CHAR") or Text.StartsWith(connectorType, "VARCHAR") then "STRING"
                    else if Text.StartsWith(connectorType, "GEOMETRY") or Text.StartsWith(connectorType, "GEOGRAPHY") then "STRING"
                    else if Text.StartsWith(connectorType, "VOID") then "STRING"
                    else connectorType,
                newType = Type.ReplaceFacets(originalType, [NativeTypeName = adjustedType])
            in
                [Type = newType, Optional = field[Optional]]
            }})
    in
        type table Type.ForRecord(Record.FromTable(adjusted), false);

FoldNavigationStep = (selector, loader, kind) =>
    let
        reduceAnd = (ast) => if ast[Kind] = "Binary" and ast[Operator] = "And" then List.Combine({@reduceAnd(ast[Left]), @reduceAnd(ast[Right])}) else {ast},
        matchFieldAccess = (ast) => if ast[Kind] = "FieldAccess" and ast[Expression] = RowExpression.Row then ast[MemberName] else ...,
        matchConstant = (ast) => if ast[Kind] = "Constant" then ast[Value] else ...,
        matchIndex = (ast) => if ast[Kind] = "Binary" and ast[Operator] = "Equals"
            then
                if ast[Left][Kind] = "FieldAccess"
                    then Record.AddField([], matchFieldAccess(ast[Left]), matchConstant(ast[Right]))
                    else Record.AddField([], matchFieldAccess(ast[Right]), matchConstant(ast[Left]))
            else ...,
        predicate1 = Record.Combine(List.Transform(reduceAnd(RowExpression.From(selector)), matchIndex)),
        isKindList = kind is list,
        kindMatch = if isKindList then List.Contains(kind,predicate1[Kind]?) else predicate1[Kind]? = kind,
        predicate2 = if kindMatch then Record.RemoveFields(predicate1, {"Kind"}) else predicate1,
        pickKind = if isKindList then 
                    if List.Contains(kind,predicate1[Kind]?) then predicate1[Kind]? else ...
                else kind,
        name = if Record.FieldCount(predicate2) = 1 and predicate2[Name]? <> null then 
                    predicate2[Name] 
                else if predicate2[Item]? <> null then 
                    predicate2[Item] 
                else 
                    ...
    in
        Table.FromRecords({[Name=name, Description="", Data=loader(name), Kind=pickKind]});

AllValueEqualsToNull = (equalityComparers) =>
    if (List.IsEmpty(List.Select(equalityComparers, each _ <> Value.Equals))) then null
    else equalityComparers;

AdvancedOptionsValidators = Extension.LoadFunction("AdvancedOptions.pqm")[AdvancedOptionsValidators];

GetAdbcConnectionString = (host as text, httpPath as text, validatedOptions as record) as record =>
    let
        UseCachedResult = if validatedOptions[SSP_use_cached_result]? = null then true else validatedOptions[SSP_use_cached_result],
        BaseConnectionString = [
            adbc.spark.type = "http",
            adbc.spark.host = host,
            adbc.spark.path = httpPath,
            adbc.spark.port = 443,
            adbc.http_options.tls.enabled = true,
            adbc.spark.user_agent_entry = "PowerBI",
            adbc.databricks.ssp_use_cached_result = Logical.ToText(UseCachedResult),
            adbc.databricks.token_renew_limit = 10
        ],
        OptionAdbcFields = AdbcFieldsFromOptions(validatedOptions),
        EnableAutomaticProxyDiscovery = Record.FieldOrDefault(validatedOptions, "EnableAutomaticProxyDiscovery", false),
        ProxyOptions = if EnableAutomaticProxyDiscovery then
        let
        ProxyUriRecord = Web.DefaultProxy(host),
        ops = if Record.FieldCount(ProxyUriRecord) > 0 then
            let
                UriRecord = Uri.Parts(ProxyUriRecord[ProxyUri]),
                proxyOptions = [
                    adbc.proxy_options.use_proxy = true,
                    adbc.proxy_options.proxy_host = UriRecord[Host],
                    adbc.proxy_options.proxy_port = UriRecord[Port]
                ]
            in 
                proxyOptions
            else []
        in
           ops 
        else [],
        ConnectionStringWithOptions = Record.Combine({BaseConnectionString, ProxyOptions, OptionAdbcFields}),
        ConnectionStringWithStringOptions = Record.TransformFields(
            ConnectionStringWithOptions,
            List.Transform(
                Record.FieldNames(ConnectionStringWithOptions),
                each {_, (value) => 
                    if value is text then value 
                    else if value is number then Text.From(value)
                    else if value is logical then Logical.ToText(value)
                    else if value is null then ""
                    else Text.From(value)}
            )
        ),
        ConnectionStringWithEmptyRemoved = Record.SelectFields(
            ConnectionStringWithStringOptions,
            List.Select(
                Record.FieldNames(ConnectionStringWithStringOptions),
                each Record.Field(ConnectionStringWithStringOptions, _) <> null and Record.Field(ConnectionStringWithStringOptions, _) <> ""
            )
        )
    in
        ConnectionStringWithEmptyRemoved;

CredentialProperty = (p) => p meta [Credential.Property = true];

GetAdbcCredentialConnectionString = (Credential as record) as record =>
    let
        AuthKind = Credential[AuthenticationKind]
    in
        if AuthKind = "Key" then [
            adbc.spark.auth_type = CredentialProperty("token"),
            adbc.spark.token = CredentialProperty(Credential[Key])
        ] else if AuthKind = "OAuth" then [
            adbc.spark.auth_type = CredentialProperty("oauth"),
            adbc.spark.access_token = CredentialProperty(Credential[access_token])
        ] else if AuthKind = "UsernamePassword" then
            if Credential[Username] = "token" then
                [
                    adbc.spark.auth_type = CredentialProperty("token"),
                    adbc.spark.token =  CredentialProperty(Credential[Password])
                ]
            else
                [
                    adbc.spark.auth_type = CredentialProperty("oauth"),
                    adbc.databricks.oauth.grant_type = CredentialProperty("client_credentials"),
                    adbc.databricks.oauth.client_id = CredentialProperty(Credential[Username]),
                    adbc.databricks.oauth.client_secret = CredentialProperty(Credential[Password]),
                    adbc.databricks.oauth.scope = CredentialProperty("sql")
                ]
        else
            error Extension.CredentialError("DataSource.UnsupportedAuthenticationKind", Text.Format("Unsupported authentication mode #{0}", {AuthKind}));

EscapeIdentifier = (identifier as text) as text => "`" & Text.Replace(identifier, "`", "``") & "`";

MakeNavTableType = (isLeaf) =>
    let
        dataType = type table meta [
            NavigationTable.ItemKind = "Table",
            Preview.Delay = "Table",
            NavigationTable.RowConfigurationColumn = "Kind"
        ],
        tableType = type table [
            Name = text,
            Description = nullable text,
            Data = dataType,
            Kind = text
        ],
        withKeys = Type.ReplaceTableKeys(tableType, {[Columns={"Name", "Kind"}, Primary=true]}) meta [
            NavigationTable.NameColumn="Name",
            NavigationTable.DataColumn="Data",
            NavigationTable.KindColumn="Kind"
        ]
    in
        withKeys;

MakeNavTableTypeWithExtendedMetadata = (isLeaf) =>
    let
        dataType = type table meta [
            NavigationTable.ItemKind = "Table",
            Preview.Delay = "Table",
            NavigationTable.RowConfigurationColumn = "Kind"
        ],
        tableType = type table [
            Name = text,
            Item = text,
            Schema = text,
            Catalog = text,
            Description = nullable text,
            Data = dataType,
            Kind = text
        ],
        withKeys = Type.ReplaceTableKeys(tableType, {[Columns={"Item", "Schema", "Catalog", "Kind"}, Primary=true]}) meta [
            NavigationTable.NameColumn="Name",  // Still display the full name
            NavigationTable.DataColumn="Data", 
            NavigationTable.KindColumn="Kind"
        ]
    in
        withKeys;

GetDatabases = (context, dataSource) =>
    let
        isLeaf = false,
        kind = "Database",
        thriftApi = "GetCatalogs",
        properties = [adbc.apache.statement.is_metadata_command = "true"],
        result = context[ExecuteThriftApi](thriftApi, [StatementProperties = properties]),
        isOldDBR = Table.RowCount(result) = 1 and result{0}[TABLE_CAT] = "SPARK",
        result1 = if isOldDBR then Table.FromRecords({[TABLE_CAT = "hive_metastore"]}) else result,
        tables = Table.RenameColumns(Table.AddColumn(result1, "Description", each [TABLE_CAT]), {{"TABLE_CAT", "Name"}}),
        getSchemas = (name) => GetSchemas(context, dataSource, name),
        withData = Table.AddColumn(tables, "Data", each getSchemas([Name]), type table),
        withKind = Table.AddColumn(withData, "Kind", each kind meta [NavigationTable.IsLeaf = isLeaf], type text),
        withFolding = Table.View(null, [
            GetType = () => MakeNavTableType(isLeaf),
            GetRows = () => withKind,
            OnSelectRows = (selector) => FoldNavigationStep(selector, getSchemas, kind),
            ThrowFoldingFailures = false
        ])
    in
        withFolding;

GetSchemas = (context, dataSource, catalog) =>
    let
        isLeaf = false,
        kind = "Schema",
        thriftApi = "GetSchemas",
        properties = [adbc.apache.statement.is_metadata_command = "true", adbc.get_metadata.escape_pattern_wildcards="true", adbc.get_metadata.target_catalog = catalog],
        primaryResult = context[ExecuteThriftApi](thriftApi, [StatementProperties = properties]),
        needsFallback = Text.Lower(catalog) = "hive_metastore" and Table.RowCount(primaryResult) = 0,
        actualCatalog = if needsFallback then "SPARK" else catalog,
        sparkProperties = [adbc.apache.statement.is_metadata_command = "true", adbc.get_metadata.escape_pattern_wildcards="true", adbc.get_metadata.target_catalog = "SPARK"],
        result = if needsFallback then
            context[ExecuteThriftApi](thriftApi, [StatementProperties = sparkProperties])
        else
            primaryResult,
        schemasRaw = Table.RenameColumns(Table.AddColumn(result, "Description", each [TABLE_SCHEM]), {{"TABLE_SCHEM", "Name"}}),
        schemas = Table.SelectColumns(schemasRaw,{"Name","Description"}),
        withoutInformationSchema = Table.SelectRows(schemas, each [Name] <> "INFORMATION_SCHEMA"),
        getTables = (name) => GetTables(context, actualCatalog, name),
        withData =  Table.AddColumn(withoutInformationSchema, "Data", each getTables([Name]), type table),
        withKind = Table.AddColumn(withData, "Kind", each kind meta [NavigationTable.IsLeaf = isLeaf], type text),
        db = dataSource{[Name=catalog, Kind="Database"]}[Data],
        withFolding = Table.View(null, [
            GetType = () => MakeNavTableType(isLeaf),
            GetRows = () => withKind,
            OnSelectRows = (selector) => FoldNavigationStep(selector, getTables, kind),
            OnNativeQuery = (cmd, params, options) =>
               let
                    disableFolding = options[EnableFolding]? <> true,
                    // Scope the native query to the drilled-in `catalog` (not actualCatalog:
                    // the hive_metastore -> SPARK fallback is only for metadata requests).
                    result = NativeQuery(context, catalog, cmd, disableFolding)
                in
                    try result catch (e) => error Table.ViewError(e),
            OnNativeStatement = (cmd, params, options) =>
                try ValueAction.NativeStatement(db, cmd, params, options) catch (e) => error Table.ViewError(e),
            ThrowFoldingFailures = false
        ])
    in
        withFolding;

NativeQuery = (context, catalog, cmd, optional disableFolding) =>
    let
        hasPermission = Extension.HasPermission([PermissionKind = "NativeQuery", Value = cmd]), // ends in challenge on failure
        detection = DetectQueryType(cmd, context[ValidatedOptions]),
        // The drill-down catalog is passed as [Catalog=catalog] (adbc.get_metadata.target_catalog).
        // When the customer enables the ScopeCurrentCatalog advanced option, the ADBC driver
        // issues a standalone USE CATALOG for it (only on change) so a verbatim 2-level
        // `schema`.`table` name in the native query resolves. See ES-2115589.
        result = if not detection[ShouldWrap] then
            let
                directResult = context[ExecuteQuery](cmd, [Catalog=catalog, IsMetadata=false]),
                nonFoldable = Table.Buffer(directResult)
            in
                nonFoldable
        else
            let
                typeQuery = "select *#(cr)#(lf)from (#(cr)#(lf)" & cmd & "#(cr)#(lf)) as `_`#(cr)#(lf)where 0 = 1",
                typeResult = context[ExecuteQuery](typeQuery, [Catalog=catalog, IsMetadata=true]),
                tableType = Value.Type(Table.Buffer(typeResult)),
                adjustedType = if context[Connection]? = null then tableType else AdjustNativeTypes(tableType),
                reference = [Kind = "FromQuery", Query = [Kind="Verbatim", Query=cmd], Alias = "_"],
                foldableResult = context[SqlGenerator](reference, adjustedType, [Catalog = catalog]),
                finalResult = if disableFolding <> true then foldableResult else context[ExecuteQuery](cmd, [Catalog=catalog, IsMetadata=false])
            in
                finalResult
    in
        if hasPermission then result else ...;

GetTablesCore = (context, catalog, schema) =>
    let
        isLeaf = true,
        thriftApi = "GetTables",
        baseProperties = [adbc.apache.statement.is_metadata_command = "true", adbc.get_metadata.escape_pattern_wildcards = "true", adbc.get_metadata.target_db_schema = schema],
        propertiesWithCatalog = if catalog <> null then Record.AddField(baseProperties, "adbc.get_metadata.target_catalog", catalog) else baseProperties,
        result = context[ExecuteThriftApi](thriftApi, [StatementProperties = propertiesWithCatalog]),
        
        tablesRaw = Table.RenameColumns(Table.AddColumn(result, "Description", each [TABLE_NAME]), {{"TABLE_NAME", "Item"}}), 
        tablesBase = Table.SelectColumns(tablesRaw,{"Item","Description","TABLE_TYPE","TABLE_CAT","TABLE_SCHEM"}),
        enableMultipleCatalogsSupport = Record.FieldOrDefault(context[ValidatedOptions], "EnableMultipleCatalogsSupport", "1"),
        tablesWithCatalogFixed = Table.TransformColumns(tablesBase, {
            "TABLE_CAT", each if enableMultipleCatalogsSupport = "0" or _ = null or _ = "" then "SPARK" else _
        }),
        
        withKind = Table.RemoveColumns(
            Table.AddColumn(
                tablesWithCatalogFixed, 
                "Kind", 
                each if [TABLE_TYPE] = null or [TABLE_TYPE] = "" then 
                    "Table" meta [NavigationTable.IsLeaf = isLeaf]
                else
                    (Text.Upper(Text.Start([TABLE_TYPE], 1)) & Text.Lower(Text.Range([TABLE_TYPE], 1))) meta [NavigationTable.IsLeaf = isLeaf],
                type text
            ), 
            "TABLE_TYPE"
        )
    in
        withKind;

GetTables = (context, catalog, schema) =>
    let
        isLeaf = true,
        tablesCore = GetTablesCore(
            context, 
            catalog, 
            schema
        ),
        getTable = (tableName) => GetTable(context, catalog, schema, tableName),
        withData = Table.AddColumn(tablesCore, "Data", each getTable([Item]), type table),
        rearrangedColumns = Table.SelectColumns(Table.RenameColumns(withData,{{"Item", "Name"}}), {"Name", "Description", "Data", "Kind"}),
        withFolding = Table.View(null, [
            GetType = () => MakeNavTableType(isLeaf),
            GetRows = () => rearrangedColumns,
            OnSelectRows = (selector) => FoldNavigationStep(selector, getTable, {"Table","View"}),
            ThrowFoldingFailures = false
        ])
    in
        withFolding;

GetTablesWithMetadata = (context, schema) =>
    let
        isLeaf = true,
        tablesCore = GetTablesCore(context, null, schema),
        tablesWithRenamedColumns = Table.RenameColumns(tablesCore, {{"TABLE_CAT", "Catalog"}, {"TABLE_SCHEM", "Schema"}}),
        tablesWithName = Table.AddColumn(tablesWithRenamedColumns, "Name", each "`" & [Catalog] & "`.`" & [Schema] & "`.`" & [Item] & "`"),
        withData = Table.AddColumn(tablesWithName, "Data", each GetTable(context, [Catalog], [Schema], [Item]), type table),
        tablesWithColumns = Table.SelectColumns(withData, {"Name", "Item", "Schema", "Catalog", "Description", "Data", "Kind"}),
        withFolding = Table.View(null, [
            GetType = () => MakeNavTableTypeWithExtendedMetadata(isLeaf),
            GetRows = () => tablesWithColumns,
            ThrowFoldingFailures = false
        ])
    in
        withFolding;

GetTable = (context, catalog, databaseName, tableName) =>
    let
        tableInfo = GetTableType(context[ExecuteThriftApi], catalog, databaseName, tableName),
        tableType = tableInfo[Type],
        metadata = tableInfo[Metadata],
        isSparkCatalog = Diagnostics.Trace(
            TraceLevel.Information, [
                Name = "Databricks/GetTableCatalog",
                Data = [],
                SafeData = [IsSparkCatalog = Text.Upper(catalog) = "SPARK"]
            ],
            Text.Upper(catalog) = "SPARK"
        ),
        tableReference = [Kind = "FromTable", Table = [Schema=databaseName, Name=tableName] & (if isSparkCatalog then [] else [Catalog=catalog])],
        withSqlView = context[SqlGenerator](tableReference, tableType, []),      
        tableSchema = Table.Schema(#table(tableType, {})),
        
        complexColumns = Table.ToRecords(Table.SelectRows(tableSchema,
                    (s) => s[NativeTypeName]  = "STRUCT" or s[NativeTypeName] = "ARRAY" or s[NativeTypeName] = "MAP")),
        TransformOperations = List.Accumulate(complexColumns, withSqlView, (state, column) =>
            let
                ColumnType = Type.TableColumn(tableType, column[Name]),
                PreservedFacetFields = { "NativeTypeName", "NativeDefaultExpression", "NativeExpression" },
                Facets = Record.SelectFields(Type.Facets(ColumnType), PreservedFacetFields),
                ComplexType = if (column[NativeTypeName] = "STRUCT" or column[NativeTypeName] = "MAP") then type record else type list,
                AddNullable = if Type.IsNullable(ComplexType) then type nullable ComplexType else ComplexType,
                TypeWithFacets = Type.ReplaceFacets(AddNullable, Facets),
                ToNullableJson = (value) => if value = null then null else Json.Document(value),
                TransformColumn = Table.TransformColumns(state, { column[Name], ToNullableJson, TypeWithFacets })
            in
                TransformColumn),
        WithNavigation = if context[NavPropGenerator] = null then TransformOperations else
            context[NavPropGenerator](TransformOperations, {catalog, databaseName, tableName}, () => GetRelationships(metadata))
    in
        WithNavigation;

GetTableType = (exec, database, schema, table) =>
    let
        thriftApi = "GetColumnsExtended",
        properties = [
            adbc.apache.statement.is_metadata_command = "true",
            adbc.get_metadata.escape_pattern_wildcards = "true",
            adbc.get_metadata.target_catalog = database, 
            adbc.get_metadata.target_db_schema = schema,
            adbc.get_metadata.target_table = table
        ],
        
        result = Table.Buffer(exec(thriftApi, [StatementProperties = properties])),
        
        columnsForType = Table.SelectColumns(result, {
            "COLUMN_NAME", 
            "TYPE_NAME", 
            "BASE_TYPE_NAME", 
            "COLUMN_SIZE", 
            "DECIMAL_DIGITS", 
            "NULLABLE", 
            "PK_COLUMN_NAME",
            "FK_FKCOLUMN_NAME",
            "FK_PKTABLE_CAT",
            "FK_PKTABLE_SCHEM",
            "FK_PKTABLE_NAME",
            "FK_PKCOLUMN_NAME"
        }),
        
        columnRecords = Table.ToRecords(columnsForType),
        
        columnNames = List.Transform(columnRecords, each [COLUMN_NAME]),
        
        columnTypes = List.Transform(columnRecords, each [
            Type = GetPowerQueryType(_),
            Optional = false  // Always false
        ]),
        
        rowType = Type.ForRecord(Record.FromList(columnTypes, columnNames), false),
        
        primaryKeyColumns = List.Select(columnRecords, each [PK_COLUMN_NAME] <> null and [PK_COLUMN_NAME] <> ""),
        primaryKeyNames = List.Transform(primaryKeyColumns, each [COLUMN_NAME]),
        primaryKeys = if List.IsEmpty(primaryKeyNames) then {} else {[Columns = primaryKeyNames, Primary = true]},
        tableType = type table rowType,
        tableTypeWithPrimaryKey = Type.ReplaceTableKeys(tableType, primaryKeys),
        metadata = result
    in
        [Type = tableTypeWithPrimaryKey, Metadata = metadata];
DatabricksTypeMap = [
    STRING = Type.ReplaceFacets(Text.Type, [
        NativeTypeName = "STRING",
        IsVariableLength = true  // Compatibility with ODBC
    ]),
    BOOLEAN = Type.ReplaceFacets(Logical.Type, [
        NativeTypeName = "BOOLEAN"
    ]),
    TINYINT = Type.ReplaceFacets(Int8.Type, [
        NativeTypeName = "TINYINT"
    ]),
    SMALLINT = Type.ReplaceFacets(Int16.Type, [
        NativeTypeName = "SMALLINT"
    ]),
    INT = Type.ReplaceFacets(Int32.Type, [
        NativeTypeName = "INT"
    ]),
    INTEGER = Type.ReplaceFacets(Int32.Type, [
        NativeTypeName = "INT"
    ]),
    BIGINT = Type.ReplaceFacets(Int64.Type, [
        NativeTypeName = "BIGINT"
    ]),
    FLOAT = Type.ReplaceFacets(Single.Type, [
        NativeTypeName = "FLOAT"
    ]),
    DOUBLE = Type.ReplaceFacets(Double.Type, [
        NativeTypeName = "DOUBLE"
    ]),
    DATE = Type.ReplaceFacets(Date.Type, [
        NativeTypeName = "DATE"
    ]),
    TIMESTAMP = Type.ReplaceFacets(DateTime.Type, [
        NativeTypeName = "TIMESTAMP"
    ]),
    TIMESTAMP_NTZ = Type.ReplaceFacets(DateTime.Type, [
        NativeTypeName = "TIMESTAMP"
    ]),
    BINARY = Type.ReplaceFacets(Binary.Type, [
        NativeTypeName = "BINARY"
    ]),
    INTERVAL = Type.ReplaceFacets(type text, [
        NativeTypeName = "INTERVAL"
    ]),
    ARRAY = Type.ReplaceFacets(type text, [
        NativeTypeName = "STRING",
        IsVariableLength = true  // Compatibility with ODBC
    ]),
    MAP = Type.ReplaceFacets(type text, [
        NativeTypeName = "STRING",
        IsVariableLength = true  // Compatibility with ODBC
    ]),
    STRUCT = Type.ReplaceFacets(type text, [
        NativeTypeName = "STRING",
        IsVariableLength = true  // Compatibility with ODBC
    ]),
    VARIANT = Type.ReplaceFacets(type text, [
        NativeTypeName = "VARIANT",
        IsVariableLength = true  // Compatibility with ODBC
    ])
];

GetPowerQueryType = (column as record) =>
    let
        typeName = Text.Upper(column[BASE_TYPE_NAME]),
        rawTypeName = column[TYPE_NAME],
        isNullable = column[NULLABLE] = 1,
        
        baseType = if typeName = "DECIMAL" then 
                    Type.ReplaceFacets(Decimal.Type, [
                        NativeTypeName = typeName,
                        NumericPrecision = column[COLUMN_SIZE],
                        NumericScale = column[DECIMAL_DIGITS],
                        NumericPrecisionBase = 10
                    ])
                 else if typeName = "CHAR" or typeName = "VARCHAR" then
                    Type.ReplaceFacets(Text.Type, [
                        NativeTypeName = typeName,
                        NumericPrecision = column[COLUMN_SIZE],
                        NumericPrecisionBase = 10,
                        IsVariableLength = typeName = "VARCHAR"
                    ])
                 else if Text.StartsWith(typeName, "GEOMETRY") or Text.StartsWith(typeName, "GEOGRAPHY") then
                    // Geospatial columns arrive parameterised (e.g. GEOMETRY(0), GEOGRAPHY(4326))
                    // and surface as WKT/EWKT text; map to STRING like ARRAY/MAP/STRUCT.
                    Type.ReplaceFacets(Text.Type, [
                        NativeTypeName = "STRING",
                        IsVariableLength = true
                    ])
                 else if typeName = "VOID" then
                    // VOID is the type of an untyped NULL literal (and stored `void`
                    // columns); values are always null. Map to STRING like ARRAY/MAP/STRUCT
                    // so the Mashup bridge can bind the column.
                    Type.ReplaceFacets(Text.Type, [
                        NativeTypeName = "STRING",
                        IsVariableLength = true
                    ])
                 else if Record.HasFields(DatabricksTypeMap, {typeName}) then
                    Record.Field(DatabricksTypeMap, typeName)
                 else
                    error Error.Record("DataSource.Error", 
                        "Unsupported Databricks SQL type: " & rawTypeName,
                        rawTypeName),
                    
        adjustedType = if isNullable then type nullable baseType else baseType
    in
        adjustedType;

GetRelationships = (metadata) =>
    let
        columnsForRelationships = Table.SelectColumns(metadata, {
            "COLUMN_NAME",
            "FK_PKCOLUMN_NAME",
            "FK_PKTABLE_CAT",
            "FK_PKTABLE_SCHEM",
            "FK_PKTABLE_NAME",
            "FK_FK_NAME",
            "FK_KEQ_SEQ"
        }),
        
        foreignKeyColumns = Table.SelectRows(columnsForRelationships, each [FK_PKCOLUMN_NAME] <> null),
        
        orderedForeignKeys = Table.Sort(foreignKeyColumns, {
            "FK_PKTABLE_CAT", 
            "FK_PKTABLE_SCHEM", 
            "FK_PKTABLE_NAME", 
            "FK_FK_NAME", 
            "FK_KEQ_SEQ"
        }),
        
        groupedForeignKeys = Table.Group(orderedForeignKeys, {
            "FK_PKTABLE_CAT", 
            "FK_PKTABLE_SCHEM", 
            "FK_PKTABLE_NAME", 
            "FK_FK_NAME"
        }, {
            {"Key1", each [COLUMN_NAME]},
            {"Key2", each [FK_PKCOLUMN_NAME]}
        }),
        
        relationships = Table.FromRecords(Table.TransformRows(groupedForeignKeys, each [
            Key1=[Key1],
            Identity2={[FK_PKTABLE_CAT], [FK_PKTABLE_SCHEM], [FK_PKTABLE_NAME]},
            Key2=[Key2],
            Expanded=true
        ]))
    in
        relationships;

AdvancedOptionsModule = Extension.LoadFunction("AdvancedOptions.pqm");

ValidateAdvancedOptions = AdvancedOptionsModule[ValidateAdvancedOptions];

OdbcFieldsFromOptions = AdvancedOptionsModule[OdbcFieldsFromOptions];

QueryHelpersModule = Extension.LoadFunction("QueryHelpers.pqm");

DetectQueryType = QueryHelpersModule[DetectQueryType];

Extension.LoadFunction = (name as text) =>
    let
        binary = Extension.Contents(name),
        asText = Text.FromBinary(binary)
    in
        Expression.Evaluate(asText, #shared);

ODBC = Extension.LoadFunction("OdbcConstants.pqm");

Odbc.Flags = ODBC[Flags];

AdbcDriver = 
    let 
        AdbcDriverDefinition = 
        [
            Name =  "DatabricksAdbc",
            Folder =  "Databricks",
            File =  "AdbcDrivers.Databricks.dll",
            DriverType =  "Managed",
            TypeName =  "AdbcDrivers.Databricks.DatabricksDriver",
            IdentifierQuoteChar =  "`",
            CatalogNameSeparator =  ".",
            TableTypes =  null,
            SupportsCatalog =  true,
            SupportsSchema =  true,
            SupportedConnectionOptions = [
                adbc.connection.catalog = false,
                adbc.connection.db_schema = false
            ],
            TypeInfo =  Table.FromRecords({
                [Name="BOOLEAN",   SqlType=-7, Unsigned=false, ColumnSize=1,     NumberPrecisionRadix=null, LiteralPrefix=null, LiteralSuffix=null],
                [Name="BIGINT",    SqlType=-5, Unsigned=false, ColumnSize=19,    NumberPrecisionRadix=10,   LiteralPrefix=null, LiteralSuffix=null],
                [Name="BINARY",    SqlType=-3, Unsigned=false, ColumnSize=32767, NumberPrecisionRadix=null, LiteralPrefix="0x", LiteralSuffix=null],
                [Name="CHAR",      SqlType=-8, Unsigned=false, ColumnSize=255,   NumberPrecisionRadix=null, LiteralPrefix="'",  LiteralSuffix="'"],
                [Name="DATE",      SqlType=91, Unsigned=false, ColumnSize=10,    NumberPrecisionRadix=null, LiteralPrefix="'",  LiteralSuffix="'"],
                [Name="DECIMAL",   SqlType=3,  Unsigned=false, ColumnSize=38,    NumberPrecisionRadix=10,   LiteralPrefix=null, LiteralSuffix=null],
                [Name="DOUBLE",    SqlType=8,  Unsigned=false, ColumnSize=53,    NumberPrecisionRadix=2,    LiteralPrefix=null, LiteralSuffix=null],
                [Name="FLOAT",     SqlType=7,  Unsigned=false, ColumnSize=24,    NumberPrecisionRadix=2,    LiteralPrefix=null, LiteralSuffix=null],
                [Name="INT",       SqlType=4,  Unsigned=false, ColumnSize=10,    NumberPrecisionRadix=10,   LiteralPrefix=null, LiteralSuffix=null],
                [Name="SMALLINT",  SqlType=5,  Unsigned=false, ColumnSize=5,     NumberPrecisionRadix=10,   LiteralPrefix=null, LiteralSuffix=null],
                [Name="STRING",    SqlType=-9, Unsigned=false, ColumnSize=65535, NumberPrecisionRadix=null, LiteralPrefix="'",  LiteralSuffix="'"],
                [Name="TIMESTAMP", SqlType=93, Unsigned=false, ColumnSize=29,    NumberPrecisionRadix=null, LiteralPrefix="'",  LiteralSuffix="'"],
                [Name="TINYINT",   SqlType=-6, Unsigned=false, ColumnSize=3,     NumberPrecisionRadix=10,   LiteralPrefix=null, LiteralSuffix=null],
                [Name="VARCHAR",   SqlType=-9, Unsigned=false, ColumnSize=65535, NumberPrecisionRadix=null, LiteralPrefix="'",  LiteralSuffix="'"]
            })
        ]
    in
        AdbcDriverDefinition;

AdbcFieldsFromOptions = AdvancedOptionsModule[AdbcFieldsFromOptions];

GetPlatformVersion = () => try Number.From(Text.Split(Module.Versions()[Core], "."){1}) otherwise 0;

QueryTagsHelperModule = Extension.LoadFunction("QueryTagsHelper.pqm");

GetDefaultQueryTags = QueryTagsHelperModule[GetDefaultQueryTags];

AddDefaultQueryTags = QueryTagsHelperModule[AddDefaultQueryTags];

DatabricksSqlGenerator = () =>
  let 
     GetNumberLiteral = (value as number) => Number.ToText(value),
     GetTimeLiteral = (value as time) => Time.ToText(value,[Format="HH:mm:ss.FFFFFFF"]),
     GetDateLiteral = (value as date) => Date.ToText(value,[Format="yyyy-MM-dd"]),
     GetDateTimeLiteral = (value as datetime) as text => DateTime.ToText(value,[Format="yyyy-MM-dd HH:mm:ss.FFFFFFF"]),
     // Escape string values before embedding in a SQL literal to prevent broken/injected SQL (e.g. Keith O'Donnell).
     // Matches the ODBC connector's StringLiteralEscapeCharacters = { { "\", "\\" }, { "'", "\'"} }:
     // backslash must be escaped first, then the single quote. Databricks SQL uses backslash escaping by default
     // (spark.sql.parser.escapedStringLiterals = false).
     GetStringLiteral = (value as text) as text => "'" & Text.Replace(Text.Replace(value, "\", "\\"), "'", "\'") & "'",
     SqlGetTypeInfo = #table( { "SqlTypeName","Type", "ColumnSize", "GetLiteral", "Searchable", "UnsignedAttribute", "NumericPrecisionRadix" },
         {
             {"BOOLEAN", Logical.Type, 1, null, 2, null, null},
 
             {"TINYINT", Int8.Type, 3, GetNumberLiteral, 2, 0, 10},
             {"SMALLINT", Int16.Type, 5, GetNumberLiteral, 2, 0, 10},
             {"INT", Int32.Type, 10, GetNumberLiteral, 2, 0, 10},
             {"BIGINT", Int64.Type, 19, GetNumberLiteral, 2, 0, 10},
 
             {"DECIMAL", Decimal.Type, 15, GetNumberLiteral, 2, 0, 10},
             {"DOUBLE", Double.Type, 17, GetNumberLiteral, 2, 0, 2},
             {"FLOAT", Single.Type, 9, GetNumberLiteral, 2, 0, 2},
 
             {"STRING", Text.Type, 16777216, GetStringLiteral, 3, null, null},
 
             {"CHAR", Text.Type, 16777216, GetStringLiteral, 3, null, null},
             {"VARCHAR", Text.Type, 16777216, GetStringLiteral, 3, null, null},
 
             {"BINARY", Binary.Type, 8388608, null, 3, null, null},
             {"TIMESTAMP", DateTime.Type, 35, GetDateTimeLiteral, 3, null, null},
             {"TIMESTAMP_NTZ", DateTime.Type, 35, GetDateTimeLiteral, 3, null, null},
             {"DATE", Date.Type, 10, GetDateLiteral, 3, null, null},
             {"INTERVAL", Text.Type, 16777216, null, 3, null, null},
             {"ARRAY", Text.Type, 16777216, null, 3, null, null},
             {"MAP", Text.Type, 16777216, null, 3, null, null},
             {"STRUCT", Text.Type, 16777216, null, 3, null, null},
             {"VARIANT", Text.Type, 16777216, null, 3, null, null}
         }
     ),

    SupportedConversions = #table({"FromSqlTypeName", "ToSqlTypeNames"},
        {
    
            {"BIGINT", {"BIGINT", "TINYINT", "SMALLINT", "INT", "DECIMAL", "FLOAT", "DOUBLE", "STRING", "TIMESTAMP"}},
            {"DECIMAL", {"DECIMAL", "BIGINT", "TINYINT", "SMALLINT", "INT", "FLOAT", "DOUBLE", "STRING", "TIMESTAMP"}},
            {"DOUBLE", {"DOUBLE", "BIGINT", "TINYINT", "SMALLINT", "INT", "DECIMAL", "FLOAT", "STRING", "TIMESTAMP"}},
            {"FLOAT", {"FLOAT", "BIGINT", "TINYINT", "SMALLINT", "INT", "DECIMAL", "DOUBLE", "STRING", "TIMESTAMP"}},
            {"INT", {"INT", "BIGINT", "TINYINT", "SMALLINT", "DECIMAL", "FLOAT", "DOUBLE", "STRING", "TIMESTAMP"}},
            {"SMALLINT", {"SMALLINT", "BIGINT", "TINYINT", "INT", "DECIMAL", "FLOAT", "DOUBLE", "STRING", "TIMESTAMP"}},
            {"TINYINT", {"TINYINT", "BIGINT", "SMALLINT", "INT", "DECIMAL", "FLOAT", "DOUBLE", "STRING", "TIMESTAMP"}},
    
            {"STRING", {"BIGINT", "BINARY", "BOOLEAN", "CHAR", "DATE", "DECIMAL", "DOUBLE", "FLOAT", "INT", "SMALLINT", "TINYINT", "STRING", "TIMESTAMP", "TIMESTAMP_NTZ", "VARCHAR"}},
            {"CHAR", {"BIGINT", "BINARY", "BOOLEAN", "CHAR", "DATE", "DECIMAL", "DOUBLE", "FLOAT", "INT", "SMALLINT", "TINYINT", "STRING", "TIMESTAMP", "TIMESTAMP_NTZ", "VARCHAR"}},
            {"VARCHAR", {"BIGINT", "BINARY", "BOOLEAN", "CHAR", "DATE", "DECIMAL", "DOUBLE", "FLOAT", "INT", "SMALLINT", "TINYINT", "STRING", "TIMESTAMP", "TIMESTAMP_NTZ", "VARCHAR"}},
    
            {"DATE", {"DATE", "STRING", "TIMESTAMP", "TIMESTAMP_NTZ"}},
            {"TIMESTAMP", {"TIMESTAMP", "STRING", "DATE", "TIMESTAMP_NTZ", "BIGINT", "INT", "DECIMAL", "DOUBLE", "FLOAT", "SMALLINT", "TINYINT"}},
            {"TIMESTAMP_NTZ", {"TIMESTAMP_NTZ", "STRING", "DATE", "TIMESTAMP"}},
    
            {"BOOLEAN", {"BOOLEAN", "TINYINT", "SMALLINT", "INT", "BIGINT", "FLOAT", "DOUBLE", "DECIMAL", "STRING"}},
    
            {"BINARY", {"BINARY", "STRING", "TIMESTAMP"}}
        }
    ),
        
       SqlTypesCategories = [
    
        SoftBase2Types = {"DOUBLE", "FLOAT", "DECIMAL", "BIGINT", "INTEGER", "SMALLINT", "TINYINT"},
    
        SoftBase10Types = {"DECIMAL", "DOUBLE", "FLOAT", "BIGINT", "INTEGER", "SMALLINT", "TINYINT"},
    
        WideCharTypes = {"CHAR"},
    
        VarCharTypes = {"VARCHAR", "STRING"},
        WideVarCharTypes ={"VARCHAR", "STRING"}
    ],
    
    DefaultTypes = #table({"Type","SqlTypeName"},
        {{Double.Type, "DOUBLE"},
        {Date.Type, "DATE"},
        {DateTime.Type, "TIMESTAMP"},
        {Text.Type,"STRING"},
        {Int8.Type,"TINYINT"},
        {Int16.Type,"SMALLINT"},
        {Int32.Type,"INT"},
        {Int64.Type,"BIGINT"},
        {Decimal.Type,"DECIMAL"},
        {Single.Type,"FLOAT"},
        {Logical.Type,"BOOLEAN"},
        {Binary.Type,"BINARY"}}
    ), 

    TimestampFunctionOverrides = 
    [
        timestampadd = (timestampAst,unitAst,partAst) => 
            let 
                nativeType = Type.Facets(timestampAst[Type])[NativeTypeName],
                part = if(partAst[Literal] = "Nanosecond") then partAst & [Literal = "Millisecond"] else partAst,
                arguments = {
                    [Expression = part, Type = Text.Type],
                    [Expression = unitAst, Type = Int64.Type],
                    [Expression = timestampAst, Type = timestampAst[Type]]
                }                
             in 
                [Kind = "Invocation", Function = [Kind = "Function", Name="timestampadd"], Arguments = arguments, Type = timestampAst[Type]],
        timestampdiff = (ast1,ast2,part) => 
            let
                part = if(part[Literal] = "Nanosecond") then part & [Literal = "Millisecond"] else part,
                nativeType1 = Type.Facets(ast1[Type])[NativeTypeName],
                nativeType2 = Type.Facets(ast2[Type])[NativeTypeName],
                arg1 = if(nativeType1 = "TIMESTAMP" or nativeType1 = "TIMESTAMP_NTZ") then ast1
                    else error "Invalid timestamp type, expected TIMESTAMP or TIMESTAMP_NTZ",
                arg2 = if(nativeType2 = "TIMESTAMP" or nativeType2 = "TIMESTAMP_NTZ") then ast2
                    else error "Invalid timestamp type, expected TIMESTAMP or TIMESTAMP_NTZ",
                arguments = {
                    [Expression = part, Type = Text.Type],
                    [Expression = arg2, Type = ast2[Type]],
                    [Expression = arg1, Type = ast1[Type]]
                }                
             in 
                [Kind = "Invocation", Function = [Kind = "Function", Name="timestampdiff"], Arguments = arguments, Type = integerTypeWithFacets]                                   
    ],

    SqlCapabilities = [
            LimitClauseKind = LimitClauseKind.LimitOffset,
            FractionalSecondsScale = 3,
            SupportsBindParameters = false,
            IdentifierQuoteChar = "`" , 
            CatalogNameSeparator = "." , 
            CatalogNameLocation = 1 ,
            Sql92Conformance = 4 , 
            MaxColumnsInOrderBy = 0 , 
            MaxIdentifierNameLength = 255 , 
            OrderByColumnsInSelect = false , 
            TolerateConcatOverflow =  true,
            SupportedPredicates = [ 
               IsNull = true,
               IsNotNull = true,
               SupportsComparision = true
            ],
            SupportedSql92RelationalJoinOperators = [
               FullOuterJoin = true,
               LeftOuterJoin = true,
               RightOuterJoin = true,
               InnerJoin = true,
               CrossJoin = true
            ],
            SupportsColumnAliases = true , 
            MaxColumnsInGroupBy = 0 , 
            MaxColumnsInSelect = 0 , 
            GroupByCapabilities = 2 , 
            StringConcatNullBehavior = 0 ,
            SearchPatternEscapeCharacter = "\" , 
            SupportsCastFunction = true,
            IdentifierSpecialCharacters = "!@#$%^&*()+|?"
        ],
    Override = [
         SqlGetTypeInfo = SqlGetTypeInfo,
         UseSoftNumbers = true,
         SqlCapabilities = SqlCapabilities,
         FunctionOverrides = AdbcFunctionOverrides,
         TimestampFunctionOverrides = TimestampFunctionOverrides, 
         BinaryOperatorOverrides = [
            Add = (visitor, rowType, groupKeys, ast) =>
                let
                    left = visitor(ast[Left]),
                    right = visitor(ast[Right]),
                    result = if (Type.Is(left[Type], type nullable date) and Type.Is(right[Type], type nullable duration) and not Record.HasFields(ast[Right], "Value")) or
                    (Type.Is(right[Type], type nullable date) and Type.Is(left[Type], type nullable duration) and not Record.HasFields(ast[Left], "Value"))
                    then
                        let
                            durationArg = if Type.Is(left[Type], type nullable duration) then
                                left
                            else
                                right,
                            dateArg = if Type.Is(left[Type], type nullable date) then
                                left
                            else
                                right,
                            days = BinaryOperation(durationArg,"Divide",ticksperday),
                            day = Literal("day"),
                            dateAsTimestamp = [
                                Kind = "Invocation",
                                Function =  [Kind = "Function", Name="timestampadd"],
                                Arguments = {[Expression = day, Type = Text.Type],
                                    [Expression = days, Type = days[Type]],
                                    [Expression = dateArg, Type = dateArg[Type]]},
                                Type = datetimeTypeWithFacets
                            ]
                        in
                            CastSqlExpression(dateAsTimestamp, dateTypeWithFacets)
                    else null
                in
                    result,
            Subtract = (visitor, rowType, groupKeys, ast) =>
                let
                    left = visitor(ast[Left]),
                    right = visitor(ast[Right]),
                    result = if Type.Is(left[Type], type nullable number) and Type.Is(right[Type], type nullable number)
                    then
                        let
                            leftAsDouble = if left[Type] = Double.Type then
                                left
                            else
                                CastSqlExpression(left, doubleTypeWithFacets),
                            rightAsDouble = if right[Type] = Double.Type then
                                right
                            else
                                CastSqlExpression(right, doubleTypeWithFacets),
                            result = BinaryOperation(leftAsDouble,"Subtract",rightAsDouble)
                        in
                            result
                    else if (Type.Is(left[Type], type nullable date) or Type.Is(left[Type], type nullable datetime)) and
                    (Type.Is(right[Type], type nullable date) or Type.Is(right[Type], type nullable datetime))
                    then [
                        Kind = "Invocation",
                        Function =  [Kind = "Function", Name="timestampdiff"],
                        Arguments = {[Expression = millisecond, Type = Text.Type],
                            [Expression = right, Type = right[Type]],
                            [Expression = left, Type = left[Type]]},
                        Type = Duration.Type
                    ]
                    else null
                in
                    result,
            Multiply = (visitor, rowType, groupKeys, ast) =>
                let
                    left = visitor(ast[Left]),
                    right = visitor(ast[Right]),
                    result = if Type.Is(left[Type], type nullable number) and Type.Is(right[Type], type nullable number)
                    then
                        let
                            leftAsDouble = if left[Type] = Double.Type then
                                left
                            else
                                CastSqlExpression(left, doubleTypeWithFacets),
                            rightAsDouble = if right[Type] = Double.Type then
                                right
                            else
                                CastSqlExpression(right, doubleTypeWithFacets),
                            result = BinaryOperation(leftAsDouble,"Multiply",rightAsDouble)
                        in
                            result
                    else if (Type.Is(left[Type], type nullable duration) and Type.Is(right[Type], type nullable number)) or
                    (Type.Is(left[Type], type nullable number) and Type.Is(right[Type], type nullable duration))
                    then
                        let
                            multiplied = BinaryOperation(left,"Multiply",right),
                            multipliedAsBigInt = CastSqlExpression(multiplied, int64TypeWithFacets),
                            total = [Kind = "Binary", Left = multipliedAsBigInt, Operator = "Add", Right = zero, Type = int64TypeWithFacets]
                        in
                            total & [Type = Duration.Type]
                    else null
                in
                    result,
            Divide = (visitor, rowType, groupKeys, ast) =>
                let
                    left = visitor(ast[Left]),
                    right = visitor(ast[Right]),
                    result = if Type.Is(left[Type], type nullable number) and Type.Is(right[Type], type nullable number)
                    then
                        let
                            leftAsDouble = if left[Type] = Double.Type then
                                left
                            else
                                CastSqlExpression(left, doubleTypeWithFacets),
                            rightAsDouble = if right[Type] = Double.Type then
                                right
                            else
                                CastSqlExpression(right, doubleTypeWithFacets),
                            result = BinaryOperation(leftAsDouble,"Divide",rightAsDouble)
                        in
                            result
                    else if Type.Is(left[Type], type nullable duration) and Type.Is(right[Type], type nullable number)
                    then
                        let
                            divided = BinaryOperation(left,"Divide",right),
                            dividedAsBigInt = CastSqlExpression(divided, int64TypeWithFacets),
                            total = [Kind = "Binary", Left = dividedAsBigInt, Operator = "Add", Right = zero, Type = int64TypeWithFacets]
                        in
                            total & [Type = Duration.Type]
                    else null
                in
                    result
         ],
         UnaryOperatorOverrides = [],
         DefaultTypes = DefaultTypes, 
         SupportedConversions = SupportedConversions,
         SqlTypesCategories = SqlTypesCategories
     ],

    SqlGenerator = SqlGeneratorHelpers[MergeOverrides]("Sql92",Override,false), 
    currentAstVisitorRecord = SqlGenerator[AstVisitor], 

    addToAstVisitor = 
      [
        AstVisitor = currentAstVisitorRecord & 
         [
           Constant =
              let
                 Quote = each Text.Format("'#{0}'", { _ }),
                 Cast = (value, typeName) => [
                        Text = Text.Format("CAST(#{0} as #{1})", { value, typeName }, "") ],                                                                                   
                 Function = (functionname, p1, p2) => [
                        Text = Text.Format("#{0}(#{1},#{2})", { functionname, p1, p2 })],
                 Visitor = [
                  DECIMAL = each [Text = Text.From(_)],
                  INTEGER = each [Text = Text.From(_)],
                  INT = each [Text = Text.From(_)],
                  BIGINT = each [Text = Text.From(_)],
                  FLOAT = each Cast(_, "FLOAT"),
                  DOUBLE = each Cast(_, "DOUBLE"),
                  DATE = each Cast(Quote(Date.ToText(_, "yyyy-MM-dd")), "DATE"),
                  TIMESTAMP = each Function("TO_TIMESTAMP", Quote(DateTime.ToText(_, "yyyy-MM-dd HH:mm:ss.fffffff")), Quote("yyyy-MM-dd HH:mm:ss.SSSSSSS")),
                  BOOLEAN = each [Text = Text.From(_)]
                  ]
               in      
                (typeInfo, ast) => Record.FieldOrDefault(Visitor, typeInfo[TYPE_NAME], each null)(ast[Value])
          ] 
        ],

    funcName = 
        [
            year = "year",
            month = "month",
            dayofmonth = "dayofmonth",
            quarter = "quarter",
            week = "weekofyear",
            dayofyear = "dayofyear",
            dayofweek = "dayofweek",
            ABS = "ABS",
            ACOS = "ACOS",
            ASIN = "ASIN",
            ATAN = "ATAN",
            ATAN2 = "ATAN2",
            COS = "COS",
            EXP = "EXP",
            MOD = "MOD",
            POWER = "POWER",
            SIGN = "SIGN",
            SIN = "SIN",
            SQRT = "SQRT",
            TAN = "TAN",
            CONTAINS = "CONTAINS",
            StartsWith = "StartsWith",
            EndsWith = "EndsWith",
            Length = "Length",
            LEFT = "LEFT",
            RIGHT = "RIGHT",
            REPLACE = "REPLACE",
            REPEAT = "REPEAT",
            LOWER = "LOWER",
            UPPER = "UPPER",
            LTRIM = "LTRIM",
            RTRIM = "RTRIM",
            CHAR = "CHAR",
            ASCII = "ASCII",
            second = "second",
            minute = "minute",
            hour = "hour",
            round = "round",
            bround = "bround",
            ceil = "ceil",
            floor = "floor",
            log = "log",
            LN = "LN",
            log10 = "log10"       
        ],
    UseSoftNumbers = true,

    millisecond = Literal("millisecond"),

    tickspersecond = Literal("1000"), // Changed from 1000000000 (nanoseconds) to 1000 (milliseconds) to match Databricks precision
    ticksperminute = Literal("60000"),
    ticksperhour = Literal("3600000"),
    ticksperday = Literal("86400000"), // Updated from 86400000000000 to 86400000 to match milliseconds precision, since databricks will overflow any number over int32 in timestampadd unit

    SqlGeneratorHelpers = SqlGeneratorCommon(),
    AdbcHelpers = SqlGeneratorHelpers[Helpers],
    AdbcConstants =  SqlGeneratorHelpers[Constants],
    SingleListElement = AdbcHelpers[SingleListElement],
    InExpression = AdbcHelpers[InExpression],
    GetInvocation = AdbcHelpers[GetInvocation],
    ApproxDistinctCount = AdbcHelpers[ApproxDistinctCount],
    WhenItem = AdbcHelpers[WhenItem],
    CaseFunction = AdbcHelpers[CaseFunction],
    ConditionOperation = AdbcHelpers[ConditionOperation],
    UnaryLogicalOperation = AdbcHelpers[UnaryLogicalOperation],
    BinaryLogicalOperation = AdbcHelpers[BinaryLogicalOperation],
    Argument = AdbcHelpers[Argument],
    Function = AdbcHelpers[Function],
    Literal = AdbcHelpers[Literal],
    BinaryOperation = AdbcHelpers[BinaryOperation],
    Invocation = AdbcHelpers[Invocation],
    InvocationWithType = AdbcHelpers[InvocationWithType],
    InArrayExpression = AdbcHelpers[InArrayExpression],
    SqlConstant = AdbcHelpers[SqlConstant],
    CastSqlExpression = AdbcHelpers[CastSqlExpression],
    
    minute = AdbcConstants[minute],
    second = AdbcConstants[second],
    hour = AdbcConstants[hour],
    minusone = AdbcConstants[minusone],
    one = AdbcConstants[one],
    zero = AdbcConstants[zero],
    nanosecondspersecond = AdbcConstants[nanosecondspersecond],
    startOfYearDateTime = AdbcConstants[startOfYearDateTime],

    ValueFunctionsArgumentsVisitor = (value, precision) =>
            if Type.Is(value[Type], type number) or Type.Is(value[Type], type nullable number) 
            then 
                if (precision = Precision.Decimal) then
                    if (Type.Facets(value[Type])[NativeTypeName] = "DECIMAL") then
                        value
                    else
                        CastSqlExpression(value, decimalTypeWithFacets)
                else if (precision = Precision.Double) then
                    if (Type.Facets(value[Type])[NativeTypeName] = "DOUBLE") then
                        value
                    else
                        CastSqlExpression(value, doubleTypeWithFacets)
                else
                    ...
            else ...,

     ValueFunctions = (visitor, ast, operation) =>
            if GetListCount(ast[Arguments]) = 2 or GetListCount(ast[Arguments]) = 3
            then
                let
                    value1 = visitor(ast[Arguments]{0}),
                    value2 = visitor(ast[Arguments]{1}),
                    value3 = if GetListCount(ast[Arguments]) = 3 then ast[Arguments]{2}[Value] else Precision.Double,
                    firstArg = ValueFunctionsArgumentsVisitor(value1, value3),
                    secondArg = ValueFunctionsArgumentsVisitor(value2, value3)
                in
                    BinaryOperation(firstArg,operation,secondArg)
            else ...,

        ValueAsAndReplaceType = (visitor, ast) =>
            if GetListCount(ast[Arguments]) = 2 then 
                let 
                    arg1 = visitor(ast[Arguments]{0}),
                    arg2 = ast[Arguments]{1}[Value]
                in
                    if (Type.Is(arg2,type any))  or (Type.Is(arg1[Type],arg2) and Type.IsNullable(arg2)) 
                    then arg1
                    else ...
            else ...,
            
    CreateArguments = (args) => List.Transform(args,each Argument(_,integerTypeWithFacets)),

    IntFromHelper = (ast, visitor, targetType, castType) =>
        let 
            sqlastarg1 = visitor(ast[Arguments]{0}),
            result = if ((GetListCount(ast[Arguments]) = 3) and 
                (ast[Arguments]{2}[Value] = RoundingMode.AwayFromZero or ast[Arguments]{2}[Value] = RoundingMode.ToEven)) then
                    ...
                else if ((GetListCount(ast[Arguments]) >= 2) and ast[Arguments]{1}[Value] <> null) then
                    ...
                else if ((sqlastarg1[Type] = targetType)) then
                    sqlastarg1
                else if ((sqlastarg1[Type] = Decimal.Type) or (sqlastarg1[Type] = Double.Type) or (sqlastarg1[Type] = Single.Type)) then
                    let
                        rounded = InvocationWithType(CreateArguments({sqlastarg1}), "round", castType),
                        result = if (castType = Double.Type and sqlastarg1[Type] = Double.Type) then
                            rounded
                        else
                            CastSqlExpression(rounded, castType)
                    in 
                        result
                else if ((Type.Is(sqlastarg1[Type],type text)) or (Type.Is(sqlastarg1[Type],type nullable text))) then
                    let
                        stringAsDouble = CastSqlExpression(sqlastarg1, doubleTypeWithFacets),
                        rounded = InvocationWithType(CreateArguments({stringAsDouble}), "round", castType),
                        result = if (castType = Double.Type) then
                            rounded
                        else
                            CastSqlExpression(rounded, castType)
                    in 
                        result
                else if ((Type.Is(sqlastarg1[Type],type logical))
                or (Type.Is(sqlastarg1[Type],type nullable logical))
                or (Type.Is(sqlastarg1[Type],type number))
                or (Type.Is(sqlastarg1[Type],type nullable number))) then 
                    CastSqlExpression(sqlastarg1, castType)
                else if((Type.Is(sqlastarg1[Type],type date))
                or (Type.Is(sqlastarg1[Type],type nullable date))) then 
                    let 
                        startdate =  SqlConstant("AnsiString","1899-12-30",type text),                                      
                        casteddate = CastSqlExpression(startdate, dateTypeWithFacets),
                        day = Literal("day"),
                        daydiff = InvocationWithType(CreateArguments({day,casteddate,sqlastarg1}),"timestampdiff", int64TypeWithFacets),
                        result = if (targetType = Int32.Type) then
                            daydiff
                        else
                            CastSqlExpression(daydiff, castType)
                    in 
                        result
                else ...
        in 
            result,                    

    NumericFromHelper = (ast, visitor, targetType, castType) =>
        let 
            sqlastarg1 = visitor(ast[Arguments]{0}),
            result = if ((GetListCount(ast[Arguments]) = 2) and ast[Arguments]{1}[Value] <> null) then
                    ...
                else if ((sqlastarg1[Type] = targetType)) then
                    sqlastarg1
                else if((Type.Is(sqlastarg1[Type],type text))
                or (Type.Is(sqlastarg1[Type],type nullable text))
                or (Type.Is(sqlastarg1[Type],type logical))
                or (Type.Is(sqlastarg1[Type],type nullable logical))
                or (Type.Is(sqlastarg1[Type],type number))
                or (Type.Is(sqlastarg1[Type],type nullable number))) then 
                    CastSqlExpression(sqlastarg1, castType)
                else if((Type.Is(sqlastarg1[Type],type date))
                or (Type.Is(sqlastarg1[Type],type nullable date))) then 
                    let 
                        startdate =  SqlConstant("AnsiString","1899-12-30",type text),                                      
                        casteddate = CastSqlExpression(startdate, dateTypeWithFacets),
                        day = Literal("day")
                    in 
                        CastSqlExpression(InvocationWithType(CreateArguments({day,casteddate,sqlastarg1}),"timestampdiff", int64TypeWithFacets), castType)
                else ...
        in 
            result,

    DurationHelper = (visitor, ast, ticks) =>
        if GetListCount(ast[Arguments]) = 1 then
            let
                sqlastarg = visitor(ast[Arguments]{0}),
                sqlastargasdouble = CastSqlExpression(sqlastarg,doubleTypeWithFacets),
                total = BinaryOperation(sqlastargasdouble,"Divide",ticks),
                result = if Type.Is(sqlastarg[Type], type nullable duration) then total
                    else ...
             in
                result
        else ...,        

    ListCountHelper = (visitor, ast) =>
        let
            foldedArg = visitor(ast[Arguments]{0}[Arguments]{0}),
            arg = GetCountArgument(ast, visitor, true),
            withCount = InvocationWithType({ arg[ArgumentAst] }, "Count", integerTypeWithFacets)
        in 
            if arg[AddOneIfNull]
            then 
                let 
                    whencondition = UnaryLogicalOperation("IsNull", foldedArg),
                    whenItem = WhenItem(whencondition, one, Number.Type),
                    case = CaseFunction({whenItem},zero,null,Number.Type),
                    max = InvocationWithType({Argument(case,integerTypeWithFacets)},"max",integerTypeWithFacets),
                    result = BinaryOperation(withCount,"Add",max)
                in 
                    result
            else 
                withCount,

    GetCountArgument = (ast as record, visitor as function, countNulls as logical) =>
        let
            argument = ast[Arguments]{0},
            sqlastarg = visitor(argument)
        in
            if argument[Kind] = "FieldAccess"
            then
                [
                    Nullable = true,
                    AddOneIfNull = false,
                    ArgumentAst = Argument(if countNulls then one else sqlastarg, if countNulls then integerTypeWithFacets else sqlastarg[Type])
                ]
            else if argument[Kind] = "Invocation" then
                let
                    invocation = argument,
                    argumentForInvocation = @GetCountArgument(invocation, visitor, false)
                in
                    if invocation[Function][Value]? = List.Distinct and List.Count(invocation[Arguments]) = 1
                    then
                        [
                            Nullable = true,
                            AddOneIfNull = countNulls and argumentForInvocation[Nullable],
                            ArgumentAst = Argument(InvocationWithType({ argumentForInvocation[ArgumentAst] }, "DISTINCT", integerTypeWithFacets), argumentForInvocation[ArgumentAst][Type])
                        ]
                    else if invocation[Function][Value]? = List.Select and List.Count(invocation[Arguments]) = 2
                        and IsNotNullPattern(invocation[Arguments]{1}[Value]?)
                    then
                        argumentForInvocation & [
                            Nullable = false,
                            AddOneIfNull = false
                        ]
                    else if (invocation[Function][Value] = ItemExpression.Item[Function][Value])
                    then
                        [
                            Nullable = true,
                            AddOneIfNull = false,
                            ArgumentAst = Argument(one, integerTypeWithFacets)
                        ]
                    else ...
            else ...,

    IsNotNullPattern = (expr) =>
        let
            rowexpr = RowExpression.From(expr)
        in
            expr <> null and rowexpr[Kind] = "Binary" and rowexpr[Operator] = "NotEquals" and (
                (rowexpr[Left]  = ItemExpression.Item and rowexpr[Right][Kind] = "Constant" and rowexpr[Right][Value] = null) or
                (rowexpr[Right] = ItemExpression.Item and rowexpr[Left][Kind]  = "Constant" and rowexpr[Left][Value]  = null)),

    GetListCount = (listvalue) => List.Count(listvalue),    
    DateStartOfHelper = (args,visitor,datetimepart) =>                                                       
        let 
            sqlexprList = List.Transform(args, (c) => visitor(c)),                    
            totimestamp = CastSqlExpression(startOfYearDateTime, datetimeTypeWithFacets),
            sqlconstant = Literal(datetimepart),
            arguments = CreateArguments({sqlconstant,totimestamp,sqlexprList{0}}),
            timestampdiff = InvocationWithType(arguments,"timestampdiff", int64TypeWithFacets),
            timestampaddarguments = CreateArguments({sqlconstant,timestampdiff,totimestamp}),
            timestampadd = InvocationWithType(timestampaddarguments,"timestampadd", datetimeTypeWithFacets),
            result = if (Type.Is(sqlexprList{0}[Type],type nullable date)) then
                CastSqlExpression(timestampadd, dateTypeWithFacets)
                else timestampadd
         in 
            result,
    DateEndOfHelper = (args,visitor,datetimepart,dayorsec) =>  
        let 
            sqlexprList = List.Transform(args, (c) => visitor(c)),                     
            totimestamp = InvocationWithType({Argument(startOfYearDateTime,textTypeWithFacets)}, "TO_TIMESTAMP", datetimeTypeWithFacets),
            datetimeconstant = Literal(datetimepart),
            dayorsecconstant = Literal(dayorsec),
            arguments = CreateArguments({datetimeconstant,totimestamp,sqlexprList{0}}),
            timestampdiff = InvocationWithType(arguments, "timestampdiff", int64TypeWithFacets),
            timestampdiffplusone = BinaryOperation(timestampdiff,"Add",one),
            timestampaddarguments = CreateArguments({datetimeconstant,timestampdiffplusone,totimestamp}),
            timestampadd = InvocationWithType(timestampaddarguments, "timestampadd", datetimeTypeWithFacets),
            secondtimestampaddarguments = CreateArguments({dayorsecconstant,minusone,timestampadd}),
            secondtimestampadd = InvocationWithType(secondtimestampaddarguments, "timestampadd",datetimeTypeWithFacets),
            result = if (Type.Is(sqlexprList{0}[Type],type nullable date)) then
                CastSqlExpression(secondtimestampadd, dateTypeWithFacets)
                else secondtimestampadd
         in 
            result,
    DateAddHelper = (args,visitor,datetimepart) =>  
        let 
            sqlexprList = List.Transform(args, (c) => visitor(c)),                     
            constant = Literal(datetimepart),
            arguments = CreateArguments({constant,sqlexprList{1},sqlexprList{0}}),
            timestampadd = InvocationWithType(arguments, "timestampadd", datetimeTypeWithFacets),
            result = if (Type.Is(sqlexprList{0}[Type],type nullable date)) then
                CastSqlExpression(timestampadd, dateTypeWithFacets)
                else timestampadd
         in 
            result,
    
    textTypeWithFacets = Type.ReplaceFacets(Text.Type,[NativeTypeName = "STRING"]),
    doubleTypeWithFacets = Type.ReplaceFacets(Double.Type,[NativeTypeName = "DOUBLE"]),
    integerTypeWithFacets = Type.ReplaceFacets(Int32.Type,[NativeTypeName = "INT"]),
    int8TypeWithFacets = Type.ReplaceFacets(Int8.Type, [NativeTypeName = "TINYINT"]),
    int16TypeWithFacets = Type.ReplaceFacets(Int16.Type, [NativeTypeName = "SMALLINT"]),
    int64TypeWithFacets = Type.ReplaceFacets(Int64.Type, [NativeTypeName = "BIGINT"]),
    decimalTypeWithFacets = Type.ReplaceFacets(Decimal.Type,[
        NativeTypeName = "DECIMAL",
        NumericPrecision = 38, // DECIMAL(38, 6) is the same precision and scale used in ODBC when specifying Precision.Decimal
        NumericScale = 6,
        NumericPrecisionBase = 10]
    ),

    logicalTypeWithFacets = Type.ReplaceFacets(Logical.Type,[NativeTypeName = "BOOLEAN"]),
    dateTypeWithFacets = Type.ReplaceFacets(Date.Type,[NativeTypeName = "DATE"]),
    datetimeTypeWithFacets = Type.ReplaceFacets(DateTime.Type,[NativeTypeName = "TIMESTAMP"]),
    timeTypeWithFacets = Type.ReplaceFacets(Time.Type,[NativeTypeName = "TIMESTAMP"]),

    Extension.LoadExpression = (name as text) =>
       let
           binary = Extension.Contents(name),
           asText = Text.FromBinary(binary)
        in
           Expression.Evaluate(asText, #shared),
    Diagnostics = Extension.LoadExpression("Diagnostics.pqm"),
    Diagnostics.LogValue2 = Diagnostics[LogValue2],    
    
    AdbcFunctionOverrides = [
        Number.Log10 = funcName[log10],
        /*
        This can work, but only commented out since ODBC does not override this
        Number.Ln = (visitor, rowType, groupKeys, ast) =>
            let
                sqlastarg = visitor(ast[Arguments]{0})
            in
                if GetListCount(ast[Arguments]) = 1 and Type.Is(sqlastarg[Type], type nullable number) then    
                    InvocationWithType({Argument(sqlastarg,doubleTypeWithFacets)},funcName[LN],doubleTypeWithFacets)
                else ...,
        */

        Number.Log = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Number.Log and GetListCount(ast[Arguments]) >= 1 and GetListCount(ast[Arguments]) <= 2 then 
                let
                    sqlastarg1 = visitor(ast[Arguments]{0}),
                    sqlastarg1AsDouble = if sqlastarg1[Type] = Double.Type then
                            sqlastarg1
                        else
                            CastSqlExpression(sqlastarg1, doubleTypeWithFacets),

                    result = if GetListCount(ast[Arguments]) = 1 or (GetListCount(ast[Arguments]) = 2 and Record.HasFields(ast[Arguments]{1}, "Value") and ast[Arguments]{1}[Value] = null) then
                            InvocationWithType({Argument(sqlastarg1AsDouble,doubleTypeWithFacets)},funcName[log],doubleTypeWithFacets)
                        else 
                            let
                                sqlastarg2 = visitor(ast[Arguments]{1}),
                                sqlastarg2AsDouble = if sqlastarg2[Type] = Double.Type then
                                        sqlastarg2
                                    else
                                        CastSqlExpression(sqlastarg2, doubleTypeWithFacets)
                            in
                                InvocationWithType({Argument(sqlastarg2AsDouble,doubleTypeWithFacets), Argument(sqlastarg1AsDouble,doubleTypeWithFacets)},funcName[log],doubleTypeWithFacets)
                in
                    result
            else ...,

        Time.Second = funcName[second],          // second([timecolumn])
        Date.WeekOfYear = funcName[week],        // weekofyear([DateColumn])  

        Date.DayOfWeek = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Date.DayOfWeek and GetListCount(ast[Arguments]) = 1 then 
                let
                    sqlastarg = visitor(ast[Arguments]{0})
                in
                    if Type.Is(sqlastarg[Type], type nullable date) or Type.Is(sqlastarg[Type], type nullable datetime) then
                        let
                            dayofweek = InvocationWithType({Argument(sqlastarg,sqlastarg[Type])},"dayofweek",integerTypeWithFacets),
                            one = Literal("1"),
                            result = BinaryOperation(dayofweek,"Subtract", one)
                        in 
                            result
                    else ...
            else ...,
  
       Text.Middle = (visitor, rowType, groupKeys, ast) as record =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Text.Middle and  ( GetListCount(ast[Arguments]) = 2 or GetListCount(ast[Arguments]) = 3) then
                let
                    args = ast[Arguments],
                    sqlexprList = List.Transform(args, (c) => visitor(c)),
                    arguments = List.Transform(sqlexprList,each Argument(_,_[Type])),
                    fixedStart = Argument(BinaryOperation(sqlexprList{1}, "Add", one), arguments{1}[Type]),
                    result = if (GetListCount(sqlexprList) = 3)
                        then if(args{2}[Kind] = "Constant" and Type.Is(Value.Type(args{2}[Value]),type number)) then InvocationWithType({arguments{0}, fixedStart, arguments{2}},"SUBSTRING",textTypeWithFacets)
                            else
                                let
                                    LengthInvocation = InvocationWithType({arguments{0}},funcName[Length], int64TypeWithFacets),
                                    IfNullSecondArg = BinaryOperation(LengthInvocation,"Subtract",sqlexprList{1}),
                                    IfNull = InvocationWithType({arguments{2}, Argument(IfNullSecondArg, integerTypeWithFacets)}, "IfNull", int64TypeWithFacets),
                                    result = InvocationWithType({arguments{0}, fixedStart, Argument(IfNull, integerTypeWithFacets)}, "SUBSTRING", textTypeWithFacets)                                            
                                 in
                                    result
                        else
                            let
                                LengthInvocation = InvocationWithType({arguments{0}},funcName[Length], int64TypeWithFacets),
                                thirdArgument = BinaryOperation(LengthInvocation,"Subtract",sqlexprList{1}),
                                allarguments = List.Combine({arguments,{Argument(thirdArgument,integerTypeWithFacets)}}),
                                sqlastWithTwoArguments = InvocationWithType({allarguments{0}, fixedStart, allarguments{2}}, "SUBSTRING", textTypeWithFacets)
                             in
                                sqlastWithTwoArguments
                 in
                    result
             else ... ,

        Text.From = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Text.From and  GetListCount(ast[Arguments]) = 1 then
                let
                    sqlastarg = visitor(ast[Arguments]{0}),
                    argType = sqlastarg[Type]?
                 in
                    // Complex Spark types (ARRAY/MAP/STRUCT/VARIANT) are registered as Text.Type
                    // in the SQL-type registry (see GetTypeNameToTypeMapping at the top of this file):
                    // the driver already serializes them to JSON strings before they reach M.
                    // If we still emit CAST(col AS STRING), Spark's server-side Cast formatter
                    // re-stringifies the underlying complex type to its native repr
                    // (e.g. "{Key1 -> 10}" for MAP, "{1, John Doe}" for STRUCT) which diverges
                    // from the driver's JSON serialization and breaks ODBC/ADBC parity.
                    // When the SQL expression is already text, the cast is redundant and harmful.
                    if argType <> null and (Type.Is(argType, type text) or Type.Is(argType, type nullable text)) then
                        sqlastarg
                    else
                        // TO_VARCHAR is supported by DBR 11.3+
                        CastSqlExpression(sqlastarg, textTypeWithFacets)

            else ...,
        
        Text.PositionOf = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Text.PositionOf and  GetListCount(ast[Arguments]) = 2 then  
                let 
                    one = Literal("1"),
                    sqlargs = List.Transform(ast[Arguments], (c) => visitor(c)), 
                    arg1 = Argument(sqlargs{0},textTypeWithFacets),
                    arg2 = Argument(sqlargs{1},textTypeWithFacets),
                    arg3 = Argument(one,integerTypeWithFacets),
                    PositionFunction = InvocationWithType({arg2,arg1,arg3},"POSITION", int64TypeWithFacets),
                    result = BinaryOperation(PositionFunction,"Subtract",one)
                 in 
                    result
              else ..., 
    
        Date.StartOfYear = (visitor, rowType, groupKeys, ast) => 
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Date.StartOfYear and  GetListCount(ast[Arguments]) = 1 
            then DateStartOfHelper(ast[Arguments],visitor,"year")              
            else ...  ,
    
        Date.StartOfQuarter = (visitor, rowType, groupKeys, ast) => 
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Date.StartOfQuarter and  GetListCount(ast[Arguments]) = 1 
            then DateStartOfHelper(ast[Arguments],visitor,"quarter") 
            else ...  ,
     
        Date.StartOfMonth = (visitor, rowType, groupKeys, ast) => 
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Date.StartOfMonth and  GetListCount(ast[Arguments]) = 1 
            then DateStartOfHelper(ast[Arguments],visitor,"month") 
            else ...  ,  
    
        Date.StartOfDay = (visitor, rowType, groupKeys, ast) => 
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Date.StartOfDay and  GetListCount(ast[Arguments]) = 1 
            then DateStartOfHelper(ast[Arguments],visitor,"day") 
            else ...  ,
    
        Date.StartOfWeek = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Date.StartOfWeek and  GetListCount(ast[Arguments]) = 1 
            then DateStartOfHelper(ast[Arguments],visitor,"week") 
            else ...  ,
    
        Date.EndOfYear = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Date.EndOfYear and  GetListCount(ast[Arguments]) = 1 then  
                let
                    sqlastarg = visitor(ast[Arguments]{0}) 
                 in 
                    if(Type.Is(sqlastarg[Type],type nullable date)) then DateEndOfHelper(ast[Arguments],visitor,"year","day")
                    else if(Type.Is(sqlastarg[Type],type nullable datetime)) then DateEndOfHelper(ast[Arguments],visitor,"year","millisecond")
                    else ...                    
            else ...  ,
    
        Date.EndOfQuarter = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Date.EndOfQuarter and  GetListCount(ast[Arguments]) = 1 then
                let
                    sqlastarg = visitor(ast[Arguments]{0}) 
                 in 
                    if(Type.Is(sqlastarg[Type],type nullable date)) then DateEndOfHelper(ast[Arguments],visitor,"quarter","day") 
                    else if(Type.Is(sqlastarg[Type],type nullable datetime)) then DateEndOfHelper(ast[Arguments],visitor,"quarter","millisecond")
                    else ...                    
            else ...  ,
    
        Date.EndOfMonth = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Date.EndOfMonth and  GetListCount(ast[Arguments]) = 1 then
                let
                    sqlastarg = visitor(ast[Arguments]{0}) 
                 in 
                    if(Type.Is(sqlastarg[Type],type nullable date)) then DateEndOfHelper(ast[Arguments],visitor,"month","day") 
                    else if(Type.Is(sqlastarg[Type],type nullable datetime)) then DateEndOfHelper(ast[Arguments],visitor,"month","millisecond")
                    else ...                    
            else ...  ,
    
        Date.EndOfWeek = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Date.EndOfWeek and  GetListCount(ast[Arguments]) = 1 then  
                let
                    sqlastarg = visitor(ast[Arguments]{0}) 
                 in 
                    if(Type.Is(sqlastarg[Type],type nullable datetime)) then DateEndOfHelper(ast[Arguments],visitor,"week","millisecond")
                    else ...                    
            else ...  ,
    
        Date.EndOfDay = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Date.EndOfDay and  GetListCount(ast[Arguments]) = 1 then
                let
                    sqlastarg = visitor(ast[Arguments]{0}) 
                 in 
                    if(Type.Is(sqlastarg[Type],type nullable date)) then DateEndOfHelper(ast[Arguments],visitor,"day","day") 
                    else if(Type.Is(sqlastarg[Type],type nullable datetime)) then DateEndOfHelper(ast[Arguments],visitor,"day","millisecond")
                    else ...                    
            else ...  ,
    
        Date.AddYears = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Date.AddYears and  GetListCount(ast[Arguments]) = 2 
            then DateAddHelper(ast[Arguments],visitor,"year") 
            else ...  , 
    
        Date.AddQuarters = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Date.AddQuarters and  GetListCount(ast[Arguments]) = 2 
            then DateAddHelper(ast[Arguments],visitor,"quarter") 
            else ...  ,
    
        Date.AddMonths = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Date.AddMonths and  GetListCount(ast[Arguments]) = 2 
            then DateAddHelper(ast[Arguments],visitor,"month") 
            else ...  ,
    
        Date.AddWeeks = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Date.AddWeeks and  GetListCount(ast[Arguments]) = 2
            then DateAddHelper(ast[Arguments],visitor,"week") 
            else ...  , 
    
        Date.AddDays = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Date.AddDays and  GetListCount(ast[Arguments]) = 2 
            then DateAddHelper(ast[Arguments],visitor,"day") 
            else ...  ,
    
        Time.EndOfHour = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Time.EndOfHour and  GetListCount(ast[Arguments]) = 1 then 
                let 
                    sqlexprList = List.Transform(ast[Arguments], (c) => visitor(c)),                     
                    totimestamp = InvocationWithType({Argument(startOfYearDateTime,type text)}, "TO_TIMESTAMP", datetimeTypeWithFacets),
                    arguments = CreateArguments({hour,totimestamp,sqlexprList{0}}),
                    timestampdiff = InvocationWithType(arguments, "timestampdiff", int64TypeWithFacets),
                    timestampdiffplusone = BinaryOperation(timestampdiff,"Add",one),
                    timestampaddarguments = CreateArguments({hour,timestampdiffplusone,totimestamp}),
                    timestampadd = InvocationWithType(timestampaddarguments, "timestampadd", datetimeTypeWithFacets),
                    secondtimestampaddargs = CreateArguments({millisecond,minusone,timestampadd}),
                    secondtimestampadd = InvocationWithType(secondtimestampaddargs, "timestampadd", datetimeTypeWithFacets)
                 in 
                    secondtimestampadd 
            else ...,

        Time.StartOfHour = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Time.StartOfHour and  GetListCount(ast[Arguments]) = 1 then 
                let 
                    sqlexprList = List.Transform(ast[Arguments], (c) => visitor(c)),                     
                    totimestamp = InvocationWithType({Argument(startOfYearDateTime,type text)}, "TO_TIMESTAMP", datetimeTypeWithFacets),
                    arguments = CreateArguments({hour,totimestamp,sqlexprList{0}}),
                    timestampdiff = InvocationWithType(arguments, "timestampdiff", integerTypeWithFacets),
                    timestampaddarguments = CreateArguments({hour,timestampdiff,totimestamp}),
                    timestampadd = InvocationWithType(timestampaddarguments, "timestampadd", datetimeTypeWithFacets)
                 in 
                    timestampadd
            else ...,
    
        Byte.From = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Byte.From and GetListCount(ast[Arguments]) >= 1 and GetListCount(ast[Arguments]) <= 3
            then IntFromHelper(ast, visitor, Byte.Type, doubleTypeWithFacets)
            else ...,
    
        Int32.From = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Int32.From and GetListCount(ast[Arguments]) >= 1 and GetListCount(ast[Arguments]) <= 3
            then IntFromHelper(ast, visitor, Int32.Type, integerTypeWithFacets)
            else ...,
    
        Int16.From = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Int16.From and GetListCount(ast[Arguments]) >= 1 and GetListCount(ast[Arguments]) <= 3
            then IntFromHelper(ast, visitor, Int16.Type, int16TypeWithFacets)
            else ...,
    
        Int8.From = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Int8.From and GetListCount(ast[Arguments]) >= 1 and GetListCount(ast[Arguments]) <= 3
            then IntFromHelper(ast, visitor, Int8.Type, int8TypeWithFacets)
            else ...,
    
        Int64.From = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Int64.From and GetListCount(ast[Arguments]) >= 1 and GetListCount(ast[Arguments]) <= 3
            then IntFromHelper(ast, visitor, Int64.Type, int64TypeWithFacets)
            else ...,

        Decimal.From = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Decimal.From and GetListCount(ast[Arguments]) >= 1 and GetListCount(ast[Arguments]) <= 2
            then 
                NumericFromHelper(ast, visitor, Decimal.Type, decimalTypeWithFacets)
            else ...,

        Single.From = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Single.From and GetListCount(ast[Arguments]) >= 1 and GetListCount(ast[Arguments]) <= 2
            then 
                NumericFromHelper(ast, visitor, Double.Type, doubleTypeWithFacets)
            else ...,    

        Double.From = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Double.From and GetListCount(ast[Arguments]) >= 1 and GetListCount(ast[Arguments]) <= 2
            then 
                NumericFromHelper(ast, visitor, Double.Type, doubleTypeWithFacets)
            else ...,

        Duration.From = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Duration.From and GetListCount(ast[Arguments]) = 1 then
                let
                    sqlastarg1 = visitor(ast[Arguments]{0}),
                    result = if Type.Is(sqlastarg1[Type], type nullable duration) then sqlastarg1
                        else if Type.Is(sqlastarg1[Type], type nullable number) then
                            let
                                sqlastarg1 = visitor(ast[Arguments]{0}),
                                sqlastarg1AsDouble = if sqlastarg1[Type] = Double.Type then
                                        sqlastarg1
                                    else
                                        CastSqlExpression(sqlastarg1,doubleTypeWithFacets),
                                multiplied = [Kind = "Binary", Left = sqlastarg1AsDouble, Operator = "Multiply", Right = ticksperday, Type = int64TypeWithFacets],
                                multipliedAsBigInt = CastSqlExpression(multiplied, int64TypeWithFacets),
                                total = [Kind = "Binary", Left = multipliedAsBigInt,Operator = "Add", Right = zero, Type = int64TypeWithFacets]
                            in
                                total & [Type = Duration.Type]
                        else ...
                 in
                    result
            else ...,
    
        Logical.From = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Logical.From and  GetListCount(ast[Arguments]) = 1 then 
                let 
                    sqlastarg = visitor(ast[Arguments]{0}),
                    truestring = SqlConstant("AnsiString","true", textTypeWithFacets),
                    result = if(Type.Is(sqlastarg[Type],type nullable logical)) then sqlastarg
                        else if(Type.Is(sqlastarg[Type],type nullable number)) then
                        CastSqlExpression(sqlastarg, logicalTypeWithFacets)
                        else if (Type.Is(sqlastarg[Type],type nullable text)) then
                        BinaryLogicalOperation("Equals",
                            InvocationWithType({Argument(sqlastarg, textTypeWithFacets)}, "LOWER", textTypeWithFacets),
                            truestring)
                        else ...
                 in
                    result
            else ...,
    
        DateTime.From = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = DateTime.From and  GetListCount(ast[Arguments]) = 1 then
                let     
                    sqlastarg1 = visitor(ast[Arguments]{0}),
                    abs = InvocationWithType({Argument(sqlastarg1,doubleTypeWithFacets)},funcName[ABS],doubleTypeWithFacets),
                    floor = InvocationWithType({Argument(abs,doubleTypeWithFacets)},funcName[floor],doubleTypeWithFacets),
                    date18991230 = SqlConstant("AnsiString","1899-12-30 00:00:00.0000000",type text),
                    time000000 = SqlConstant("AnsiString","00:00:00.0000000",type text),
                    cast1 = CastSqlExpression(tickspersecond,doubleTypeWithFacets),
                    cast2 = CastSqlExpression(ticksperday,doubleTypeWithFacets),
                    cast3 = CastSqlExpression(time000000,timeTypeWithFacets),
                    ToTimeStamp = InvocationWithType({Argument(date18991230,doubleTypeWithFacets)},"TO_TIMESTAMP",datetimeTypeWithFacets),
                    hourFunction = InvocationWithType({Argument(sqlastarg1,doubleTypeWithFacets)},funcName[hour],doubleTypeWithFacets),
                    minuteFunction = InvocationWithType({Argument(sqlastarg1,doubleTypeWithFacets)},funcName[minute],doubleTypeWithFacets),
                    firstcondition = BinaryLogicalOperation("LessThan",sqlastarg1,Literal("0")),
                    secondcondition = BinaryLogicalOperation("NotEqualTo",BinaryOperation(abs,"Subtract",floor),Literal("0")),
                    whencondition = ConditionOperation("and",firstcondition,secondcondition),
                    whenItem = WhenItem(whencondition,one,doubleTypeWithFacets),
                    case = CaseFunction({whenItem},zero,null,doubleTypeWithFacets),
                    timestamptype = type datetime,
                    timestamptypewithFacets = Type.ReplaceFacets(timestamptype,[NativeTypeName = "TIMESTAMP"]),
                    result = if(Type.Is(sqlastarg1[Type],type nullable date)) then CastSqlExpression(sqlastarg1,timestamptypewithFacets)
                        else if(Type.Is(sqlastarg1[Type],type nullable datetime)) then sqlastarg1
                        /*
                        Databricks does not support time type
                        */
                        else if(Type.Is(sqlastarg1[Type],type nullable number)) then 
                            let 
                                secondarg = BinaryOperation(BinaryOperation(BinaryOperation(abs,"Subtract",floor),"Add",case),"Multiply",cast2),
                                thirdarg = InvocationWithType(List.Transform({Literal("day"),InvocationWithType({Argument(sqlastarg1,doubleTypeWithFacets)},"floor",doubleTypeWithFacets),ToTimeStamp},each Argument(_,doubleTypeWithFacets)),"timestampadd",datetimeTypeWithFacets)
                             in
                                InvocationWithType(CreateArguments({millisecond,secondarg,thirdarg}),"timestampadd",datetimeTypeWithFacets)
                        else ...
                 in 
                    result
            else ...,
    
      Date.From = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Date.From and GetListCount(ast[Arguments]) = 1 then
                let     
                    sqlastarg1 = visitor(ast[Arguments]{0}),
                    date18991230 = SqlConstant("AnsiString","1899-12-30",type text),
                    result = if(Type.Is(sqlastarg1[Type],type nullable date)) then sqlastarg1
                        else if(Type.Is(sqlastarg1[Type],type nullable datetime)) then 
                            CastSqlExpression(sqlastarg1, dateTypeWithFacets)
                        else if(Type.Is(sqlastarg1[Type],type nullable number)) then 
                            let 
                                days = CastSqlExpression(sqlastarg1, integerTypeWithFacets),
                                arguments = CreateArguments({Literal("day"), days, date18991230}),
                                timestampaddResult = InvocationWithType(arguments, "timestampadd", datetimeTypeWithFacets)
                            in
                                CastSqlExpression(timestampaddResult, dateTypeWithFacets)
                        else ...
                in 
                    result
            else ...,

        Table.ApproximateRowCount = (visitor, rowType, groupKeys, ast) as record => 
            let
                Function = (name) => [Kind = "Function", Name=name],
                Argument = (expr) => [Expression = expr, Type = null],
                ApproxDistinctCount = (list) => [
                    Kind = "Invocation",
                    Function = Function("approx_count_distinct"),
                    Arguments = List.Transform(list, Argument), Type = Int64.Type
                ],
                GetInvocation = (ast, function, count) =>
                    if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = function and GetListCount(ast[Arguments]) = count
                    then ast[Arguments]
                    else ...,
                tarc = GetInvocation(ast, Table.ApproximateRowCount, 1),
                td = GetInvocation(tarc{0}, Table.Distinct, 1),
                sc = GetInvocation(td{0}, Table.SelectColumns, 2)
             in 
                if groupKeys <> null and sc{0} = RowExpression.Row and sc{1}[Value]? is list then
                ApproxDistinctCount(List.Transform(sc{1}[Value], (c) => visitor(RowExpression.Column(c))))
                else ...,

        RoundingHelper = (ast, visitor, roundFunc) =>
            let
                argCount = GetListCount(ast[Arguments]),
                sqlexprList = List.Transform(ast[Arguments], (c) => visitor(c)),
                resultType = if sqlexprList{0}[Type] = Decimal.Type then decimalTypeWithFacets
                    else Double.Type
            in
                if argCount = 1 or (argCount = 2 and Record.HasFields(ast[Arguments]{1}, "Value") and ast[Arguments]{1}[Value] = null) then
                    InvocationWithType({Argument(sqlexprList{0}, sqlexprList{0}[Type])}, roundFunc, resultType)
                else if argCount = 2 and Record.HasFields(ast[Arguments]{1}, "Value") then
                    InvocationWithType({Argument(sqlexprList{0}, sqlexprList{0}[Type]), Argument(sqlexprList{1}, sqlexprList{1}[Type])}, roundFunc, resultType)
                else
                    ...,

        Number.Round = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Number.Round and GetListCount(ast[Arguments]) <= 2 then
                RoundingHelper(ast, visitor, funcName[round]) // Use round for ODBC compatibility, but switch to bround after migration to match Number.Round expected behavior
            else ...,

        Number.RoundUp = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Number.RoundUp and GetListCount(ast[Arguments]) <= 2 then
                RoundingHelper(ast, visitor, funcName[ceil])
            else ...,

        Number.RoundDown = (visitor, rowType, groupKeys, ast) =>
            if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = Number.RoundDown and GetListCount(ast[Arguments]) <= 2 then
                RoundingHelper(ast, visitor, funcName[floor])
            else ...,
    
        List.Sum = (visitor, rowType, groupKeys, ast) =>
            let
                foldedArg = visitor(ast[Arguments]{0})
            in
                if ast[Kind] = "Invocation" and
                   ast[Function][Kind] = "Constant" and
                   ast[Function][Value] = List.Sum and
                   groupKeys <> null and
                   Type.Is(foldedArg[Type], type number) and
                   (GetListCount(ast[Arguments]) = 1 or 
                    GetListCount(ast[Arguments]) = 2) 
                   then if ((GetListCount(ast[Arguments]) = 1) or 
                     ( ast[Arguments]{1}[Kind] = "Constant" 
                      and ast[Arguments]{1}[Value] = Precision.Double)
                     )
                   then InvocationWithType({Argument(CastSqlExpression(foldedArg,doubleTypeWithFacets),doubleTypeWithFacets)},"SUM", doubleTypeWithFacets)
                   else if((GetListCount(ast[Arguments]) = 2) and (ast[Arguments]{1}[Kind] = "Constant" and ast[Arguments]{1}[Value] = Precision.Decimal))
                   then if foldedArg[Type] = Decimal.Type then
                        InvocationWithType({Argument(foldedArg,foldedArg[Type])},"SUM", foldedArg[Type])
                        else 
                        InvocationWithType({Argument(CastSqlExpression(foldedArg,decimalTypeWithFacets),decimalTypeWithFacets)},"SUM", decimalTypeWithFacets)
                   else ...
                else ...,
    
        List.Average = (visitor, rowType, groupKeys, ast) =>
            let
                foldedArg = visitor(ast[Arguments]{0})
             in
                if ast[Kind] = "Invocation" and
                    ast[Function][Kind] = "Constant" and
                    ast[Function][Value] = List.Average and
                    (GetListCount(ast[Arguments]) = 1 or 
                    GetListCount(ast[Arguments]) = 2) and
                    groupKeys <> null and
                    Type.Is(foldedArg[Type], type number) then
                    if ((GetListCount(ast[Arguments]) = 1) or 
                    (ast[Arguments]{1}[Kind] = "Constant" and ast[Arguments]{1}[Value] = Precision.Double)) then
                        InvocationWithType({Argument(CastSqlExpression(foldedArg,doubleTypeWithFacets),doubleTypeWithFacets)},"AVG", doubleTypeWithFacets)
                    else if(ast[Arguments]{1}[Kind] = "Constant" and ast[Arguments]{1}[Value] = Precision.Decimal)
                    then if foldedArg[Type] = Decimal.Type then
                        InvocationWithType({Argument(foldedArg,foldedArg[Type])},"AVG", foldedArg[Type])
                        else
                        InvocationWithType({Argument(CastSqlExpression(foldedArg,decimalTypeWithFacets),decimalTypeWithFacets)},"AVG", decimalTypeWithFacets)
                    else ...
                else ...,

        MinMaxHelper = (foldedArg,functionName) =>
        if Type.Is(foldedArg[Type], type nullable number) or 
            Type.Is(foldedArg[Type], type nullable date) or
            Type.Is(foldedArg[Type], type nullable datetime) or
            Type.Is(foldedArg[Type], type nullable text)
        then
            let
                returnType = if Type.Is(foldedArg[Type], type nullable number) then
                    if foldedArg[Type] = Decimal.Type then decimalTypeWithFacets 
                    else if foldedArg[Type] = Int64.Type then int64TypeWithFacets
                    else if foldedArg[Type] = Int32.Type then integerTypeWithFacets
                    else if foldedArg[Type] = Int16.Type then int16TypeWithFacets
                    else if foldedArg[Type] = Int8.Type then int8TypeWithFacets
                    else doubleTypeWithFacets
                else if Type.Is(foldedArg[Type], type nullable date) then dateTypeWithFacets
                else if Type.Is(foldedArg[Type], type nullable datetime) then datetimeTypeWithFacets
                else textTypeWithFacets
            in
                InvocationWithType({Argument(foldedArg, foldedArg[Type])}, functionName, returnType)
        else ...,

        List.Max = (visitor, rowType, groupKeys, ast) =>
            let
                foldedArg = visitor(ast[Arguments]{0})
             in
                if (GetListCount(ast[Arguments]) = 1 or GetListCount(ast[Arguments]) = 2) and groupKeys <> null 
                then MinMaxHelper(foldedArg,"MAX")
                else ...,
    
        List.Min = (visitor, rowType, groupKeys, ast) =>
           let
                foldedArg = visitor(ast[Arguments]{0})
             in
                if (GetListCount(ast[Arguments]) = 1 or GetListCount(ast[Arguments]) = 2) and groupKeys <> null 
                then MinMaxHelper(foldedArg,"MIN")
                else ...,

        List.Count = (visitor, rowType, groupKeys, ast) =>
            if GetListCount(ast[Arguments]) = 1 and groupKeys <> null then ListCountHelper(visitor, ast)
            else ...,

        Table.RowCount = (visitor, rowType, groupKeys, ast) =>
            if GetListCount(ast[Arguments]) = 1 and groupKeys <> null then ListCountHelper(visitor, ast)
            else ...,

        Value.Multiply = (visitor, rowType, groupKeys, ast) => ValueFunctions(visitor, ast, "Multiply"),

        Value.Add = (visitor, rowType, groupKeys, ast) => ValueFunctions(visitor, ast, "Add"),

        Value.Divide = (visitor, rowType, groupKeys, ast) => ValueFunctions(visitor, ast, "Divide"),

        Value.Subtract = (visitor, rowType, groupKeys, ast) => ValueFunctions(visitor, ast, "Subtract"),

        Value.Compare = (visitor, rowType, groupKeys, ast) => 
            let 
                arg1minusarg2 = ValueFunctions(visitor, ast, "Subtract"),
                addSign = InvocationWithType({Argument(arg1minusarg2, doubleTypeWithFacets)},funcName[SIGN],integerTypeWithFacets)
            in 
                addSign,

        Value.As = (visitor, rowType, groupKeys, ast) => ValueAsAndReplaceType(visitor, ast),

        Value.ReplaceType = (visitor, rowType, groupKeys, ast) => ValueAsAndReplaceType(visitor, ast),

        Duration.Days = (visitor, rowType, groupKeys, ast) =>
            if GetListCount(ast[Arguments]) = 1 then
                let
                    sqlastarg1 = visitor(ast[Arguments]{0}),
                    days = BinaryOperation(sqlastarg1,"Divide",ticksperday),
                    daysAsInteger = CastSqlExpression(days,integerTypeWithFacets),
                    result = if Type.Is(sqlastarg1[Type], type nullable duration) then daysAsInteger
                        else ...
                 in
                    result
            else ...,

        Duration.Hours = (visitor, rowType, groupKeys, ast) =>
            if GetListCount(ast[Arguments]) = 1 then
                let
                    sqlastarg1 = visitor(ast[Arguments]{0}),
                    durationpertick = BinaryOperation(sqlastarg1,"Divide",ticksperhour),
                    hours = InvocationWithType(CreateArguments({durationpertick,Literal("24")}),"mod",integerTypeWithFacets),
                    hoursAsInteger = CastSqlExpression(hours,integerTypeWithFacets),
                    result = if Type.Is(sqlastarg1[Type], type nullable duration) then hoursAsInteger
                        else ...
                 in
                    result
            else ...,

        Duration.Minutes = (visitor, rowType, groupKeys, ast) =>
            if GetListCount(ast[Arguments]) = 1 then
                let
                    sqlastarg1 = visitor(ast[Arguments]{0}),
                    durationpertick = BinaryOperation(sqlastarg1,"Divide",ticksperminute),
                    minutes = InvocationWithType(CreateArguments({durationpertick,Literal("60")}),"mod",integerTypeWithFacets),
                    minutesAsInteger = CastSqlExpression(minutes,integerTypeWithFacets),
                    result = if Type.Is(sqlastarg1[Type], type nullable duration) then minutesAsInteger
                        else ...
                 in
                    result
            else ...,

        Duration.Seconds = (visitor, rowType, groupKeys, ast) =>
            if GetListCount(ast[Arguments]) = 1 then
                let
                    sqlastarg1 = visitor(ast[Arguments]{0}),
                    durationModTicks = InvocationWithType(CreateArguments({sqlastarg1,ticksperminute}),"mod",integerTypeWithFacets),
                    durationModTicksAsDouble = CastSqlExpression(durationModTicks,doubleTypeWithFacets),
                    tickspersecondasdouble = CastSqlExpression(tickspersecond,doubleTypeWithFacets),
                    seconds = BinaryOperation(durationModTicksAsDouble,"Divide",tickspersecondasdouble),
                    result = if Type.Is(sqlastarg1[Type], type nullable duration) then seconds
                        else ...
                 in
                    result
            else ...,

        Duration.TotalDays = (visitor, rowType, groupKeys, ast) => DurationHelper(visitor, ast, ticksperday),

        Duration.TotalHours = (visitor, rowType, groupKeys, ast) => DurationHelper(visitor, ast, ticksperhour),

        Duration.TotalMinutes = (visitor, rowType, groupKeys, ast) => DurationHelper(visitor, ast, ticksperminute),

        Duration.TotalSeconds = (visitor, rowType, groupKeys, ast) => DurationHelper(visitor, ast, tickspersecond)
    ]
  in 
    SqlGenerator & addToAstVisitor;

SqlGeneratorCommon = () =>
let
// Base SqlGenerator
    Implementation = "1.0",
// This is used to convert for the type conversions of the results, if provided then any comparision/operation
// between Type1 and Type2 will result in ResultType
//   Table Columns :
//   Type1 :     TypeValue
//   Type2 :     TypeValue
//   ResultType: TypeValue
    ImplicitTypeConversions = null,
//Allows the M engine to select a compatible data type when conversion between two specific numeric types is not declared as supported in the SupportedConversions.
//If true then SqlTypeCategories SoftBase2Types and SoftBase10Types also needs to be provided.
    UseSoftNumbers = false,
    funcName = [
        year = "year",
        month = "month",
        dayofmonth = "dayofmonth",
        quarter = "quarter",
        week = "week",
        dayofyear = "dayofyear",
        dayofweek = "dayofweek",
        ABS = "ABS",
        ACOS = "ACOS",
        ASIN = "ASIN",
        ATAN = "ATAN",
        ATAN2 = "ATAN2",
        COS = "COS",
        EXP = "EXP",
        MOD = "MOD",
        POWER = "POWER",
        SIGN = "SIGN",
        SIN = "SIN",
        SQRT = "SQRT",
        TAN = "TAN",
        CONTAINS = "CONTAINS",
        StartsWith = "StartsWith",
        EndsWith = "EndsWith",
        Length = "Length",
        LEFT = "LEFT",
        RIGHT = "RIGHT",
        REPLACE = "REPLACE",
        REPEAT = "REPEAT",
        LOWER = "LOWER",
        UPPER = "UPPER",
        LTRIM = "LTRIM",
        RTRIM = "RTRIM",
        CHAR = "CHAR",
        ASCII = "ASCII",
        minute = "minute",
        hour = "hour",
        round = "round",
        ceil = "ceil",
        floor = "floor",
        LN = "LN"
    ],
// Constants
    minute = Literal("minute"),
    second = Literal("second"),
    hour = Literal("hour"),
    nanosecond = Literal("nanosecond"),
    minusone = Literal("-1"),
    one = Literal("1"),
    zero = Literal("0"),
    nanosecondspersecond = Literal("1000000000"),
    startOfYearDateTime = SqlConstant("AnsiString","2000-01-01 00:00:00.000",type text),
    ticksperday = Literal("864000000000"),
    ticksperhour = Literal("36000000000"),
    ticksperminute = Literal("600000000"),
    tickspersecond = Literal("10000000"),

//Internal Helpers
    SingleListElement = (ast,visitor) =>
        let
            sqlastarg2 = visitor(ast[Arguments]{1}),
            array = List.Transform(ast[Arguments]{0}[Value],(c) => [Kind = "Constant", Value = c]),
            sqlastarray = List.Transform(array, (c) => visitor(c)),
            sqlast = if(ast[Arguments]{0}[Value]{0} = null) then UnaryLogicalOperation("IsNull",sqlastarg2)
                else BinaryLogicalOperation("Equals",sqlastarg2,sqlastarray{0})
        in
            sqlast,

    InExpression = (args,visitor) =>
        let
            array = List.Transform(args{0}[Value],(c) => [Kind = "Constant", Value = c]),
            sqlastarg1 = List.Transform(array, (c) => visitor(c)),
            inarrayexpression = InArrayExpression(sqlastarg1),
            sqlastarg2 = visitor(args{1})
        in
            BinaryLogicalOperation("In",sqlastarg2,inarrayexpression),

// All Helpers
    GetInvocation = (ast, function, count) =>
        if ast[Kind] = "Invocation" and ast[Function][Kind] = "Constant" and ast[Function][Value] = function and List.Count(ast[Arguments]) = count
        then ast[Arguments]
        else ...,
    ApproxDistinctCount = (list) => [
        Kind = "Invocation",
        Function = Function("approx_count_distinct"),
        Arguments = List.Transform(list, Argument), Type = Int64.Type
    ],
    InvocationWithVerbatim = (verbatimPrefix,args,name,Type) => [Kind = "Invocation", Function =  [Kind = "Function", Name=name, VerbatimPrefix = verbatimPrefix], Arguments = args, Type = Type],
    IntervalExpression = (intervalUnit,expr) => [Kind = "Interval", Interval = [Kind = "Literal", Value = intervalUnit], Expression = expr],
    WhenItem = (when,thenItem,Type) => [When = when,Then = thenItem,Type = Type],
    CaseFunction = (whenItems,elseItem,case,Type) => [Kind = "Case",Conditions = whenItems,Case = case,Else = elseItem,Type = Type],
    ConditionOperation = (operator,left,right) => [Kind = "ConditionOperation",Operator = operator,Left = left,Right = right,Type = Logical.Type],
    UnaryLogicalOperation = (operator,expression) => [Kind = "UnaryLogicalOperation",Operator = operator,Expression = expression,Type = Logical.Type ],
    BinaryLogicalOperation = (operator,left,right) =>  [Kind = "BinaryLogicalOperation",Operator = operator,Left =left,Right= right,Type = Logical.Type],
    Argument = (expr,Type) => [Expression = expr, Type = Type],
    Function = (name) => [Kind = "Function", Name=name],
    Literal = (value) => [Kind = "Literal", Value = value],
    BinaryOperation = (left, operator, right) => [Kind = "Binary",Left = left,Operator = operator, Right = right, Type = Double.Type ],
    Invocation = (args, name) => [Kind = "Invocation", Function = Function(name), Arguments = args, Type = Int64.Type],
    InvocationWithType = (args,name,Type) => [Kind = "Invocation", Function = Function(name), Arguments = args, Type = Type],
    InArrayExpression = (elements) => [Kind = "InArray",Elements = elements,Type = List.Type],
    SqlConstant = (constantType,literal,typeValue) => [Kind = "SqlConstant", ConstantType = constantType,Literal = literal,Type = typeValue],
    CastSqlExpression = (SqlAst,Type) => [Kind = "Cast",Expression = SqlAst,Type = Type],

// These are helper functions to merge base sql generator record with user provided overrides
// If ApplyAssert is false then validations are skipped. It shouldn't be true in Production Code.
    MergeOverrides = (generatorId as text, SqlGeneratorOverrides as record,ApplyAssert as logical) =>
        let
            SqlGeneratorBase = SqlGeneratorBaseSettings{[ID = generatorId]}[Settings],
            SqlGetTypeInfo = Value.AssertTableType(SqlGeneratorOverrides[SqlGetTypeInfo],SqlGetTypeInfoType,ApplyAssert),
            DefaultTypes = if(Record.HasFields(SqlGeneratorOverrides,{"DefaultTypes"}))
                then Value.AssertTableType(SqlGeneratorOverrides[DefaultTypes],DefaultTypesType,ApplyAssert)
                else null,
            TimestampFunctionOverrides = if(Record.HasFields(SqlGeneratorOverrides,{"TimestampFunctionOverrides"})) then Value.AssertRecordType(SqlGeneratorOverrides[TimestampFunctionOverrides],TimestampFunctionOverridesType,2,ApplyAssert)
                else null,
            SupportedConversions = if(Record.HasFields(SqlGeneratorOverrides,{"SupportedConversions"}))
                then Value.AssertTableType(SqlGeneratorOverrides[SupportedConversions],SupportedConversionsType,ApplyAssert)
                else null,
            SqlTypesCategories = if(Record.HasFields(SqlGeneratorOverrides,{"SqlTypesCategories"}))
                then Value.AssertRecordType(SqlGeneratorOverrides[SqlTypesCategories],SqlTypesCategoriesType,2,ApplyAssert)
                else null,
            withnullcheckSqlCapabilities = SqlGeneratorOverrides[SqlCapabilities]? ?? [],
            validatedSqlCapabilitiesOverrides =  Value.AssertRecordType(withnullcheckSqlCapabilities,SqlCapabilitiesType,2,ApplyAssert),
            mergedSqlCapabilities = MergeSqlCapabilities(SqlGeneratorBase[SqlCapabilities],validatedSqlCapabilitiesOverrides),
            SqlCapabilities = Value.AssertRecordType(mergedSqlCapabilities,SqlCapabilitiesType,1,ApplyAssert),
            withchecknull = SqlGeneratorOverrides[FunctionOverrides]? ?? [],
            validatedfunctionoverrides = Value.AssertRecordType(withchecknull,FunctionOverridesType,1,ApplyAssert),
            FunctionOverrides = Value.AssertRecordType(MergeFunctionOverrides(SqlGeneratorBase[AstVisitor][FunctionOverrides],validatedfunctionoverrides),FunctionOverridesType,1,ApplyAssert),
            BinaryOperatorOverrides = SqlGeneratorOverrides[BinaryOperatorOverrides]? ?? [],
            UnaryOperatorOverrides = SqlGeneratorOverrides[UnaryOperatorOverrides]? ?? [],
            ImplicitTypeConversions = SqlGeneratorOverrides[ImplicitTypeConversions]? ?? SqlGeneratorBase[ImplicitTypeConversions],
            SoftNumbers = SqlGeneratorOverrides[UseSoftNumbers]? ?? SqlGeneratorBase[SoftNumbers],
            AstVisitor = SqlGeneratorBase[AstVisitor] & [FunctionOverrides = FunctionOverrides, BinaryOperatorOverrides = BinaryOperatorOverrides, UnaryOperatorOverrides = UnaryOperatorOverrides],
            CombineContext = (left, right) => if left = [] then right else if right = [] then left else null
        in
            [
                Implementation = SqlGeneratorBase[Implementation],
                ImplicitTypeConversions = ImplicitTypeConversions,
                SoftNumbers = SoftNumbers,
                SqlGetTypeInfo = SqlGetTypeInfo,
                SqlCapabilities = SqlCapabilities,
                AstVisitor = AstVisitor,
                CombineContext = CombineContext,
                DefaultTypes = DefaultTypes,
                TimestampFunctionOverrides = TimestampFunctionOverrides,
                SupportedConversions = SupportedConversions,
                SqlTypesCategories = SqlTypesCategories
            ],

    MergeSqlCapabilities = (SqlCapabilitiesBase as record, SqlCapabilitiesOverrides as record) =>
        let
// Sql Capabilities merge
            fields = Record.FieldNames(SqlCapabilitiesOverrides),
            listOfFieldValues = List.Transform(fields,each TransformFunction(_,SqlCapabilitiesOverrides,SqlCapabilitiesBase)),
            TransformFunction = (fieldName as text,override as record, base as record) =>
            if(Type.Is(Value.Type(Record.Field(override,fieldName)),type record))
            then Record.AddField([],fieldName,Record.Field(base,fieldName) & Record.Field(override,fieldName))
            else Record.AddField([],fieldName,Record.Field(override,fieldName))
        in
            SqlCapabilitiesBase & Record.Combine(listOfFieldValues),
    MergeFunctionOverrides = (base as record, overrides as record) =>
        let
            FunctionOverrides = if(overrides = null) then [] else overrides
        in
            if(overrides = []) then base else base & FunctionOverrides,

// #SqlGeneratorTypes
// Types for SqlCapabilities
    SupportedPredicatesType = type [ IsNull = logical,IsNotNull = logical,SupportsComparision = logical],
    SupportedSql92RelationalJoinOperatorsType = type  [ FullOuterJoin = logical,LeftOuterJoin = logical,RightOuterJoin = logical,
        InnerJoin = logical,CrossJoin = logical
    ],
    TimeStampIntervalValuesType = type nullable [
        Nanosecond = text,
        Microsecond = text,
        Second = text,
        Minute = text,
        Hour = text,
        Day = text,
        Week = text,
        Month = text,
        Quarter = text,
        Year = text
    ],
    SqlCapabilitiesType = type  [
        LimitClauseKind = number,
        FractionalSecondsScale =  number,
        SupportsBindParameters = logical,
        IdentifierQuoteChar = nullable text,
        CatalogNameSeparator = nullable text,
        CatalogNameLocation = nullable number,
        Sql92Conformance = nullable number,
        MaxColumnsInOrderBy = nullable number,
        MaxIdentifierNameLength = nullable number,
        OrderByColumnsInSelect = nullable logical,
        TolerateConcatOverflow = logical,
        SupportedPredicates = SupportedPredicatesType,
        SupportedSql92RelationalJoinOperators = SupportedSql92RelationalJoinOperatorsType,
        TimeStampIntervalValues = TimeStampIntervalValuesType,
        SupportsColumnAliases = logical,
        MaxColumnsInGroupBy = number,
        MaxColumnsInSelect = number,
        GroupByCapabilities = number,
        StringConcatNullBehavior = number,
        SearchPatternEscapeCharacter = text,
        SupportsCastFunction = logical,
        IdentifierSpecialCharacters = nullable text
    ],
    SqlGetTypeInfoType = Value.Type(SqlGetTypeInfo),
    DefaultTypesType = Value.Type(DefaultTypes),
    TimestampFunctionOverridesType = Value.Type(TimestampFunctionOverrides),
    SupportedConversionsType = Value.Type(SupportedConversions),
    SqlTypesCategoriesType = type [
        SoftBase2Types = nullable list,
        SoftBase10Types = nullable list,
        VarBinaryTypes = nullable list,
        WideCharTypes = nullable list,
        VarCharTypes = nullable list,
        WideVarCharTypes = nullable list
    ],
    FunctionOverridesType = type [
        Date.Year =         nullable text,
        Date.Month =        nullable text,
        Date.Day =          nullable text,
        Date.QuarterOfYear = nullable text,
        Date.WeekOfYear = nullable text,
        Date.DayOfYear = nullable text,
        Date.DayOfWeek = nullable text,
        Number.Abs = nullable text,
        Number.Acos = nullable text,
        Number.Asin = nullable text,
        Number.Atan = nullable text,
        Number.Atan2 = nullable text,
        Number.Cos = nullable text,
        Number.Exp = nullable text,
        Number.Mod = nullable text,
        Number.Power = nullable text,
        Number.Sign = nullable text,
        Number.Sin = nullable text,
        Number.Sqrt = nullable text,
        Number.Tan = nullable text,
        Text.Contains = record,
        Text.StartsWith = nullable text,
        Text.EndsWith = nullable text,
        Text.Length = nullable text,
        Text.Start = nullable text,
        Text.End = nullable text,
        Text.Replace = nullable text,
        Text.Repeat = nullable text,
        Text.Lower = nullable text,
        Text.Upper = nullable text,
        Text.TrimStart = nullable text,
        Text.TrimEnd = nullable text,
        Character.FromNumber = nullable text,
        Character.ToNumber = nullable text,
        Time.Minute = nullable text,
        Time.Hour = nullable text,
        Number.Round = nullable text,
        Number.RoundUp = nullable text,
        Number.RoundDown = nullable text,
        Number.Log = nullable text,
        Value.NullableEquals = nullable text,
        Value.Equals = nullable text
    ] meta [recordtype = "FunctionOverrides"],

    ComplexFunctionOverridesType = Type.ForFunction([ReturnType = type record, Parameters = [visitor = type function,rowType = type record,groupKeys = type list, ast = type record]], 5),

    Value.AssertRecordType = (value as record,valuetype as type, validationtype as number,ApplyAssert as logical) =>
        if(ApplyAssert = false) then value
        else if(Type.Is(valuetype,type record)<> true) then error "Type provided is not a record type"
        else if(Value.Metadata(valuetype)[recordtype]? = "FunctionOverrides") then Value.AssertFunctionOverrides(value,valuetype)
        else if(validationtype = 1) then  Value.HardValidation(value,valuetype)
        else if(validationtype = 2) then  Value.SoftValidation(value,valuetype)
        else error "validationType is not correct",

    Value.AssertTableType = (value as table,tabletype as type,ApplyAssert as logical) =>
        let
            rows= Table.ToRows(value),
            fieldnamesfromvalue = Table.Column(Table.Schema(value),"Name"),
            fieldnamesfromtype  = Table.Column(Type.TableSchema(tabletype),"Name"),
            validatecolumncount = if(List.Count(fieldnamesfromvalue) = List.Count(fieldnamesfromtype))
                then rows else error "Column counts do not match between table value and table type provided",
            validatedcolumnames = if(List.MatchesAll(fieldnamesfromvalue, each fieldnamesfromtype{List.PositionOf(fieldnamesfromvalue,_)} = _))
                then validatecolumncount else error "Column names of the table value doesnt match with table type provided",
            validatedatatypes = List.Transform(validatedcolumnames,each validatetablerows(_)),
            validatetablerows = (row as list) =>
                let
                    rowrecord  = Record.FromList(row,fieldnamesfromtype),
                    result = List.Transform(fieldnamesfromtype,each validatecell(_)),
                    validatecell = (fieldname as text) =>
                        let
                            value = if(Record.HasFields(rowrecord,fieldname)) then Record.Field(rowrecord,fieldname) else error Text.Format("table column #{0} is missing",{fieldname}),
                            result = if(Type.Is(Value.Type(value),Type.TableColumn(tabletype,fieldname))) then true else error Text.Format("table column #{0} type mismatch",{fieldname})
                        in
                            result
                in
                    List.AllTrue(result)
        in
            if (ApplyAssert = false) then value
            else if(List.AllTrue(validatedatatypes)) then value
            else error "There should already have been error message",

//  These all are internal functions used for validation
    Value.AssertFunctionType = (functionvalue as function, functiontype as type) =>
        let
            parametersfromvalue = Type.FunctionParameters(Value.Type(functionvalue)),
            returnfromvalue = Type.FunctionReturn(Value.Type(functionvalue)),
            parametersfromtype = Type.FunctionParameters(functiontype),
            returnfromtype = Type.FunctionReturn(functiontype),
            returnValidated = if(Type.Is(returnfromvalue,returnfromtype)or Type.Is(type any, returnfromvalue))
                then true
                else error "return for the function doesnt match with type",
            parameternamesfromvalue = Record.FieldNames(parametersfromvalue),
            parameternamesfromtype = Record.FieldNames(parametersfromtype),
            validateparametercount = if(List.Count(parameternamesfromvalue) = List.Count(parameternamesfromtype))
                then true
                else error "Number of parameters in function doesn't match with number of parameters in type",
            validatedparameternames = if(List.MatchesAll(parameternamesfromvalue, each parameternamesfromtype{List.PositionOf(parameternamesfromvalue,_)} = _))
                then true
                else error "parameter names for the function signature doesn't match with type",
            validateparametertypes =  List.AllTrue(List.Transform(parameternamesfromvalue,each
                if(Type.Is(Record.Field(parametersfromvalue,_),Record.Field(parametersfromtype,_))
                or  Type.Is(type any,Record.Field(parametersfromvalue,_)))
                then true
                else error Text.Format("Function parameter #{0} type doesn't match function signature type",{_})))
        in
            List.AllTrue({returnValidated,validateparametercount,validateparametertypes}),

    Value.AssertFunctionOverrides = (value as record, valuetype as type) =>
        let
            fieldnames = Record.FieldNames(value),
            result = List.Transform(fieldnames, each validatefield(_)),
            validatefield = (fieldname as text) =>
                let
                    fieldvalue = Record.Field(value,fieldname),
                    result = try if((Type.Is(Value.Type(fieldvalue),type text) or fieldvalue = null)
                        or (Type.Is(Value.Type(fieldvalue),type record)))
                        then Value.ValidateTextForFunctionOverrides(fieldname)
                        else if (Type.Is(Value.Type(fieldvalue),type function)) then Value.AssertFunctionType(fieldvalue,ComplexFunctionOverridesType)
                        else error Text.Format("#{0} doesn't have a valid type, Functionoverrides can have only functions and text as a value",{fieldname})
                in
                    if(result[HasError]) then error result[Error] else true
        in
            if(List.AllTrue(result)) then value
            else error "There is an error which should already have been shown",

    Value.ValidateTextForFunctionOverrides = (fieldname as text) =>
        let
            typefields = Type.RecordFields(FunctionOverridesType)
        in
            if(Record.HasFields(typefields,fieldname)) then true
            else error Text.Format("Simple Overrides can only be provided to functions for which there is already a simple function override in base SqlGenerator
            , #{0} function is not a simple override in base sql generator",{fieldname}),

    Value.SoftValidation = (value as record, valuetype as type) =>
        if( Value.FieldByFieldValidation(value,valuetype,2)) then value else error "There is an error which should already have been shown",
//   Value.FieldByFieldValidation(value,valuetype,2),

    Value.HardValidation = (value as record, valuetype as type) =>
        if(Record.FieldCount(value) <> Record.FieldCount(Type.RecordFields(valuetype)))
        then error [  Reason = "FileNotFound",
                      Message = "Field Count doesnt match with type"
                   ]
        else if(Type.Is(valuetype,type record) <> true) then error "Type passed for validation is not record type"
        else if(Value.FieldByFieldValidation(value,valuetype,1)) then value
        else error "There is an error which should already have been shown",

    Value.FieldByFieldValidation = (value as record, valuetype as type, validationtype as number)  =>
        let
            validatedfields = List.Transform(Record.FieldNames(value),each ValidateField(_,value,valuetype,validationtype))
        in
            List.AllTrue(validatedfields),

// validatedfields,
    ValidateField = (fieldname as text, value as record, valuetype as type,validationtype as number) =>
        let
            typefields = Type.RecordFields(valuetype),
            fieldtype = if(Record.HasFields(typefields,fieldname))
                then Record.Field(typefields,fieldname)[Type]
                else error Text.Format("Field #{0} is not a valid field in provided type",{fieldname}),
            fieldvalue = Record.Field(value,fieldname),
            checkforRecord = try if(Type.Is(Value.Type(fieldvalue),type record)) then Value.AssertRecordType(fieldvalue,fieldtype,validationtype)
                else if (Type.Is(Value.Type(fieldvalue),type table)) then Value.AssertTableType(fieldvalue,fieldtype)
                else if (Type.Is(Value.Type(fieldvalue),type function)) then Value.AssertFunctionType(fieldvalue,fieldtype)
                else if (Type.Is(Value.Type(Record.Field(value,fieldname)),fieldtype)) then true
                else error Text.Format("Invalid fieldtype for #{0}",{fieldname})
        in
            if(checkforRecord[HasError]) then error checkforRecord[Error] else true,

    SqlGetTypeInfo = #table(type table [SqlTypeName = text, Type = type, ColumnSize = number, GetLiteral = nullable function,Searchable = number,UnsignedAttribute = nullable number,NumericPrecisionRadix = nullable number],{}),
    SqlCapabilities = [
       // LimitClause kind supported by DataSource
       // Possible Values are :
       //            LimitClauseKind.None
       //            LimitClauseKind.Top
       //            LimitClauseKind.LimitOffset
       //            LimitClauseKind.Limit
       //            LimitClauseKind.AnsiSql2008
        LimitClauseKind = LimitClauseKind.None,
       //   Fractional second scale supported for time values in datasource. For example value of 9 means ss.fffffffff (fractional second value till 9 decimal is supported)
        FractionalSecondsScale = 9,
       //  DataSource supports bind parameters. Valid values are true or false
        SupportsBindParameters = false,
     //   The character string that is used as the starting and ending delimiter of a quoted (delimited)
     //   identifier in SQL statements.
        IdentifierQuoteChar = """" ,
     //   A character string: the character or characters that the data source defines as the separator
     //   between a catalog name and the qualified name element that follows or precedes it.If null value provided
     //   then it defaults to "."
        CatalogNameSeparator = "." ,
     //   An integer value that indicates the position of the catalog in a qualified table name
     //   Possible values are :
     //       0  ---> Datasource doesn't support catalog name.
     //       1  ---> catalog name is at the start of the table name, as in \EMPDATA\EMP.DBF.
     //       2  ---> catalog is at the end of the table name, as in ADMIN.EMP@EMPDATA.
     //       null ---> Defaults to 1
        CatalogNameLocation = 1 ,
     //   An integer value that indicates the level of SQL-92 supported by the driver:
     //   Possible values are :
     //       1  ---> Entry level SQL-92 compliant.
     //       2  ---> FIPS 127-2 transitional level compliant.
     //       4  ---> Intermediate level SQL-92 compliant.
     //       8  ---> Full level SQL-92 compliant.
     //       null ---> Defaults to 4
        Sql92Conformance = 4 ,
     //   An integer Value that specifies the maximum number of columns allowed in an ORDER BY clause.
     //   If there is no specified limit or the limit is unknown, this value is set to zero.
     //   If null value is provided or value not provided then it defaults to 15
        MaxColumnsInOrderBy = 65535 ,
     //   An integer that indicates the maximum size in characters that the data source supports for user-defined names.
     //   If null then defaults to 128
        MaxIdentifierNameLength = 255 ,
     //   true if the columns in the ORDER BY clause must be in the select list; otherwise, false.
     //   if null then defaults to true
        OrderByColumnsInSelect = false ,
     //  This is set to true when trying to tolerate concatenation overflows. It is used along with SqlTypesCategories
     //   VarBinaryTypes , WideCharTypes , VarCharTypes , WideVarCharTypes
        TolerateConcatOverflow =  true,
     //   This record determines which Sql predicate Functions are supported
        SupportedPredicates = [
            IsNull = true,
            IsNotNull = false,
            SupportsComparision = true
        ],
     //   This record is to configure which Sql relational join operators are supported
        SupportedSql92RelationalJoinOperators = [
            FullOuterJoin = true,
            LeftOuterJoin = true,
            RightOuterJoin = true,
            InnerJoin = true,
            CrossJoin = true
        ],
     //   true if the data source supports column aliases; otherwise, false.
        SupportsColumnAliases = true ,
     //   An integer value that specifies the maximum number of columns allowed in a GROUP BY clause.
     //   If there is no specified limit or the limit is unknown, this value is set to zero.
        MaxColumnsInGroupBy = 65535 ,
     //   An integer value that specifies the maximum number of columns allowed in a select list.
     //   If there is no specified limit or the limit is unknown, this value is set to zero.
        MaxColumnsInSelect = 65535 ,
     //   An integer value that specifies the relationship between the columns in the GROUP BY clause
     //   and the nonaggregated columns in the select list:
     //   Possible values are :
     //       0  ---> A COLLATE clause can be specified at the end of each grouping column.
     //       1  ---> GROUP BY clauses are not supported.
     //       2  ---> The GROUP BY clause must contain all nonaggregated columns in the select list.
     //               It cannot contain any other columns. For example, SELECT DEPT, MAX(SALARY) FROM EMPLOYEE GROUP BY DEPT.
     //       3  ---> The GROUP BY clause must contain all nonaggregated columns in the select list. It can contain columns
     //               that are not in the select list. For example, SELECT DEPT, MAX(SALARY) FROM EMPLOYEE GROUP BY DEPT, AGE.
     //       4  ---> The columns in the GROUP BY clause and the select list are not related. The meaning of nongrouped,
     //               nonaggregated columns in the select list is data source-dependent. For example, SELECT DEPT, SALARY
     //               FROM EMPLOYEE GROUP BY DEPT, AGE.
        GroupByCapabilities = 2 ,
     //  TimeStampInterval Values supported by datasource
        TimeStampIntervalValues = [
            Nanosecond = "nanosecond",
            Microsecond = "microsecond",
            Second = "second",
            Minute = "minute",
            Hour = "hour",
            Day = "day",
            Week = "week",
            Month = "month",
            Quarter = "quarter",
            Year = "year"
        ],
     //   This value indicates how the data source handles the concatenation of NULL valued character data type columns with non-NULL valued character data type columns.
     //   Possible values are :
     //       0  ---> Result is NULL valued.
     //       1  ---> Result is concatenation of non-NULL valued column or columns.
        StringConcatNullBehavior = 0 ,
     //   A character string specifying what driver supports as an escape character that allows the use of the pattern match metacharacters underscore (_) and percent sign (%)
     //   as valid characters in search patterns. This escape character applies only for those catalog function arguments that support search strings. If this string is empty,
     //   the driver does not support a search-pattern escape character.
        SearchPatternEscapeCharacter = "\" ,
     //  Supports Cast Function
        SupportsCastFunction = true,
     //   A character string that contains all special characters (that is, all characters except a through z, A through Z, 0 through 9, and underscore)
     //   that can be used in an identifier name, such as a table name, column name, or index name, on the data source.
     //   For example, "#$^". If an identifier contains one or more of these characters, the identifier must be a delimited identifier.
        IdentifierSpecialCharacters = ""
     ],

    FunctionOverrides = [
    // Simple Function Overrides
        Date.Year = funcName[year],              // year([DateColumn])
        Date.Month = funcName[month],            // month(DateColumn])
        Date.Day = funcName[dayofmonth],         // dayofmonth([DateColumn])
        Date.QuarterOfYear = funcName[quarter],  // quarter([DateColumn])
        Date.WeekOfYear = funcName[week],        // week([DateColumn])
        Date.DayOfYear = funcName[dayofyear],    // dayofyear([DateColumn])
        Date.DayOfWeek = funcName[dayofweek],    // dayofweek([DateColumn])
        Number.Abs = funcName[ABS],              // ABS([NumberColumn])
        Number.Acos = funcName[ACOS],            // ACOS([NumberColumn])
        Number.Asin = funcName[ASIN],            // ASIN([NumberColumn])
        Number.Atan = funcName[ATAN],            // ATAN([NumberColumn])
        Number.Atan2 = funcName[ATAN2],          // ATAN2([NumberColumn])
        Number.Cos = funcName[COS],              // COS([NumberColumn])
        Number.Exp = funcName[EXP],              // EXP([NumberColumn])
        Number.Mod = funcName[MOD],              // MOD(INT1,INT2)
        Number.Power = funcName[POWER],          // POWER([NumberColumn])
        Number.Sign = funcName[SIGN],            // SIGN([NumberColumn])
        Number.Sin = funcName[SIN],              // SIN([NumberColumn])
        Number.Sqrt = funcName[SQRT],            // SQRT([NumberColumn])
        Number.Tan = funcName[TAN],              // TAN([NumberColumn])
        Text.Contains = [Name = funcName[CONTAINS],Type = Logical.Type],      // CONTAINS([STRINGCOLUMN],"texttocheck")
        Text.StartsWith = [Name = funcName[StartsWith],Type = Logical.Type],  // StartsWith([STRINGCOLUMN],"substring")
        Text.EndsWith = [Name = funcName[EndsWith],Type = Logical.Type],      // EndsWith([STRINGCOLUMN],"substring")
        Text.Length = funcName[Length],          // Length([STRINGCOLUMN])
        Text.Start = funcName[LEFT],             // LEFT([STRINGCOLUMN],count)
        Text.End = funcName[RIGHT],              // RIGHT([STRINGCOLUMN],count)
        Text.Replace = funcName[REPLACE],        // REPLACE([STRINGCOLUMN],"oldtext","newtext")
        Text.Repeat = funcName[REPEAT],          // REPEAT([STRINGCOLUMN],repeatcount)
        Text.Lower = funcName[LOWER],            // LOWER([STRINGCOLUMN])
        Text.Upper = funcName[UPPER],            // UPPER([STRINGCOLUMN])
        Text.TrimStart = funcName[LTRIM],        // LTRIM([STRINGCOLUMN])
        Text.TrimEnd = funcName[RTRIM],          // RTRIM([STRINGCOLUMN])
        Character.FromNumber = funcName[CHAR],   // CHAR([NumberColumn])
        Character.ToNumber = funcName[ASCII],    // ASCII([STRINGCOLUMN])
        Time.Minute = funcName[minute],          // minute([timecolumn])
        Time.Hour = funcName[hour],              // hour([timecolumn])
        Number.Round = funcName[round],          // round([numbercolumn])
        Number.RoundUp = funcName[ceil],         // ceil([numbercolumn])
        Number.RoundDown = funcName[floor],      // floor([numbercolumn])
        Number.Log = funcName[LN],               // LN([numbercolumn])
        Value.Equals = null,
        Value.NullableEquals = null,
        
        List.Contains = (visitor, rowType, groupKeys, ast) =>
            if List.Count(ast[Arguments]) = 2 then
                let
                    arg1 = ast[Arguments]{0},
                    arg2 = ast[Arguments]{1},
                    sqlAstArg2 = visitor(arg2),
                    withNullRemoved = List.RemoveNulls(arg1[Value]),
                    countAfterNullRemoved = List.Count(withNullRemoved),
                    hasNull = List.Count(arg1[Value]) <> countAfterNullRemoved,
                    valueEqualsTo = BinaryLogicalOperation("Equals",sqlAstArg2,visitor([Kind = "Constant", Value = withNullRemoved{0}])),
                    isNull = UnaryLogicalOperation("IsNull",sqlAstArg2),
                    result = if(arg1[Kind] = "Constant" and Type.Is(Value.Type(arg1[Value]),type list))
                        then 
                            let                                
                                result = if(countAfterNullRemoved = 1) 
                                    then 
                                        if hasNull then ConditionOperation("Or",valueEqualsTo,isNull) else valueEqualsTo
                                    else 
                                        if (hasNull and (countAfterNullRemoved = 0)) 
                                        then isNull
                                        else
                                            let 
                                                inExpression = InExpression({[Kind = "Constant", Value = withNullRemoved],ast[Arguments]{1}},visitor),
                                                result = if hasNull then ConditionOperation("Or",inExpression,isNull) else inExpression
                                            in 
                                                result
                                in 
                                    result
                        else ...
                    in
                        result
            else ...
    ],

    DefaultTypes = #table(type table [Type = type,SqlTypeName = text],{}),

    TimestampFunctionOverrides = [timestampadd = null, timestampdiff = null],

    SupportedConversions = #table(type table [FromSqlTypeName = text, ToSqlTypeNames = list ],{}),

    SqlTypesCategories = [
        SoftBase2Types = null,
        SoftBase10Types = null,
        VarBinaryTypes = null,
        WideCharTypes = null,
        VarCharTypes = null,
        WideVarCharTypes = null
    ],

    BinaryOperatorOverrides = [],
    UnaryOperatorOverrides = [],

    SqlGeneratorBase = [
        Implementation = Implementation,
        SoftNumbers = UseSoftNumbers,
        ImplicitTypeConversions = ImplicitTypeConversions,
        SqlGetTypeInfo = SqlGetTypeInfo,
        AstVisitor = []
    ],

    SqlGenerator92Standard = [
        Implementation = Implementation,
        ImplicitTypeConversions = ImplicitTypeConversions,
        SoftNumbers = UseSoftNumbers,
        SqlGetTypeInfo = SqlGetTypeInfo,
        SqlCapabilities = SqlCapabilities,
        AstVisitor = [
               FunctionOverrides = FunctionOverrides,
               BinaryOperatorOverrides = BinaryOperatorOverrides,
               UnaryOperatorOverrides = UnaryOperatorOverrides
        ],
        DefaultTypes = DefaultTypes,
        TimestampFunctionOverrides = TimestampFunctionOverrides,
        SupportedConversions = SupportedConversions,
        SqlTypesCategories = SqlTypesCategories
    ],

    Generators.Sql92.ID = "Sql92",
    SqlGeneratorBaseSettings = #table({"ID", "Settings"}, {
        {Generators.Sql92.ID, SqlGenerator92Standard}
      })
in
    [
       MergeOverrides = MergeOverrides,
       Value.AssertRecordType = Value.AssertRecordType,
       Value.AssertTableType = Value.AssertTableType,
       AllTypes = [
           SupportedPredicatesType = SupportedPredicatesType,
           SupportedSql92RelationalJoinOperatorsType = SupportedSql92RelationalJoinOperatorsType,
           TimeStampIntervalValuesType = TimeStampIntervalValuesType,
           SqlCapabilitiesType = SqlCapabilitiesType,
           SqlGetTypeInfoType = SqlGetTypeInfoType,
           FunctionOverridesType = FunctionOverridesType,
           DefaultTypesType = DefaultTypesType,
           TimestampFunctionOverridesType = TimestampFunctionOverridesType,
           SqlTypesCategoriesType = SqlTypesCategoriesType,
           SupportedConversions = SupportedConversionsType
        ],
        Constants = [
            minute = minute,
            second = second,
            hour = hour,
            nanosecond = nanosecond,
            minusone = minusone,
            one = one,
            zero = zero,
            startOfYearDateTime = startOfYearDateTime,
            ticksperday = ticksperday,
            tickspersecond = tickspersecond,
            ticksperminute = ticksperminute,
            ticksperhour = ticksperhour,
            nanosecondspersecond = nanosecondspersecond
        ],
        Helpers = [
            SingleListElement = SingleListElement,
            InExpression = InExpression,
            GetInvocation = GetInvocation,
            ApproxDistinctCount = ApproxDistinctCount,
            InvocationWithVerbatim = InvocationWithVerbatim,
            WhenItem = WhenItem,
            CaseFunction = CaseFunction,
            ConditionOperation = ConditionOperation,
            UnaryLogicalOperation = UnaryLogicalOperation,
            BinaryLogicalOperation = BinaryLogicalOperation,
            Argument = Argument,
            Function = Function,
            Literal = Literal,
            BinaryOperation = BinaryOperation,
            Invocation = Invocation,
            InvocationWithType = InvocationWithType,
            InArrayExpression = InArrayExpression,
            SqlConstant = SqlConstant,
            CastSqlExpression = CastSqlExpression,
            IntervalExpression = IntervalExpression
        ],
        FunctionNames = funcName
    ];