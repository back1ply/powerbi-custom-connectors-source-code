# Power Query Connector Source Reference

[Browse the reference site](https://back1ply.github.io/power-bi-custom-connectors-source-code/): source-reviewed patterns, connector source links, authentication tags, and a refresh log.

This unofficial archive extracts Microsoft's certified Power BI connector packages for studying Power Query (M). Pattern explanations and excerpts live in `knowledge/patterns/`; the Python tools generate the connector directory, indexes, and detection lists. Static evidence finds candidates; source-bound Claude Haiku or DeepSeek Flash assessments separate supported, uncertain, and rejected matches. These are source-reading assessments, not runtime verification. See the [source-review record](REVIEW.md) for scope and review validity.

See [the roadmap](ROADMAP.md) for coverage gaps, deeper examples, runtime checks, maintenance work, and proposed OKF tool trials.

## For agents and LLMs

Start at [`bundle/index.md`](bundle/index.md): the generated [Open Knowledge Format v0.3](https://github.com/open-knowledge-format/open-knowledge-format/blob/main/SPEC.md) bundle, committed so it can be browsed directly. [`AGENTS.md`](AGENTS.md) maps the repository. To build a connector, use the `write-connector` skill: Microsoft's SDK steps in TripPin order, the quality bar from the retired certification rules, and pitfalls found in certified connectors, with [`bundle/techniques/`](bundle/techniques/index.md) showing which archived connectors use each technique. The `skills/` folder holds agent skills for writing connectors (`write-connector`), using the archive (`find-connector-code`), maintaining it (`refresh-archive`, `review-pattern`, `run-candidate-reviews`), and the official OKF skills (`okf-generate`, `okf-consume`); it installs as a plugin from this repository's marketplace. [`.mcp.json`](.mcp.json) runs [okf-mcp](https://github.com/mfdaves/okf-mcp) on the bundle for search and link navigation. The site publishes [`llms.txt`](https://back1ply.github.io/power-bi-custom-connectors-source-code/llms.txt).

## Local development

Install Python 3.12 or newer and [uv](https://docs.astral.sh/uv/), then run:

```powershell
uv sync --locked --group site
uv run pqkb build
uv run pytest -q
uv run ruff check src tests
uv run ruff format --check src tests
uv run python skills/okf-generate/scripts/validate.py bundle
uv run pqkb verify-reviews
uv run pqkb verify-matches
uv run mkdocs build --strict
uv run pqkb viz
uv run pqkb functions Attio
```

`pqkb functions <Connector>` lists each top-level function with its file, line range, and the other functions it calls (`--json` for agents). It is the first step of phase 2, which profiles every connector against the questions in `knowledge/checklist.yaml`; those questions follow the Power Query SDK "Handling …" topics on Microsoft Learn.

`pqkb certification [Connector]` checks source against Microsoft's published connector certification rules (MUST, SHOULD, and security items from the [archived certification page](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)); every connector page shows the result. Statuses are pass, fail, review (needs judgement), n/a, and info. These are static source checks, not Microsoft's review.

`pqkb profile`, `pqkb eval`, and `pqkb check-profiles` run the LLM checklist answers, score them against the hand-labelled gold set in `evals/gold/`, and validate answer files.

`build` regenerates the reference from `connectors/` without downloading packages and writes the OKF bundle to `bundle/`, which is committed. Preview the site with `uv run mkdocs serve`; static output goes to `build/site/`, including `llms.txt`. `pqkb viz` writes the official OKF graph viewer to `build/viz.html` for local use; it is not published while phase 2 redesigns connector pages. Power Query highlighting loads Prism from a CDN.

The bundle follows [Open Knowledge Format v0.3](https://github.com/open-knowledge-format/open-knowledge-format/blob/main/SPEC.md) and is checked by the official validator vendored in `skills/okf-generate`. `verify-reviews` and `verify-matches` report drift and coverage; they do not fail CI.

## Pattern evidence

The scanner applies evidence requirements for all 23 patterns to every connector. It masks comments and string literals while preserving line numbers and quoted M identifiers. Related calls, callback registrations, and option fields are collected across each connector. “Corroborated” means those signals co-occur; it does not establish control flow or that a helper is used.

`uv run pqkb review-matches` asks the locally installed, signed-in Claude Code CLI to review changed candidates with its `haiku` model. The reviewer receives source windows, pattern scope, and a lexical symbol inventory, with tools and MCP servers disabled. Its verdicts must cover every candidate and cite exact supplied lines. Unsupported quotes fail validation. Confidence is qualitative, not a measured probability.

For the DeepSeek alternative, run `uv run pqkb review-matches --provider opencode` with OpenCode 2.0.32 and `OPENROUTER_API_KEY` configured. This selects `openrouter/deepseek/deepseek-v4.1-flash-1017`, uses a temporary isolated profile with tools denied and no MCP servers, and confirms the model through OpenCode's exported session metadata. Both providers use the same candidate and quote validation. Existing current reviews are reused across providers; provider-specific protocol fingerprints prevent relabelling a review as another provider's work.

Assessments live in `knowledge/match-reviews.json`, including model identity, reasons, and citations. Full connector source, reviewer prompt, and the exact request (candidates, the pattern scope shown, and supplied context) are fingerprinted to detect stale results; an edit to an unrelated pattern page does not expire a connector's review. Since 2026-11-25 these assessments are not shown on connector pages; they are kept as a record and a baseline while phase 2 replaces them with per-connector checklist answers. No match does not prove that a connector lacks a technique. Candidate assessments never renew the separate pattern-prose review.

Run `uv run pqkb build` after reviewing to update the reference. `uv run pqkb verify-matches` checks coverage, fingerprints, and cited quotes without contacting an LLM; CI runs it as a report and never blocks on it. Production evidence rules are in `src/pqkb/signals.py`; pattern `detect` metadata remains a fallback for patterns without a catalog entry.

Each pattern compares source implementations, explains their dependencies and failure paths, and lists adaptation checks. Topics include asynchronous exports, date-range filters, and function-parameter metadata. These are archived source excerpts with explicit dependencies, rather than standalone runnable connectors. Every Power Query block carries a `<!-- source: ID -->` marker tied to a frontmatter source URL and start line. Tests compare every block with that source while the page's review is current; the site gives each block its own original line numbers and source link. When the cited source changes, the page is frozen rather than blocking: its bundle copy gets OKF `stale_after` and a "Changed since review" banner until an agent renews the review.

## Refreshing the archive

```powershell
uv run pqkb refresh
```

Refresh selects the highest package version per connector from Microsoft's feed, extracts and redacts source, replaces `connectors/`, and rebuilds the reference. It does not filter by Power BI engine compatibility. Missing connectors are removed; package changes and unchanged checks are logged. Successful refreshes record a receipt in `knowledge/refresh.json` and renew connector freshness for 14 days. Rebuilding the site does not renew that receipt.

For local packages, use `uv run pqkb refresh --source-dir 'C:\packages\certified-connectors'`. Supply the complete set of `.mez` and `.pqx` files in a folder outside `connectors/`; absent connectors are removed. Local packages have no inferred publisher, version, or certification.

Download and extraction failures leave the archive intact. Installation failure attempts rollback and reports the backup location if recovery fails. If the subsequent bundle build fails, the refreshed archive remains: fix the reported problem and rerun `uv run pqkb build`.

Recognized secret values become `<redacted>`; public OAuth client IDs remain. Redaction is heuristic, and git history retains earlier content. Stripped resources and redacted values can prevent these sources from running as connectors.

## Automation

The [weekly refresh](.github/workflows/refresh.yml) runs Mondays at 03:23 UTC and supports manual dispatch. It opens a PR, validates its exact commit, and merges passing updates without bypassing repository restrictions. If an `ANTHROPIC_API_KEY` repository Actions secret is configured, the refresh installs the pinned Claude Code CLI and reviews changed candidates automatically. Without that secret, unchanged assessments are reused and stale ones keep their last verdict, labelled as older; candidate coverage is reported in the PR but does not block the merge. The local Claude subscription login is not transferred to GitHub. Drifted pattern reviews are reported in the PR and marked stale in the bundle, but do not block the merge. Failed tests, lint, OKF validation, or site build leave a draft PR; a failed secret scan prevents PR creation.

The [Pages workflow](.github/workflows/pages.yml) validates and publishes `main`. Bot merges explicitly dispatch publication because their push events do not trigger another workflow. GitHub Pages and Actions PR permissions are already configured.

## Repository layout

- `connectors/`: extracted vendor source and package metadata.
- `knowledge/`: authored patterns, source-bound candidate assessments, and the refresh log.
- `bundle/`: generated OKF bundle (connector pages, pattern copies, indexes, log); committed, never edited by hand.
- `skills/`: agent skills and plugin manifests, including the vendored official OKF skills.
- `src/pqkb/`: refresh, redaction, detection, review checks, rendering, and the vendored OKF viewer (`viz/`).
- `build/`: website and local viewer output; ignored by git and safe to regenerate.
- `tests/`: pipeline, source-excerpt, review-validity, and site checks.

## License

Tools and original documentation use the [MIT license](LICENSE). The vendored OKF skills and viewer are Apache-2.0 ([notice](skills/OKF-LICENSE.md)). Extracted source, quoted excerpts, trademarks, and other vendor material retain their owners' rights. This project is not affiliated with Microsoft or the connector vendors.
