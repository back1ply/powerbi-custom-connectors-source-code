"""MkDocs presentation hooks; the portable OKF Markdown stays unchanged."""

import html
import re
from collections import defaultdict
from pathlib import Path

from pqkb import frontmatter, repo
from pqkb.bundle import load_patterns
from pqkb.excerpts import Excerpt, excerpts
from pqkb.topics import TOPICS_DIR, load_topics, topic_menu


def on_config(config):
    # Set here, not in mkdocs.yml, so the site follows the repository's current name.
    config.site_url = repo.pages_url()
    config.repo_url = repo.github_url()
    config.repo_name = "GitHub"
    root = Path(config.docs_dir)
    patterns = load_patterns(root / "patterns")
    summaries = {p.pattern_id: (p.title, p.doc.meta["description"]) for p in patterns}
    topics = load_topics(Path(config.config_file_path).parent, summaries)
    config.nav = [
        {"Overview": "index.md"},
        {"Connectors": connectors_nav(root / "connectors")},
        *topic_menu(topics),
        {"Refresh log": "log.md"},
    ]
    return config


def connectors_nav(folder: Path) -> list:
    """The connector index, then connector pages grouped by first letter."""
    groups = defaultdict(list)
    for path in folder.glob("*.md"):
        if path.name == "index.md":
            continue
        title = frontmatter.read(path).meta["title"]
        letter = title[0].upper() if title[0].isascii() and title[0].isalpha() else "#"
        groups[letter].append((title, path.name))
    nav: list = ["connectors/index.md"]
    for letter, pages in sorted(groups.items()):
        entries = sorted(pages, key=lambda item: item[0].lower())
        nav.append({letter: [{title: f"connectors/{name}"} for title, name in entries]})
    return nav


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
    llms = llms_txt(Path(config.docs_dir), config.site_url, config.repo_url)
    (Path(config.site_dir) / "llms.txt").write_text(llms, encoding="utf-8", newline="\n")


def llms_txt(bundle_root: Path, site_url: str, repo_url: str) -> str:
    """Render an llms.txt index (llmstxt.org) that points at the raw bundle Markdown."""
    raw = repo_url.replace("https://github.com/", "https://raw.githubusercontent.com/")
    raw = f"{raw.rstrip('/')}/main/bundle"
    root = frontmatter.read(bundle_root / "index.md").meta

    def entries(folder: str, pattern: str = "*.md") -> list[str]:
        lines = []
        for page in sorted((bundle_root / folder).glob(pattern)):
            if page.parent == bundle_root / folder and page.name == "index.md":
                continue
            meta = frontmatter.read(page).meta
            description = " ".join(str(meta.get("description", "")).split())
            path = page.relative_to(bundle_root).as_posix()
            lines.append(f"- [{meta['title']}]({raw}/{path}): {description}")
        return lines

    return "\n".join(
        [
            f"# {root['title']}",
            "",
            f"> {' '.join(root['description'].split())}",
            "",
            "Each link is the raw Markdown of one page of the Open Knowledge Format bundle. "
            f"Connector source is under {repo_url}/tree/main/connectors.",
            "",
            "## Patterns",
            "",
            *entries("patterns"),
            "",
            "## Connectors",
            "",
            *entries("connectors"),
            "",
            "## Topics",
            "",
            *entries(TOPICS_DIR, "*/index.md"),
            "",
            "## Optional",
            "",
            f"- [Bundle index]({raw}/index.md): sections of the bundle",
            f"- [Refresh log]({raw}/log.md): archive refresh history",
            f"- [Bundle download]({site_url.rstrip('/')}/knowledge.zip): the whole bundle as a zip",
            "",
        ]
    )
