# Repository instructions

## CodeScene

After changing code, run `code_health_review` on the changed files. If Code
Health drops, fix the issues, run the review again, and use `code_health_score`
to confirm the result. Target Code Health 10.0, as required by the parent
instructions. Before finishing, run `pre_commit_code_health_safeguard` and
resolve reported regressions. Run `analyze_change_set` before opening a PR.

## Generated knowledge

Scripts generate connector pages, indexes, counts, and pattern detection lists.
Edit pattern explanations in `knowledge/patterns/`; rebuild with `uv run pqkb build`.
Keep patterns as drafts until a human reviews them. Never attribute human
verification to an automated check.
