[ Version = "1.2.11" ]
section OneLakeFile;

apiUrl = Environment.FeatureSwitch("PowerBiUri", "https://api.powerbi.com");
cloud = Environment.FeatureSwitch("Cloud", "global");
AadAdlsStorageResource = "https://storage.azure.com";
AadWorkspaceApiOAuthResource = Environment.FeatureSwitch("PowerBiAadResource", "https://analysis.windows.net/powerbi/api");
 
// Extension library functions
Extension.LoadFunction = (name as text, optional additionalContext as nullable record) =>
    let
        binary = Extension.Contents(name),
        asText = Text.FromBinary(binary),
        baseContext = #shared,
        context = if additionalContext = null then baseContext 
            else Record.Combine({baseContext, additionalContext})
    in
        try
            Expression.Evaluate(asText, context)
        catch (e) =>
            error [
                Reason = "Extension.LoadFunction Failure",
                Message.Format = "Loading '#{0}' failed - '#{1}': '#{2}'",
                Message.Parameters = {name, e[Reason], e[Message]},
                Detail = [File = name, Error = e]
            ];

// Load modules
Utils = Extension.LoadFunction("Utils.pqm");
Table.NavigationTableView = Extension.LoadFunction("Table.NavigationTableView.pqm");

WorkspacePrivateLink = Extension.LoadFunction("Workspace.PrivateLink.pqm", [Utils = Utils]);
Workspace = Extension.LoadFunction("Workspace.pqm", [
    Utils = Utils, 
    Table.NavigationTableView = Table.NavigationTableView,
    WorkspacePrivateLink = WorkspacePrivateLink
]);
Variable.ValueOrDefault = try #shared[Variable.ValueOrDefault] otherwise (name, optional default) => default;

OneLakeFile = [
    Type = "Custom",
    MakeResourcePath = MakeResourcePath,
    ParseResourcePath = (resourcePath) => {resourcePath},
    TestConnection = (dataSourcePath) => { "OneLake.Contents" } & ParseResourcePath(dataSourcePath),
    IsKnownEndpoint = (path) => true,
    Authentication = [
          Aad = [
                   AuthorizationUri = Uri.Combine(Environment.FeatureSwitch("AzureActiveDirectoryUri", "https://login.microsoftonline.com"), "/common/oauth2/authorize"),
                   Resource = "",
                   // The OneLake service depends on this ordering of audiences in the credential
                   Scope = Utils[Utility.CreateOrderedScope]({AadAdlsStorageResource, AadWorkspaceApiOAuthResource})
                ]
           ],

    ApplicationProperties = [
        PBI_CapacityObjectId = [PropertyType = Text.Type, IsRequired = false],
        PBIEndpointUrl = [PropertyType = Text.Type, IsRequired = false]
    ],

// valid DSRs
/*
{"protocol":"onelake-storage","address":{"workspaceId":"cb336908-3120-4178-9c6d-6f6c0b11945c","artifactId":"f1d00b31-1d71-4d4e-9711-9e3f7768c9da"}}
{"protocol":"onelake-storage","address":{"workspaceId":"cb336908-3120-4178-9c6d-6f6c0b11945c","artifactId":"f1d00b31-1d71-4d4e-9711-9e3f7768c9da","path":"partial/path"}}
*/
    DSRHandlers = [
        #"onelake-storage" = [
            GetDSR = (path as text, optional options, optional navigation) =>
                let
                    parsed = ParseOneLakePath(path),
                    isRelativeReference = parsed[isRelativeReference],
                    workspaceField =
                        if isRelativeReference then [workspaceId = Variable.ValueOrDefault("currentWorkspaceId", parsed[workspace])]
                        else [workspaceId = parsed[workspace]],
                    artifactField =
                        if parsed[artifactId] <> null then [artifactId = parsed[artifactId]]
                        else [artifactName = parsed[artifactName], artifactType = parsed[artifactType]],
                    pathField = if parsed[partialPath] <> null then [path = parsed[partialPath]] else [],
                    relativeField = if isRelativeReference then [isRelativeReference = true] else [],
                    address = workspaceField & artifactField & pathField & relativeField
                in
                    {[protocol = "onelake-storage", address = address], options ?? []},
            GetFormula = (dsr, optional options) =>
                let
                    address = ValidateAddressRecord(dsr[address]),
                    workspaceId = Record.FieldOrDefault(address, "workspaceId", null),
                    artifactId = Record.FieldOrDefault(address, "artifactId", null),
                    artifactName = Record.FieldOrDefault(address, "artifactName", null),
                    artifactType = Record.FieldOrDefault(address, "artifactType", null),
                    partialPath = Record.FieldOrDefault(address, "path", null),
                    artifactSegment = if artifactId <> null then artifactId
                        else artifactName & "." & artifactType,
                    pathParts = {workspaceId, artifactSegment} & (if partialPath <> null then {partialPath} else {}),
                    fullPath = "/" & Text.Combine(pathParts, "/")
                in
                    () => OneLake.Contents(fullPath),
            GetFriendlyName = (dsr) => "OneLake"
        ]
   ]
];

MakeResourcePath = (path as text) as text =>   
    let
        // TODO: Consider sharing logic with runtime invocation?
        segments = Text.Split(Text.Trim(path, "/"), "/"),
        startingSlash = if Text.StartsWith(path, "/") then "/" else "",
        endingSlash = if Text.EndsWith(path, "/") then "/" else "",
        workspace = segments{0}?,
        resourcePath = if workspace = "."
            then startingSlash & Text.Combine({Variable.ValueOrDefault("currentWorkspaceId", ".")} & List.Skip(segments, 1), "/") & endingSlash
            else path
    in
        resourcePath;

ValidateOptions2 = (options, optionsType) =>
    let
        available = Type.RecordFields(optionsType),
        found = Record.FieldNames(options),
        unknown = Text.Combine(List.FirstN(found, each not Record.HasFields(available, _)), ","),
        result = if (unknown <> null and unknown <> "") then error "Unknown field: " & unknown else options
    in
        result;

ValidateAddressRecord = (address as record) =>
    let
        validated = ValidateOptions2(address, type [
            workspaceId = Guid.Type,
            artifactId = Guid.Type,
            artifactName = Text.Type,
            artifactType = Text.Type,
            path = Text.Type,
            isRelativeReference = Logical.Type
        ])
    in
        validated;

[DataSource.Kind = "OneLakeFile", Publish = "OneLakeFile.Publish"]
shared OneLake.Contents = Value.ReplaceType(OneLakeFileImpl, OneLakeFile.Type);

OneLakeFile.Type =
    let
    OneLakeFunctionType = Type.ForFunction([
            Parameters = [
                path = type text meta [
                    Documentation.FieldCaption = Extension.LoadString("OneLakeFile_PathCaption"),
                    Documentation.SampleValues = { "/workspaceId/artifactId/partial/path" }
                ],
                options = type record meta [
                    Documentation.FieldCaption = Extension.LoadString("OptionsParameterCaption"),
                    Documentation.SampleValues = { "[ ConnectionTimeout = 0 ]" }
                ]
            ],
            ReturnType = type table
        ], 1
    ),

    withMetadata = Value.ReplaceMetadata(
        OneLakeFunctionType,
        [
            Documentation.Name = Extension.LoadString("OneLakeFile_Title"),
            Documentation.Caption = Extension.LoadString("OneLakeFile_Title"),
            Documentation.Description = Extension.LoadString("OneLakeFile_Description"),
            Documentation.LongDescription = Extension.LoadString("OneLakeFile_LongDescription"),
            Documentation.Examples = {[
                  Description = Extension.LoadString("OneLakeFile_ExampleDescription"),
                  Code = "OneLake.Contents(""/85599f29-c009-4253-b53b-c3ba6e4afa97/fec0346d-3fa4-48c2-b3f3-714f5caa5f08/Files/path"")",
                  Result = Extension.LoadString("OneLakeFile_ExampleResult")
                ]}
        ])
    in
        withMetadata;

OneLakeFileImpl = (path as text, optional options as record) =>
    let
        parsed = ParseOneLakePath(path),
        resolvedWorkspaceId = if parsed[isRelativeReference]
            then try Variable.Value("currentWorkspaceId")
                catch () => error Error.Record("Expression.Error", Extension.LoadString("CurrentWorkspaceNotResolved"))
            else parsed[workspace],
        artifactSegment = if parsed[artifactId] <> null then parsed[artifactId]
            else ResolveArtifact(resolvedWorkspaceId, parsed[artifactName], parsed[artifactType]),

        baseUrl = Utils[GetOneLakeBaseUrl](cloud, Text.Contains(Text.Lower(apiUrl), "msit"), true),
        urlParts = {baseUrl, resolvedWorkspaceId, artifactSegment} & (if parsed[partialPath] <> null then {parsed[partialPath]} else {}),
        dfsUrl = Text.Combine(urlParts, "/"),
        result = OneLakeDataLake(dfsUrl)
    in
        result;

ResolveArtifact = (workspaceId as text, artifactName as text, artifactType as text) =>
    Extension.InvokeWithCredentials(
        (datasource) => Utils[GetCredential](AadWorkspaceApiOAuthResource),
        () => ResolveArtifactId(workspaceId, artifactName, artifactType));

// Resolves an artifact display name + type to its Guid id using the Fabric Items API.
// https://learn.microsoft.com/en-us/rest/api/fabric/core/items/list-items?tabs=HTTP
ResolveArtifactId = (workspaceId as text, artifactName as text, artifactType as text) as text =>
    let
        workspaceSpecificApiUrl = WorkspacePrivateLink[GetWorkspaceBaseUrl](apiUrl, workspaceId),
        isPL = WorkspacePrivateLink[IsWorkspacePLUrl](workspaceSpecificApiUrl),
        endPoint = Text.Format("v1/workspaces/#{0}/items?type=#{1}", {workspaceId, artifactType}),
        connectionPath = if isPL then endPoint & "&privateLinkType=Workspace" else endPoint,
        url = Uri.Combine(workspaceSpecificApiUrl, connectionPath),
        response = Utils[Web.JsonContents](
            url,
            /*headers*/ WorkspacePrivateLink[GetPrivateLinkS2SHeader](workspaceId),
            /*additionalHandlers*/ null,
            /*jsonBody*/ null,
            /*startState*/ null,
            /*traceContext*/ [Origin = Utils[NonPii]("ResolveArtifactId"),
                              WorkspaceId = Utils[NonPii](workspaceId),
                              ArtifactType = Utils[NonPii](artifactType)]),
        items = if response = null or not Record.HasFields(response, "value") or response[value] = null then
                error Diagnostics.Trace(
                    TraceLevel.Error,
                    [Name = "OneLakeFile/ResolveArtifactId/NoItemsResponse",
                     Data = [WorkspaceId = Utils[NonPii](workspaceId), ArtifactType = Utils[NonPii](artifactType)]],
                    Error.Record(
                        Utils[NonPii]("DataSource.Error"),
                        Utils[NonPii](Extension.LoadString("GetWorkspaceItemsFailure")),
                        [
                            ArtifactType = Utils[NonPii](artifactType),
                            WorkspaceId = Utils[NonPii](workspaceId)
                        ],
                        {Utils[NonPii](artifactType), Utils[NonPii](workspaceId)}))
            else
                response[value],
        matches = List.Select(items, each Record.FieldOrDefault(_, "displayName", null) = artifactName),
        matchCount = List.Count(matches),
        resolved = if matchCount = 0 then
                error Diagnostics.Trace(
                    TraceLevel.Error,
                    [Name = "OneLakeFile/ResolveArtifactId/ArtifactNotFound",
                     Data = [WorkspaceId = Utils[NonPii](workspaceId), ArtifactType = Utils[NonPii](artifactType)]],
                    Error.Record(
                        Utils[NonPii]("DataSource.Error"),
                        Utils[NonPii](Extension.LoadString("OneLakeArtifactNotFound")),
                        [
                            ArtifactName = artifactName,
                            ArtifactType = Utils[NonPii](artifactType),
                            WorkspaceId = Utils[NonPii](workspaceId)
                        ],
                        {artifactName, Utils[NonPii](artifactType), Utils[NonPii](workspaceId)}))
            else if matchCount > 1 then
                error Diagnostics.Trace(
                    TraceLevel.Error,
                    [Name = "OneLakeFile/ResolveArtifactId/AmbiguousArtifactName",
                     Data = [WorkspaceId = Utils[NonPii](workspaceId), ArtifactType = Utils[NonPii](artifactType), MatchCount = Utils[NonPii](matchCount)]],
                    Error.Record(
                        Utils[NonPii]("DataSource.Error"),
                        Utils[NonPii](Extension.LoadString("OneLakeAmbiguousArtifactName")),
                        [
                            ArtifactName = artifactName,
                            ArtifactType = Utils[NonPii](artifactType),
                            WorkspaceId = Utils[NonPii](workspaceId)
                        ],
                        {artifactName, Utils[NonPii](artifactType), Utils[NonPii](workspaceId)}))
            else
                List.First(matches)[id]
    in
        resolved;

// Path parsing: supports /wsId/artifactId/path, /wsId/name.type/path and relative /./name.type/path.
// The workspace segment must be a Guid or the relative reference ("."); the artifact segment can be
// an artifactId or the name.type form, which is resolved to an artifactId at runtime.
ParseOneLakePath = (path as text) as record =>
    let
        segments = Text.Split(Text.Trim(path, "/"), "/"),
        workspace = segments{0},
        artifactSegment = if List.Count(segments) < 2 then error Extension.LoadString("InvalidPathFormat_TooFewSegments") else segments{1},
        partialPath = Text.Combine(List.Skip(segments, 2), "/"),

        lastDotIndex = if artifactSegment <> null then Text.PositionOf(artifactSegment, ".", Occurrence.Last) else -1,
        isArtifactNameAndType = lastDotIndex >= 0,
        artifactName = if isArtifactNameAndType then Text.Start(artifactSegment, lastDotIndex) else null,
        artifactType = if isArtifactNameAndType then Text.Range(artifactSegment, lastDotIndex + 1) else null,
        isRelativeReference = workspace = ".",
        isWorkspaceId = isRelativeReference or (try Guid.From(workspace))[HasError] = false
    in
        // Relative workspace ("./") requires the artifact to be in name.type form (not a Guid)
        // so it can be resolved via the Fabric Items API.
        if isRelativeReference and not isArtifactNameAndType then
            error Extension.LoadString("InvalidPathFormat_RelativeRequiresNameType")
        else if not isWorkspaceId then
            error Extension.LoadString("InvalidPathFormat_WorkspaceArtifactMismatch")
        else 
        [
            isRelativeReference = isRelativeReference,
            isWorkspaceId = isWorkspaceId,
            workspace = workspace,
            artifactName = artifactName,
            artifactType = artifactType,
            artifactId = if not isArtifactNameAndType then artifactSegment else null,
            partialPath = if partialPath = "" then null else partialPath
        ];

OneLakeDataLake = (entityUrl as text) =>
    Extension.InvokeWithCredentials(
        (datasource) => Utils[GetCredential](AadAdlsStorageResource),
        () => AzureStorage.DataLake(entityUrl, [HierarchicalNavigation = true, IsOneLake = true]));

OneLakeFile.Publish = [
    Beta = true,
    Name = Extension.LoadString("DataSourceLabel"),
    Category = "Fabric",
    ButtonText = {
            Extension.LoadString("OneLakeFile_Title"), Extension.LoadString("OneLakeFile_Description")
        },
    SourceImage = OneLakeFile.Icons,
    SourceTypeImage = OneLakeFile.Icons
];

OneLakeFile.Icons = [
    Icon16 = { Extension.Contents("OneLakeFile16.png"), Extension.Contents("OneLakeFile20.png"), Extension.Contents("OneLakeFile24.png"), Extension.Contents("OneLakeFile32.png") },
    Icon32 = { Extension.Contents("OneLakeFile32.png"), Extension.Contents("OneLakeFile40.png"), Extension.Contents("OneLakeFile48.png"), Extension.Contents("OneLakeFile64.png") }
];
