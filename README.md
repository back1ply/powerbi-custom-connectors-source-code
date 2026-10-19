# Power Query Connector Source Reference

[Browse the reference site](https://back1ply.github.io/powerbi-custom-connectors-source-code/): source-reviewed patterns, connector source links, authentication tags, and a refresh log.

This unofficial archive extracts Microsoft's certified Power BI connector packages for studying Power Query (M). Pattern explanations and excerpts live in `knowledge/patterns/`; the Python tools generate the connector directory, indexes, and detection lists. Static evidence finds candidates; source-bound Claude Haiku assessments separate supported, uncertain, and rejected matches. These are source-reading assessments, not runtime verification. See the [source-review record](REVIEW.md) for scope and review validity.

## Local development

Install Python 3.12 or newer and [uv](https://docs.astral.sh/uv/), then run:

```powershell
uv sync --locked --group site
uv run pqkb build
uv run pytest -q
uv run ruff check src tests
uv run ruff format --check src tests
uv run okflint validate --manifest okf-base.yaml
uv run pqkb verify-reviews
uv run pqkb verify-matches
uv run mkdocs build --strict
```

`build` regenerates the reference from `connectors/` without downloading packages. Preview it with `uv run mkdocs serve`; the generated OKF bundle goes to `build/knowledge/` and static output to `build/site/`. Power Query highlighting loads Prism from a CDN.

The bundle follows [Open Knowledge Format v0.2](https://github.com/GoogleCloudPlatform/open-knowledge-format/blob/ad30107c31c06aec8a7d5636e0d1058118604e6f/SPEC.md). The pinned validator's optional shape checks expect date-only `stale_after` values, so those checks are disabled in `okf-base.yaml`; tests verify timezone-aware timestamps. Core, project-profile, and internal-link checks remain enabled.

## Pattern evidence

The scanner applies evidence requirements for all 20 patterns to every connector. It masks comments and string literals while preserving line numbers and quoted M identifiers. Related calls, callback registrations, and option fields are collected across each connector. “Corroborated” means those signals co-occur; it does not establish control flow or that a helper is used.

`uv run pqkb review-matches` asks the locally installed, signed-in Claude Code CLI to review changed candidates with its `haiku` model. The reviewer receives source windows, pattern scope, and a lexical symbol inventory, with tools and MCP servers disabled. Its verdicts must cover every candidate and cite exact supplied lines. Unsupported quotes fail validation. Confidence is qualitative, not a measured probability.

Assessments live in `knowledge/match-reviews.json`, including model identity, reasons, and citations. Full connector source, pattern scope, detection rules, reviewer prompt, and exact supplied context are fingerprinted to invalidate stale results. Supported matches become connector tags; uncertain and pending candidates remain explicitly labelled; rejected matches are omitted from the browsing lists but retained in the review record. No match does not prove that a connector lacks a technique. Candidate assessments never renew the separate pattern-prose review.

Run `uv run pqkb build` after reviewing to update the reference. `uv run pqkb verify-matches` checks coverage, fingerprints, and cited quotes without contacting an LLM. Production evidence rules are in `src/pqkb/signals.py`; pattern `detect` metadata remains a fallback for patterns without a catalog entry.

## Refreshing the archive

```powershell
uv run pqkb refresh
```

Refresh selects the highest package version per connector from Microsoft's feed, extracts and redacts source, replaces `connectors/`, and rebuilds the reference. It does not filter by Power BI engine compatibility. Missing connectors are removed; package changes and unchanged checks are logged. Successful refreshes record a receipt in `knowledge/refresh.json` and renew connector freshness for 14 days. Rebuilding the site does not renew that receipt.

For local packages, use `uv run pqkb refresh --source-dir 'C:\packages\certified-connectors'`. Supply the complete set of `.mez` and `.pqx` files in a folder outside `connectors/`; absent connectors are removed. Local packages have no inferred publisher, version, or certification.

Download and extraction failures leave the archive intact. Installation failure attempts rollback and reports the backup location if recovery fails. If the subsequent bundle build fails, the refreshed archive remains: fix the reported problem and rerun `uv run pqkb build`.

Recognized secret values become `<redacted>`; public OAuth client IDs remain. Redaction is heuristic, and git history retains earlier content. Stripped resources and redacted values can prevent these sources from running as connectors.

## Automation

The [weekly refresh](.github/workflows/refresh.yml) runs Mondays at 03:23 UTC and supports manual dispatch. It opens a PR, validates its exact commit, and merges passing updates without bypassing repository restrictions. If an `ANTHROPIC_API_KEY` repository Actions secret is configured, the refresh installs the pinned Claude Code CLI and reviews changed candidates automatically. Without that secret, unchanged assessments are reused and new or stale assessments leave a draft PR. The local Claude subscription login is not transferred to GitHub. Failed content checks or expired pattern-prose reviews also leave a draft PR; a failed secret scan prevents PR creation.

The [Pages workflow](.github/workflows/pages.yml) validates and publishes `master`. Bot merges explicitly dispatch publication because their push events do not trigger another workflow. GitHub Pages and Actions PR permissions are already configured.

## Repository layout

- `connectors/`: extracted vendor source and package metadata.
- `knowledge/`: authored patterns, source-bound candidate assessments, and the refresh log.
- `src/pqkb/`: refresh, redaction, detection, review checks, and rendering.
- `build/`: generated OKF bundle and website; ignored by git and safe to regenerate.
- `tests/`: pipeline, source-excerpt, and review-validity checks.

## License

Tools and original documentation use the [MIT license](LICENSE). Extracted source, quoted excerpts, trademarks, and other vendor material retain their owners' rights. This project is not affiliated with Microsoft or the connector vendors.
