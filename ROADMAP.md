# Connector reference roadmap

Updated: 2026-10-19. This is planned work, not a claim that the reference is
exhaustive or that archived connectors have been runtime-tested.

## Current baseline

The reference has 23 source-reviewed patterns, 70 exact archived excerpts, and
133 connectors. The candidate ledger contains 874 supported, 171 uncertain, and
90 rejected decisions. These are connector/pattern decisions, not counts of
distinct connectors. Counts describe this baseline and will change on refresh.

Authored explanations live in `knowledge/patterns/`. Connector pages, indexes,
and match lists are generated into ignored `build/knowledge/`. MkDocs publishes
the site. The current review scope and limitations are recorded in [REVIEW.md](REVIEW.md).

## Work sequence

| Order | Work | Deliverable | Acceptance criteria |
| --- | --- | --- | --- |
| 1 | Audit coverage gaps | A ranked backlog with source locations, affected connectors, reader tasks, and existing related patterns. | Examine every connector for techniques outside the current catalog. Distinguish genuinely missing topics from details that belong in an existing page; record the audit scope and unresolved gaps. |
| 2 | Resolve uncertain matches | Reviewed decisions for the current 171 uncertainties, starting with patterns used across many connectors. | Read complete functions, imported helpers, and entry-point wiring. Resolve each verdict or state precisely which evidence is unavailable. Preserve justified uncertainty. |
| 3 | Fill demonstrated gaps | New pattern pages or targeted expansions of existing pages. | Each addition addresses a gap from step 1 and includes implementation paths, dependencies, failure cases, selection guidance, and adaptation checks. Use contrasting source implementations where available; identify single-implementation coverage explicitly. |
| 4 | Add runnable teaching examples | Small examples with mock inputs/responses and expected results. | Examples run without vendor credentials and declare their host requirements. Keep authored teaching code distinct from exact vendor excerpts; do not imply that excerpts are standalone connectors. |
| 5 | Add runtime evidence | A reproducible harness for the teaching examples and selected techniques. | Exercise empty/last pages, pagination termination, retry exhaustion, malformed responses, schema drift, and date boundaries. Record the engine/host version and distinguish executed results from source-reading assessments. |
| 6 | Improve discovery | Task-based entry pages and technique comparisons. | Readers can choose an approach for authentication, pagination, schema handling, or asynchronous exports and reach relevant patterns and connector sources. Check navigation and source permalinks on desktop and mobile. |
| 7 | Reduce maintenance intervention | Targeted review jobs, bounded recovery, and actionable refresh summaries. | Reuse unchanged reviews, validate the exact publication commit, preserve honest reviewer identity, and leave failed updates in a repairable draft PR. Report failures and the next action without requiring log archaeology. |

Implement review cost limits and quota handling before another large review run,
even though the broader maintenance work is listed last. Independent teaching
examples can proceed while some uncertain matches remain unresolved.

The gap audit should investigate areas such as data-source identity, host/gateway
constraints, rate-limit response handling, and XML/binary parsing. These are
questions to investigate, not confirmed missing patterns or promised additions.

## First work package

1. Audit the connector corpus and produce the ranked gap backlog. Link every
   proposed addition to concrete source evidence and an existing reader task.
2. Group uncertain matches by cause: missing helper context, unclear wiring,
   disabled branches, or insufficient evidence. Review complete source where
   possible instead of repeatedly submitting the same limited context.
3. Add per-run spending/token limits, bounded retries, and a stop condition for
   quota or billing errors before running bulk external reviews again. Reuse
   completed results and report which records remain pending.
4. Trial the two tools below in isolation. Record compatibility findings and
   adopt them only if they add a capability the existing pipeline lacks.

## OKF tooling decisions

The [OKF tools directory](https://okf.md/tools/) and
[ecosystem map](https://okf.md/ecosystem-map/) were read on 2026-10-19.
The map's scores are directory assessments, not benchmarks on this repository.
Recommendations below reflect this project's needs. Proposed tools have not
been installed or compatibility-tested as part of this documentation change.

| Tool | Decision | Fit and adoption condition |
| --- | --- | --- |
| MkDocs Material | Keep | The current publisher already provides search, navigation, and per-excerpt source line links. Improve its content discovery before considering another publishing engine. |
| okflint 0.5.0 | Keep | Already pinned in `pyproject.toml` and used by CI. Retain the project profile and existing excerpt/review checks; another validator cannot establish factual correctness. |
| `@mfdaves/okf-mcp` 0.9.1 | First trial | Serve the generated bundle to agents with search, graph navigation, and provenance lookup. Start with local read-only consumption and verify that custom types and review fields are preserved. |
| `@fcmam5/okph` 0.9.0 | Second trial | Produce targeted dependency and change-impact reports for reviewers. Determine how to seed changes from tracked sources into the generated bundle before making it a CI dependency. |
| OKF-Schema | Conditional | Evaluate explicit schemas for `Power Query Pattern` and `Power Query Connector` only when they catch metadata errors that the current profile and tests miss. Avoid a second parallel knowledge lifecycle. |
| Obsidian | Optional reader | A local way to browse a copy of the generated bundle. Edits to generated pages are temporary; authored pattern changes must go through `knowledge/patterns/`. No CI dependency needed. |
| OKF-Runtime | Defer | Reconsider if deterministic bundle querying/composition is needed and the MCP trial does not cover it. Avoid adding another indexing layer without a demonstrated use case. |
| okf-guard | Defer | Its hidden-content screening targets document ingestion. Revisit if PDF, Office, or HTML documents become inputs; it does not replace secret scanning or source review. |
| kcmd, kcenrich, Google Cloud Knowledge Catalog | Defer | Catalog synchronization and cloud infrastructure are outside this static source-reference project's current requirements. |
| Groma, Roteiro, other repository generators | Defer | Architecture mapping is a different output from reviewed Power Query technique explanations. Require a demonstrated source-understanding benefit before another generator is added. |

Keep Superops OKF, OpenWiki, and `viz.html` out of the plan, as previously
requested. Keep MkDocs as the publisher; Kiso remains a possible future
compatibility target rather than a parallel site to maintain.

### Trial A: agent retrieval with okf-mcp

Upstream documents local bundle consumption, BM25+ search, provenance queries,
and a stdio MCP interface. Its write and producer features are separate from
the read-only trial proposed here.
[Source: okf-mcp v0.9.1 README](https://github.com/mfdaves/okf-mcp/blob/v0.9.1/README.md).

Build the bundle first, then point a pinned local consumer at `build/knowledge/`.
Test a fixed set of questions spanning authentication, paging, errors, schema,
and exports. Check that answers can retrieve the relevant concepts and original
citations, and that uncertainty, agent verification, and freshness remain
visible. Rebuild and confirm the consumer can reload the changed bundle.

Adopt only if retrieval improves over the current browsing workflow and the
trial leaves authored files, review events, and generated output unchanged.
Document startup/rebuild behavior and runtime requirements before enabling it
for normal agent sessions. Do not register a producer or enable authoring for
this trial.

### Trial B: review impact with OKPH

Upstream provides dependency traversal and Git-seeded impact analysis. Its
results identify documents that may be affected through links; they do not
establish semantic impact.
[Source: OKPH v0.9.0 README](https://github.com/Fcmam5/okph/blob/v0.9.0/README.md).

This repository's generated bundle is ignored by Git. A Git diff scoped to
`build/knowledge/` therefore cannot represent the tracked source changes that
caused a rebuild. Also, connector source links use GitHub URLs; a Markdown link
graph alone does not prove which local source edits invalidate a review.

Trial dependency reports on the built bundle and map changed tracked files to
affected concepts using existing source fingerprints and citation metadata.
Compare the result against known source/prose changes, an unrelated change,
and a deletion. Adopt only if the report identifies the expected review work
without treating generated-list changes as new prose review requirements.
Keep the existing fingerprint checks authoritative. Use focused PR reports,
not another full-site graph viewer.

### Conditional schema validation

OKF-Schema supports per-type JSON Schemas and separate opinionated knowledge
and requirements workflows. Only the generic validation layer is a candidate
for this project.
[Source: OKF-Schema README](https://github.com/gsemet/okf-schema#readme).

If evaluated, define schemas for the project's actual custom types, source
records, timestamps, and review metadata. Compare diagnostics with okflint and
the existing tests before adding a gate. Resolve the known timestamp-shape
limitation documented in [README.md](README.md) through a tested validator
change; do not silently broaden disabled checks or let a formatter rewrite
reviewed content and fingerprints.

## Completion standard

Each work package should leave a small reviewable change, source-backed claims,
appropriate checks, and a clear account of what was actually executed. Renew
authored pattern reviews only after checking changed claims against their
sources, with the actual reviewer identity. Keep generated output ignored.

Measure progress through reviewed gap closure, useful examples, resolved
uncertainties, retrieval quality, and maintenance effort. A larger pattern count
alone is not evidence of depth, and no tool's conformance result proves that a
connector works against its vendor service.
