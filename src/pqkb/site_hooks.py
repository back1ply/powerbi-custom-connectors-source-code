"""MkDocs presentation hooks; the portable OKF Markdown stays unchanged."""

import html
import re
from collections import defaultdict
from pathlib import Path

from pqkb import frontmatter
from pqkb.bundle import load_patterns, patterns_by_category
from pqkb.excerpts import Excerpt, excerpts


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
    document = frontmatter.Document(page.meta, page.markdown)
    by_id = {excerpt.source_id: excerpt for excerpt in excerpts(document)}
    pattern = r"<!-- source: ([\w-]+) -->\s*<pre[^>]*>"
    return re.sub(pattern, lambda match: source_header(by_id[match.group(1)]), content)


def source_header(excerpt: Excerpt) -> str:
    url = html.escape(
        excerpt.resource.split("#", 1)[0] + f"#L{excerpt.start}-L{excerpt.end}", quote=True
    )
    title = html.escape(excerpt.title)
    return (
        f'<p class="source-reference"><strong>{title} · '
        f"lines {excerpt.start}–{excerpt.end}</strong> "
        f'<a href="{url}" target="_blank" rel="noopener">Open original source ↗</a></p>'
        f'<pre id="source-{excerpt.source_id}" '
        'class="highlight line-numbers linkable-line-numbers" '
        f'data-start="{excerpt.start}" data-line-offset="{excerpt.start - 1}">'
    )


def on_post_build(config):
    import shutil

    destination = Path(config.site_dir) / "assets"
    for asset in (Path(config.config_file_path).parent / "site-assets").iterdir():
        shutil.copyfile(asset, destination / asset.name)
