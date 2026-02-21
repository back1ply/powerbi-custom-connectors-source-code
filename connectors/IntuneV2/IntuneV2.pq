// This file contains the data connector logic for Intune Data Warehouse V2
[Version = "2.0.0"]
section IntuneV2;

IntuneV2.AuthUri = "https://login.microsoftonline.com/common/oauth2/authorize";
IntuneV2.ResourceUri = "https://warehouse.manage.microsoft.com";

[DataSource.Kind="IntuneV2", Publish="IntuneV2.Publish"]
shared IntuneV2.Contents = Value.ReplaceType(IntuneV2DwImpl, IntuneV2DwType) ;

// Function type
IntuneV2DwType = type function (
    dataWarehouseAsuUri as (type text meta [
        Documentation.FieldCaption = Extension.LoadString("asuUriCaption"),
        Documentation.FieldDescription = Extension.LoadString("asuUriDescription"),
        Documentation.SampleValues = { "https://fef.amsua0602.manage.microsoft.com/TrafficGateway/TrafficRoutingService/ReportingService/DataWarehouseFEService?api-version=v1.0" }
        ]
    ),
    optional options as (
        type nullable [
            optional maxHistoryDays = (type number meta [
                Documentation.FieldCaption = Extension.LoadString("historyDaysCaption"),
                Documentation.FieldDescription = Extension.LoadString("historyDaysDescription"),
                Documentation.AllowedValues = { 1, 2, 3, 4, 5, 6, 7, 14, 30 }
            ])
        ]
    )
) as table meta [
        Documentation.Name = "Intune Data Warehouse V2",
        Documentation.LongDescription = "Intune Data Warehouse V2"];

// Function implementation
IntuneV2DwImpl = (dataWarehouseAsuUri as text, optional options as record) =>
    let
        // Get api-version with a default of v1.0
        _parts = Uri.Parts(dataWarehouseAsuUri),
        _query = if Record.HasFields(_parts, "Query") then _parts[Query] else [],
        _apiVersion = if Record.HasFields(_query, "api-version") then _query[#"api-version"] else "v1.0",

        // Validate dataWarehouseAsuUri
        _hostname = Text.Lower(_parts[Host]),
        _isValidDataWarehouseAsuUri = Text.StartsWith(dataWarehouseAsuUri, "https://") and
            (Text.EndsWith(_hostname, ".manage.microsoft.com") or
             Text.EndsWith(_hostname, ".manage-beta.microsoft.com") or
             Text.EndsWith(_hostname, ".manage-selfhost.microsoft.com")),
        
        // Get maxHistoryDays from options with a default of 7
        _options = options ?? [],
        _maxDays = _options[maxHistoryDays]? ?? 7,

        // Create OData feed
        queryString = [
            MaxHistoryDays = Number.ToText(_maxDays),
            #"api-version" = _apiVersion
        ],
        feed = OData.Feed(dataWarehouseAsuUri, null, [Query = queryString, Implementation="2.0", ODataVersion = 4])
    in
        if _isValidDataWarehouseAsuUri then feed
        else error Error.Record("Expression.Error", Extension.LoadString("invalidDataWarehouseUriError"), [ Uri = dataWarehouseAsuUri ]);

// Data Source Kind description
IntuneV2 = [
    TestConnection = (dataSourcePath) => {"IntuneV2.Contents", Json.Document(dataSourcePath)[dataWarehouseAsuUri]}, 
    Authentication = [
        Aad = [
            AuthorizationUri = IntuneV2.AuthUri,
            Resource = IntuneV2.ResourceUri
        ]
    ]
];

// Data Source UI publishing description
IntuneV2.Publish = [
    Beta = true,
    Category = "Online Services",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    SourceImage = IntuneV2.Icons,
    SourceTypeImage = IntuneV2.Icons
];

IntuneV2.Icons = [
    Icon16 = { Extension.Contents("Intune16.png"), Extension.Contents("Intune20.png"), Extension.Contents("Intune24.png"), Extension.Contents("Intune32.png") },
    Icon32 = { Extension.Contents("Intune32.png"), Extension.Contents("Intune40.png"), Extension.Contents("Intune48.png"), Extension.Contents("Intune64.png") }
];