---
name: review-pattern
description: Renew the source review of a pattern page in this repository after the connector code it quotes has changed, by checking every claim against the current source, repairing excerpts and line references, and recording the review honestly. Use this skill when a pattern page shows "Source changed since review", when `pqkb verify-reviews` lists drifted pages, or when asked to update or re-review knowledge/patterns/*.md.
license: MIT
metadata:
  version: "0.1.0"
---

# Renew a pattern review

Pattern pages live in `knowledge/patterns/<id>.md`. Each carries a `review`
block with fingerprints of its own text and of every cited connector file.
When cited code changes, `uv run pqkb verify-reviews` lists the page and the
build marks its copy in `bundle/` as stale with a banner. Nothing blocks; this
skill clears the flag properly.

## Rules

1. **Review before recording.** Never call `record_review` to make a check pass.
   A recorded review means an agent or person checked every claim on the page
   against the cited source.
2. **Record who actually reviewed.** Use your own actor, `<tool>/<model>`, for
   example `claude-code/claude-opus-5-5`. Never write a `human:` actor unless that
   person reviewed the page and asked you to record it.
3. **Keep what you did not review.** Do not reword unrelated prose; do not touch
   other pages' fingerprints.

## Procedure

1. List drifted pages: `uv run pqkb verify-reviews`.
2. For each page, find what changed. For every cited file in the page's
   `sources`, diff the archive against the last reviewed state, for example
   `git log -p -- connectors/<Name>/<file>`.
3. Classify each source:
   - **Lines only moved:** update every `#L<n>` resource and every "lines a–b"
     reference by the shift; confirm the boundary lines at their new positions.
   - **Code changed outside the cited ranges:** confirm no claim depends on it.
   - **Code changed inside a cited range:** re-read the function and its callers,
     rewrite the affected claims, and copy excerpts again from the file exactly.
4. Check every remaining claim against the source, including footnotes.
5. Verify: `uv run pytest -q tests/test_knowledge.py` (excerpts must match the
   cited lines exactly once the review is current).
6. Record the review:

   ```bash
   uv run python -c "from datetime import datetime, UTC; from pathlib import Path; from pqkb.reviews import record_review; record_review(Path.cwd(), Path('knowledge/patterns/<id>.md'), '<tool>/<model>', datetime.now(UTC))"
   ```

7. Rebuild and confirm: `uv run pqkb build && uv run pqkb verify-reviews`, then run
   the full test suite. Commit the page and the regenerated `bundle/` together,
   and summarize per page what changed and what you checked.

A link-only migration (for example a renamed branch in source URLs) may update
`content_sha256` without a review, as long as `verified` is left unchanged and
the commit message says it is a migration.
