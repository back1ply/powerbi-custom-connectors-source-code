# Power Query Connector Source Reference

[Browse the reference site](https://back1ply.github.io/power-bi-custom-connectors-source-code/): connector source links, topics that follow the Power Query SDK concepts (each with its source-reviewed patterns and the connectors that use each approach), and a refresh log.

This unofficial archive extracts Microsoft's certified Power BI connector packages for studying Power Query (M). Pattern explanations and excerpts live in `knowledge/patterns/`, and `knowledge/topics.yaml` files each pattern under a Power Query SDK topic. Which connectors use each approach comes from per-connector checklist profiles (`knowledge/profiles/`), checked against hand labels in `evals/`. These are source-reading results, not runtime verification. See the [source-review record](docs/REVIEW.md) for scope and review validity, and [the roadmap](docs/ROADMAP.md) for planned work.

## For agents and LLMs

Start at [`bundle/index.md`](bundle/index.md), the generated [Open Knowledge Format v0.3](https://github.com/open-knowledge-format/open-knowledge-format/blob/main/SPEC.md) bundle. [`AGENTS.md`](AGENTS.md) says where to go for each task and which skill to use; the `skills/` folder installs as a plugin from this repository's marketplace. The site also publishes [`llms.txt`](https://back1ply.github.io/power-bi-custom-connectors-source-code/llms.txt).

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
uv run mkdocs build --strict
```

- `pqkb build` regenerates `bundle/` from `connectors/` and `knowledge/` without downloading packages. Preview the site with `uv run mkdocs serve`; static output, including `llms.txt`, goes to `build/site/`.
- `pqkb functions <Connector>` lists each top-level function with its file, line range, and the functions it calls (`--json` for agents).
- `pqkb certification [Connector]` checks source against Microsoft's published certification rules (MUST, SHOULD, and security items from the [archived certification page](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)); every connector page shows the result. These are static source checks, not Microsoft's review.
- `pqkb profile`, `pqkb eval`, and `pqkb check-profiles` answer the checklist in `knowledge/checklist.yaml` with an LLM, score the answers against the hand-labelled sets in `evals/`, and validate answer files. The checklist questions follow the Power Query SDK "Handling …" topics on Microsoft Learn.
- `pqkb verify-reviews` reports pattern pages whose prose or cited source changed since review; it does not fail CI.
- `pqkb viz` writes the official OKF graph viewer to `build/viz.html` for local use; it is not published.

## Pattern pages

Each pattern compares source implementations, explains their dependencies and failure paths, and lists adaptation checks. Excerpts are exact archived source, tested against the cited lines; they are not standalone runnable connectors. When the cited source changes, the page is labelled "Changed since review" instead of blocking anything; the [source-review record](docs/REVIEW.md) explains how reviews expire and are renewed.

## Refreshing the archive

```powershell
uv run pqkb refresh
```

Refresh downloads the newest package per connector from Microsoft's feed, extracts and redacts the source, replaces `connectors/`, and rebuilds `bundle/`. A [weekly workflow](.github/workflows/refresh.yml) does this every Monday and merges the result when checks pass; the [Pages workflow](.github/workflows/pages.yml) publishes `main`. Local packages, failure handling, and the refresh PR report are covered by the `refresh-archive` skill.

Recognized secret values become `<redacted>`; public OAuth client IDs remain. Redaction is heuristic, and git history retains earlier content. Stripped resources and redacted values can prevent these sources from running as connectors.

## Repository layout

- `connectors/`: extracted vendor source and package metadata.
- `knowledge/`: authored patterns, the checklist and topic mapping, connector profiles, and the refresh log.
- `bundle/`: generated OKF bundle (connector, topic, and pattern pages, indexes, log); committed, never edited by hand.
- `evals/`: hand-labelled checklist answers, their final scores, and the connector-writing trial.
- `reference/`: Microsoft's sample connectors and SDK test queries, vendored under MIT.
- `skills/`: agent skills, including the vendored official OKF skills.
- `src/pqkb/`: refresh, redaction, profiling, certification checks, rendering, site hooks, and the vendored OKF viewer (`viz/`).
- `tests/`: pipeline, source-excerpt, review-validity, topic, and site checks.
- `docs/`: the source-review record and the roadmap.
- `build/`: website and local viewer output; ignored by git.

## License

Tools and original documentation use the [MIT license](LICENSE). The vendored OKF skills and viewer are Apache-2.0 ([notice](skills/OKF-LICENSE.md)). Extracted source, quoted excerpts, trademarks, and other vendor material retain their owners' rights. This project is not affiliated with Microsoft or the connector vendors.
