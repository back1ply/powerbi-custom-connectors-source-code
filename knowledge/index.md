---
okf_version: "0.2"
---

# Authentication

* [Credential access](patterns/credentials.md) - Authentication-kind dispatch and credential connection strings.
* [HMAC request signing](patterns/hmac.md) - HMAC request signing in extracted connector implementations.
* [OAuth2 login and token refresh](patterns/oauth2.md) - OAuth2 callbacks and refresh-token exchange.
* [PKCE and URL-safe encoding](patterns/pkce.md) - PKCE verifier transport, SHA-256, and URL-safe encoding.

# Data retrieval

* [Buffering tables, lists, and binaries](patterns/buffering.md) - Binary response snapshots and buffered configuration lists.
* [GraphQL requests](patterns/graphql.md) - GraphQL request bodies, cursors, and application errors.
* [OData feeds](patterns/odata.md) - Credential headers and explicit OData feed options.
* [Page generation and cursor traversal](patterns/pagination.md) - Cursor and offset pagination through table metadata.
* [Response and pagination metadata](patterns/response-metadata.md) - Pagination state versus HTTP response metadata.
* [Retries, delays, and polling](patterns/retry-polling.md) - Retry producers, page delays, and exhaustion behavior.
* [Web requests and relative paths](patterns/web-requests.md) - Web request options and explicit HTTP response branches.

# Query folding

* [Native queries](patterns/native-query.md) - Native-query interception and display-name handling.
* [ODBC and DirectQuery configuration](patterns/odbc.md) - ODBC capabilities and a separate DirectQuery declaration.
* [Table.View handlers](patterns/table-view.md) - Stateful Table.View handlers and request parameter generation.

# Schema and errors

* [Diagnostic tracing](patterns/diagnostics.md) - Tracing values while preserving return and error behavior.
* [Schema and type enforcement](patterns/schema.md) - Function metadata, returned table types, and dynamic expansion.
* [Structured errors and HTTP status handling](patterns/errors.md) - Explicit API errors and the limits of handled-status branches.

# Navigation and UI

* [Navigation tables and connection checks](patterns/navigation.md) - Navigation-column mappings and connection-test entry points.

# Packaging

* [Resources and modular source loading](patterns/packaging.md) - Configuration resources, localization calls, and extracted archives.

# Actions

* [Actions and table mutation handlers](patterns/actions.md) - Actions and table mutation handlers in extracted connector implementations.

# Archive

* [Connectors](connectors/index.md) - All 133 connectors in the archive, their files and detected patterns.
* [Connector tags](tags/index.md) - Browse authentication kinds and detected patterns.
* [Refresh log](log.md) - Successful refreshes, verification checks, and package changes.
