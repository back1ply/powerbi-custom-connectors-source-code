"""MkDocs presentation hooks; the portable OKF Markdown stays unchanged."""

import html
import re
from collections import defaultdict
from pathlib import Path
from urllib.parse import urlsplit

from pqkb import frontmatter
from pqkb.bundle import load_patterns, patterns_by_category


def on_config(config):
    root = Path(config.docs_dir)
    patterns = ["patterns/index.md"]
    for category, pages in patterns_by_category(load_patterns(root / "patterns")).items():
        patterns.append(
            {
                category: [
                    {p.title: f"patterns/{p.pattern_id}.md"}
                    for p in sorted(pages, key=lambda p: p.title.lower())
                ]
            }
        )
    groups = defaultdict(list)
    for path in (root / "connectors").glob("*.md"):
        if path.name == "index.md":
            continue
        title = frontmatter.read(path).meta["title"]
        letter = title[0].upper() if title[0].isascii() and title[0].isalpha() else "#"
        groups[letter].append((title, path.name))
    connectors = ["connectors/index.md"]
    for letter, pages in sorted(groups.items()):
        connectors.append(
            {
                letter: [
                    {title: f"connectors/{name}"}
                    for title, name in sorted(pages, key=lambda item: item[0].lower())
                ]
            }
        )
    config.nav = [
        {"Overview": "index.md"},
        {"Patterns": patterns},
        {"Connectors": connectors},
        {"Connector tags": "tags/index.md"},
        {"Refresh log": "log.md"},
    ]
    return config


def on_page_content(content, page, **kwargs):
    if not page.file.src_uri.startswith("patterns/"):
        return content
    citation = next((s for s in page.meta.get("sources", []) if s["id"] == "example"), None)
    if citation is None:
        return content
    resource = citation["resource"]
    start = int(urlsplit(resource).fragment.removeprefix("L"))
    excerpt = re.search(r"```powerquery\n(.*?)\n```", page.markdown, re.S)
    if excerpt is None:
        return content
    end = start + len(excerpt.group(1).splitlines()) - 1
    url = html.escape(resource.split("#", 1)[0] + f"#L{start}-L{end}", quote=True)
    title = html.escape(citation["title"])
    reference = (
        f'<p class="source-reference"><strong>{title} · lines {start}–{end}</strong> '
        f'<a href="{url}" target="_blank" rel="noopener">Open original source ↗</a></p>'
    )
    pre = (
        '<pre id="source-example" class="highlight line-numbers linkable-line-numbers" '
        f'data-start="{start}" data-line-offset="{start - 1}">'
    )
    return re.sub(r"<pre[^>]*>", lambda match: reference + pre, content, count=1)


def on_post_build(config):
    import shutil

    destination = Path(config.site_dir) / "assets"
    for asset in (Path(config.config_file_path).parent / "site-assets").iterdir():
        shutil.copyfile(asset, destination / asset.name)
