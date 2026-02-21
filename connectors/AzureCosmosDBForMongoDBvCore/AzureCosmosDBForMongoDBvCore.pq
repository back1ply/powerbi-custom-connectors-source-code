[Version = "1.0.2"]
section AzureCosmosDBForMongoDBvCore;

// Loads the Diagnostics infracture
Diagnostics = Extension.LoadFunction("Diagnostics.pqm");

// Loads the Table.ChangeType function
Table.ChangeType = Extension.LoadFunction("Table.ChangeType.pqm");


// Loads the extended json extraction function
// shared ExtendedJson.Extract = Extension.LoadFunction("ExtendedJson.Extract.pqm");
ExtendedJson.Extract = Extension.LoadFunction("ExtendedJson.Extract.pqm");

// Loads the Visitors infrastructure
// shared Visitors.VisitAstKind = Extension.LoadFunction("Visitors.VisitAstKind.pqm");
Visitors.VisitAstKind = Extension.LoadFunction("Visitors.VisitAstKind.pqm");

// Enable or disable diagnostics tracing using this flag.
// By default, the value is false. Enable for development work, only.
EnableDiagnostics = false;
// shared Diagnostics.LogValue = 
Diagnostics.LogValue = 
    if EnableDiagnostics then
        Diagnostics[LogValue]
    else
        (prefix, value, optional delayed) => value;
// shared Diagnostics.LogFailure = 
Diagnostics.LogFailure = 
        if EnableDiagnostics then
            Diagnostics[LogFailure]
        else 
            (text, function) => function;
// shared Diagnostics.WrapHandlers =
Diagnostics.WrapHandlers =
    if EnableDiagnostics then
        Diagnostics[WrapHandlers]
    else
        (handlers as record) as record => handlers;

// Set Test configuration in this file.s
// shared TestConfig = Extension.LoadFunction("TestConfig.pqm");
TestConfig = Extension.LoadFunction("TestConfig.pqm");

[DataSource.Kind = "AzureCosmosDBForMongoDBvCore", Publish = "AzureCosmosDBForMongoDBvCore.Publish"]
shared AzureCosmosDBForMongoDBvCore.Contents = Value.ReplaceType(AzureCosmosDBForMongoDBvCoreImpl, CosmosDbType);

applicationHeader = [
    #"Content-Type" = "application/ejson",
    #"Accept" = "application/ejson"
];

ApiVersionV1 = "v1";
ApiVersionLatest = ApiVersionV1;
ApiPathPrelude = "/data/" & ApiVersionLatest & "/action";
LISTDATABASEURL = ApiPathPrelude & "/listDatabases";
LISTCOLLECTIONSURL = ApiPathPrelude & "/listCollections";
GETSCHEMAURL = ApiPathPrelude & "/getSchema";
AGGREGATEURL = ApiPathPrelude & "/aggregate";

SchemaMapping = [
    // V1 alpha - backward compatible
    #"ObjectId" = type nullable Text.Type,
    #"Int32" = type nullable Number.Type,
    #"Int64" = type nullable Number.Type,
    #"Boolean" = type nullable Logical.Type,
    #"Decimal128" = type nullable Text.Type,
    #"Double" = type nullable Number.Type,
    #"Timestamp" = type nullable Text.Type,
    #"Document" = Any.Type,
    #"String" = type nullable Text.Type,
    // V1 Production
    #"array" = Any.Type,
    #"binData" = type nullable Text.Type,
    #"bool" = type nullable Logical.Type,
    #"date" = type nullable DateTimeZone.Type,
    #"decimal" = type nullable Text.Type,
    #"double" = type nullable Number.Type,
    #"int" = type nullable Number.Type,
    #"long" = type nullable Number.Type,
    #"maxKey" = type nullable Text.Type,
    #"minKey" = type nullable Text.Type,
    #"null" = Any.Type,
    #"object" = Any.Type,
    #"objectId" = type nullable Text.Type,
    #"regex" = type nullable Text.Type,
    #"string" = type nullable Text.Type,
    #"timestamp" = type nullable Text.Type,
    #"Any" = Any.Type
];

CosmosDbType = type function (
    baseURL as (
        type text meta [
            Documentation.FieldCaption = Extension.LoadString("baseURLFieldCaption"),
            Documentation.FieldDescription = Extension.LoadString("baseURLFieldDescription"),
            Documentation.SampleValues = {Extension.LoadString("baseURLSampleValues")}
        ]
    ),
    optional database as (
        type text meta [
            Documentation.FieldCaption = Extension.LoadString("databaseFieldCaption"),
            Documentation.FieldDescription = Extension.LoadString("databaseFieldDescription"),
            Documentation.SampleValues = {Extension.LoadString("databaseSampleValues")}
        ]
    ),
    optional collection as (
        type text meta [
            Documentation.FieldCaption = Extension.LoadString("collectionFieldCaption"),
            Documentation.FieldDescription = Extension.LoadString("collectionFieldDescription"),
            Documentation.SampleValues = {Extension.LoadString("collectionSampleValues")}
        ]
    )
) as table meta [
    Documentation.Name = Extension.LoadString("datasourceTypeTableName"),
    Documentation.LongDescription = Extension.LoadString("datasourceTypeTableLongDescription")
];

AzureCosmosDBForMongoDBvCoreImpl = (baseURL as text, optional database as text, optional collection as text) as table =>
    let
        _resultTable =
            if database <> null and collection <> null then
                AzureCosmosDBForMongoDBvCoreImpl.View(baseURL, database, collection)
            else if database <> null and collection = null then
                AzureCosmosDBForMongoDBvCoreImpl.NavigationTable({database}, baseURL)
            else if database = null and collection <> null then
                error Extension.LoadString("databaseCollectionError")
            else
                let
                    databases = Diagnostics.LogValue("Databases", AzureCosmosDBForMongoDBvCoreImpl.ReturnsDatabases(baseURL)),
                    databaseList = Diagnostics.LogValue("Database List", List.Transform(databases[databases], each [name])),
                    navTable = AzureCosmosDBForMongoDBvCoreImpl.NavigationTable(databaseList, baseURL)
                in
                    navTable,
        resultTable = Diagnostics.LogValue("AzureCosmosDBForMongoDBvCoreImpl result table: ", _resultTable)
    in
        resultTable;

// Navigation Table -------------------------------------------------------------
// shared AzureCosmosDBForMongoDBvCoreImpl.NavigationTable = (showDatabases as list, baseURL as text) as table =>
AzureCosmosDBForMongoDBvCoreImpl.NavigationTable = (showDatabases as list, baseURL as text) as table =>
    let
        tableName = Table.FromList(showDatabases, null, {"Name"}),
        tableNameKey = Table.AddColumn(tableName, "Key", each [Name]),
        tableData = Table.AddColumn(tableNameKey, "Data", each AzureCosmosDBForMongoDBvCoreImpl.GetCollections(baseURL, [Name])),
        tableItemKind = Table.AddColumn(tableData, "ItemKind", each "Database"),
        tableItemName = Table.AddColumn(tableItemKind, "ItemName", each "Database"),
        tableIsLeaf = Table.AddColumn(tableItemName, "Isleaf", each false),
        NavTable = Table.ToNavigationTable(tableIsLeaf, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        NavTable;

AzureCosmosDBForMongoDBvCoreImpl.GetCollections = (baseURL as text, databaseName as text) as table =>
    let
        collections = Diagnostics.LogValue("Collections", AzureCosmosDBForMongoDBvCoreImpl.ReturnsCollections(baseURL, databaseName)),
        collectionList = Diagnostics.LogValue("Collection List", List.Transform(collections[collections], each [name])),
        tableName = Table.FromList(collectionList, null, {"Name"}),
        tableNameKey = Table.AddColumn(tableName, "Key", each [Name]),
        // Use a lambda function for the table retrieval to delay call to retrieve table contents.
        tableData = Table.AddColumn(tableNameKey, "Data", each () as table => AzureCosmosDBForMongoDBvCoreImpl.View(baseURL, databaseName, [Key])),
        tableItemKind = Table.AddColumn(tableData, "ItemKind", each "Table"),
        tableItemName = Table.AddColumn(tableItemKind, "ItemName", each "Table"),
        tableIsLeaf = Table.AddColumn(tableItemName, "Isleaf", each true),
        NavTable = Table.ToNavigationTable(tableIsLeaf, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        NavTable;

// -------------------------------------------------------------
// Data Source Kind description
AzureCosmosDBForMongoDBvCore = [
    TestConnection = (dataSourcePath) => { "AzureCosmosDBForMongoDBvCore.Contents", Json.Document(dataSourcePath)[baseURL] }, 
    Authentication = [
        UsernamePassword = []
    ],
    Label = Extension.LoadString("authenticationLabel"),
    Icons = AzureCosmosDBForMongoDBvCore.Icons
];

// shared AzureCosmosDBForMongoDBvCoreImpl.ReturnsDatabases = (url as text) as record =>
AzureCosmosDBForMongoDBvCoreImpl.ReturnsDatabases = (url as text) as record =>
    let
        _databaseURL = Uri.Combine(url, LISTDATABASEURL),
        databaseURL = Diagnostics.LogValue("ReturnsDatabases url: ", _databaseURL),
        content = [],
        postData = Json.FromValue(content),
        source = Web.Contents(databaseURL, [Headers = applicationHeader, Content = postData]),
        json = Json.Document(source)
    in
        json;

// Return collections function
// shared AzureCosmosDBForMongoDBvCoreImpl.ReturnsCollections = (url as text, databaseName as text) as record =>
AzureCosmosDBForMongoDBvCoreImpl.ReturnsCollections = (url as text, databaseName as text) as record =>
    let
        _databaseURL = Uri.Combine(url, LISTCOLLECTIONSURL),
        databaseURL = Diagnostics.LogValue("ReturnsCollections url: ", _databaseURL),
        content = [
            database = databaseName
        ],
        postData = Json.FromValue(content),
        source = Web.Contents(databaseURL, [Headers = applicationHeader, Content = postData]),
        json = Json.Document(source)
    in
        json;

// Return schema
// shared AzureCosmosDBForMongoDBvCoreImpl.ReturnsSchema = (url as text, databaseName as text, collectionName as text) as record =>
AzureCosmosDBForMongoDBvCoreImpl.ReturnsSchema = (url as text, databaseName as text, collectionName as text) as record =>
    let
        _databaseURL = Uri.Combine(url, GETSCHEMAURL),
        databaseURL = Diagnostics.LogValue("ReturnsSchema url: ", _databaseURL),
        content = [
            database = databaseName,
            collection = collectionName
        ],
        postData = Json.FromValue(content),
        source = Web.Contents(databaseURL, [Headers = applicationHeader, Content = postData]),
        _json = Json.Document(source),
        json = Diagnostics.LogValue("Json in Return Schema", _json)
    in
        json;

// Calculates the body contents of web request based on current state
// shared AzureCosmosDBForMongoDBvCoreImpl.CalculateQueryForAggregate = (_state as record) as record =>
AzureCosmosDBForMongoDBvCoreImpl.CalculateQueryForAggregate = (_state as record) as record =>
    let
        state = Diagnostics.LogValue("Calculate Query for Aggregate State at start", _state),
        queryWithPipeline = if (state[Pipeline]? <> null) then state[Pipeline] else {},
        // TODO: Calculate a $project stage based on state[SelectColumns]
        // Add a $skip stage
        queryWithSkip =
            if (state[Skip]? <> null) then
                queryWithPipeline & {[#"$skip" = state[Skip]]}
            else
                queryWithPipeline,
        // Add a $limit stage
        finalQuery =
            if (state[Limit]? <> null) then
                queryWithSkip & {[#"$limit" = state[Limit]]}
            else
                queryWithSkip,
        _query = [
            database = state[Database],
            collection = state[Collection],
            pipeline = finalQuery
        ],
        query = Diagnostics.LogValue("CalculateQueryForAggregate query: ", _query)
    in
        query;

// shared AzureCosmosDBForMongoDBvCoreImpl.SchemaMappingApplication = (recordFieldTypes) as list =>
AzureCosmosDBForMongoDBvCoreImpl.SchemaMappingApplication = (recordFieldTypes) as list =>
    let
        fieldTypes = List.Transform(
            recordFieldTypes,
            each Record.FieldOrDefault(SchemaMapping, if [bsonType]? is null then "Any" else [bsonType]?, Any.Type)
        )
    in
        fieldTypes;

// shared AzureCosmosDBForMongoDBvCoreImpl.GetType = (state as record) as type =>
AzureCosmosDBForMongoDBvCoreImpl.GetType = (state as record) as type =>
    let
        mongoSchema = AzureCosmosDBForMongoDBvCoreImpl.ReturnsSchema(state[Endpoint], state[Database], state[Collection]),
        // TODO: Revisit for improvements.
        _fields = mongoSchema,
        fields = Diagnostics.LogValue("GetType Schema fields", _fields),
        _fieldNames = Record.FieldNames(fields),
        fieldNames = Diagnostics.LogValue("GetType schema field names", _fieldNames),
        _recordFieldTypes = Record.FieldValues(fields),
        recordFieldTypes = Diagnostics.LogValue("Record Field Types", _recordFieldTypes),
        _fieldTypes = AzureCosmosDBForMongoDBvCoreImpl.SchemaMappingApplication(recordFieldTypes),
        fieldTypes = Diagnostics.LogValue("FieldTypes in GetType", _fieldTypes),
        schemaType = AzureCosmosDBForMongoDBvCoreImpl.SchemaFormatter(fieldNames, fieldTypes)
    in
        schemaType;

// shared AzureCosmosDBForMongoDBvCoreImpl.GetExpression = (
AzureCosmosDBForMongoDBvCoreImpl.GetExpression = (
    endpoint as text, database as text, collection as text, state as record
) as record =>
    let
        ast = [
            Kind = "Invocation",
            Function = [
                Kind = "Constant",
                Value = Value.NativeQuery
            ],
            Arguments = {
                [
                    Kind = "Invocation",
                    Function = [
                        Kind = "Constant",
                        Value = AzureCosmosDBForMongoDBvCore.Contents
                    ],
                    Arguments = {
                        [
                            Kind = "Constant",
                            Value = endpoint
                        ],
                        [
                            Kind = "Constant",
                            Value = database
                        ],
                        [
                            Kind = "Constant",
                            Value = collection
                        ]
                    }
                ],
                [
                    Kind = "Constant",
                    Value = Text.FromBinary(
                        Json.FromValue(AzureCosmosDBForMongoDBvCoreImpl.CalculateQueryForAggregate(state))
                    )
                ]
            }
        ],
        _ast = Diagnostics.LogValue("GetExpression AST: ", ast)
    in
        _ast;

// shared AzureCosmosDBForMongoDBvCoreImpl.OnInvoke = (
AzureCosmosDBForMongoDBvCoreImpl.OnInvoke = (
    state as record, cosmoView as function, _function as function, arguments as list, index as number
) as any =>
    let
        _result =
            if _function = cosmoView then
                state
            else if _function = DirectQueryCapabilities.From then
                #table(
                    {"Name", "Value"},
                    {
                        //TODO: we think this is a list of things that can be supported by DirectQuery
                        //TODO: Determine if mongo can support these if not remove
                        {"Core", null},
                        {"LiteralCount", 1000},

                        {"Table.FirstN", null},
                        {"Table.Sort", null},
                        {"Table.RowCount", null},

                        {"List.Average", null},
                        {"List.Sum", null},
                        {"List.Min", null},
                        {"List.Max", null},
                        {"List.StandardDeviation", null},

                        {"Text.Start", null},
                        {"Text.End", null},
                        {"Text.Range", null},
                        {"Text.PositionOf", null},
                        {"Text.Replace", null},
                        {"Text.Lower", null},
                        {"Text.Upper", null},
                        {"Text.Length", null},
                        {"Text.TrimStart", null},
                        {"Text.TrimEnd", null},

                        {"Date.AddWeeks", null},
                        {"Date.Year", null},
                        {"Date.Month", null},
                        {"Date.WeekOfYear", null},
                        {"Date.Day", null},
                        {"Date.DayOfWeek", null},
                        {"Date.DayOfYear", null},

                        {"Duration.TotalDays", null},
                        {"Duration.TotalHours", null},
                        {"Duration.TotalMinutes", null},
                        {"Duration.TotalSeconds", null},

                        {"Number.Round", null},
                        {"Number.RoundUp", null},
                        {"Number.RoundDown", null},
                        {"Number.Mod", null},
                        {"Number.Abs", null},
                        {"Number.Sign", null},
                        {"Number.Power", null},
                        {"Number.Exp", null},
                        {"Number.Ln", null},
                        {"Number.Log10", null},
                        {"Number.Sqrt", null},
                        {"Number.Acos", null},
                        {"Number.Asin", null},
                        {"Number.Atan", null},
                        {"Number.Atan2", null},
                        {"Number.Cos", null},
                        {"Number.Sin", null},
                        {"Number.Tan", null}
                    }
                )
            else
                error
                    [
                        Reason = "Unsupported OnInvoke function",
                        Message.Format = "Unsupported function: '#{0}'",
                        Message.Parameters = {Value.Expression(Value.Optimize(_function))[Name]},
                        Detail = "Function not implemented for OnInvoke"
                    ],
        result = Diagnostics.LogValue("OnInvoke result: ", _result)
    in
        result;

// shared AzureCosmosDBForMongoDBvCoreImpl.CalculateSchema = (_state as record) as type =>
AzureCosmosDBForMongoDBvCoreImpl.CalculateSchema = (_state as record) as type =>
    let
        state = Diagnostics.LogValue("state passed in calc schema", _state),
        res = 
            if (state[IsNativeQuery]? = true) then
                AzureCosmosDBForMongoDBvCoreImpl.NativeQueryCalculateSchema(state)
            else if (state[Schema]? <> null) then
                state[Schema]
            else
                AzureCosmosDBForMongoDBvCoreImpl.GetType(state)
    in
        res;

AzureCosmosDBForMongoDBvCoreImpl.NativeQueryCalculateSchema = (state as record) as type =>
    let
        addLimitState = state & [Limit = 1], //limit of 1 to calculate schema from results
        content = Json.FromValue(AzureCosmosDBForMongoDBvCoreImpl.CalculateQueryForAggregate(addLimitState)),
        json_response = Web.Contents(
            Uri.Combine(state[Endpoint], AGGREGATEURL), [Headers = applicationHeader, Content = content]
        ),
        response = Json.Document(json_response),
        documentList = Diagnostics.LogValue("records in NativeQueryCalculateSchema", response[documents]?),
        schemaType = 
            if List.Count(documentList) = 0 and state[Schema]? <> null then
                state[Schema]
            else if List.Count(documentList) = 0 and state[Schema]? = null then
                AzureCosmosDBForMongoDBvCoreImpl.GetType(state)
            else 
                let
                    recordFieldAndValues = documentList{0}?, 
                    fieldNames = Record.FieldNames(recordFieldAndValues),
                    NativeQuerySchemaType = AzureCosmosDBForMongoDBvCoreImpl.SchemaFormatter(fieldNames)
                in 
                    NativeQuerySchemaType
    in
        schemaType;

// shared AzureCosmosDBForMongoDBvCoreImpl.GetRows = (state as record) as table =>
AzureCosmosDBForMongoDBvCoreImpl.GetRows = (state as record) as table =>
    let
        content = Json.FromValue(AzureCosmosDBForMongoDBvCoreImpl.CalculateQueryForAggregate(state)),
        json_response = Web.Contents(
            Uri.Combine(state[Endpoint], AGGREGATEURL), [Headers = applicationHeader, Content = content]
        ),
        response = Diagnostics.LogValue("Response in GetRows", Json.Document(json_response)),
        appliedType = Diagnostics.LogValue("Applied type in GetRows", AzureCosmosDBForMongoDBvCoreImpl.FormatAggregationResponse(state, response)),
        extractedEJSON = Diagnostics.LogValue("Extract type in GetRows", ExtendedJson.Extract(appliedType))
    in
        extractedEJSON;

// shared AzureCosmosDBForMongoDBvCoreImpl.FormatAggregationResponse = (state as record, response as record) as table =>
AzureCosmosDBForMongoDBvCoreImpl.FormatAggregationResponse = (state as record, response as record) as table =>
    let
        records = response[documents]?,
        // get the columns from the current schema (which is an M Type value)
        currentSchema = AzureCosmosDBForMongoDBvCoreImpl.CalculateSchema(state),
        result = Table.FromRecords(records, currentSchema, MissingField.UseNull)
        // TODO: Check if necessary when using a more specific schema (i.e., not all as type any)
        //appliedType = Table.ChangeType(result, currentSchema)
    in
        result;

AzureCosmosDBForMongoDBvCoreImpl.SchemaFormatter = (_columns as list, optional _listType as list) =>
    let
        columns = Diagnostics.LogValue("Schema Formatter - columns", _columns),
        listType = Diagnostics.LogValue("Schema Formatter - listType", _listType),
        // Properly formats new schema into `type table [_id = any, bool0 = any, ...]`
        result = Diagnostics.LogValue("result in Schema Formatter", #table(columns, {})),
        fieldTypes = Diagnostics.LogValue("Field types in Schema formatter", if listType <> null then
            List.Zip({columns, listType})
        else
            List.Transform(columns, each {_, Any.Type})),
        tableType = Diagnostics.LogValue("Table type in schema formatter", Value.Type(Table.TransformColumnTypes(result, fieldTypes)))
    in
        tableType;

// shared AzureCosmosDBForMongoDBvCoreImpl.OnSelectRows = (condition as function, state as record) as record =>
AzureCosmosDBForMongoDBvCoreImpl.OnSelectRows = (condition as function, state as record) as record =>
    let
        state = Diagnostics.LogValue("~~~~~~~~~~ OnSelectRows ~~~~~~~~~~", state),
        _ast = RowExpression.From(condition),
        ast = Diagnostics.LogValue("OnSelectRows AST", _ast),
        // TODO: Check handling of embedded documents and arrays.
        match = [
            #"$match" = [#"$expr" = Visitors.VisitAstKind(ast)]
        ],
        _pipeline = if Record.HasFields(state, "Pipeline") then List.Combine({state[Pipeline]? & {match}}) else {
            match
        },
        pipeline = Diagnostics.LogValue("OnSelectRows Pipeline", _pipeline),
        endingState = Diagnostics.LogValue("========== Ending state of OnSelectRows ==========", state & [Pipeline = pipeline])
    in
        endingState;

// shared AzureCosmosDBForMongoDBvCoreImpl.OnSelectColumns = (_columns as list, _state as record) as record =>
AzureCosmosDBForMongoDBvCoreImpl.OnSelectColumns = (_columns as list, _state as record) as record =>
    let
        startingState = Diagnostics.LogValue("~~~~~~~~~~ OnSelectColumns ~~~~~~~~~~", _state),

        columns = Diagnostics.LogValue("Columns in OnSelectColumns", _columns), // important
        // get the current schema
        currentSchema = Diagnostics.LogValue("currentSchema in OnSelectColumns", AzureCosmosDBForMongoDBvCoreImpl.CalculateSchema(startingState)),
        state = startingState & [IsNativeQuery = false],
        // get the columns from the current schema (which is an M Type value)
        rowRecordType = Diagnostics.LogValue("rowRecordType in OnSelectColumns", Type.RecordFields(Type.TableRow(currentSchema))),
        existingColumns = Diagnostics.LogValue("existingColumns in OnSelectColumns", Record.FieldNames(rowRecordType)),
        // calculate the new schema
        columnsToRemove = Diagnostics.LogValue("columnsToRemove in OnSelectColumns", List.Difference(existingColumns, columns)),
        updatedColumns = Diagnostics.LogValue("updatedColumns in OnSelectColumns", Record.RemoveFields(rowRecordType, columnsToRemove)),
        reorderedSchema = Diagnostics.LogValue("reorder schema in OnSelectColumns", Record.ReorderFields(updatedColumns, columns)),
        newSchema = Diagnostics.LogValue("newSchema in OnSelectColumns", type table (Type.ForRecord(reorderedSchema, false))),

        projectRecord = Diagnostics.LogValue("projectRecord in OnSelectColumns", Record.Combine(List.Transform(columns, each Record.AddField([], _, 1)))),

        _project = [
            #"$project" = projectRecord
        ],
        project = Diagnostics.LogValue("Project in OnSelectColumns", _project),

        _pipeline = if Record.HasFields(state, "Pipeline") then List.Combine({state[Pipeline]? & {project}}) else {
            project
        },
        pipeline = Diagnostics.LogValue("OnSelectColumns Pipeline", _pipeline),
        endingState = Diagnostics.LogValue("========== Ending state of OnSelectColumns ==========", state & [SelectColumns = columns, Schema = newSchema, Pipeline = pipeline])
    in
        endingState;

// shared AzureCosmosDBForMongoDBvCoreImpl.OnNativeQuery = (
AzureCosmosDBForMongoDBvCoreImpl.OnNativeQuery = (
    _state as record, query as text, optional parameters as any, optional options as any
) as record =>
    let
        state = Diagnostics.LogValue("~~~~~~~~~~ OnNativeQuery ~~~~~~~~~~", _state),
        _query = Text.Trim(query),
        json = if Text.Length(_query) > 0 then Json.Document(Text.ToBinary(_query)) else {},
        jsonList =
            if (not Value.Is(json, List.Type) and Value.Is(json, Record.Type)) then
                {json}
            else if (Value.Is(json, List.Type)) then
                json
            else
                error Extension.LoadString("onNativeQueryUnexpectedJsonError"),
        _jsonList = Diagnostics.LogValue("OnNativeQuery JSON", jsonList),
        result = if List.Count(jsonList) = 0 then state else state & [Pipeline = List.Combine({if Record.HasFields(state, "Pipeline") then state[Pipeline] else {} , _jsonList}), IsNativeQuery = true],
        endingState = Diagnostics.LogValue("========== Ending state of OnNativeQuery ==========", result)
    in
        endingState;

// shared AzureCosmosDBForMongoDBvCoreImpl.OnSort = (columnSortDetails as list, _state as record) as record =>
AzureCosmosDBForMongoDBvCoreImpl.OnSort = (columnSortDetails as list, _state as record) as record =>
    let
        state = Diagnostics.LogValue("~~~~~~~~~~ OnSort ~~~~~~~~~~", _state),
        //mongo only supports sort on a maximum of 32 keys https://www.mongodb.com/docs/manual/reference/operator/aggregation/sort/#limits
        sort =
            if List.Count(columnSortDetails) <= 32 then
                [
                    #"$sort" = Record.FromList(
                        List.Transform(columnSortDetails, each if [Order]? = Order.Ascending then 1 else -1),
                        List.Transform(columnSortDetails, each [Name])
                    )
                ]
            else
                error Extension.LoadString("onSortUnsupportedColumnSelectionError"),    
        _pipeline = 
            if Record.HasFields(state, "Pipeline") then 
                List.Combine({state[Pipeline]? & {sort}}) 
            else {
                sort},
        pipeline = Diagnostics.LogValue("OnSort Pipeline", _pipeline),
        endingState = Diagnostics.LogValue("========== Ending state of OnSort ==========", state & [Pipeline = pipeline])
    in
        endingState;

AzureCosmosDBForMongoDBvCoreImpl.OnTake = (state as record, count as number) as record =>
    let
        pipeline = 
            if Record.HasFields(state, "Pipeline") then 
                List.Combine({state[Pipeline]? & {[#"$limit" = count]}}) 
            else 
                {[#"$limit" = count]},
        
        newState = state & [Pipeline = pipeline]
    in
        newState;


AzureCosmosDBForMongoDBvCoreImpl.OnSkip = (state as record, count as number) as record =>
    let
        pipeline = 
            if Record.HasFields(state, "Pipeline") then 
                List.Combine({state[Pipeline]? & {[#"$skip" = count]}}) 
            else 
                {[#"$skip" = count]},
        
        newState = state & [Pipeline = pipeline]
    in
        newState;

// shared AzureCosmosDBForMongoDBvCoreImpl.OnGroup = (_keys as list, aggregate as list, _state as record) as record =>
AzureCosmosDBForMongoDBvCoreImpl.OnGroup = (_keys as list, aggregate as list, _state as record) as record =>
    let
        startingState = Diagnostics.LogValue("~~~~~~~~~~ OnGroup ~~~~~~~~~~", _state),
        keys = Diagnostics.LogValue("Keys in OnGroup", _keys),

        mongoIdRec = 
            if List.IsEmpty(keys) = true then
                [#"_id" = null]
            else
                [#"_id" = Record.FromList(List.Transform(keys, each "$" & _), keys)],

        // get list of functions and extract column name
        groupFunctionRec = Record.FromList(
            List.Transform(aggregate, each AzureCosmosDBForMongoDBvCore.GroupExtractFunctionandColumn([Function])),
            List.Transform(aggregate, each [Name])
        ),
        // then combine and add to group stage
        group = [
            #"$group" = mongoIdRec & groupFunctionRec
        ],
        // create project stage to flatten _id object returned from mongo
        projectExistingColumns = Record.FromList(
            List.Transform(keys, each "$_id." & _),
            keys
        ),
        projectNewColumns = Record.FromList(
            List.Transform(aggregate, each "$" & [Name]),
            List.Transform(aggregate, each [Name])
        ),
        combinedProject = projectExistingColumns & projectNewColumns,
        addIDProjectStage = 
            if List.Contains(keys, "_id") = true then
                combinedProject
            else    
                Record.AddField(combinedProject, "_id", 0),
        // add to project stage
        project = [
            #"$project" = addIDProjectStage
        ],
        combinedGroupProject = {group} & {project},
        _pipeline =
            if Record.HasFields(state, "Pipeline") then
                List.Combine({state[Pipeline]? & combinedGroupProject})
            else
                combinedGroupProject,
        pipeline = Diagnostics.LogValue("OnGroup Pipeline", _pipeline),

        //Calculate new schema since Group creates new column(s)
        _names = List.Transform(aggregate, each [Name]),
        names = Diagnostics.LogValue("Names in OnGroup", _names),
        newTypes = List.Transform(aggregate, each [Type]),

        currentSchema = AzureCosmosDBForMongoDBvCoreImpl.CalculateSchema(state),
        state = startingState & [IsNativeQuery = false],
        recordName = Type.RecordFields(Type.TableRow(currentSchema)),
        currentSelectedNames = Record.SelectFields(recordName, keys),
        currentTypes = Record.FieldValues(currentSelectedNames),
        _transformedTypes = List.Transform(currentTypes, each [Type]),
        transformedTypes = Diagnostics.LogValue("Transformed type in OnGroup", _transformedTypes),

        // Combines original columns for group with the new columns into a list
        combinedNames = keys & names,
        combinedTypes = transformedTypes & newTypes,

        transformedTable = AzureCosmosDBForMongoDBvCoreImpl.SchemaFormatter(combinedNames, combinedTypes),

        // Adds selected columns to the state.
        newState = AzureCosmosDBForMongoDBvCoreImpl.OnSelectColumns(combinedNames, state),
        finalState = Diagnostics.LogValue("finalState in OnGroup", newState),
        endingState = Diagnostics.LogValue("========== Ending state of OnGroup ==========", finalState & [Pipeline = pipeline,
            Schema = transformedTable])
    in
        endingState;

AzureCosmosDBForMongoDBvCore.GroupExtractFunctionandColumn = (_aggregateFunction as function) as record =>
    let
        //percentile and count distinct values are only supported in Power Query Online
        //mongo does not support count distinct values, count distinct rows or all rows in group stage of aggregate
        //Azure Cosmos DB for MongoDB does not support median
        //operations taken from https://learn.microsoft.com/en-us/power-query/group-by#operations-available
        SupportedGroupFunction = [
            List.Average = List.Average,
            Table.RowCount = Table.RowCount,
            List.Count = List.Count,
            List.Max = List.Max,
            List.Min = List.Min,
            List.Sum = List.Sum
        ],
        ast = RowExpression.From(_aggregateFunction),
        _function = ast[Function][Value],
        _result =
            if _function = SupportedGroupFunction[Table.RowCount] 
                or _function = SupportedGroupFunction[List.Count] then
                //count can be treated as sum:1 for the group stage
                //see https://www.mongodb.com/docs/manual/reference/operator/aggregation/count-accumulator/#behavior
                [#"$sum" = 1]
            else if
                _function = SupportedGroupFunction[List.Average]
                or _function = SupportedGroupFunction[List.Max]
                or _function = SupportedGroupFunction[List.Min]
                or _function = SupportedGroupFunction[List.Sum]
            then
                Visitors.VisitAstKind(ast)
            else
                error
                    [
                        Reason = Extension.LoadString("groupExtractErrorReason"),
                        Message.Format = Extension.LoadString("groupExtractErrorFormat"),
                        Message.Parameters = {Value.Expression(Value.Optimize(_aggregateFunction))[Name]?},
                        Detail = Extension.LoadString(Extension.LoadString("expectingOneOfError"))
                            & Text.Combine(List.Sort(Record.FieldNames(SupportedGroupFunction)), ", ")
                    ],
        result = Diagnostics.LogValue("GroupExtractFunctionandColumn result: ", _result)
    in
        result;

AzureCosmosDBForMongoDBvCoreImpl.SingleOnAddColumns = (_constructor as record) =>
    let
        constructor = Diagnostics.LogValue("Constructor in SingleOnAddColumns", _constructor),
        _ast = RowExpression.From(constructor[Function]),
        ast = Diagnostics.LogValue("OnAddColumns AST", _ast),
        _visitAst = Visitors.VisitAstKind(ast),
        visitAst = Diagnostics.LogValue("OnAddColumns VisitAst", _visitAst)
    in
        visitAst;

// shared AzureCosmosDBForMongoDBvCoreImpl.OnAddColumns = (_state as record, _constructor as list) =>?
AzureCosmosDBForMongoDBvCoreImpl.OnAddColumns = (_state as record, _constructor as list) =>
    let
        startMessage = Diagnostics.LogValue("~~~~~~~~~~ OnAddColumns ~~~~~~~~~~", _state),

        initalstate = Diagnostics.LogValue("State at start of OnAddColumns", startMessage),
        constructor = Diagnostics.LogValue("Constructor at start of OnAddColumns", _constructor),
        // Seperates the names from constructor
        _names = List.Transform(constructor, each [Name]),
        names = Diagnostics.LogValue("Names in OnAddColumns", _names),
        _types = List.Transform(constructor, each [Type]),
        types = Diagnostics.LogValue("Types in OnAddColumns", _types),

        // Handles each item in the list of new columns
        _individualColumn = List.Transform(constructor, AzureCosmosDBForMongoDBvCoreImpl.SingleOnAddColumns),
        individualColumn = Diagnostics.LogValue("Individual column in OnAddColumns", _individualColumn),
        _recordList = Record.FromList(individualColumn, names),
        recordList = Diagnostics.LogValue("Record list in OnAddColumns", _recordList),

        _currentSchema = AzureCosmosDBForMongoDBvCoreImpl.CalculateSchema(initalstate),
        state = initalstate & [IsNativeQuery = false],
        currentSchema = Diagnostics.LogValue("Current Schema in OnAddColumns", _currentSchema),

        // Breaks current schema down into a name list and a type list
        _recordName = Type.RecordFields(Type.TableRow(currentSchema)),
        recordName = Diagnostics.LogValue("_recordName in OnAddColumns", _recordName),
        _currentNames = Record.FieldNames(recordName),
        currentNames = Diagnostics.LogValue("_currentNames in OnAddColumns", _currentNames),

        _currentTypes = Record.FieldValues(recordName),
        currentTypes = Diagnostics.LogValue("Current Types in OnAddColumns", _currentTypes),

        _transformedTypes = List.Transform(currentTypes, each [Type]),
        transformedTypes = Diagnostics.LogValue("Transformed types in OnAddColumns", _transformedTypes),

        // Combines original schema with the new values for the schema into a list
        _combinedNames = currentNames & names,
        combinedNames = Diagnostics.LogValue("Combined names in OnAddColumns", _combinedNames),
        _combinedTypes = transformedTypes & types,
        combinedTypes = Diagnostics.LogValue("Combined Types in OnAddColumns", _combinedTypes),

        _tableType = AzureCosmosDBForMongoDBvCoreImpl.SchemaFormatter(combinedNames, combinedTypes),
        tableType = Diagnostics.LogValue("tableType in OnAddColumns", _tableType),

        _addFields = [
            #"$addFields" = recordList
        ],
        addFields = Diagnostics.LogValue("AddFields in OnAddColumns", _addFields),

        _pipeline = 
            if Record.HasFields(state, "Pipeline") then 
                List.Combine({state[Pipeline]? & {addFields}}) 
            else 
            {
                addFields
            },
        pipeline = Diagnostics.LogValue("Pipeline in OnAddColumns", _pipeline),
        endingState = Diagnostics.LogValue("========== Ending State OnAddColumns ==========", state & [Pipeline = pipeline,
            Schema = tableType,
            SelectColumns = combinedNames])
    in
        endingState;


// shared AzureCosmosDBForMongoDBvCoreImpl.OnRenameColumns = (_state as record, _renames as list) =>
AzureCosmosDBForMongoDBvCoreImpl.OnRenameColumns = (_state as record, _renames as list) =>
let
    startMessage = Diagnostics.LogValue("~~~~~~~~~~ OnRenameColumn ~~~~~~~~~~", _state),
    startingState = Diagnostics.LogValue("State in OnRenameColumns", startMessage),
    renames = Diagnostics.LogValue("Renames in OnRenameColumns", _renames),

    properlyFormattedRenames = List.Transform(renames, each Record.ToList(_)),

    _addFieldsList = List.Transform(renames, each Record.AddField([], [NewName], "$" & [OldName])),
    addFieldsList = Diagnostics.LogValue("addFieldsList in OnRenameColumns", _addFieldsList),
    _addFieldsRecordCombine = Record.Combine(addFieldsList),
    addFieldsRecordCombine = Diagnostics.LogValue("addFieldsRecordCombine in OnRenameColumns", _addFieldsRecordCombine),

    _projectList = List.Transform(renames, each Record.AddField([], [OldName], 0)),
    projectList = Diagnostics.LogValue("projectList in OnRenameColumns", _projectList),
    _projectRecordCombine = Record.Combine(projectList),
    projectRecordCombine = Diagnostics.LogValue("projectRecordCombine in OnRenameColumns", _projectRecordCombine),

    // Project in aggregate is to remove old fields
    _project = [
        #"$project" = projectRecordCombine
    ],
    project = Diagnostics.LogValue("project in OnRenameColumns", _project),

    // Add fields adds newly named field to match old data
    _addFields = [
        #"$addFields" = addFieldsRecordCombine
    ],
    addFields = Diagnostics.LogValue("addFields in OnRenameColumns", _addFields),

    _currentSchema = AzureCosmosDBForMongoDBvCoreImpl.CalculateSchema(startingState),
    currentSchema = Diagnostics.LogValue("Current Schema in OnRenameColumns", _currentSchema),
    state = startingState & [IsNativeQuery = false],

    _recordName = Type.RecordFields(Type.TableRow(currentSchema)),
    recordName = Diagnostics.LogValue("_recordName in OnRenameColumns", _recordName),

    replacedRecordName = Diagnostics.LogValue("Replaced Record Name in RenameColumns", Record.RenameFields(recordName, properlyFormattedRenames)),

    _currentNames = Record.FieldNames(replacedRecordName),
    currentNames = Diagnostics.LogValue("_currentNames in OnRenameColumns", _currentNames),

    _currentTypes = Record.FieldValues(recordName),
    currentTypes = Diagnostics.LogValue("Current Types in OnRenameColumns", _currentTypes),
    _transformedTypes = List.Transform(currentTypes, each [Type]),
    transformedTypes = Diagnostics.LogValue("Transformed types in OnRenameColumns", _transformedTypes),

    renameColumns = Diagnostics.LogValue("Rename columns at end of OnRenameColumns", currentNames),

    newSchema = Diagnostics.LogValue("New Schema in OnRenameColumns", transformedTypes),
    properlyFormattedNewSchema =  Diagnostics.LogValue("properlyFormattedNewSchema OnRenameColumns", AzureCosmosDBForMongoDBvCoreImpl.SchemaFormatter(renameColumns, newSchema)),

    _pipeline = 
    if Record.HasFields(state, "Pipeline") then 
        List.Combine({state[Pipeline]? & {addFields} & {project}}) 
    else 
        {addFields, project},
    pipeline = Diagnostics.LogValue("Pipeline in OnRenameColumns 2", _pipeline),


    endingState = Diagnostics.LogValue("========== Ending State 10 OnRenameColumns 2 ==========", 
        state & 
            [Pipeline = pipeline,
            SelectColumns = renameColumns,
            Schema = properlyFormattedNewSchema])
in
    endingState;


//note when doing a distinct with no columns or null selected, powerquery creates a list that contains all of the columns
// shared AzureCosmosDBForMongoDBvCoreImpl.OnDistinct = (columns as list, _state as record) as record =>
AzureCosmosDBForMongoDBvCoreImpl.OnDistinct = (columns as list, _state as record) as record =>
    let
        // get existing columns from the current schema
        currentSchema = AzureCosmosDBForMongoDBvCoreImpl.CalculateSchema(_state),
        state = _state & [IsNativeQuery = false],
        // get the existing column names from the schema
        rowRecordType = Type.RecordFields(Type.TableRow(currentSchema)),
        existingColumns = Record.FieldNames(rowRecordType),
        // calculate the columns that will be added to the stages
        removeDuplicateColumns = List.Difference(existingColumns, columns),
        //check to see if _id is part of the existing columns before removing and if it doesnt exist dont do anything special with _id
        isObjectIdProjectedFromRoot =
            if List.Contains(columns, "_id") = true or List.Contains(existingColumns, "_id") = false then
                false
            else
                true,
        existingColumnNames =
            if isObjectIdProjectedFromRoot then
                List.RemoveItems(removeDuplicateColumns, {"_id"})
            else
                removeDuplicateColumns,

        //get the columns we want to have distinct value for
        mongoIdRec = [#"_id" = Record.FromList(List.Transform(columns, each "$" & _), columns)],

        //get record of other existing columns and get the first entry for each
        firstColumnsRec = Record.FromList(
            List.Transform(existingColumnNames, each [#"$first" = "$" & _]), existingColumnNames
        ),
        groupStage = mongoIdRec & firstColumnsRec,

        //will use the group aggregation for distinct since we cannot use the distinct mongo function
        group =
            if isObjectIdProjectedFromRoot then
                [#"$group" = groupStage & [
                    #"CosmosDistinctDataObj" = [#"$first" = "$$ROOT"]
                ]]
            else
                [#"$group" = groupStage],
        // create project stage to flatten _id object returned from mongo
        projectColumns = Record.FromList(List.Transform(columns, each "$_id." & _), columns),

        //set _id column created from group stage back to objectID if needed
        addIDProjectStage =
            if isObjectIdProjectedFromRoot then
                Record.AddField(projectColumns, "_id", "$CosmosDistinctDataObj._id")
            else
                [],

        projectExistingColumns = Record.FromList(
            List.Transform(existingColumnNames, each "$" & _), existingColumnNames
        ),

        // add to project stage
        project = [
            #"$project" = projectColumns & projectExistingColumns & addIDProjectStage
        ],

        combinedGroupProject = {group} & {project},
        _pipeline =
            if Record.HasFields(state, "Pipeline") then
                {state[Pipeline]? & combinedGroupProject}
            else
                combinedGroupProject,
        pipeline = Diagnostics.LogValue("OnDistinct Pipeline", _pipeline)
    in
        state & [Pipeline = pipeline];

// Various articles and documentation the Table.View handlers.
//
// See: https://github.com/microsoft/DataConnectors/blob/00b30f78143873b0bff60335ed53069288aad6db/docs/table-view.md
// GetRows () as table => (Required) Returns the table result. Always the last handler called.
// GetType () as type => (Required) Returns the M type of the table expected from GetRows.
// GetRowCount () as number => Returns a number. Used as an optimization where count can be determined without a call to GetRows.
// GetExpression () as record => Returns an AST record describing the server-side functionality
//
// See: https://community.fabric.microsoft.com/t5/Power-Query/Table-View-Handling-NestedJoin-Expand/td-p/2670026
// OnAddColumns = (constructors as {[Name = text, Function = (row as record) => any, Type = type]}) as table => Called when adding a calculated column (Table.AddColumn).
// OnCombine = (tables as {table}, index as Int64.Type) as table => ...,
// OnDistinct = (columns as {text}) as table => Called when as a result of Table.Distinct.,
// OnGroup = (keys as {text}, aggregates as {[Name = text, Function = (subtable as table) => any, Type = type]}) => Called for various aggregation transformations.,
// OnInvoke = (function as function, arguments as list, index as Int64.Type) as any => Called to determine Direct Query capabilities.,
// OnJoin = (joinSide as Int64.Type, leftTable as table, rightTable as table, joinKeys as {text}, joinKind as JoinKind.Type) as table => Called when performing a join of two tables.,
// OnPivot = (pivotValues as list, attributeColumn as {text}, valueColumn as text, aggregateFunction as (items as list) as any) as table => ...,
// OnRenameColumns = (renames as {[OldName as text, NewNew as text]}) as table => Called when renaming columns (Table.RenameColumns)., Format of renames {[OldName = "oName", NewName = "nName"]}
// OnSelectColumns = (columns as {text}) => Called when selecting specific columns.,
// OnSelectRows = (condition as (row as record) as logical) as table => Called when selecting rows based on an expression (Table.SelectRows).,
// OnSkip = (count as Int64.Type) as table => Called when using Table.Skip.,
// OnSort = (order as {[Name = as text, Order as Order.Type]}) as table => Called when table is sorted (Table.Sort).,
// OnTake = (count as Int64.Type) as table => Called when limiting the number of rows being retrieved (Table.FirstN).,
// OnUnpivot = (pivotColumns as {text}, attributeColumn as text, valueColumn as text) as table => ...,
// OnNativeQuery = (query as text, optional parameters as any, optional options as any) as any =>
//
// See: https://bengribaudo.com/blog/2022/01/04/6398/custom-folding-arbitrary-functions-oninvoke-table-viewfunction
//
// See: https://web.archive.org/web/20200920164149/https://github.com/microsoft/DataConnectors/issues/246
// "For DQ, you always have to implement GetExpression, which should return a representation of an AST that represents the
//  invocation of the query against the underlying source."
// shared AzureCosmosDBForMongoDBvCoreImpl.View = (endpoint as text, database as text, collection as text) as table =>
AzureCosmosDBForMongoDBvCoreImpl.View = (endpoint as text, database as text, collection as text) as table =>
    let
        _cosmosView = Table.ViewFunction((view) => ...),
        // Calculate the initial schema so it can be cached and not have to be retrieved again.
        schema = AzureCosmosDBForMongoDBvCoreImpl.CalculateSchema(
            [Endpoint = endpoint, Database = database, Collection = collection]
        ),
        View = (state as record) as table =>
            Table.View(
                null,
                Diagnostics.WrapHandlers(
                    [
                        GetType = () => AzureCosmosDBForMongoDBvCoreImpl.CalculateSchema(state),
                        GetRows = () => AzureCosmosDBForMongoDBvCoreImpl.GetRows(state),
                        GetExpression = () =>
                            AzureCosmosDBForMongoDBvCoreImpl.GetExpression(endpoint, database, collection, state),
                        OnTake = (count as number) => @View(AzureCosmosDBForMongoDBvCoreImpl.OnTake(state, count)),
                        OnSkip = (count as number) => @View(AzureCosmosDBForMongoDBvCoreImpl.OnSkip(state, count)),
                        OnSelectRows = (condition as function) =>
                            @View(AzureCosmosDBForMongoDBvCoreImpl.OnSelectRows(condition, state)),
                        OnSelectColumns = (columns as list) =>
                            @View(AzureCosmosDBForMongoDBvCoreImpl.OnSelectColumns(columns, state)),
                        OnNativeQuery = (query as text, optional parameters as any, optional options as any) =>
                            @View(AzureCosmosDBForMongoDBvCoreImpl.OnNativeQuery(state, query, parameters, options)),
                        OnSort = (columnSortDetails as list) =>
                            @View(AzureCosmosDBForMongoDBvCoreImpl.OnSort(columnSortDetails, state)),
                        OnGroup = (keys as list, aggregates as list) =>
                            @View(AzureCosmosDBForMongoDBvCoreImpl.OnGroup(keys, aggregates, state)),
                        OnInvoke = (_function as function, arguments as list, index as number) =>
                            AzureCosmosDBForMongoDBvCoreImpl.OnInvoke(state, _cosmosView, _function, arguments, index),
                        OnAddColumns = (constructors as list) as table =>
                            @View(AzureCosmosDBForMongoDBvCoreImpl.OnAddColumns(state, constructors)),
                        OnRenameColumns = (renames as list) as table =>
                            @View(AzureCosmosDBForMongoDBvCoreImpl.OnRenameColumns(state, renames)),
                        OnDistinct = (columns as list) =>
                            @View(AzureCosmosDBForMongoDBvCoreImpl.OnDistinct(columns, state))
                    ]
                )
            )
    in
        View([Endpoint = endpoint, Database = database, Collection = collection, Schema = schema]);

// Data Source UI publishing description
AzureCosmosDBForMongoDBvCore.Publish = [
    Beta = true,
    Category = "Other",
    ButtonText = {Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp")},
    SupportsDirectQuery = true,
    SourceImage = AzureCosmosDBForMongoDBvCore.Icons,
    SourceTypeImage = AzureCosmosDBForMongoDBvCore.Icons
];

AzureCosmosDBForMongoDBvCore.Icons = [
    Icon16 = {
        Extension.Contents("AzureCosmosDBForMongoDBvCore16.png"),
        Extension.Contents("AzureCosmosDBForMongoDBvCore20.png"),
        Extension.Contents("AzureCosmosDBForMongoDBvCore24.png"),
        Extension.Contents("AzureCosmosDBForMongoDBvCore32.png")
    },
    Icon32 = {
        Extension.Contents("AzureCosmosDBForMongoDBvCore32.png"),
        Extension.Contents("AzureCosmosDBForMongoDBvCore40.png"),
        Extension.Contents("AzureCosmosDBForMongoDBvCore48.png"),
        Extension.Contents("AzureCosmosDBForMongoDBvCore64.png")
    }
];

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

// Load extension functions
Extension.LoadFunction = (fileName as text) =>
    let
        asText = Text.FromBinary(Extension.Contents(fileName))
    in
        try
            Expression.Evaluate(asText, #shared) catch (e) =>
                error
                    [
                        Reason = Extension.LoadString("loadFunctionErrorReason"),
                        Message.Format = Extension.LoadString("loadFunctionErrorFormat"),
                        Message.Parameters = {fileName, e[Reason], e[Message]},
                        Detail = [File = fileName, Error = e]
                    ];
