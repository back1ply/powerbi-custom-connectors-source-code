# Power BI Custom Connectors: Source Code Archive

[![Power Query](https://img.shields.io/badge/Language-Power%20Query%20(M)-blue.svg)](https://learn.microsoft.com/en-us/powerquery-m/)
[![Power BI](https://img.shields.io/badge/Platform-Power%20BI-yellow.svg)](https://powerbi.microsoft.com/)

A comprehensive reference archive containing the extracted source code (`.m`, `.pq`, `.pqm`) for **124+ Microsoft-Certified Power BI Custom Connectors**. 

This repository is designed to be the ultimate GEO/SEO optimized reference guide for developers building their own Power Query / Power BI custom extensions. By analyzing the production-ready code in this repository, you can understand how major software companies handle complex data retrieval and authentication patterns.

## 🎯 Why does this exist?
Building a Custom Connector for Power BI using the [Power Query SDK](https://learn.microsoft.com/en-us/power-query/power-query-sdk) can be challenging, especially when dealing with complex authentication (OAuth2, Session Tokens, API Keys) or advanced data navigation. 

Instead of guessing how to implement these features, this repository allows you to study how real, Microsoft-certified connectors interact with their underlying APIs.

### What you can learn from this repo:
- **Authentication Patterns:** How to implement OAuth2 flows, handle API Keys, and manage persistent session tokens in `M`.
- **Navigation Tables:** How to structure `Table.ToNavigationTable` to provide a seamless user experience in the Power BI Navigator dialog.
- **Handling Pagination & Rate Limits:** Real-world examples of paginated API calls using `List.Generate` and `Web.Contents`.
- **Connector Metadata:** How to define `Extension.Contents` and `Publish` records for UI integration.

## 📂 Repository Structure

The raw `.mez` and `.pqx` files have been automatically unpacked using PowerShell. To reduce noise for developers (and AI assistants doing RAG/context injections), all UI files (`.png`, `.jpg`), localization strings (`.resx`), and packaging metadata (`.xml`) have been stripped out. 

**Only the high-value source code remains:**

```text
├── connectors/
│   ├── ADPAnalytics/             # Extracted ADP Connector
│   │   ├── ADPAnalytics.m        # Main Power Query M logic
│   │   └── Config.json           # Environment definitions (if applicable)
│   ├── Asana/                    # Extracted Asana Connector
│   │   ├── Asana.m               # OAuth2 and API retrieval logic
│   │   └── Table.ToNavigationTable.pqm 
│   ├── Databricks/
│   │   └── Databricks.m
│   └── ... (120+ more connectors)
│
├── docs/
│   ├── authentication/
│   │   ├── [oauth2_pattern.md](docs/authentication/oauth2_pattern.md)           # Boilerplate for OAuth2 StartLogin/FinishLogin
│   │   ├── [api_key_pattern.md](docs/authentication/api_key_pattern.md)         # Implementing Personal Access Tokens & Custom Headers
│   │   └── [basic_and_anonymous_pattern.md](docs/authentication/basic_and_anonymous_pattern.md) # Handling Username/Password, Windows, or Implicit APIs
│   │
│   └── patterns/
│       ├── [pagination_pattern.md](docs/patterns/pagination_pattern.md)         # How to handle API pagination using List.Generate
│       ├── [table_generatebypage_pattern.md](docs/patterns/table_generatebypage_pattern.md) # The ultimate pagination boilerplate (wrapping List.Generate)
│       ├── [navigation_table_pattern.md](docs/patterns/navigation_table_pattern.md) # Building nested folder UIs in Get Data
│       ├── [api_retries_pattern.md](docs/patterns/api_retries_pattern.md)       # Using Value.WaitFor to handle Rate Limiting (429s)
│       ├── [schema_enforcement_pattern.md](docs/patterns/schema_enforcement_pattern.md) # Enforcing types with Table.ChangeType
│       ├── [dynamic_data_source_pattern.md](docs/patterns/dynamic_data_source_pattern.md) # Avoiding Scheduled Refresh errors using RelativePath
│       ├── [diagnostics_tracing_pattern.md](docs/patterns/diagnostics_tracing_pattern.md) # Tracing errors with Diagnostics.pqm
│       ├── [multiple_environments_pattern.md](docs/patterns/multiple_environments_pattern.md) # Sandbox/Prod dropdowns with AllowedValues
│       ├── [test_connection_pattern.md](docs/patterns/test_connection_pattern.md)       # Enabling Scheduled Refresh on the Gateway
│       ├── [odbc_directquery_pattern.md](docs/patterns/odbc_directquery_pattern.md)     # Translating M to SQL for DirectQuery using AstVisitor
│       ├── [cursor_pagination_pattern.md](docs/patterns/cursor_pagination_pattern.md)   # Paginating without URLs using Limit/Offset
│       ├── [custom_headers_pattern.md](docs/patterns/custom_headers_pattern.md)         # Global User-Agent and nested generic headers
│       ├── [error_handling_pattern.md](docs/patterns/error_handling_pattern.md)         # Catching HTTP 400s using ManualStatusHandling
│       ├── [ui_customization_pattern.md](docs/patterns/ui_customization_pattern.md)     # Customizing categories and icons via the Publish record
│       ├── [localization_pattern.md](docs/patterns/localization_pattern.md)             # Bundling .resx files to translate UI strings globally
│       ├── [feature_switch_pattern.md](docs/patterns/feature_switch_pattern.md)         # Power Query Flighting A/B testing (Environment.FeatureSwitch)
│       ├── [enforced_api_delay_pattern.md](docs/patterns/enforced_api_delay_pattern.md) # Strict request throttling (Function.InvokeAfter)
│       ├── [caching_table_buffer_pattern.md](docs/patterns/caching_table_buffer_pattern.md) # In-memory optimization (Table.Buffer)
│       ├── [dynamic_data_privacy_pattern.md](docs/patterns/dynamic_data_privacy_pattern.md) # Bypassing Formula.Firewall with RelativePath
│       ├── [embedded_static_assets_pattern.md](docs/patterns/embedded_static_assets_pattern.md) # Bundling Extension.Contents(.json) into .mez files
│       ├── [type_imposition_pattern.md](docs/patterns/type_imposition_pattern.md)       # O(1) Schema Enforcement with Value.ReplaceType
│       ├── [error_record_pattern.md](docs/patterns/error_record_pattern.md)             # Structured Exception Handling with Error.Record
│       ├── [table_view_folding_pattern.md](docs/patterns/table_view_folding_pattern.md) # Building custom REST API Query Folding engines
│       ### 🔐 Authentication flows
│       ├── [oauth2_authorization_code_pattern.md](docs/patterns/oauth2_authorization_code_pattern.md) # Standard OAuth2 3-legged flow
│       ├── [oauth2_client_credentials_pattern.md](docs/patterns/oauth2_client_credentials_pattern.md) # System-to-system automated OAuth2 flow
│       ├── [oauth2_token_refresh_pattern.md](docs/patterns/oauth2_token_refresh_pattern.md) # Automatic access_token regeneration natively in M
│       ├── [api_key_auth_pattern.md](docs/patterns/api_key_auth_pattern.md)               # Key-based auth with Extension.CurrentCredential()
│       ├── [basic_auth_pattern.md](docs/patterns/basic_auth_pattern.md)                   # Base64-encoded Username:Password
│       ├── [privacy_credential_logging_pattern.md](docs/patterns/privacy_credential_logging_pattern.md) # Scrubbing secrets in Diagnostics
│       ├── [html_error_responses_pattern.md](docs/patterns/html_error_responses_pattern.md) # Catching 502 Bad Gateway HTML pages
│       ├── [graphql_api_pattern.md](docs/patterns/graphql_api_pattern.md)               # Handling POST GraphQL queries and variables
│       ├── [odata_integration_pattern.md](docs/patterns/odata_integration_pattern.md)   # Customizing OData.Feed + Web.Page Anti-Pattern
│       ├── [native_query_folding_pattern.md](docs/patterns/native_query_folding_pattern.md) # Passing raw SQL queries with Value.NativeQuery
│       ├── [code_modularity_hiding_pattern.md](docs/patterns/code_modularity_hiding_pattern.md) # Hiding code using Extension.Contents evaluation
│       ├── [crypto_hmac_signing_pattern.md](docs/patterns/crypto_hmac_signing_pattern.md) # Generating API Headers with Crypto.CreateHmac
│       ├── [table_navigation_metadata_pattern.md](docs/patterns/table_navigation_metadata_pattern.md) # Exposing data in the Get Data folder UI
│       ├── [navigation_table_simple_pattern.md](docs/patterns/navigation_table_simple_pattern.md) # Building Navigation Tables using the Type.AddTableKey helper
│       ├── [json_ndjson_parsing_pattern.md](docs/patterns/json_ndjson_parsing_pattern.md) # Parsing streaming payload lines with Lines.FromBinary
│       ├── [json_xml_parsing_pattern.md](docs/patterns/json_xml_parsing_pattern.md)       # Parsing JSON and XML REST API responses
│       └── [action_writeback_pattern.md](docs/patterns/action_writeback_pattern.md)     # Writing data to an API using Action.Sequence and Action.Return
│
└── scripts/                      # PowerShell utilities used to generate this archive
    ├── extract_connectors.ps1    # Unpacks .pqx and .mez zip archives
    ├── cleanup_noise.ps1         # Deletes .png, .resx, and packaging files
    └── list_extensions.ps1       # Tallies up file extension counts
```

## 🛠️ How this repo was generated

This repository relies on the Microsoft Power BI Desktop Store App installation wrapper, which locally caches the certified extensions. 
The files were sourced from:
`%LOCALAPPDATA%\Microsoft\Power BI Desktop Store App\CertifiedExtensions`

Our custom `extract_connectors.ps1` script unpacks the archives, and `cleanup_noise.ps1` removes over 2,700 localized `.resx` and UI `.png` files, leaving only 500+ `.pqm` and `.m` files comprising the core extension logic.

## ⚖️ License & Disclaimer

**Disclaimer:** This is an unofficial, community-driven archive created for educational, research, and development purposes.
- All extracted `.m`, `.pq`, and `.pqm` code, trademarks, and associated APIs remain the intellectual property (IP) of their respective copyright holders (Microsoft, Databricks, Asana, Zendesk, etc.).
- The PowerShell scripts and documentation contained in `scripts/` and `docs/` are provided as-is under the MIT License by the repository owner. 
- Please do not blindly copy and paste API keys, client IDs, or proprietary queries into your own commercial applications.
