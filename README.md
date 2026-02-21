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
├── docs/                         # (Coming Soon) Guides analyzing specific patterns
│   └── authentication/           # OAuth2 vs API Key examples across connectors
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
