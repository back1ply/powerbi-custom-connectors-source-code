---
type: Power Query Pattern
title: Table.View handlers
description: Stateful Table.View handlers and request parameter generation.
category: Query folding
tags: [query-folding]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:42Z'
detect: [\bTable\.View\s*\(]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L37
  title: Asana/Asana.m
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:00:47Z'
review:
  content_sha256: d35da4c4842a67f297fc001b623bb47c2aeb562e46fc0790819206e5ec01e556
  sources_sha256:
    example: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
---

**Review scope:** static source review; vendor connector runtime behavior is not tested.

# Mechanism

Asana constructs a `Table.View(null, ...)` whose state initially contains the input link. `GetType` returns the type of `AsanaSchema()`. `GetRows` computes query parameters from the current state and passes them to `GetTasks`, so parameter calculation and row retrieval remain separate steps.[^example]

`OnTake` produces a new state by adding `Limit = count` and recursively returns `@View(newState)`. `CalculateUrl` includes a textual `limit` query parameter when that state field is present. This is the concrete relationship between the view handler and the later request; the view does not merely truncate an already-returned table in that branch.[^example]

# Adaptation and failure paths

Treat each handler as an implementation commitment. This source shows `OnTake`, but that does not demonstrate support for filtering, sorting, skipping, or aggregation. Follow the state through the final request before claiming that a transformation is handled remotely.[^example]

Check how successive transformations combine their state, especially when a handler overwrites a previous value. Here `state & [Limit = count]` replaces the limit field. When adapting the approach, test compositions as well as isolated transformations, and compare the actual endpoint request with the result expected by the caller.[^example]

The type path calls a schema function that performs a web request, while the row path calls `GetTasks`. Include failures in both paths when reviewing the connector; successful type discovery is not evidence that row retrieval succeeded.[^example]

See [native-query interception](native-query.md), [schema handling](schema.md), and [web requests](web-requests.md).

# Examples

The following excerpt is copied from `Asana/Asana.m`, lines 37–78.[^example]

```powerquery
Asana.View = (link as text) as table =>
    let
        View = (state as record) => Table.View(null, [

            GetType = () => Value.Type(AsanaSchema()),

            // Called last - retrieves the data from the calculated URL
            GetRows = () =>
                let
                    qp = CalculateUrl(state),
                    result = GetTasks(qp)
                in
                    result,

            // OnTake - handles the Table.FirstN transform, limiting
            // the maximum number of rows returned in the result set.
            OnTake = (count as number) =>
                let
                    newState = state & [ Limit = count ]
                in
                    @View(newState),

            // Calculates the final URL based on the current state.
            CalculateUrl = (state) as record =>
                let
                    url = api_url & "/v1/data",

                    // Uri.BuildQueryString requires that all field values
                    // are text literals.
                    defaultQueryString = [ url = state[Link]],

                    // Check for Top defined in our state
                    qsWithLimit =
                        if (state[Limit]? <> null) then
                            defaultQueryString & [ limit = Number.ToText(state[Limit]) ]
                        else
                            defaultQueryString
                in
                    qsWithLimit
        ])
    in
        View([Link = link]);
```

[^example]: Asana/Asana.m; see the matching `sources` entry.

# Detection limits

The list below is generated from the `detect` expressions in this page. Detection reports the first matching line per source file, including matches in comments, strings, or helper definitions. Treat each result as a source-reading lead; it is not proof of runtime behavior or a complete implementation.

# Seen in

<!-- seen-in:start -->

Detected in **25** connectors in this archive.

* [Asana](../connectors/Asana.md): [Asana.m line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L39)
* [Assemble Views](../connectors/AssembleViews.md): [AssembleViews.m line 478](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AssembleViews/AssembleViews.m#L478)
* [Azure Cosmos DB for MongoDB vCore](../connectors/AzureCosmosDBForMongoDBvCore.md): [AzureCosmosDBForMongoDBvCore.pq line 975](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L975)
* [Solver](../connectors/BI360.md): [Solver.m line 102](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BI360/Solver.m#L102)
* [Bloomberg](../connectors/Bloomberg.md): [Folding.pqm line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Folding.pqm#L37)
* [BuildingConnected & TradeTapp](../connectors/BuildingConnected.md): [BuildingConnected.pq line 235](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq#L235)
* [Wolters Kluwer CCH Tagetik](../connectors/CCHTagetik.md): [CCHTagetik.pq line 319](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CCHTagetik/CCHTagetik.pq#L319)
* [CData Connect Cloud](../connectors/CDataConnectCloud.md): [CDataConnectCloudService.pqm line 211](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudService.pqm#L211), [CDataConnectCloudServiceV2.pqm line 301](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudServiceV2.pqm#L301)
* [Celonis EMS](../connectors/Celonis.md): [Celonis.m line 273](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Celonis/Celonis.m#L273)
* [Dataverse](../connectors/CommonDataService.md): [CommonDataService.pq line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq#L74)
* [Dynamics 365 Customer Insights](../connectors/CustomerInsights.md): [CustomerInsights.m line 237](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CustomerInsights/CustomerInsights.m#L237)
* [Azure Databricks](../connectors/Databricks.md): [Databricks.pq line 1367](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L1367)
* [Dremio](../connectors/Dremio.md): [DremioAdbcDataSource.pqm line 293](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioAdbcDataSource.pqm#L293)
* [SQL database](../connectors/FabricSql.md): [FabricSql.pq line 272](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/FabricSql.pq#L272), [Table.NavigationTableView.pqm line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Table.NavigationTableView.pqm#L57)
* [FHIR](../connectors/Fhir.md): [Fhir.pq line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Fhir/Fhir.pq#L124)
* [kxkdbinsightsenterprise](../connectors/kxkdbinsightsenterprise.md): [kxkdbinsightsenterprise.pq line 191](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L191)
* [Lakehouse](../connectors/LakeHouse.md): [DualTable.View.pqm line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/DualTable.View.pqm#L30), [LakeHouse.pq line 145](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/LakeHouse.pq#L145), [Table.NavigationTableView.pqm line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/Table.NavigationTableView.pqm#L57)
* [MicrostrategyDataset](../connectors/MicrostrategyDataset.md): [MicroStrategyDataset.m line 496](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L496)
* [OneLake Files](../connectors/OneLakeFile.md): [Table.NavigationTableView.pqm line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Table.NavigationTableView.pqm#L57)
* [OneLakeSql](../connectors/OneLakeSql.md): [OneLakeSql.pq line 244](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/OneLakeSql.pq#L244), [Table.NavigationTableView.pqm line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Table.NavigationTableView.pqm#L57)
* [Dataflows](../connectors/PowerPlatformDataflows.md): [PowerPlatformDataflows.pq line 175](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L175), [Table.NavigationTableView.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Table.NavigationTableView.pqm#L47)
* [Samsara](../connectors/Samsara.md): [Samsara.Table.Fetch.pqm line 145](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Table.Fetch.pqm#L145)
* [Usercube](../connectors/Usercube.md): [Usercube.m line 111](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Usercube.m#L111)
* [Warehouse](../connectors/Warehouse.md): [Table.NavigationTableView.pqm line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Table.NavigationTableView.pqm#L57), [Warehouse.pq line 344](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Warehouse.pq#L344), [WarehouseOutputInterceptor.pqm line 54](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/WarehouseOutputInterceptor.pqm#L54)
* [Viva Insights](../connectors/WorkplaceAnalytics.md): [WorkplaceAnalytics.pq line 573](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L573)

<!-- seen-in:end -->
