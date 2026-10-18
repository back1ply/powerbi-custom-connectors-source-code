# Power Query Connector Source Reference

An unofficial archive of source extracted from Microsoft's certified Power BI connector packages, with a generated knowledge bundle for browsing implementation patterns.

Start with the [pattern directory](knowledge/patterns/index.md), [connector directory](knowledge/connectors/index.md), [authentication and pattern tags](knowledge/tags/index.md), or [refresh log](knowledge/log.md).

The bundle uses [Open Knowledge Format v0.2](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/62432a095456147ee71e70ac6e4dc0d2dea3ac30/okf/SPEC.md). Patterns have an explicitly attributed agent source review; the [review report](REVIEW.md) describes its scope and corrections. Each includes a real source excerpt and a generated list of regex matches; matches can include comments or helper definitions and do not establish runtime behavior.

## Build and check

Install Python 3.12 or newer and [uv](https://docs.astral.sh/uv/). From the repository root:

```powershell
uv sync --locked
uv run pqkb build
uv run pytest -q
uv run ruff check tools tests
uv run okflint validate --manifest okf-base.yaml
uv run pqkb verify-reviews
```

`build` uses the existing archive without downloading packages. It generates connector pages, pattern match lists, indexes, and an initial log entry when no log exists. Unchanged pages retain their content-generation timestamps. Pattern explanations and excerpts are maintained in `knowledge/patterns/`; tests check excerpts against their cited source files.

`verify-reviews` checks the reviewed prose, detection rules, citation metadata, and complete cited files against recorded fingerprints. It fails for missing or expired reviews. A build returns affected reviewed pages to draft and removes their current verification event. Generated match-list changes alone preserve the review. Renewing a review requires checking the source; passing a hash comparison is not a substitute for that work.

`okflint` is pinned in `uv.lock`. Its optional v0.2 shape checks still expect date-only `stale_after` values, so that check family is disabled in `okf-base.yaml`; repository tests check timezone-aware timestamps instead. Core, project-profile, and internal-link checks remain enabled.

## Refresh from Microsoft

```powershell
uv run pqkb refresh
```

This selects the highest package version per connector from Microsoft's certified-extension manifest, downloads and extracts the packages, removes images and packaging resources, redacts recognized secret values, replaces `connectors/`, and rebuilds the bundle. Connectors absent from the manifest are removed. Version additions, updates, and removals are recorded in the refresh log. Selection does not filter by Power BI engine compatibility.

Every successful refresh updates connector verification times and extends `stale_after` by 14 days, including when package versions do not change. The log records those unchanged checks too. Verification here means that the archive was refreshed and its generated reference rebuilt; it does not claim runtime testing of vendor connectors or human review of patterns.

The replacement is staged: download or extraction failures stop before the archive is replaced. Installation failure attempts to restore the previous archive. If restoration also fails, the error reports a retained backup path for recovery. If the subsequent bundle build fails, the refreshed archive remains; correct the reported problem and run `uv run pqkb build`. A changed source excerpt needs a corresponding review and update to its pattern page.

For a complete local package set:

```powershell
uv run pqkb refresh --source-dir 'C:\packages\certified-connectors'
```

The folder is scanned recursively for `.mez` and `.pqx` files. Missing or empty folders, duplicate connector names, corrupt packages, and packages without M source stop before replacement. The folder must be outside `connectors/`. Supply the full set to retain: connectors absent from it are removed. Publisher, version, and package URL are left unknown in local mode; do not assume that local packages are certified.

Client secrets, API keys, passwords, and secret resource files recognized by the redaction rules become `<redacted>`. OAuth client IDs remain public identifiers. Redaction is heuristic; it does not guarantee removal of every possible credential. Historical commits retain their original contents. The archive is a reading reference; stripped resources and redacted values can prevent it from running as a connector.

The Python CLI replaces the old PowerShell downloader and refresh scripts. Their cleaned, redacted output was compared on fixture `.mez` and `.pqx` packages; the older manual extraction, cleanup, and extension-listing utilities remain in `scripts/`. The earlier tutorials in `docs/` remain historical material; the reviewed bundle is the maintained reference.

## Weekly updates

The [refresh workflow](.github/workflows/refresh.yml) runs on Mondays at 03:23 UTC and supports manual dispatch. It refreshes the archive and opens or updates a PR on `automation/certified-connectors`. Routine updates merge automatically only after tests, source-review checks, lint, metadata, links, and the site build pass. A second validation run checks the exact PR commit before merging; the merge command also requires that head commit to remain unchanged. Existing repository merge restrictions still apply.

Changed reviewed sources or explanations require a renewed agent or human source review. Those failures and other failed content checks leave a draft PR; a failed secret scan blocks PR creation. After repair, **Validate reference** can be dispatched on the branch. The workflow never uses administrative bypass flags to merge.

GitHub suppresses push-triggered workflows for changes made with `GITHUB_TOKEN`, so a successful automated merge explicitly dispatches publication. It does not rely on a PR workflow approval prompt for unattended validation. These token rules are described in [GitHub's workflow-trigger documentation](https://docs.github.com/en/actions/how-tos/write-workflows/choose-when-workflows-run/trigger-a-workflow#triggering-a-workflow-from-a-workflow).

## Preview the site

```powershell
uv sync --locked --group site
uv run --group site mkdocs build --strict
uv run --group site mkdocs serve
```

The static output is written to `public/`. The local server prints its preview URL. The [validation workflow](.github/workflows/validate.yml) builds the same preview and uploads it as an artifact only after its checks and secret scans pass.

Power Query highlighting uses Prism 1.30.0 from a CDN and requires network access in the browser. The text remains readable when those assets are unavailable.

## One-time GitHub activation

Push or merge the commits to `master`, allow Actions to create PRs in the repository workflow settings, and select **GitHub Actions** as the Pages source. These are repository settings, not recurring review steps. The [create-pull-request action documents the required PR permission](https://github.com/peter-evans/create-pull-request/tree/v7#workflow-permissions).

The [Pages workflow](.github/workflows/pages.yml) publishes validated `master` commits automatically and supports manual dispatch. It has no human-review checkbox. Both publication paths require current source-bound reviews and publish only the artifact produced by validation. Normal weekly updates then need no intervention; review expiry, failing checks, and repository merge restrictions are the exceptions.

## Layout

- `connectors/`: extracted vendor source and generated package metadata in `index.json`.
- `knowledge/`: generated connector pages, source-reviewed patterns, indexes, and refresh log.
- `tools/pqkb/`: Python refresh, redaction, detection, and bundle-generation code.
- `tests/`: pipeline checks and source-excerpt verification.
- `PLAN.md`: rebuild plan and current progress.

## License and attribution

Tools and original documentation are covered by the [MIT license](LICENSE). Extracted connector source, quoted excerpts, trademarks, and vendor material retain their respective owners' rights; this repository does not relicense them. This project is not affiliated with Microsoft or the connector vendors.
