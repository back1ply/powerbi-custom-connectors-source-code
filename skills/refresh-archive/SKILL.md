---
name: refresh-archive
description: Refresh this repository's archive of Microsoft's certified Power Query connectors and rebuild its OKF bundle, then read the refresh report and handle failures. Use this skill when asked to update the connector archive, run or debug the weekly refresh workflow, fix a failing refresh pull request, rebuild bundle/, or re-sync the vendored OKF skills.
license: MIT
metadata:
  version: "0.1.0"
---

# Refresh the archive

The weekly workflow `.github/workflows/refresh.yml` (Mondays 03:23 UTC) downloads
the newest certified connector packages, rebuilds `bundle/`, and opens the PR
"Refresh certified connectors from Microsoft" on branch
`automation/certified-connectors`. It merges that PR automatically when tests,
lint, the OKF validator, the secret scan, and the site build pass. Review drift
is reported in the PR body but never blocks.

## Run locally

```bash
uv sync --locked --group site
uv run pqkb refresh            # download, extract, redact, rebuild bundle/, log
uv run pqkb build              # rebuild bundle/ only (no download)
uv run pytest -q
uv run ruff check src tests && uv run ruff format --check src tests
uv run python skills/okf-generate/scripts/validate.py bundle
uv run --group site mkdocs build --strict
```

`pqkb refresh --source-dir <folder>` uses a complete local set of `.mez`/`.pqx`
packages instead of downloading. Never edit files in `bundle/` by hand; change
`knowledge/` or `src/pqkb/` and rebuild.

## Read the refresh PR

| Report line | Meaning | Action |
| --- | --- | --- |
| Source excerpts and pipeline: failure | `pytest` failed | Fix the code or test; never weaken an assertion. |
| Lint, metadata, and links: failure | ruff or the OKF validator failed | Run the commands above and fix the errors. |
| Pattern review drift: failure | Some pattern pages cite code that changed | Not blocking. Renew them with the `review-pattern` skill when convenient. |
| Site build: failure | `mkdocs build --strict` failed | Usually a broken link in a pattern page. |

After fixing on the refresh branch, dispatch the "Validate reference" workflow
on it, then merge. A merge by the workflow's own token does not trigger push
workflows, so the refresh dispatches publishing itself.

## Re-sync the vendored OKF skills

`skills/okf-generate` and `skills/okf-consume` are vendored unmodified. To update
them, follow `skills/VENDORED.md`, then run the validator above and the tests.
