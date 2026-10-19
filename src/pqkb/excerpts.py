"""Associate each archived code excerpt with its cited source start line."""

import re
from dataclasses import dataclass
from urllib.parse import urlsplit

from pqkb.frontmatter import Document

FENCE = re.compile(r"```powerquery\n(.*?)\n```", re.DOTALL)
MARKED_FENCE = re.compile(r"<!-- source: ([\w-]+) -->\s*```powerquery\n(.*?)\n```", re.DOTALL)


@dataclass(frozen=True)
class Excerpt:
    source_id: str
    title: str
    resource: str
    start: int
    code: str

    @property
    def end(self) -> int:
        return self.start + len(self.code.split("\n")) - 1


def excerpts(document: Document) -> list[Excerpt]:
    blocks = MARKED_FENCE.findall(document.body)
    if len(blocks) != len(FENCE.findall(document.body)):
        raise ValueError("Every Power Query excerpt needs a <!-- source: ID --> marker")
    sources = {source["id"]: source for source in document.meta.get("sources", [])}
    result = []
    for source_id, code in blocks:
        source = sources[source_id]
        start = int(urlsplit(source["resource"]).fragment.removeprefix("L"))
        result.append(Excerpt(source_id, source["title"], source["resource"], start, code))
    return result
