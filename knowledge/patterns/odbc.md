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
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/AmazonAthena.m#L67
  title: AmazonAthena/AmazonAthena.m
- id: athena-connect
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/AmazonAthena.m#L123
  title: AmazonAthena/AmazonAthena.m
- id: athena-sqlcolumns
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/AmazonAthena.m#L145
  title: AmazonAthena/AmazonAthena.m
- id: athena-capabilities
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/AmazonAthena.m#L163
  title: AmazonAthena/AmazonAthena.m
- id: athena-ui
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/AmazonAthena.m#L240
  title: AmazonAthena/AmazonAthena.m
- id: variant
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/MarkLogicODBC.m#L303
  title: MarkLogicODBC/MarkLogicODBC.m
- id: directquery
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/MarkLogicODBC.m#L362
  title: MarkLogicODBC/MarkLogicODBC.m
- id: mlcreds
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/MarkLogicODBC.m#L132
  title: MarkLogicODBC/MarkLogicODBC.m
- id: mlcall
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/MarkLogicODBC.m#L315
  title: MarkLogicODBC/MarkLogicODBC.m
- id: mlbuild
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/MarkLogicODBC.m#L380
  title: MarkLogicODBC/MarkLogicODBC.m
review:
  content_sha256: 17cffa79c464e582e6896db644c83be9b1e9cb005e4b16daab0f33be0016a0cf
  sources_sha256:
    example: fe4d2fa4c6e8eb8778bc55737620f3fe827c84146e8a7c82f63b51ffcf6cb0b8
    athena-connect: fe4d2fa4c6e8eb8778bc55737620f3fe827c84146e8a7c82f63b51ffcf6cb0b8
    athena-sqlcolumns: fe4d2fa4c6e8eb8778bc55737620f3fe827c84146e8a7c82f63b51ffcf6cb0b8
    athena-capabilities: fe4d2fa4c6e8eb8778bc55737620f3fe827c84146e8a7c82f63b51ffcf6cb0b8
    athena-ui: fe4d2fa4c6e8eb8778bc55737620f3fe827c84146e8a7c82f63b51ffcf6cb0b8
    variant: 2d4e1443df32a7f24853d4afd67afaae87637e5146d5b6f4b08dd3e5bb200b27
    directquery: 2d4e1443df32a7f24853d4afd67afaae87637e5146d5b6f4b08dd3e5bb200b27
    mlcreds: 2d4e1443df32a7f24853d4afd67afaae87637e5146d5b6f4b08dd3e5bb200b27
    mlcall: 2d4e1443df32a7f24853d4afd67afaae87637e5146d5b6f4b08dd3e5bb200b27
    mlbuild: 2d4e1443df32a7f24853d4afd67afaae87637e5146d5b6f4b08dd3e5bb200b27
verified:
  by: claude/claude-haiku-5-5 + codex/gpt-6
  at: '2026-10-19T10:10:51Z'
---

# ODBC and DirectQuery configuration

## Mechanism

AmazonAthena calls `Odbc.DataSource` inside `Connect` (lines 123–205). The call passes a connection string, a record of options, and then merges in `Options`, which holds a JWT credential record only for OAuth (lines 57–66, line 205). The options set `HierarchicalNavigation = true` (line 127), `HideNativeQuery = true` (line 130), and `ClientConnectionPooling = true` (line 139), along with `SQLColumns`, `SqlCapabilities`, and `SQLGetInfo`.[^athena-connect]

The `SQLColumns` callback rewrites column metadata: `DATA_TYPE` 7 becomes 8, and `TYPE_NAME` "float" becomes "double". The local constants call those numeric values `OdbcSqlType.FLOAT` and `OdbcSqlType.DOUBLE`; those names are source labels, not a verified definition of the ODBC standard. The callback changes reported metadata rather than stored database values.[^athena-sqlcolumns]

The `SqlCapabilities` record (lines 163–202) declares `PrepareStatements = true` (line 166), `SupportsTop = false` (line 169), `LimitClauseKind.Limit` (line 172), and `Sql92Translation = "PassThrough"` (line 200). These are the connector's declared values. Check them against the driver's behavior rather than assuming that the driver supports them.[^athena-capabilities]

MarkLogicODBC is the contrasting connector. Its `Config_` constants at the top of the file drive `BuildOdbcConfig`. `Config_SupportsTop = false` (line 83), `Config_UseParameterBindings = true` (line 63), and `Config_EnableDirectQuery = true` (line 87) are the main ones. Its connection handler accepts only `UsernamePassword` and raises an error for any other authentication kind (lines 132–139).[^mlcreds]

`MarkLogicODBCImpl` calls `Odbc.DataSource` at lines 315–334. It passes `CredentialConnectionString`, `AstVisitor`, `SqlCapabilities`, `SQLColumns`, `SQLGetInfo`, and `SQLGetTypeInfo`. It does not pass `SQLGetFunctions`.[^mlcall]

## DirectQuery and adaptation

MarkLogicODBC declares DirectQuery in its publish record. `MarkLogicODBC.Publish` sets `SupportsDirectQuery = Config_EnableDirectQuery` (line 368), and the flag itself is set on line 87. Read the publish flag together with the `AstVisitor` and capability settings. This file does not show what the host checks beyond the flag, so the driver's DirectQuery support must be tested separately.[^directquery]

AmazonAthena declares DirectQuery separately. Its publish record sets `SupportsDirectQuery = true` (line 253). Each connector sets the flag in its own publish record. This file does not show how the host uses either one.[^athena-ui]

Keep driver identity, connection properties, credentials, SQL capabilities, and publish modes distinct during review. MarkLogic keeps its credentials in `CredentialConnectionString` rather than in the base connection string (lines 132–139, 315–334).[^mlcreds][^mlcall]

## Failure paths

Athena's `ValidateRole` raises `MissingRoleError` when the authentication kind is OAuth and no role is given (lines 73–80). MarkLogic raises an error for any authentication kind other than `UsernamePassword` (line 139). Test both before publishing.[^example][^mlcreds]

The source comment on lines 79–81 of MarkLogicODBC says that when `SupportsTop` is false, the `AstVisitor` `LimitClause` must be implemented. The visitor at lines 303–313 emits `LIMIT` and `OFFSET` text. Removing it while `SupportsTop` is false is a failure case the comment warns about.[^variant]

MarkLogic declares `Config_UseCastInsteadOfConvert = true` (line 77). `BuildOdbcConfig` writes `SQLGetFunctions` for that setting (lines 434–442), but `MarkLogicODBCImpl` reads only `SqlCapabilities` and `SQLGetInfo` from the built config (lines 146 and 153). Because `Odbc.DataSource` never receives `SQLGetFunctions`, the setting has no effect in this connector.[^mlbuild][^mlcall]

Trace capability records through every merge. `withEscape` stores `StringLiteralEscapeCharacters` inside `SqlCapabilities`. `withTop` merges that inner record with a new nested `SqlCapabilities` field, then merges the result into the outer config. M's [record-merge rule](https://learn.microsoft.com/en-us/powerquery-m/m-spec-operators#record-merge) takes the right-hand value for a duplicate field. The resulting nested capabilities contain `SupportsTop`; the escape setting has moved to the outer record and is not part of the `SqlCapabilities` forwarded to `Odbc.DataSource`. Test the emitted SQL before reusing this configuration.[^mlbuild][^mlcall]

Athena's callback affects every metadata row with `DATA_TYPE = 7` or `TYPE_NAME = "float"`. Test those reported types against actual values before copying this override to another driver.[^athena-sqlcolumns]

Adaptation checklist:

- Confirm the driver name, DSN or host, port, and authentication kind. Test each error branch.
- Confirm that each `Odbc.DataSource` option is one the driver honors. MarkLogic's unused `SQLGetFunctions` shows how an option can be present without effect.
- Hand-trace merged capability records, check the SQL the driver receives, and test `SQLColumns` changes against a column of each affected type.
- Publish DirectQuery only after testing the limit clause and capabilities. Athena and MarkLogic both set `HideNativeQuery = true`; SingleStore does not, so see [native queries](native-query.md) before enabling native SQL.

See also [Table.View](table-view.md).

## Examples

The first excerpt, copied from `AmazonAthena/AmazonAthena.m` lines 67–80, is a complete pair of helper bindings from `AthenaImpl`. `AddConnectionStringOption` adds an optional setting, and `ValidateRole` raises the missing-role error. The bindings are part of a larger `let` and are not a standalone connector.[^example]

<!-- source: example -->
```powerquery
        AddConnectionStringOption = (options as record, name as text, value as any) as record =>
            if value = null then
                options
            else
                Record.AddField(options, name, value),

        ValidateRole = (authKind as text, optional roleValue as any) as any =>
            if authKind = "OAuth" or authKind = "OAuth2" then
                if roleValue = null then
                    error Extension.LoadString("MissingRoleError")
                else
                    roleValue
            else
                roleValue,
```

The second excerpt, copied from `MarkLogicODBC/MarkLogicODBC.m` lines 303–313, is the contrasting `AstVisitor` record. It supplies the `LIMIT` and `OFFSET` text that the driver's TOP-less path needs. It is a complete record, and it is the implementation that the source comment requires when `SupportsTop` is false.[^variant]

<!-- source: variant -->
```powerquery
        AstVisitor = [
            LimitClause = (skip, take) =>
                let
                    offset = if (skip <> null and skip > 0) then Text.Format("OFFSET #{0}", {skip}) else "",
                    limit = if (take <> null) then Text.Format("LIMIT #{0}", {take}) else ""
                in
                    [
                        Text = Text.Format("#{0} #{1}", {limit, offset}),
                        Location = "AfterQuerySpecification"
                    ]
        ],
```

The third excerpt, copied from `MarkLogicODBC/MarkLogicODBC.m` lines 362–372, is the publish record. Its `SupportsDirectQuery` assignment is the declaration that the DirectQuery section describes.[^directquery]

<!-- source: directquery -->
```powerquery
MarkLogicODBC.Publish = [
    Beta = false,
    Category = "Database",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://powerbi.microsoft.com/",

    SupportsDirectQuery = Config_EnableDirectQuery,

    SourceImage = MarkLogicODBC.Icons,
    SourceTypeImage = MarkLogicODBC.Icons
];
```

[^example]: AmazonAthena/AmazonAthena.m lines 67–80: `AddConnectionStringOption` and `ValidateRole` inside `AthenaImpl`; `ValidateRole` raises `MissingRoleError` for OAuth without a role.
[^athena-connect]: AmazonAthena/AmazonAthena.m lines 123–205: `Connect` calls `Odbc.DataSource` with the connection string and options, then merges `Options`, which holds the JWT credential record for OAuth.
[^athena-sqlcolumns]: AmazonAthena/AmazonAthena.m lines 145–162: the `SQLColumns` callback maps FLOAT to DOUBLE for `DATA_TYPE` and `TYPE_NAME`.
[^athena-capabilities]: AmazonAthena/AmazonAthena.m lines 163–202: the `SqlCapabilities` record declares prepared statements, `SupportsTop = false`, the LIMIT clause kind, and pass-through SQL.
[^athena-ui]: AmazonAthena/AmazonAthena.m lines 240–273: `AmazonAthena.UI` sets `SupportsDirectQuery = true` (line 253).
[^mlcreds]: MarkLogicODBC/MarkLogicODBC.m lines 132–139: credentials are read from `Extension.CurrentCredential()`, only `UsernamePassword` is accepted, and any other kind raises an error.
[^mlcall]: MarkLogicODBC/MarkLogicODBC.m lines 315–334: `Odbc.DataSource` receives the credential connection string, `AstVisitor`, `SqlCapabilities`, `SQLColumns`, `SQLGetInfo`, and `SQLGetTypeInfo`, but not `SQLGetFunctions`.
[^variant]: MarkLogicODBC/MarkLogicODBC.m lines 303–313: the `AstVisitor` `LimitClause` emits LIMIT and OFFSET text, as the comment on lines 79–81 requires when `SupportsTop` is false.
[^directquery]: MarkLogicODBC/MarkLogicODBC.m lines 362–372: `MarkLogicODBC.Publish` sets `SupportsDirectQuery` to `Config_EnableDirectQuery`, which line 87 defines.
[^mlbuild]: MarkLogicODBC/MarkLogicODBC.m lines 380–459: `BuildOdbcConfig` builds `SqlCapabilities`, `SQLGetFunctions`, and `SQLGetInfo` in stages; the escape and TOP stages are at lines 410–431 and the cast stage at lines 433–444.
