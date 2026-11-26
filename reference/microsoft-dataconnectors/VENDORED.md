# Microsoft DataConnectors samples (vendored)

Text files from [microsoft/DataConnectors](https://github.com/microsoft/DataConnectors)
at commit `c7b9d81d0d1a62b5f5486f63087c8587e2ca0160` (2026-06-08), MIT licensed
(`LICENSE`, copyright Microsoft Corporation). Unmodified; images, Visual Studio project
files, `.diagnostics` traces, test data and the SDK installer were left out.

These are Microsoft's own teaching connectors, written to be copied, unlike the
certified connectors in `connectors/`, which are vendor products kept for study.

| Path | What it is |
| --- | --- |
| `samples/TripPin/` | The TripPin tutorial, one folder per part (1 OData ... 10 folding), matching the Learn tutorial pages. |
| `samples/HelloWorld*`, `samples/NavigationTable`, `samples/OData` | Minimal connectors: function documentation, navigation table, OData. |
| `samples/Github`, `samples/OAuthPKCE`, `samples/DataWorldSwagger` | OAuth flows (PKCE, refresh). |
| `samples/ODBC`, `samples/DirectQueryForSQL`, `samples/NativeQuery` | ODBC DirectQuery, SQL capabilities, native query support. |
| `samples/DuckDbFlightSQL` | ADBC / Flight SQL connector with a SQL generator. |
| `samples/UnitTesting` | The unit-testing helper used by the Learn page. |
| `testframework/tests/` | The Power Query SDK test framework's standard test queries (`.query.pq` and expected `.pqout`). |

To refresh: download the repository at a newer commit, copy the same file types
(`.pq .pqm .m .pqout .resx .json .md`) from `samples/` and `testframework/tests/`, and
update the commit above.
