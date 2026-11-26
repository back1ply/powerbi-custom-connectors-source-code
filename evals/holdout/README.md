# Held-out labels

Gold labels for connectors that were never used to tune the checklist definitions or the
profiler prompt. They were labelled blind, before any model profiled these connectors.

Use them only to measure: `uv run pqkb eval --gold evals/holdout --profiles <dir>`.
Do not change definitions or prompts in response to mistakes found here; once a fix is
tuned on a held-out connector, move that connector to `evals/gold/` and label new ones.
