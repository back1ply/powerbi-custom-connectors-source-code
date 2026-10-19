---
type: Power Query Pattern
title: OData feeds
description: Credential headers and explicit OData feed options.
category: Data retrieval
tags: [data-retrieval]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: [\bOData\.Feed\s*\(]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AptixInsights/AptixInsights.pq#L37
  title: AptixInsights/AptixInsights.pq
- id: helper
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AptixInsights/AptixInsights.pq#L11
  title: AptixInsights/AptixInsights.pq
- id: registration
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AptixInsights/AptixInsights.pq#L55
  title: AptixInsights/AptixInsights.pq
- id: variant
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneV2/IntuneV2.pq#L33
  title: IntuneV2/IntuneV2.pq
- id: intuneAuth
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneV2/IntuneV2.pq#L62
  title: IntuneV2/IntuneV2.pq
review:
  content_sha256: e02fccb818c74e5870a40bb1f0d652557703d3b15796611839e3f5955e5c8c86
  sources_sha256:
    example: 6a7c94fb9ba68a34571e7d750093b679be8070224209a7a323728194b1b3bb75
    helper: 6a7c94fb9ba68a34571e7d750093b679be8070224209a7a323728194b1b3bb75
    registration: 6a7c94fb9ba68a34571e7d750093b679be8070224209a7a323728194b1b3bb75
    variant: 3eca7d49bdeab3eaba6e6e0e7bc46c654db5c72d722b220ff571263987d8fcd8
    intuneAuth: 3eca7d49bdeab3eaba6e6e0e7bc46c654db5c72d722b220ff571263987d8fcd8
verified:
  by: claude/claude-haiku-5-5 + codex/gpt-6
  at: '2026-10-19T10:10:51Z'
---

# OData feeds

## Mechanism

`AptixInsightsImpl` (lines 37–52) reads the credential's `Key` and builds `Authorization: Bearer <key>` (lines 39–41). It then calls `OData.Feed` with that header and a service-options record. The options are `Implementation = "2.0"`, `MoreColumns = true`, `ODataVersion = 4`, and `Query`, which is `[]` when no query is given (lines 42–47, 50).[^example]

`ValidateUrlScheme` raises `Url scheme must be HTTPS` for other schemes and is used before the feed call. The connector declares `Key` authentication, and `TestConnection` reads `url` from the JSON data-source path. Its comment calls the credential a JWT key: a token supplied through a Key credential can still be forwarded as a bearer value. The registration and token format describe different aspects of authentication.[^helper][^registration][^example]

`IntuneV2DwImpl` (lines 33–59) builds the feed differently. It reads `api-version` from the URI query with a default of `v1.0` (lines 36–38). It requires an `https://` URI with a Microsoft manage host suffix (lines 41–45). It passes `null` headers, and its `Query` option carries `MaxHistoryDays` and `api-version` (lines 52–56). The feed is returned only when the check passes; otherwise the function raises an error (lines 58–59).[^variant]

IntuneV2's authentication is an AAD declaration, not a header. `IntuneV2` declares `Aad` with an authorization URI and a resource (lines 62–70), and the function sets no `Authorization` header.[^intuneAuth] This source does not show how the engine supplies that credential to the OData requests.

Neither source adds a retry loop or a manual pagination callback. Continuation and transport handling are left to `OData.Feed` and the engine. Do not infer that behavior from the [retry](retry-polling.md) or [pagination](pagination.md) patterns.[^example][^variant]

## Selection and dependencies

Use `OData.Feed` when the service publishes an OData endpoint and the table shape comes from its metadata. The inputs are the URL, an optional query record, and the credential. The output is the feed table. The dependencies are the URL check, the credential shape, the key name that `TestConnection` reads, and the options the service version accepts (`Implementation`, `ODataVersion`).

Choose an explicit bearer header, as Aptix does, when the connector must control the token value. Choose an AAD declaration, as IntuneV2 does, when the engine should handle sign-in. IntuneV2's check is stricter: it validates the host suffix, not only the scheme. For a non-OData API, see [web requests](web-requests.md). For connection tests, see [navigation](navigation.md). For credentials, see [credential access](credentials.md).

## Adaptation and failure paths

Trace the URL, query, headers, and connection-test argument together. Copying only `OData.Feed(url)` drops the options and the bearer header. The Aptix options are observed values for that service, not defaults to copy.[^example]

Check the query type. Aptix declares `query` as `any` (line 37), and `Query = if query = null then [] else query` passes whatever arrives (line 46). The source does not validate its type, so a non-record value reaches `OData.Feed`.[^example]

Read `ValidateUrlScheme` and the feed's own errors before you add a catch-all fallback. Aptix's check raises a text error for non-HTTPS URLs (line 13). IntuneV2 uses `feed` only in its `then` branch (line 58), so an invalid URI takes the configured error branch.[^helper][^variant] Keep that order if you add checks.

The connection-test key names differ. Aptix reads `url` (line 57), and IntuneV2 reads `dataWarehouseAsuUri` (line 63). A data-source path saved under one name does not test with the other.[^registration][^intuneAuth]

## Validation checklist

- Choose an explicit header or an AAD declaration, and confirm which one the target service needs.
- Validate the scheme and host before the feed. Use IntuneV2's host check when the service has a fixed domain.
- Keep `Implementation`, `ODataVersion`, `MoreColumns`, and `Query` as a set, and confirm each one against the service.
- Confirm that the key `TestConnection` reads matches the key in the saved data-source path.
- Distinguish the credential kind, token format, and header construction when documenting authentication.

## Examples

Feed builder, AptixInsights lines 37–52:

<!-- source: example -->
```powerquery
AptixInsightsImpl = (url as text, optional query as any) =>
    let
        credential = Extension.CurrentCredential(),
        token = credential[Key],
        headers = [Authorization = "Bearer " & token],
        serviceOptions = [
            Implementation = "2.0",
            MoreColumns = true,
            ODataVersion = 4,
            Query = if query = null then [] else query
        ],
        //add the query string record option
        url = ValidateUrlScheme(url),
        source = OData.Feed(url, headers, serviceOptions)
    in
        source;
```

Scheme check, AptixInsights lines 11–15:

<!-- source: helper -->
```powerquery
ValidateUrlScheme = (url as text) as text =>
    if (Uri.Parts(url)[Scheme] <> "https") then
        error "Url scheme must be HTTPS"
    else
        url;
```

Connector record, AptixInsights lines 55–62:

<!-- source: registration -->
```powerquery
AptixInsights = [
    // enable JWT Key based auth
    TestConnection = (dataSourcePath) => {"AptixInsights.Feed", Json.Document(dataSourcePath)[url]},
    Authentication = [
        Key = []
    ],
    Label = Extension.LoadString("DataSourceLabel")
];
```

Feed with a host check, IntuneV2 lines 33–59:

<!-- source: variant -->
```powerquery
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
```

[^example]: AptixInsights/AptixInsights.pq lines 37–52 (`AptixInsightsImpl`): bearer header (lines 39–41), service options (lines 42–47), the scheme check call (line 49), and `OData.Feed` (line 50). The `query` parameter is declared `any` (line 37).
[^helper]: AptixInsights/AptixInsights.pq lines 11–15 (`ValidateUrlScheme`): raises `Url scheme must be HTTPS` for any non-https scheme.
[^registration]: AptixInsights/AptixInsights.pq lines 55–62: `Key = []` authentication (lines 58–60), `TestConnection` reading `url` from the JSON data-source path (line 57), and the comment on line 56.
[^variant]: IntuneV2/IntuneV2.pq lines 33–59 (`IntuneV2DwImpl`): `api-version` default (lines 36–38), URI checks (lines 41–45), the `maxHistoryDays` default (line 49), the `null`-header feed call (line 56), and the conditional return (lines 58–59).
[^intuneAuth]: IntuneV2/IntuneV2.pq lines 62–70: `Aad` authentication with `AuthorizationUri` and `Resource`, and `TestConnection` reading `dataWarehouseAsuUri` (line 63).
