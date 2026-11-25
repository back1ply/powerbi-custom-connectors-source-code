---
name: run-candidate-reviews
description: Run, retry, and check the LLM candidate reviews that confirm or reject this repository's static pattern matches per connector (stored in knowledge/match-reviews.json). Use this skill when asked to review pattern candidates, refresh "Unreviewed match" or "older review" labels on connector pages, run `pqkb review-matches`, or investigate candidate review failures.
license: MIT
metadata:
  version: "0.1.0"
---

# Run candidate reviews

The static scanner finds connectors that may use each pattern. An LLM then
reviews each connector's candidates against selected source windows and records
supported, uncertain, or rejected verdicts with exact quotes in
`knowledge/match-reviews.json`. These reviews are advisory: they label matches
on connector pages and never block a refresh.

## Run

```bash
uv run pqkb review-matches                     # Claude Code CLI, haiku model
uv run pqkb review-matches --provider opencode # OpenCode + DeepSeek Flash
uv run pqkb build
uv run pqkb verify-matches                     # report coverage; no LLM calls
```

The Claude provider uses the locally installed, signed-in `claude` CLI with tools
and MCP servers disabled. The OpenCode provider needs OpenCode 2.0.32 and
`OPENROUTER_API_KEY`. Only connectors without a current, valid review are sent.
Each completed connector is saved immediately, so an interrupted run loses
nothing.

## Failures

A connector fails when the model's answer does not validate: a candidate is
missing or duplicated, a quote is not an exact substring of a supplied line, or
a supported verdict cites no meaningful line at a detected signal. Rerun
`pqkb review-matches`; only the failed connectors are retried. If one keeps
failing, try the other provider. Never edit `match-reviews.json` by hand to make
a review pass.

## What the labels mean

| Label on a connector page | Meaning |
| --- | --- |
| (no label) | Current review supports the match. |
| Uncertain match | Current review could not establish the wiring. |
| Unreviewed match | No review has assessed this candidate. |
| Match from a review of older source / (older review) | The connector's code changed since its review; the last verdict is kept until it is reviewed again. |

Rejected matches are hidden from the pages but kept in the review record.
