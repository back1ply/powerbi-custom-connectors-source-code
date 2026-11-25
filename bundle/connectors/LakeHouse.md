---
type: Power Query Connector
title: Lakehouse
description: Import data from a Lakehouse
tags: [aad]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.267
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DeltaTableFastCopy.pqm
  title: DeltaTableFastCopy.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DualTable.View.pqm
  title: DualTable.View.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/FabricEnvironment.pqm
  title: FabricEnvironment.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq
  title: LakeHouse.pq
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/MDSync.pqm
  title: MDSync.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkCompute.pqm
  title: SparkCompute.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkComputeUtils.pqm
  title: SparkComputeUtils.pqm
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SqlGenerator.pqm
  title: SqlGenerator.pqm
- id: file-9
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SqlGeneratorCommon.pqm
  title: SqlGeneratorCommon.pqm
- id: file-10
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Table.NavigationTableView.pqm
  title: Table.NavigationTableView.pqm
- id: file-11
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-12
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/TypeInfo.pqm
  title: TypeInfo.pqm
- id: file-13
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Utils.pqm
  title: Utils.pqm
- id: file-14
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.DLP.pqm
  title: Workspace.DLP.pqm
- id: file-15
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.PrivateLink.pqm
  title: Workspace.PrivateLink.pqm
- id: file-16
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.pqm
  title: Workspace.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/LakeHouse/1.0.267/LakeHouse_1.0.267.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T20:59:46Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.267 | Aad |

# Source files

* [DeltaTableFastCopy.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DeltaTableFastCopy.pqm)
* [DualTable.View.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DualTable.View.pqm)
* [FabricEnvironment.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/FabricEnvironment.pqm)
* [LakeHouse.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq)
* [MDSync.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/MDSync.pqm)
* [SparkCompute.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkCompute.pqm)
* [SparkComputeUtils.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkComputeUtils.pqm)
* [SqlGenerator.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SqlGenerator.pqm)
* [SqlGeneratorCommon.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SqlGeneratorCommon.pqm)
* [Table.NavigationTableView.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Table.NavigationTableView.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Table.ToNavigationTable.pqm)
* [TypeInfo.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/TypeInfo.pqm)
* [Utils.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Utils.pqm)
* [Workspace.DLP.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.DLP.pqm)
* [Workspace.PrivateLink.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.PrivateLink.pqm)
* [Workspace.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.pqm)
