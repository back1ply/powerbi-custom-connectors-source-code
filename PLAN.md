# Rebuild plan

Goal: turn this repo into an accurate, self-maintaining reference for Power Query
connector code, published as an [OKF v0.2](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/62432a095456147ee71e70ac6e4dc0d2dea3ac30/okf/SPEC.md)
knowledge bundle and a GitHub Pages site.

Core rule: **scripts generate every fact; people (and agents) only write explanations.**
No hand-typed counts, connector lists, or "seen in" claims.

## Progress — 2026-10-18

- The Python CLI supports both feed refreshes and `refresh --source-dir`.
  Cleaned, redacted output matches the old PowerShell script on fixture `.mez`
  and `.pqx` packages with nested source, JSON, images, and resources. The old
  downloader and refresh scripts are retired; manual extraction utilities remain.
  This is fixture parity, not a full re-download comparison of every vendor package.
- Failure checks cover invalid local package sets, failed feed downloads,
  installation rollback, and failed rollback with a retained recovery copy.
  Cross-platform manifest paths and duplicate connector identities are rejected.
- Successful refreshes record machine verification and renew freshness separately
  from content-generation timestamps. Unchanged refreshes are logged too.
- The first `knowledge/` bundle is generated from the existing archive. Pattern
  pages have exact, source-linked excerpts, detection rules, and generated match
  lists. Tests check excerpts and cited files against the archive. Explanations
  now cover mechanisms, adaptation decisions, and failure paths, including sourced
  HMAC and action-handler pages. They remain drafts pending human review.
  Legacy `docs/` is retained as historical material outside the published bundle.
- Connector tags include authentication kinds and detected patterns. A generated
  tag index supports browsing the directory by either kind of tag.
- Validator spike: downloaded the Markdown from all four Google bundles at the
  pinned spec commit (`acme_retail`, `crypto_bitcoin`, `ga4`, `stackoverflow`).

  | Tool | Results on Google's bundles | Decision |
  | --- | --- | --- |
  | okflint 0.5.0, core checks | All passed, no diagnostics | Pin for CI |
  | okf-schema 0.12.0 | `acme_retail` failed; other bundles passed with warnings | Not the CI gate |
  | @mfdaves/okf-mcp 0.9.1 | `acme_retail` failed; other bundles passed | Not the CI gate |

  The optional `okflint` v0.2 shape family rejects spec-correct datetime
  `stale_after` values. It is disabled explicitly; repository tests check
  timezone-aware timestamps. Core, project-profile, and internal-link checks
  stay enabled. This is a documented compatibility limit, not full shape coverage.
- Kiso 0.2.6 failed the full-bundle spike: it warned about datetime
  `stale_after`, then rejected the root `okf_version: "0.2"`. Linked footnote
  definitions also caused a Windows path error; plain source-label definitions
  avoid that error and follow the spec's source-ID convention. Use the planned
  MkDocs Material fallback. Its configuration targets the GitHub project path.
  The fallback preview builds with `--strict`, produces a search index, and
  passes a local HTML-link check. Pygments has no Power Query lexer in this
  environment, so the preview uses Prism 1.30.0's Power Query grammar from a
  CDN. Highlighting requires browser network access; plain code remains visible.
- Gitleaks scans the current archive and bundle. The only exception is the
  public `oauth_client_id` assignment in ExactOnlinePremium, constrained by
  both path and assignment shape. History is not scanned or rewritten.
- README, license scope, repository-local CodeScene rules, and validation are
  in place. Validation checks tests, lint, generated output, internal links,
  secrets, and the site-preview build. Secret scans run before artifact upload.
- Weekly refresh automation opens or updates a draft PR. Excerpt failures are
  reported for repair; a failed secret scan prevents PR creation. Checks run in
  the refresh workflow because the default token does not trigger another PR run.
- A manual Pages workflow validates and deploys the resulting preview artifact
  only after an explicit review acknowledgement. Publication is pending human
  review, as required below; no remote push or deployment has been performed.
- Still open: human review of the pattern drafts, initial publication, and
  enabling automatic deployment on merge after that review. Optional MCP
  registration remains out of scope.

Tool references: [okflint](https://github.com/mattdav/okflint),
[okf-schema](https://github.com/gsemet/okf-schema),
[okf-mcp](https://github.com/mfdaves/okf-mcp),
[Kiso 0.2.6](https://github.com/oak-invest/kiso/tree/v0.2.6), and
[Material syntax highlighting](https://squidfunk.github.io/mkdocs-material/setup/extensions/python-markdown-extensions/#highlight).

## Target spec

- OKF **v0.2**, SPEC.md at commit `62432a0` (2026-08-21). The latest release.
- v0.3 is only an open proposal (issue #312, a "Skill" type). Not relevant; revisit if it ships.
- Root `knowledge/index.md` declares `okf_version: "0.2"`.
- All timestamps are full ISO 8601 datetimes with an offset (`2026-10-17T00:00:00Z`), per the Aug 2026 spec change.

## Target layout

```
README.md                     short intro, links to the site (outside the bundle)
PLAN.md                       this file
connectors/<Name>/            raw extracted source, redacted        (generated)
knowledge/                    the OKF bundle (also the Pages source)
  index.md                    okf_version: "0.2" + sections          (generated)
  log.md                      one entry per refresh                  (generated)
  connectors/
    index.md                                                          (generated)
    <Name>.md                 type: Power Query Connector             (generated)
  patterns/
    index.md                                                          (generated)
    <pattern>.md              type: Power Query Pattern  (prose written, "Seen in" generated)
tools/                        Python package: refresh, redact, scan, build bundle
tests/                        pytest
.github/workflows/            validate, weekly refresh PR, Pages deploy
```

Why the bundle is a subdirectory: OKF requires frontmatter with `type` on every
non-reserved `.md` file. The root README, and the vendor `.md` files shipped inside
some connectors, would fail that. So the raw `connectors/` archive stays outside
the bundle.

Links:
- Concept-to-concept links are **relative** (`../patterns/x.md`). The spec prefers
  `/`-rooted links, but those break both on GitHub (resolved from the repo root)
  and on a project Pages site (resolved from the domain root).
- Links to source code use absolute GitHub URLs on `master`.

## How OKF fields are used

| Field | Connector concept | Pattern concept |
| --- | --- | --- |
| `type` | `Power Query Connector` | `Power Query Pattern` |
| `title`, `description` | from manifest/package | written |
| `resource` | package URL from Microsoft's manifest | — |
| `tags` | auth kinds + detected patterns | category (auth, pagination, folding…) |
| `sources` | one entry per source file (`id` = file name) | one entry per connector file cited, `id` used as footnote label |
| `generated` | `{ by: process:pqkb-build, at: … }` | `{ by: codex/gpt-6, at: … }` for prose |
| `verified` | `{ by: process:pqkb-refresh, at: … }` after a successful refresh | **omitted until you actually review the page**; then `{ by: human:back1ply, at: … }` |
| `status` | `stable` (connectors that leave the manifest are deleted; the deletion is recorded in `log.md`) | `draft` until reviewed, then `stable` |
| `stale_after` | refresh time + 14 days | — |
| extension key `detect` | — | regex rule(s) the scanner runs |

Every factual claim in a pattern page carries a footnote keyed to a `sources[].id`
that points at a real connector file. That is what replaces made-up claims such as
"used in over 60 connectors" (the real number is about 23).

Pattern bodies use conventional headings: `# Examples` (real excerpts with their
source path) and a generated `# Seen in` section between markers that the build
rewrites.

## Phases

Each phase ends with: tests green, the chosen OKF validator passing, a CodeScene
Code Health check on new or changed tool code (per AGENTS.md), and a commit.

### Phase 0: Spikes (timeboxed, about half a day)
1. **Validator choice.** Run okflint, okf-schema and okf-mcp against Google's own
   sample bundles at `62432a0`. Keep the one that passes them cleanly; pin its
   version. (The tools page cites okflint's core rules as "§9" while conformance is
   §11 in the spec, a sign some tools lag the spec.)
2. **Site generator.** Build about 5 connectors and 3 patterns with **Kiso**
   (OKF-native, has a GitHub Action, v0.2.x so young). Pass criteria:
   - works under the project path `/powerbi-custom-connectors-source-code/`
   - relative links resolve
   - M code blocks render with highlighting
   - build time stays reasonable when extrapolated to about 200 concepts
   Fallback if any criterion fails: **MkDocs Material** (mature, ignores unknown
   frontmatter, built-in search and tags).
3. Skip `viz.html` for the full bundle: it inlines everything and is meant for 10–50
   concepts. Maybe later for patterns only.

### Phase 1: Refresh pipeline in Python
- Port `download_connectors.ps1` and `refresh_connectors.ps1` into `tools/`:
  manifest → download → extract → strip noise → **redact** → write `connectors/`.
- Redaction: replace values in `client_secret` / `auth_parameter` and other secret
  files, and inline literal secrets in `.pq`/`.pqm`/`.m`, with `<redacted>`.
  Retain public OAuth client identifiers. Add
  a secret scan (gitleaks) as a test.
- Git history keeps the old values. These are already public inside vendor
  packages, so the plan does **not** rewrite history unless you ask for it.
- Delete the PowerShell scripts once output matches.
- pytest on a small fixture `.mez`.

### Phase 2: Scanner and bundle generator
- Load `detect` rules from pattern frontmatter, scan `connectors/`, record
  file and line matches.
- Generate the connector concepts, the `# Seen in` sections, every `index.md`,
  and a `log.md` entry (added / updated / removed connectors) per refresh.
- Output is deterministic (sorted, stable), so diffs stay readable.

### Phase 3: Accuracy pass on the docs
- Merge the 46 docs into about 15–20 pattern concepts (for example retries,
  backoff, rate-limit and long-polling become one).
- Rewrite each page so that:
  - examples are real excerpts from the archive
  - every claim is footnoted to a connector file
  - wording is plain (no "exclusively", no "ultimate")
- All pages start as `status: draft`. You review them; reviewed pages get
  `verified: human:back1ply` and `status: stable`.

### Phase 4: GitHub Pages
- **Must run after Phase 1 redaction and Phase 3.** The site makes the credential
  files crawlable and would spread wrong claims.
- Build `knowledge/` with the generator chosen in Phase 0, deploy with
  `actions/deploy-pages`.
- Site sections: patterns (main entry), connector directory with filters by tag,
  refresh log.
- Rewrite the root README: what this is, a link to the site, how to refresh,
  license and disclaimer. Add a `LICENSE` file: MIT for tools and docs, with the
  vendor-code carve-out.

### Phase 5: Automation
- On PR: OKF validate, link check, secret scan, pytest.
- Weekly cron: refresh → regenerate → open a PR (peter-evans/create-pull-request).
  Never push straight to master.
- First publish: manual Pages deployment after human review. Enable deployment
  on merge to master after the initial review and publication.
- Optional: register the bundle with okf-mcp so agents can query it over MCP.

## Decisions

1. **Connectors that leave Microsoft's manifest:** deleted, as today. Each deletion
   is recorded in `log.md`, and git history keeps the code.
2. **Tooling language:** Python with uv.
3. **Site generator:** MkDocs Material, after the Kiso spike failed. See the
   compatibility evidence in the progress section.
