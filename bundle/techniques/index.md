# Techniques

Which archived connectors use each answer of the connector checklist (`knowledge/checklist.yaml`), with the first cited source line. **✓** marks hand-checked labels; the rest are model-generated profiles (about 95% exact against hand labels), so open the cited line before relying on one. This shows what certified connectors do, which is evidence rather than advice: Microsoft's guidance and the `write-connector` skill say what to do.

* [auth](auth.md): How does the connector authenticate? `anonymous` 8, `key` 33, `username-password` 48, `windows` 9, `oauth` 50, `aad` 32, `signed-request` 2
* [transport](transport.md): What does it use to reach the data source? `web-contents` 91, `odata-feed` 13, `odbc` 27, `adonet-oledb` 1, `sql-database` 8, `adbc-flight` 3, `other` 7
* [user-inputs](user-inputs.md): What does the user supply to connect? `url-or-server` 82, `database-or-resource-id` 46, `options-record` 46, `region-or-environment` 8, `date-range` 14, `none` 19, `other` 50
* [paging](paging.md): How does it page through results? `none` 83, `offset-limit` 14, `cursor-token` 13, `next-link-url` 16, `skip-token` 2, `graphql-cursor` 2, `other` 5
* [data-formats](data-formats.md): What data formats does it parse? `json` 93, `csv` 14, `xml` 1, `parquet` 4, `excel` 1, `binary-compressed` 2, `arrow` 3, `driver-rows` 38, `other` 6
* [schema](schema.md): How are column names and types set? `declared-schema` 57, `inferred-from-data` 63, `explicit-type-conversion` 57, `driver-provided` 55
* [http-errors](http-errors.md): How does it handle HTTP status codes and errors? `default` 68, `manual-status-handling` 64, `structured-error-records` 54, `retry-with-delay` 18, `rate-limit-aware` 6, `not-applicable` 32
* [documentation](documentation.md): What documentation metadata does it attach to its shared functions? `function-documentation` 113, `parameter-captions` 108, `parameter-descriptions` 92, `sample-values` 98, `allowed-values` 44, `none` 15
* [navigation](navigation.md): How is the navigation table built? `single-table` 12, `fixed-list` 37, `discovered-from-api` 93, `hierarchical` 71
* [test-connection](test-connection.md): How is TestConnection wired for gateway refresh? `dedicated-probe` 15, `reuses-entry-function` 117
* [folding](folding.md): Does it fold queries to the source, and how? `none` 67, `table-view-handlers` 18, `odbc-sql-capabilities` 27, `native-query` 10, `custom-sql-generator` 6, `odata-folding` 13, `source-function-folding` 12
* [packaging](packaging.md): How is the connector packaged? `single-file` 65, `pqm-modules` 65, `localized-strings` 124, `icons` 128, `beta-flag` 47
* [diagnostics](diagnostics.md): Does it emit diagnostics? `none` 90, `tracing-always` 20, `tracing-gated` 22
* [long-running](long-running.md): Does it run long-running operations? `none` 121, `async-export-polling` 7, `other` 4
* [writes](writes.md): Does it write data back to the source? `none` 130, `table-view-mutations` 2

## Not profiled

No profile yet (too large for the model, or rejected): [Fhir](../connectors/Fhir.md), [PowerPlatformDataflows](../connectors/PowerPlatformDataflows.md), [SiteImprove](../connectors/SiteImprove.md).
