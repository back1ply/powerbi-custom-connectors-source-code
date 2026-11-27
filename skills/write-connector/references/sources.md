# Sources

Official guidance first. All Learn links are under
`https://learn.microsoft.com/en-us/power-query/`; they were checked live on 2026-11-26.

## Power Query SDK (live)

| Step | Pages |
| --- | --- |
| Setup | [install-sdk](https://learn.microsoft.com/en-us/power-query/install-sdk), [power-query-sdk-vs-code](https://learn.microsoft.com/en-us/power-query/power-query-sdk-vs-code), [creating-first-connector](https://learn.microsoft.com/en-us/power-query/creating-first-connector), [additional-connector-functionality](https://learn.microsoft.com/en-us/power-query/additional-connector-functionality) |
| Whole build, in order | TripPin tutorial: [readme](https://learn.microsoft.com/en-us/power-query/samples/trippin/readme), parts 1 (OData) to 10 (folding); OAuth: [GitHub sample](https://learn.microsoft.com/en-us/power-query/samples/github/readme); [samples-directory](https://learn.microsoft.com/en-us/power-query/samples-directory) |
| Authentication | [handling-authentication](https://learn.microsoft.com/en-us/power-query/handling-authentication), [configure-microsoft-entra-for-connector](https://learn.microsoft.com/en-us/power-query/configure-microsoft-entra-for-connector), [connector-authentication](https://learn.microsoft.com/en-us/power-query/connector-authentication) |
| Data source path | [handling-resource-path](https://learn.microsoft.com/en-us/power-query/handling-resource-path), [TripPin 4](https://learn.microsoft.com/en-us/power-query/samples/trippin/4-paths/readme) |
| Data access, kind and Publish records | [handling-data-access](https://learn.microsoft.com/en-us/power-query/handling-data-access) |
| Navigation | [handling-navigation-tables](https://learn.microsoft.com/en-us/power-query/handling-navigation-tables), [TripPin 3](https://learn.microsoft.com/en-us/power-query/samples/trippin/3-navtables/readme) |
| Paging | [handling-paging](https://learn.microsoft.com/en-us/power-query/handling-paging), [TripPin 5](https://learn.microsoft.com/en-us/power-query/samples/trippin/5-paging/readme), [helper-functions](https://learn.microsoft.com/en-us/power-query/helper-functions) (`Table.GenerateByPage`) |
| Transformations | [handling-transformations](https://learn.microsoft.com/en-us/power-query/handling-transformations) |
| Schema | [handling-schema](https://learn.microsoft.com/en-us/power-query/handling-schema), TripPin [6](https://learn.microsoft.com/en-us/power-query/samples/trippin/6-schema/readme) and [7](https://learn.microsoft.com/en-us/power-query/samples/trippin/7-advancedschema/readme) |
| Errors and retries | [handling-status-codes](https://learn.microsoft.com/en-us/power-query/handling-status-codes), [wait-retry](https://learn.microsoft.com/en-us/power-query/wait-retry) |
| Requests | [Web.Contents](https://learn.microsoft.com/en-us/powerquery-m/web-contents) (`RelativePath`, `Query`, `Headers`, `ManualStatusHandling`, `IsRetry`, `Timeout`) |
| The M language | [function reference](https://learn.microsoft.com/en-us/powerquery-m/power-query-m-function-reference), [language specification](https://learn.microsoft.com/en-us/powerquery-m/m-spec-introduction) |
| Diagnostics | [TripPin 8](https://learn.microsoft.com/en-us/power-query/samples/trippin/8-diagnostics/readme) |
| TestConnection and gateway | [handling-gateway-support](https://learn.microsoft.com/en-us/power-query/handling-gateway-support), [TripPin 9](https://learn.microsoft.com/en-us/power-query/samples/trippin/9-testconnection/readme) |
| Folding | [TripPin 10](https://learn.microsoft.com/en-us/power-query/samples/trippin/10-tableview1/readme), [native-query-sdk](https://learn.microsoft.com/en-us/power-query/native-query-sdk) |
| ODBC | [odbc](https://learn.microsoft.com/en-us/power-query/odbc), [odbc-parameters](https://learn.microsoft.com/en-us/power-query/odbc-parameters), [odbc-troubleshooting](https://learn.microsoft.com/en-us/power-query/odbc-troubleshooting) |
| ADBC (newer database path) | [transition-to-adbc](https://learn.microsoft.com/en-us/power-query/transition-to-adbc), [adbc](https://learn.microsoft.com/en-us/power-query/adbc), [adbc-advanced-patterns](https://learn.microsoft.com/en-us/power-query/adbc-advanced-patterns), [adbc-sql-generator](https://learn.microsoft.com/en-us/power-query/adbc-sql-generator) |
| Documentation | [handling-documentation](https://learn.microsoft.com/en-us/power-query/handling-documentation) |
| Proxy | [handling-proxy-support](https://learn.microsoft.com/en-us/power-query/handling-proxy-support) |
| Signing | [handling-connector-signing](https://learn.microsoft.com/en-us/power-query/handling-connector-signing) |
| Versioning | [handling-versioning](https://learn.microsoft.com/en-us/power-query/handling-versioning) |
| Testing | [handling-unit-testing](https://learn.microsoft.com/en-us/power-query/handling-unit-testing), [SDK test framework](https://learn.microsoft.com/en-us/power-query/sdk-testframework/test-framework), [PQTest](https://learn.microsoft.com/en-us/power-query/sdk-tools/pqtest-overview) |
| Service-only failures | [custom-connector-development-faq](https://learn.microsoft.com/en-us/power-query/custom-connector-development-faq) (missing `TestConnection`, missing OAuth `state`, eager navigation tables) |
| Security | [security-best-practices-power-query](https://learn.microsoft.com/en-us/power-query/security-best-practices-power-query) |
| Using custom connectors | [Power BI connector extensibility](https://learn.microsoft.com/en-us/power-bi/connect-data/desktop-connector-extensibility) |

## Microsoft tooling (MIT, on GitHub)

- [vscode-powerquery-sdk](https://github.com/microsoft/vscode-powerquery-sdk): the Power
  Query SDK for VS Code; its issues and changelog track SDK behaviour.
- [powerquery-parser](https://github.com/microsoft/powerquery-parser),
  [powerquery-formatter](https://github.com/microsoft/powerquery-formatter),
  [powerquery-language-services](https://github.com/microsoft/powerquery-language-services):
  the M parser, formatter and language service behind the VS Code extension.
- `PQTest.exe` and `MakePQX.exe` ship in the
  [Microsoft.PowerQuery.SdkTools](https://www.nuget.org/packages/Microsoft.PowerQuery.SdkTools)
  NuGet package (Windows): build a `.mez`, then `info`, `validate`, `test-connection`
  and `compare` run it on the real engine. The package's `content/pqtest.md` is the
  full manual, including the HTTP mock file format (`run-test --httpMock`), which the
  Learn pages do not cover.

## Further reading (link only)

- [Power Query M Primer](https://bengribaudo.com/blog/2017/11/17/4107/power-query-m-primer-part1-introduction-simple-expressions-let),
  Ben Gribaudo: the language in depth (evaluation, scope, types, errors).

## Retired certification pages (archived)

Microsoft stopped taking new certification submissions in October 2025
([announcement](https://community.fabric.microsoft.com/blog/fbc_pbiupdatesblog/empowering-our-customers-to-shape-the-future-of-data-connectivity-in-power-bi-an/5174038));
the Learn and Fabric certification URLs now redirect there. The last published rules
survive only in the Wayback Machine:

- [connector-certification, 2024-08-09](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)
- [certification-submission, 2024-07-11](https://web.archive.org/web/20240711034156/https://learn.microsoft.com/en-us/power-query/certification-submission)

[quality-bar.md](quality-bar.md) summarizes them.

## This repository

- `reference/microsoft-dataconnectors/`: Microsoft's sample connectors (TripPin parts
  1-10, GitHub OAuth, PKCE, ODBC, native query, ADBC/Flight SQL) and the SDK test
  framework's standard queries, vendored under MIT. These are written to be copied:
  start a new connector from the TripPin part that matches the step you are on.

- `knowledge/checklist.yaml`: the design questions and answer definitions.
- `bundle/topics/`: one page per checklist question, linking the reviewed pattern guides
  (`bundle/patterns/`, exact excerpts) and the connectors that use each answer.
- `connectors/<Name>/`: archived certified connector source; `knowledge/profiles/` and
  `evals/gold/` describe each one's design with line citations.
- `uv run pqkb certification --path <folder>`: static checks of a connector against the
  archived rules. They read source; they do not run it.
