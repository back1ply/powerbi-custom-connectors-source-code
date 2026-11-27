# Topics

One topic per question of the connector checklist, in the order of the Power Query SDK concepts on Microsoft Learn. Each topic lists the pattern pages that explain it and which archived connectors use each answer.

## [Authentication](auth.md)

How does the connector authenticate? `anonymous` 8, `key` 33, `username-password` 48, `windows` 9, `oauth` 50, `aad` 33, `signed-request` 2

* [Credential access](../patterns/credentials.md) - Authentication-kind dispatch and credential connection strings.
* [HMAC request signing](../patterns/hmac.md) - HMAC request signing in extracted connector implementations.
* [OAuth2 login and token refresh](../patterns/oauth2.md) - OAuth2 callbacks and refresh-token exchange.
* [PKCE and URL-safe encoding](../patterns/pkce.md) - PKCE verifier transport, SHA-256, and URL-safe encoding.

## [Data access](transport.md)

What does it use to reach the data source? `web-contents` 92, `odata-feed` 13, `odbc` 27, `adonet-oledb` 2, `sql-database` 8, `adbc-flight` 3, `other` 8

* [GraphQL requests](../patterns/graphql.md) - GraphQL request bodies, cursors, and application errors.
* [OData feeds](../patterns/odata.md) - Credential headers and explicit OData feed options.
* [Web requests and relative paths](../patterns/web-requests.md) - Web request options and explicit HTTP response branches.

## [Resource path](user-inputs.md)

What does the user supply to connect? `url-or-server` 82, `database-or-resource-id` 46, `options-record` 47, `region-or-environment` 8, `date-range` 14, `none` 19, `other` 50

* [Date-range request filters](../patterns/date-filters.md) - Optional date bounds, request serialization, and validation before paging.
* [Function parameters and data-source identity](../patterns/parameter-metadata.md) - Typed exported functions, parameter documentation, and data-source path exclusions.

## [Paging](paging.md)

How does it page through results? `none` 83, `offset-limit` 14, `cursor-token` 14, `next-link-url` 16, `skip-token` 2, `graphql-cursor` 2, `other` 5

* [Page generation and cursor traversal](../patterns/pagination.md) - Cursor and offset pagination through table metadata.
* [Response and pagination metadata](../patterns/response-metadata.md) - Pagination state versus HTTP response metadata.

## [Transformations](data-formats.md)

What data formats does it parse? `json` 94, `csv` 15, `xml` 1, `parquet` 5, `excel` 1, `binary-compressed` 2, `arrow` 3, `driver-rows` 39, `other` 6

## [Schemas](schema.md)

How are column names and types set? `declared-schema` 58, `inferred-from-data` 63, `explicit-type-conversion` 58, `driver-provided` 55

* [Schema and type enforcement](../patterns/schema.md) - Function metadata, returned table types, and dynamic expansion.

## [Status codes and errors](http-errors.md)

How does it handle HTTP status codes and errors? `default` 69, `manual-status-handling` 65, `structured-error-records` 55, `retry-with-delay` 19, `rate-limit-aware` 6, `not-applicable` 32

* [Buffering tables, lists, and binaries](../patterns/buffering.md) - Binary response snapshots and buffered configuration lists.
* [Retries, delays, and polling](../patterns/retry-polling.md) - Retry producers, page delays, and exhaustion behavior.
* [Structured errors and HTTP status handling](../patterns/errors.md) - Explicit API errors and the limits of handled-status branches.

## [Documentation](documentation.md)

What documentation metadata does it attach to its shared functions? `function-documentation` 114, `parameter-captions` 108, `parameter-descriptions` 92, `sample-values` 98, `allowed-values` 44, `none` 15

## [Navigation tables](navigation.md)

How is the navigation table built? `single-table` 12, `fixed-list` 38, `discovered-from-api` 94, `hierarchical` 72

* [Navigation tables and connection checks](../patterns/navigation.md) - Navigation-column mappings and connection-test entry points.

## [Gateway and TestConnection](test-connection.md)

How is TestConnection wired for gateway refresh? `dedicated-probe` 16, `reuses-entry-function` 117

## [Query folding](folding.md)

Does it fold queries to the source, and how? `none` 67, `table-view-handlers` 19, `odbc-sql-capabilities` 27, `native-query` 11, `custom-sql-generator` 7, `odata-folding` 13, `source-function-folding` 13

* [Native queries](../patterns/native-query.md) - Native-query interception and display-name handling.
* [ODBC and DirectQuery configuration](../patterns/odbc.md) - ODBC capabilities and a separate DirectQuery declaration.
* [Table.View handlers](../patterns/table-view.md) - Stateful Table.View handlers and request parameter generation.

## [Packaging](packaging.md)

How is the connector packaged? `single-file` 65, `pqm-modules` 66, `localized-strings` 125, `icons` 129, `beta-flag` 47

* [Resources and modular source loading](../patterns/packaging.md) - Configuration resources, localization calls, and extracted archives.

## [Diagnostics](diagnostics.md)

Does it emit diagnostics? `none` 90, `tracing-always` 21, `tracing-gated` 22

* [Diagnostic tracing](../patterns/diagnostics.md) - Tracing values while preserving return and error behavior.

## [Long-running operations](long-running.md)

Does it run long-running operations? `none` 122, `async-export-polling` 7, `other` 4

* [Asynchronous exports and result downloads](../patterns/async-exports.md) - Starting export tasks, polling state, and assembling chunked results.

## [Writes](writes.md)

Does it write data back to the source? `none` 131, `table-view-mutations` 2

* [Actions and table mutation handlers](../patterns/actions.md) - Actions and table mutation handlers in extracted connector implementations.

## Not profiled

No profile yet (too large for the model, or rejected): [Fhir](../connectors/Fhir.md), [SiteImprove](../connectors/SiteImprove.md).
