# Vendored skills

`okf-generate` and `okf-consume` are copied unmodified from the official Open
Knowledge Format repository. Do not edit them here; re-sync instead.

| Field | Value |
| --- | --- |
| Source | https://github.com/open-knowledge-format/open-knowledge-format/tree/main/skills |
| Commit | `527e81aff55992be21507e97004286789126f88c` |
| Commit date | 2026-11-18 |
| License | Apache-2.0, see [OKF-LICENSE.md](OKF-LICENSE.md) |

`okf-generate/scripts/validate.py` is the bundle validator that CI runs.

## Re-sync

```bash
tmp=$(mktemp -d)
git clone --depth 1 --filter=blob:none --sparse https://github.com/open-knowledge-format/open-knowledge-format "$tmp/okf"
git -C "$tmp/okf" sparse-checkout set skills
rm -rf skills/okf-generate skills/okf-consume
cp -r "$tmp/okf/skills/okf-generate" "$tmp/okf/skills/okf-consume" skills/
cp "$tmp/okf/LICENSE.md" skills/OKF-LICENSE.md
git -C "$tmp/okf" log -1 --format='%H %cs'   # record the new commit above
```
