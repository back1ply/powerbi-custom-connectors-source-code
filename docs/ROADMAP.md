# Connector reference roadmap

Updated: 2026-11-28. This is planned work, not a claim that the reference is
exhaustive or that archived connectors have been runtime-tested.

## Current baseline

The reference has 23 source-reviewed patterns, 70 exact archived excerpts, and
133 connectors. 132 connectors have checklist profiles; against hand labels they
are 95.8% exact on the 17 scored gold connectors and 95.4% on 4 held-out ones
(`evals/results/`). Counts describe this baseline and will change on refresh.

Authored explanations live in `knowledge/patterns/`, and `knowledge/topics.yaml`
files each one under a checklist question. Connector pages, one topic page per
Power Query SDK concept (its patterns, and which connectors use each answer),
and indexes are generated into the committed OKF v0.3 bundle `bundle/`.
MkDocs publishes the site and `llms.txt`; the official OKF graph viewer is
available locally (`pqkb viz`) and unpublished. Review drift is reported and shown as stale; it never blocks. The current review scope and limitations are recorded in [REVIEW.md](REVIEW.md).

## Work sequence

| Order | Work | Deliverable | Acceptance criteria |
| --- | --- | --- | --- |
| 1 | Audit coverage gaps | A ranked backlog with source locations, affected connectors, reader tasks, and existing related patterns. | Examine every connector for techniques outside the current catalog. Distinguish genuinely missing topics from details that belong in an existing page; record the audit scope and unresolved gaps. |
| 2 | Check profiles against source | More hand-checked answers, starting with answers shared by many connectors and recurring `other` answers. | Read complete functions, imported helpers, and entry-point wiring. Group mistakes in `evals/` by cause (missing helper context, unclear wiring, disabled branches, insufficient evidence). Correct wrong answers or state precisely which evidence is unavailable; turn recurring `other` answers into answer ids. |
| 3 | Fill demonstrated gaps | New pattern pages or targeted expansions of existing pages. Two topics have no pattern of their own yet: Transformations (data formats) and Gateway and TestConnection. | Each addition addresses a gap from step 1 and includes implementation paths, dependencies, failure cases, selection guidance, and adaptation checks. Use contrasting source implementations where available; identify single-implementation coverage explicitly. |
| 4 | Add runnable teaching examples | Small examples with mock inputs/responses and expected results. | Examples run without vendor credentials and declare their host requirements. Keep authored teaching code distinct from exact vendor excerpts; do not imply that excerpts are standalone connectors. |
| 5 | Add runtime evidence | A reproducible harness for the teaching examples and selected techniques. | Exercise empty/last pages, pagination termination, retry exhaustion, malformed responses, schema drift, and date boundaries. Record the engine/host version and distinguish executed results from source-reading assessments. |
| 6 | Improve discovery | Task-based entry pages and technique comparisons. Started 2026-11-27: the Topics section merges patterns and the technique matrix, one page per SDK concept. | Readers can choose an approach for authentication, pagination, schema handling, or asynchronous exports and reach relevant patterns and connector sources. Check navigation and source permalinks on desktop and mobile. |
| 7 | Reduce maintenance intervention | Targeted review jobs, bounded recovery, and actionable refresh summaries. | Reuse unchanged reviews, validate the exact publication commit, preserve honest reviewer identity, and leave failed updates in a repairable draft PR. Report failures and the next action without requiring log archaeology. |

Before another bulk profiling or review run, add per-run spending limits, bounded
retries, and a stop on quota or billing errors; reuse completed results and report
what remains. This comes first even though maintenance work is listed last. Independent teaching
examples can proceed while profile checks continue.

The gap audit should investigate areas such as data-source identity, host/gateway
constraints, rate-limit response handling, and XML/binary parsing. These are
questions to investigate, not confirmed missing patterns or promised additions.

## OKF tooling decisions

From the [OKF tools directory](https://okf.md/tools/), read 2026-10-19. Adopt a
further tool only if it adds a capability the pipeline lacks, after testing it in
isolation.

| Tool | Decision | Fit and adoption condition |
| --- | --- | --- |
| MkDocs Material | Keep | The current publisher already provides search, navigation, and per-excerpt source line links. Improve its content discovery before considering another publishing engine. |
| Official OKF validator (`skills/okf-generate/scripts/validate.py`) | Adopted 2026-11-25 | CI gate for OKF v0.3 conformance; vendored with the official skills. |
| okflint 0.5.x | Removed 2026-11-25 | 0.5.0 and 0.5.1 reject `okf_version` 0.3. Reconsider if a release supports 0.3 and adds checks the official validator lacks. |
| `@mfdaves/okf-mcp` 0.9.1 | Adopted 2026-11-25 | `.mcp.json` serves `bundle/` read-only. Search, neighbors, provenance, and the stdio server work on the 0.3 bundle; its `validate` still applies v0.2 rules. Next: check retrieval on a fixed question set (authentication, paging, errors, schema, exports). |
| Official OKF viewer (`viz.html`) | Adopted 2026-11-25, unpublished | Vendored in `src/pqkb/viz`; local via `pqkb viz`. Its demo palette and size rules made the 158-node graph unreadable; revisit now that topics give a question → answer → connector hierarchy (`knowledge/topics.yaml`). |
| `@fcmam5/okph` 0.9.0 | Dropped | Its value is change-impact feeds, which this project does not need. |
| OKF-Schema | Conditional | Evaluate explicit schemas for `Power Query Pattern` and `Power Query Connector` only when they catch metadata errors that the official validator and tests miss. Use only its generic validation layer. |
| Obsidian | Optional reader | A local way to browse a copy of the generated bundle. Edits to generated pages are temporary; authored pattern changes must go through `knowledge/patterns/`. No CI dependency needed. |
| OKF-Runtime | Defer | Reconsider if deterministic bundle querying/composition is needed and the MCP trial does not cover it. Avoid adding another indexing layer without a demonstrated use case. |
| okf-guard | Defer | Its hidden-content screening targets document ingestion. Revisit if PDF, Office, or HTML documents become inputs; it does not replace secret scanning or source review. |
| kcmd, kcenrich, Google Cloud Knowledge Catalog | Defer | Catalog synchronization and cloud infrastructure are outside this static source-reference project's current requirements. |
| Groma, Roteiro, other repository generators | Defer | Architecture mapping is a different output from reviewed Power Query technique explanations. Require a demonstrated source-understanding benefit before another generator is added. |

Superops OKF and OpenWiki are out of scope.

## Completion standard

Each work package should leave a small reviewable change, source-backed claims,
appropriate checks, and a clear account of what was actually executed. Renew
authored pattern reviews only after checking changed claims against their
sources, with the actual reviewer identity. 
Measure progress through reviewed gap closure, useful examples, profile
accuracy, retrieval quality, and maintenance effort. A larger pattern count
alone is not evidence of depth, and no tool's conformance result proves that a
connector works against its vendor service.
