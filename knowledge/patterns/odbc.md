---
type: Power Query Pattern
title: ODBC and DirectQuery configuration
description: ODBC capabilities and a separate DirectQuery declaration.
category: Query folding
tags: [query-folding]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: ['\bOdbc\.(?:DataSource|Query)\s*\(']
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/AmazonAthena.m#L122
  title: AmazonAthena/AmazonAthena.m
- id: directquery
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/MarkLogicODBC.m#L83
  title: MarkLogicODBC/MarkLogicODBC.m
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:34:39Z'
review:
  content_sha256: 1eaacaec2ca38a56626706fea5632b3d7082c0a7c1a14e48c64e74f61d6579b2
  sources_sha256:
    example: fe4d2fa4c6e8eb8778bc55737620f3fe827c84146e8a7c82f63b51ffcf6cb0b8
    directquery: 2d4e1443df32a7f24853d4afd67afaae87637e5146d5b6f4b08dd3e5bb200b27
---

# Mechanism

AmazonAthena calls `Odbc.DataSource` with a connection string and a substantial options record. The options shown include `HierarchicalNavigation = true`, `HideNativeQuery = true`, `ClientConnectionPooling = true`, and capability records. A `SQLColumns` callback maps FLOAT metadata to DOUBLE and rewrites the corresponding type name.[^example]

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
