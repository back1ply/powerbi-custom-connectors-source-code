---
type: Power Query Pattern
title: ODBC and DirectQuery configuration
description: ODBC capabilities and a separate DirectQuery declaration.
category: Query folding
tags: [query-folding]
status: draft
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:33:26Z'
detect: ['\bOdbc\.(?:DataSource|Query)\s*\(']
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/AmazonAthena.m#L122
  title: AmazonAthena/AmazonAthena.m
- id: directquery
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/MarkLogicODBC.m#L83
  title: MarkLogicODBC/MarkLogicODBC.m
---

**Draft: awaiting human review.**

# Mechanism

AmazonAthena calls `Odbc.DataSource` with a connection string and a substantial options record. The options shown include hierarchical navigation, hidden native-query UI, connection pooling, and capability records. A `SQLColumns` callback maps FLOAT metadata to DOUBLE and rewrites the corresponding type name.[^example]

Its `SqlCapabilities` record sets `PrepareStatements = true`, `SupportsTop = false`, and a LIMIT-clause kind. These are concrete declarations of this implementation's SQL behavior; an ODBC connection call on its own does not establish them.[^example]

# DirectQuery and adaptation

MarkLogicODBC demonstrates a separate publishing declaration: `Config_EnableDirectQuery = true` is assigned to `SupportsDirectQuery` in `MarkLogicODBC.Publish`. Read that declaration alongside its capability and AST visitor configuration before transferring DirectQuery behavior to another driver.[^directquery]

Keep driver identity, connection properties, credentials, SQL capabilities, and published modes distinct during review. The Actian [credential example](credentials.md) shows a separate credential connection-string record; it should not be replaced by literals in the ordinary connection string.

# Failure paths

Review capability overrides against the driver's actual behavior, including metadata conversions and row-limit syntax. The Athena callback transforms type metadata; it is not a general claim that every driver's FLOAT values should be rewritten. Reproduce the relevant query and driver behavior before expanding an override.[^example]

See [native queries](native-query.md) and [Table.View](table-view.md).

# Examples

The following excerpt is copied from `AmazonAthena/AmazonAthena.m`, lines 122–133.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery

         Connect = 
            Odbc.DataSource(ConnectionString, [
            // A logical value that sets whether to view the tables grouped by their schema names. 
            // When set to false, tables will be displayed in a flat list under each database.
            HierarchicalNavigation = true,
            // A logical value that controls whether your connector allows native SQL statements to 
            // be passed in by a query using the Value.NativeQuery() function.
            HideNativeQuery = true,
            // Allows conversion of numeric and text types to larger types if an operation would 
            // cause the value to fall out of range of the original type.
            TolerateConcatOverflow = true,
```

[^example]: AmazonAthena/AmazonAthena.m; see the matching `sources` entry.

[^directquery]: MarkLogicODBC/MarkLogicODBC.m; see the matching `sources` entry.

# Detection limits

The list below is generated from the `detect` expressions in this page. Detection reports the first matching line per source file, including matches in comments, strings, or helper definitions. Treat each result as a source-reading lead; it is not proof of runtime behavior or a complete implementation.

# Seen in

<!-- seen-in:start -->

Detected in **27** connectors in this archive.

* [Actian](../connectors/Actian.md): [Actian.m line 218](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Actian.m#L218)
* [AmazonAthena](../connectors/AmazonAthena.md): [AmazonAthena.m line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/AmazonAthena.m#L124)
* [Amazon OpenSearch Service](../connectors/AmazonOpenSearchService.md): [AmazonOpenSearchService.m line 154](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L154)
* [BIConnector](../connectors/BIConnector.md): [BIConnector.pq line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BIConnector/BIConnector.pq#L39)
* [ClickHouse](../connectors/ClickHouse.md): [ClickHouseConnector.pq line 367](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ClickHouse/ClickHouseConnector.pq#L367)
* [CosmosDB](../connectors/CosmosDB.md): [CosmosDB.m line 388](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CosmosDB/CosmosDB.m#L388)
* [Azure Databricks](../connectors/Databricks.md): [Databricks.pq line 591](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L591)
* [Data Virtuality LDW](../connectors/DataVirtuality.md): [DataVirtuality.m line 53](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DataVirtuality/DataVirtuality.m#L53)
* [Denodo](../connectors/Denodo.md): [DenodoForPowerBI.m line 209](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Denodo/DenodoForPowerBI.m#L209)
* [Dremio](../connectors/Dremio.md): [Dremio.pq line 904](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/Dremio.pq#L904)
* [Exact Online Premium](../connectors/ExactOnlinePremium.md): [ExactOnlinePremium.m line 108](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L108)
* [Exasol](../connectors/Exasol.md): [Exasol.pq line 113](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Exasol/Exasol.pq#L113)
* [Palantir Foundry Datasets](../connectors/Foundry.md): [Foundry.m line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Foundry/Foundry.m#L65)
* [Indexima](../connectors/Indexima.md): [Indexima.m line 249](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Indexima/Indexima.m#L249)
* [InterSystems Health Insight](../connectors/IntersystemsHealthInsight.md): [IntersystemsHealthInsight.pq line 137](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L137)
* [InterSystems IRIS](../connectors/IRIS.md): [Iris_PowerBI_Connector.m line 125](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/Iris_PowerBI_Connector.m#L125)
* [JethroDataConnector](../connectors/JethroData1.0.1.md): [JethroODBC.m line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JethroData1.0.1/JethroODBC.m#L38)
* [KylinDirectQuery](../connectors/Kyligence.md): [Kyligence.m line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kyligence/Kyligence.m#L44)
* [Kyvos ODBC](../connectors/KyvosODBC.md): [KyvosODBC.pq line 517](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/KyvosODBC.pq#L517)
* [MariaDB](../connectors/MariaDB.md): [MariaDB.m line 268](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MariaDB/MariaDB.m#L268)
* [MarkLogic](../connectors/MarkLogicODBC.md): [MarkLogicODBC.m line 315](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/MarkLogicODBC.m#L315)
* [MongoDB Atlas SQL](../connectors/MongoDBAtlasODBC.md): [MongoDBAtlasODBC.pq line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L47)
* [OpenSearch Project](../connectors/OpenSearchProject.md): [OpenSearchProject.m line 154](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OpenSearchProject/OpenSearchProject.m#L154)
* [QubolePresto](../connectors/QubolePresto.md): [QubolePresto.m line 190](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QubolePresto/QubolePresto.m#L190)
* [SingleStore Direct Query Connector](../connectors/SingleStoreODBC.md): [SingleStoreODBC.m line 308](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m#L308)
* [StarburstPresto](../connectors/StarburstPresto.md): [StarburstEnterprise.pq line 425](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/StarburstPresto/StarburstEnterprise.pq#L425)
* [TIBCO.ODBC.TDV](../connectors/TIBCO.md): [TIBCO.ODBC.TDV.m line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TIBCO/TIBCO.ODBC.TDV.m#L40)

<!-- seen-in:end -->
