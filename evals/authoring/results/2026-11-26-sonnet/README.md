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
