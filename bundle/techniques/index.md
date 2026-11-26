# Techniques

Which archived connectors use each answer of the connector checklist (`knowledge/checklist.yaml`), with the first cited source line. **✓** marks hand-checked labels; the rest are model-generated profiles (about 95% exact against hand labels), so open the cited line before relying on one. This shows what certified connectors do, which is evidence rather than advice: Microsoft's guidance and the `write-connector` skill say what to do.

* [auth](auth.md): How does the connector authenticate? `anonymous` 7, `key` 32, `username-password` 46, `windows` 9, `oauth` 50, `aad` 31, `signed-request` 2
* [transport](transport.md): What does it use to reach the data source? `web-contents` 89, `odata-feed` 13, `odbc` 26, `adonet-oledb` 1, `sql-database` 8, `adbc-flight` 2, `other` 7
* [user-inputs](user-inputs.md): What does the user supply to connect? `url-or-server` 80, `database-or-resource-id` 44, `options-record` 44, `region-or-environment` 8, `date-range` 13, `none` 19, `other` 49
* [paging](paging.md): How does it page through results? `none` 82, `offset-limit` 14, `cursor-token` 13, `next-link-url` 16, `skip-token` 2, `graphql-cursor` 2, `other` 4
* [data-formats](data-formats.md): What data formats does it parse? `json` 92, `csv` 14, `xml` 1, `parquet` 4, `excel` 1, `binary-compressed` 2, `arrow` 2, `driver-rows` 37, `other` 6
* [schema](schema.md): How are column names and types set? `declared-schema` 55, `inferred-from-data` 63, `explicit-type-conversion` 55, `driver-provided` 54
* [http-errors](http-errors.md): How does it handle HTTP status codes and errors? `default` 67, `manual-status-handling` 63, `structured-error-records` 54, `retry-with-delay` 18, `rate-limit-aware` 6, `not-applicable` 32
* [documentation](documentation.md): What documentation metadata does it attach to its shared functions? `function-documentation` 111, `parameter-captions` 106, `parameter-descriptions` 90, `sample-values` 96, `allowed-values` 42, `none` 15
* [navigation](navigation.md): How is the navigation table built? `single-table` 12, `fixed-list` 36, `discovered-from-api` 91, `hierarchical` 69
* [test-connection](test-connection.md): How is TestConnection wired for gateway refresh? `dedicated-probe` 15, `reuses-entry-function` 115
* [folding](folding.md): Does it fold queries to the source, and how? `none` 66, `table-view-handlers` 17, `odbc-sql-capabilities` 26, `native-query` 9, `custom-sql-generator` 5, `odata-folding` 13, `source-function-folding` 12
* [packaging](packaging.md): How is the connector packaged? `single-file` 64, `pqm-modules` 64, `localized-strings` 122, `icons` 126, `beta-flag` 47
* [diagnostics](diagnostics.md): Does it emit diagnostics? `none` 90, `tracing-always` 18, `tracing-gated` 22
* [long-running](long-running.md): Does it run long-running operations? `none` 119, `async-export-polling` 7, `other` 4
* [writes](writes.md): Does it write data back to the source? `none` 128, `table-view-mutations` 2

## Not profiled

No profile yet (too large for the model, or rejected): [CCHTagetik](../connectors/CCHTagetik.md), [Dremio](../connectors/Dremio.md), [Fhir](../connectors/Fhir.md), [PowerPlatformDataflows](../connectors/PowerPlatformDataflows.md), [SiteImprove](../connectors/SiteImprove.md).
