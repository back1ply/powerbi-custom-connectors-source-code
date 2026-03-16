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
│   │   ├── [api_key_pattern.md](docs/authentication/api_key_pattern.md)                         # Extension.CurrentCredential() and header injection
│   │   ├── [basic_and_anonymous_pattern.md](docs/authentication/basic_and_anonymous_pattern.md) # Handling Windows, Username/Password, and Implicit auth
│   │   └── [oauth2_pattern.md](docs/authentication/oauth2_pattern.md)                           # StartLogin and FinishLogin authorization code flows
│   │
│   └── patterns/
│       ### 🏗️ Data Retrieval & API Mechanics
│       ├── [api_retries_pattern.md](docs/patterns/api_retries_pattern.md)                       # Value.WaitFor rate limit handling (429s)
│       ├── [caching_table_buffer_pattern.md](docs/patterns/caching_table_buffer_pattern.md)     # In-memory execution pinning (Table.Buffer)
│       ├── [cursor_pagination_pattern.md](docs/patterns/cursor_pagination_pattern.md)           # Page token API limits/offsets
│       ├── [custom_headers_pattern.md](docs/patterns/custom_headers_pattern.md)                 # Global User-Agent and nested headers
│       ├── [enforced_api_delay_pattern.md](docs/patterns/enforced_api_delay_pattern.md)         # Strict request throttling (Function.InvokeAfter)
│       ├── [graphql_api_pattern.md](docs/patterns/graphql_api_pattern.md)                       # Interacting with GraphQL POST queries
│       ├── [json_ndjson_parsing_pattern.md](docs/patterns/json_ndjson_parsing_pattern.md)       # Parsing streaming JSON Lines (Lines.FromBinary)
│       ├── [odata_integration_pattern.md](docs/patterns/odata_integration_pattern.md)           # Extending Microsoft's native OData.Feed
│       ├── [pagination_pattern.md](docs/patterns/pagination_pattern.md)                         # Core List.Generate offset navigation
│       ├── [table_generatebypage_pattern.md](docs/patterns/table_generatebypage_pattern.md)     # Microsoft's "Table.GenerateByPage" boilerplate
│       ├── [web_contents_isretry_pattern.md](docs/patterns/web_contents_isretry_pattern.md)     # Bypassing the Web.Contents internal cache
│       ### 🛡️ Schema, Security & Infrastructure
│       ├── [crypto_hmac_signing_pattern.md](docs/patterns/crypto_hmac_signing_pattern.md)       # HMAC header generation for Custom APIs
│       ├── [diagnostics_tracing_pattern.md](docs/patterns/diagnostics_tracing_pattern.md)       # Custom telemetry with Diagnostics.Trace
│       ├── [dynamic_data_privacy_pattern.md](docs/patterns/dynamic_data_privacy_pattern.md)     # Resolving Formula.Firewall collisions
│       ├── [dynamic_data_source_pattern.md](docs/patterns/dynamic_data_source_pattern.md)       # RelativePath caching rules for Gateway refresh
│       ├── [error_handling_pattern.md](docs/patterns/error_handling_pattern.md)                 # ManualStatusHandling HTTP overrides
│       ├── [error_record_pattern.md](docs/patterns/error_record_pattern.md)                     # Structured exceptions with Error.Record
│       ├── [html_error_responses_pattern.md](docs/patterns/html_error_responses_pattern.md)     # Catching 502 Bad Gateway proxy responses
│       ├── [multiple_environments_pattern.md](docs/patterns/multiple_environments_pattern.md)   # UI Dropdown configurations (AllowedValues)
│       ├── [privacy_credential_logging_pattern.md](docs/patterns/privacy_credential_logging_pattern.md) # Masking secrets in log output
│       ├── [schema_enforcement_pattern.md](docs/patterns/schema_enforcement_pattern.md)         # Enforcing column types with Table.ChangeType
│       ├── [test_connection_pattern.md](docs/patterns/test_connection_pattern.md)               # TestConnection handlers for Power BI Service
│       ├── [type_imposition_pattern.md](docs/patterns/type_imposition_pattern.md)               # Deep schema enforcement with Value.ReplaceType
│       ### 🧩 UI, Navigation & Packaging
│       ├── [binary_decompression_pattern.md](docs/patterns/binary_decompression_pattern.md)     # Native GZIP/Deflate extraction (Binary.Decompress)
│       ├── [binary_image_data_uri_pattern.md](docs/patterns/binary_image_data_uri_pattern.md)   # Rendering authenticated API images via Base64
│       ├── [code_modularity_hiding_pattern.md](docs/patterns/code_modularity_hiding_pattern.md) # Separating logic using Extension.Contents evaluation
│       ├── [embedded_static_assets_pattern.md](docs/patterns/embedded_static_assets_pattern.md) # Bundling static JSON datasets inside .mez files
│       ├── [feature_switch_pattern.md](docs/patterns/feature_switch_pattern.md)                 # Environment.FeatureSwitch A/B testing
│       ├── [localization_pattern.md](docs/patterns/localization_pattern.md)                     # Global UI translation with resources.resx
│       ├── [navigation_table_pattern.md](docs/patterns/navigation_table_pattern.md)             # Hierarchical folder structures in Get Data
│       ├── [navigation_table_simple_pattern.md](docs/patterns/navigation_table_simple_pattern.md) # Flat folder mappings with Type.AddTableKey
│       ├── [ui_customization_pattern.md](docs/patterns/ui_customization_pattern.md)             # Customizing icons and branding variants
│       ### 🚀 Action & Backend Delegation
│       ├── [action_writeback_pattern.md](docs/patterns/action_writeback_pattern.md)             # Constructing PowerApps-compatible Action pipelines
│       ├── [direct_query_support_pattern.md](docs/patterns/direct_query_support_pattern.md)     # Core DirectQuery flag activation
│       ├── [native_query_folding_pattern.md](docs/patterns/native_query_folding_pattern.md)     # Injecting raw SQL via Value.NativeQuery
│       ├── [odbc_directquery_pattern.md](docs/patterns/odbc_directquery_pattern.md)             # AstVisitor parsing for ODBC command trees
│       ├── [table_action_mutations_pattern.md](docs/patterns/table_action_mutations_pattern.md) # Overriding Table.View for Power Automate Writeback
│       ├── [table_view_folding_handlers_pattern.md](docs/patterns/table_view_folding_handlers_pattern.md) # Implementing OnSkip/OnTake Server-Side
│       ├── [table_view_folding_pattern.md](docs/patterns/table_view_folding_pattern.md)         # General REST API Query Folding with Table.View
│       ### 🔒 OAuth2 Advanced Enhancements
│       ├── [oauth2_pkce_pattern.md](docs/patterns/oauth2_pkce_pattern.md)                       # PKCE Cryptographic code challenges
│       ├── [oauth2_token_expiration_pattern.md](docs/patterns/oauth2_token_expiration_pattern.md) # Handling non-standard expires_in formats
│       └── [oauth2_token_refresh_pattern.md](docs/patterns/oauth2_token_refresh_pattern.md)     # Token regeneration flow in Power Service
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
