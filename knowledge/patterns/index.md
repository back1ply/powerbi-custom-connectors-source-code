# Authentication

* [Credential access](credentials.md) - Authentication-kind dispatch and credential connection strings.
* [HMAC request signing](hmac.md) - HMAC request signing in extracted connector implementations.
* [OAuth2 login and token refresh](oauth2.md) - OAuth2 callbacks and refresh-token exchange.
* [PKCE and URL-safe encoding](pkce.md) - PKCE verifier transport, SHA-256, and URL-safe encoding.

# Data retrieval

* [Buffering tables, lists, and binaries](buffering.md) - Binary response snapshots and buffered configuration lists.
* [GraphQL requests](graphql.md) - GraphQL request bodies, cursors, and application errors.
* [OData feeds](odata.md) - Credential headers and explicit OData feed options.
* [Page generation and cursor traversal](pagination.md) - Cursor and offset pagination through table metadata.
* [Response and pagination metadata](response-metadata.md) - Pagination state versus HTTP response metadata.
* [Retries, delays, and polling](retry-polling.md) - Retry producers, page delays, and exhaustion behavior.
* [Web requests and relative paths](web-requests.md) - Web request options and explicit HTTP response branches.

# Query folding

* [Native queries](native-query.md) - Native-query interception and display-name handling.
* [ODBC and DirectQuery configuration](odbc.md) - ODBC capabilities and a separate DirectQuery declaration.
* [Table.View handlers](table-view.md) - Stateful Table.View handlers and request parameter generation.

# Schema and errors

* [Diagnostic tracing](diagnostics.md) - Tracing values while preserving return and error behavior.
* [Schema and type enforcement](schema.md) - Function metadata, returned table types, and dynamic expansion.
* [Structured errors and HTTP status handling](errors.md) - Explicit API errors and the limits of handled-status branches.

# Navigation and UI

* [Navigation tables and connection checks](navigation.md) - Navigation-column mappings and connection-test entry points.

# Packaging

* [Resources and modular source loading](packaging.md) - Configuration resources, localization calls, and extracted archives.

# Actions

* [Actions and table mutation handlers](actions.md) - Actions and table mutation handlers in extracted connector implementations.
