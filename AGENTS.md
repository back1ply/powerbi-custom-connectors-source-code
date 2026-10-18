# Repository instructions

## CodeScene

After changing code, run `code_health_review` on the changed files. If Code
Health drops, fix the issues, run the review again, and use `code_health_score`
to confirm the result. Target Code Health 10.0, as required by the parent
instructions. Before finishing, run `pre_commit_code_health_safeguard` and
resolve reported regressions. Run `analyze_change_set` before opening a PR.

## Generated knowledge

Authored patterns and refresh history live in `knowledge/`.
Render connector pages, indexes, counts, and match lists into ignored `build/knowledge/`.
Never commit generated output or edit it as a source.
Edit pattern explanations in `knowledge/patterns/`; rebuild with `uv run pqkb build`.
The user delegated source review to agents and requested hands-off maintenance.
An agent may mark a pattern stable after checking every claim against its cited
source, recording its own actor identity and source/content fingerprints.
Never attribute human verification to an agent or a deterministic check.
Changed reviewed content or cited source invalidates the review and blocks
automatic publication until an agent or human renews it. Generated match-list
changes alone do not invalidate an otherwise unchanged source review.

After completing a source review, use `reviews.record_review(repo, path,
reviewer, now)` from `src/pqkb/reviews.py` to record the actual reviewer and
current fingerprints. Then build, run `pqkb verify-reviews`, and run the tests.
Never call the recording function merely to make a failing check pass.
