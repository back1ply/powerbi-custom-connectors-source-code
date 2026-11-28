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

`runtime.py` compiled each connector with MakePQX and ran 15 checks on the Power Query
engine with PQTest 2.160.2, its HTTP mock standing in for the API: navigation names,
lazy navigation, two-page invoices with a sparse record, customers with an empty middle
page, column types for all three tables, an empty table's rows, one request to preview one invoice, 401 (must raise the
engine's credential error, per Learn's handling-status-codes), 404, 429 and 503 sent
forever, an `http://` URL, and `validate` on the TestConnection call. A copy of repo-1
with `TestConnection` deleted fails that last check, so it is not a free point.
Per-trial outputs (connector code, grades, `runtime.json`) were pruned on 2026-11-28; they are in git history at commit b0af997.

| Trial | Runtime | Failed |
| --- | --- | --- |
| repo-1 | 15/15 | |
| repo-2 | 15/15 | |
| repo-3 | 13/15 | customers_rows, payments_empty_rows |
| baseline-1 | 14/15 | preview_one_page |
| baseline-2 | 14/15 | preview_one_page |
| baseline-3 | 14/15 | preview_one_page |

repo-3 combines pages with `Table.ExpandTableColumn` over a column of page tables
(`repo-3/connector/Ledgerly.pq` 195), so each empty page becomes a row of nulls: an
empty Payments table returns one all-null row, which the spec rules out. The static
grade had credited it with correct empty-result columns. Microsoft's sample
`Table.GenerateByPage` has the same flaw; see `skills/write-connector/references/pitfalls.md`.

The invoices mock has two pages. Every repo connector showed the first invoice after
one request; every baseline connector fetched both pages first, so on a large API a
preview would download the whole table. This is the only measure where the arms
split, with three trials each.

Every connector retried 429 and 503 and then failed with its own message: 5 or 6
requests, about 8-9 s for 429 (`Retry-After: 1`) and 34-66 s for 503. The mock cannot
send an error and then a success, so recovery after a retry is untested.

The rubric no longer scores which helper builds the pages (`paging/paging-generator`,
removed 2026-11-27): the trial that failed used the same expansion as Microsoft's
helper, and the behaviour is now checked on the engine instead. Rescored from the
stored profiles, all six get 23/23 (the `grade.json` files keep the original 23/24).
