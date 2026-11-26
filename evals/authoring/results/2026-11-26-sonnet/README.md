# Authoring trial, 2026-11-26 (Sonnet, Ledgerly spec)

Three agents with read access to this repository (`repo-*`) and three with only the
spec (`baseline-*`), same model and tools, no web access. Graded by `grade.py`: static
certification checks plus a Haiku checklist profile scored against `rubric.yaml`.
Nothing was executed, so this measures design and form, not whether the M code runs.
Both arms loaded the operator's global CLAUDE.md, which says nothing about Power Query.

| | Rubric | Certification fails | Mean cost | Mean turns |
| --- | --- | --- | --- | --- |
| repo | 23/24 in all three | icons in 1 of 3 | $2.17 | 38 |
| baseline | 23/24 in all three | icons in 3 of 3 | $1.59 | 19 |

All six lost the same point: pages built with `List.Generate` rather than
`Table.GenerateByPage`. All six used `RelativePath`, `IsRetry`, `Retry-After`, a `/me`
credential check and `Beta = true`.

Finding: on a well-specified REST connector, Sonnet already knows the SDK patterns this
rubric measures, so the rubric hits its ceiling and cannot show what the repository
adds. Next: grade by running the code (PQTest), set harder tasks (ODBC/ADBC
DirectQuery, Table.View folding, OAuth for the service), and try weaker models.

## Runtime grading (added 2026-11-27)

`runtime.py` compiled each connector with MakePQX and ran 14 checks on the Power Query
engine with PQTest 2.160.2, its HTTP mock standing in for the API: navigation names,
lazy navigation, two-page invoices with a sparse record, customers with an empty middle
page, column types for all three tables, an empty table's rows, 401, 404, 429 and 503
sent forever, an `http://` URL, and `TestConnection` wiring. Results are in each
trial's `runtime.json`.

| Trial | Runtime | Failed |
| --- | --- | --- |
| repo-1 | 14/14 | |
| repo-2 | 14/14 | |
| repo-3 | 12/14 | customers_rows, payments_empty_rows |
| baseline-1 | 14/14 | |
| baseline-2 | 14/14 | |
| baseline-3 | 14/14 | |

repo-3 combines pages with `Table.ExpandTableColumn` over a column of page tables
(`repo-3/connector/Ledgerly.pq` 195), so each empty page becomes a row of nulls: an
empty Payments table returns one all-null row, which the spec rules out. The static
grade had credited it with correct empty-result columns. The other five flatten record
lists with `List.Combine` and pass. Microsoft's sample `Table.GenerateByPage` has the
same flaw; see `skills/write-connector/references/pitfalls.md`.

Every connector retried 429 and 503 and then failed with its own message: 5 or 6
requests, about 8-9 s for 429 (`Retry-After: 1`) and 34-66 s for 503. The mock cannot
send an error and then a success, so recovery after a retry is untested.

The rubric's `table-generatebypage` point is in doubt: the five connectors that passed
all used `List.Generate` with `List.Combine`, and the one that failed used the
expansion that Microsoft's helper uses.
