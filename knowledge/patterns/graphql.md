---
type: Power Query Pattern
title: GraphQL requests
description: GraphQL request bodies, cursors, and application errors.
category: Data retrieval
tags: [data-retrieval]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: [\bGetGraphQLPage\s*=]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L987
  title: CogniteDataSource/CogniteDataSource.pq
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:34:38Z'
review:
  content_sha256: c0ec1c7e760bdfd34d1b19db61846ea4984b6cce16f19db3f42130b8913fc664
  sources_sha256:
    example: b8f483ebbd8313de5e3934521cc9d417f1dede58321917bcd7fa883f0766f423
---

# Mechanism

Cognite's `GetGraphQLPage` accepts a query payload, variables record, and optional cursor. It reserves the `cursor` variable name, rejects a caller-supplied field with that name, and then adds its own cursor when needed. The request body is `Json.FromValue([query = payload, variables = variablesUpdated])`, with JSON content headers and manually handled HTTP statuses.[^example]

The function passes the request to `RetryWithExponentialBackoff`. On GraphQL-level retries it adds `IsRetry = true`. It also distinguishes HTTP status failures from a top-level GraphQL `errors` array, including the case where the HTTP response is 200 and a `data` field is present.[^example]

# Adaptation and failure paths

Inspect the application payload before reading nested data fields. This implementation raises an explicit GraphQL error rather than allowing a failed response to turn into a later field-access-on-null error. Its `dataRecord` check rejects a non-record data payload, and later code checks the queried field before extracting items.[^example]

Keep transport retries and GraphQL execution retries distinct when reviewing limits. A 200 response does not settle application-level success, while an `errors` array does not by itself establish that every error is transient. The source's chosen condition and retry budget should be reviewed with the target schema and service contract before reuse.[^example]

See [pagination](pagination.md), [retries](retry-polling.md), and [structured errors](errors.md).

# Examples

The following excerpt is copied from `CogniteDataSource/CogniteDataSource.pq`, lines 987–1019.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery
GetGraphQLPage = (url as text, payload as text, variables as record, optional cursor as text, optional retryAttempt as number) as table =>
    let
        // GraphQL-level retry counter for transient execution errors (see isTransientGraphQLError)
        attempt = if retryAttempt = null then 0 else retryAttempt,
        headers = [
            #"Content-Type" = "application/json",
            #"x-cdp-app" = "CogniteDataSourcePowerBIConnector:" & CogniteDefaults[Version]
        ],
        // Extract cluster from URL
        cluster = Text.BeforeDelimiter(Uri.Parts(url)[Host], "."),
        // cursor is a special variable and should not be included in the variables record
        validateVariables =
            if Record.HasFields(variables, "cursor") then
                error
                    Error.Record(
                        "CogniteConnectorError",
                        "'cursor' is a reserved variable name and cannot be included in the variables field."
                    )
            else
                variables,
        variablesUpdated = validateVariables & (if cursor <> null then [cursor = cursor] else []),
        // Status codes that won't raise an error automatically, so we can fetch the error message from the response
        statusToRaise = {400, 403, 408, 409, 429, 500, 502, 503, 504},
        postData = Json.FromValue([query = payload, variables = variablesUpdated]),
        request = [
            Headers = headers,
            Content = postData,
            ManualStatusHandling = statusToRaise
        ]
            // On GraphQL-level retries, bypass Power Query's HTTP response cache so the
            // request is actually re-issued instead of replaying the cached error response.
            & (if attempt > 0 then [IsRetry = true] else []),
        response = RetryWithExponentialBackoff(url, request, 0),
```

[^example]: CogniteDataSource/CogniteDataSource.pq; see the matching `sources` entry.
