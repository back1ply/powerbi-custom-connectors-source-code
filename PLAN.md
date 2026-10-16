# Rebuild plan

Goal: turn this repo into an accurate, self-maintaining reference for Power Query
connector code, published as an [OKF v0.2](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/62432a095456147ee71e70ac6e4dc0d2dea3ac30/okf/SPEC.md)
knowledge bundle and a GitHub Pages site.

Core rule: **scripts generate every fact; people (and agents) only write explanations.**
No hand-typed counts, connector lists, or "seen in" claims.

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
| `generated` | `{ by: process:refresh, at: … }` | `{ by: claude/opus-5.5, at: … }` for prose |
| `verified` | omitted | **omitted until you actually review the page**; then `human:back1ply` |
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
- Redaction: blank the values in `client_id` / `client_secret` / `auth_parameter`
  files and inline literal secrets in `.pq`/`.pqm`/`.m`, marked `<redacted>`. Add
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
- On merge to master: Pages deploy.
- Optional: register the bundle with okf-mcp so agents can query it over MCP.

## Decisions

1. **Connectors that leave Microsoft's manifest:** deleted, as today. Each deletion
   is recorded in `log.md`, and git history keeps the code.
2. **Tooling language:** Python with uv.
3. **Site generator:** decided by the Phase 0 spike (Kiso first, MkDocs Material
   as fallback).
