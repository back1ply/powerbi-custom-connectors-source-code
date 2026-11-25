---
type: Power Query Connector
title: Azure Databricks
description: Import data from Azure Databricks
tags: [aad, credentials, diagnostics, errors, key, oauth, oauth2, odbc, packaging, parameter-metadata, pkce, table-view, usernamepassword]
x-pqkb-publisher: Databricks
x-pqkb-version: 2.0.34
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/AdvancedOptions.pqm
  title: AdvancedOptions.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq
  title: Databricks.pq
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/OdbcConstants.pqm
  title: OdbcConstants.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/QueryHelpers.pqm
  title: QueryHelpers.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/QueryTagsHelper.pqm
  title: QueryTagsHelper.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Databricks/2.0.34/Databricks_2.0.34.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T11:49:44Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Databricks | 2.0.34 | Aad, Key, OAuth, UsernamePassword |

# Source files

* [AdvancedOptions.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/AdvancedOptions.pqm)
* [Databricks.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/OdbcConstants.pqm)
* [QueryHelpers.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/QueryHelpers.pqm)
* [QueryTagsHelper.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/QueryTagsHelper.pqm)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Uncertain match (older review)**
    * [Databricks.pq line 1708](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L1708) — `nonFoldable = Table.Buffer(directResult)`
* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [AdvancedOptions.pqm line 108](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/AdvancedOptions.pqm#L108) — `enabledFlagsList = Table.TransformRows(flagDefinitions, each if Record.FieldOrDefault(options, [Key], false) then [ExpandedFlags] else []),`
    * [Databricks.pq line 283](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L283) — `Credential = Extension.CurrentCredential(),`
    * [Databricks.pq line 284](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L284) — `AuthenticationMode = Credential[AuthenticationKind],`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Databricks.pq line 164](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L164) — `tracedOptions = Diagnostics.Trace(`
    * [Databricks.pq line 165](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L165) — `TraceLevel.Information, [`
    * [Diagnostics.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Diagnostics.pqm#L19) — `Diagnostics.LogValue = (prefix, value, result, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & Value.ToText(value), result, delayed),`
    * [Diagnostics.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Diagnostics.pqm#L19) — `Diagnostics.LogValue = (prefix, value, result, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & Value.ToText(value), result, delayed),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Databricks.pq line 59](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L59) — `Documentation.FieldCaption = Extension.LoadString("ServerHostNameLabel"),`
    * [Databricks.pq line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L22) — `shared Databricks.Catalogs = Value.ReplaceType(DatabricksCatalogsImpl, AzureDatabricksType);`
    * [Databricks.pq line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L57) — `type function (`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [Databricks.pq line 951](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L951) — `OAuth =  [`
    * [Databricks.pq line 952](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L952) — `StartLogin = OidcStartLogin,`
    * [Databricks.pq line 953](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L953) — `FinishLogin = OidcFinishLogin,`
    * [Databricks.pq line 1184](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L1184) — `grant_type = "authorization_code",`
    * [Databricks.pq line 763](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L763) — `endpointResponse = Web.Contents(url, [`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [Databricks.pq line 591](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L591) — `Databases = Odbc.DataSource(ConnectionString & ProxyOptions, Options & CommonOptions & AstOptions & DataSourceOptions),`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [Databricks.pq line 1162](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L1162) — `code_challenge = codeChallenge,`
    * [Databricks.pq line 1186](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L1186) — `code_verifier = codeVerifier,`
    * [Databricks.pq line 1150](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L1150) — `codeChallenge = Base64UrlEncode(Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(codeVerifier, TextEncoding.Ascii))),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [AdvancedOptions.pqm line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/AdvancedOptions.pqm#L28) — `error Error.Record("Expression.Error", Extension.LoadString("MetricViewBICompatibilityModeDisabled"))`
    * [Databricks.pq line 43](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L43) — `loadString = (stringName as text, isMultiCloud as logical) => if isMultiCloud then Extension.LoadString("MultiCloud" & stringName) else Extension.LoadString(stringName);`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Uncertain match (older review)**
    * [Databricks.pq line 593](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L593) — `Metadata = Value.Metadata(Value.Type(Databases)),`
    * [Databricks.pq line 768](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L768) — `if (List.Contains(responseCodes, Value.Metadata(endpointResponse)[Response.Status]?)) then`
    * [Diagnostics.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Diagnostics.pqm#L8) — `else if value is function then Record.FieldOrDefault(Value.Metadata(Value.Type(value)), "Documentation.Name", "<function>")`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [Databricks.pq line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L22) — `shared Databricks.Catalogs = Value.ReplaceType(DatabricksCatalogsImpl, AzureDatabricksType);`
    * [Databricks.pq line 1246](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L1246) — `[Catalog = DefaultCatalog, Schema = DefaultSchema];`
    * [Diagnostics.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Diagnostics.pqm#L14) — `else if value is type then List.First(Table.Schema(#table({"type"}, {{value}}))[TypeName], "<type>")`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [AdvancedOptions.pqm line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/AdvancedOptions.pqm#L11) — `error Error.Record("Expression.Error"),`
    * [AdvancedOptions.pqm line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/AdvancedOptions.pqm#L11) — `error Error.Record("Expression.Error"),`
    * [Databricks.pq line 247](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L247) — `error Error.Record("DataSource.Error", Extension.LoadString("ErrorExpectedSqlString"))`
    * [Databricks.pq line 247](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L247) — `error Error.Record("DataSource.Error", Extension.LoadString("ErrorExpectedSqlString"))`
    * [Diagnostics.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Diagnostics.pqm#L18) — `try result otherwise "<error>",`
    * [QueryTagsHelper.pqm line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/QueryTagsHelper.pqm#L25) — `parsed = try Json.Document(record) otherwise null`
* [Table.View handlers](../patterns/table-view.md)
  * **Match from a review of older source**
    * [Databricks.pq line 1367](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L1367) — `Table.View(null, [`
    * [Databricks.pq line 1368](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L1368) — `GetType = () => resultType,`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Uncertain match (older review)**
    * [Databricks.pq line 763](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L763) — `endpointResponse = Web.Contents(url, [`
