from types import SimpleNamespace

import pytest

from pqkb import frontmatter, site_hooks
from pqkb.excerpts import excerpts


def document(body):
    return frontmatter.Document(
        {
            "sources": [
                {
                    "id": "example",
                    "title": "First.pq",
                    "resource": "https://example.com/First.pq#L12",
                },
                {
                    "id": "variant",
                    "title": "Second.pq",
                    "resource": "https://example.com/Second.pq#L39",
                },
            ]
        },
        body,
    )


BODY = """<!-- source: example -->
```powerquery
first = 1;
```

<!-- source: variant -->
```powerquery
second =
    2;

```"""


def test_each_rendered_excerpt_has_its_own_source_range_and_line_anchor():
    source = document(BODY)
    page = SimpleNamespace(
        file=SimpleNamespace(src_uri="patterns/demo.md"), meta=source.meta, markdown=source.body
    )
    content = (
        "<!-- source: example -->\n<pre><code>first = 1;</code></pre>\n"
        "<!-- source: variant -->\n<pre><code>second =\n    2;\n\n</code></pre>"
    )
    result = site_hooks.on_page_content(content, page)
    assert 'href="https://example.com/First.pq#L12-L12"' in result
    assert 'href="https://example.com/Second.pq#L39-L41"' in result
    assert 'id="source-example"' in result
    assert 'id="source-variant"' in result
    assert 'data-start="39" data-line-offset="38"' in result
    assert "<code>second =\n    2;\n\n</code>" in result


def test_unmarked_second_excerpt_cannot_silently_use_the_first_source():
    with pytest.raises(ValueError, match="Every Power Query excerpt"):
        excerpts(document(BODY.replace("<!-- source: variant -->", "")))
