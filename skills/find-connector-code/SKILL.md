---
name: find-connector-code
description: Find how Microsoft's certified Power Query (M) connectors implement something, using this repository's connector source archive and its OKF bundle. Use this skill when the user asks how real Power BI or Excel connectors do authentication (OAuth, PKCE, keys), paging, navigation tables, query folding (Table.View, ODBC, native queries), retries, error handling, schemas, or packaging; asks for an example connector to copy from; or wants M code that a certified connector uses. Read-only.
license: MIT
metadata:
  version: "0.1.0"
---

# Find connector code

This repository holds the extracted source of Microsoft's certified Power Query
connectors (`connectors/`) and a generated Open Knowledge Format bundle
(`bundle/`) that indexes it. Answer from that code. It is archived source, not
runtime-tested; say so when it matters.

## Where things are

| Path | What it is |
| --- | --- |
| `bundle/index.md` | Start here: what the bundle covers and its sections. |
| `bundle/patterns/<id>.md` | Guides to one technique each (pagination, oauth2, pkce, table-view, odbc, errors, retry-polling, ...), with quoted excerpts and links to the source lines. Pattern pages are listed under their topic in `bundle/topics/`. |
| `bundle/connectors/<Name>.md` | One page per connector: publisher, version, authentication kinds, source files, and the patterns detected in it with line links. |
| `bundle/topics/<question>.md` | One topic per checklist question in SDK order: the patterns that explain it and every archived connector grouped by its answer, with the cited line. |
| `connectors/<Name>/` | The connector's real M source (`.pq`, `.pqm`, `.m`) and resources. |
| `connectors/index.json` | Machine-readable list: name, title, publisher, version, files. |

## Procedure

1. **Find candidates.** For a technique, read the matching `bundle/patterns/<id>.md`
   for how it works and which connectors it cites. Connector pages list source
   files and authentication kinds; `bundle/topics/auth.md` groups connectors by
   authentication kind. For a library function or identifier, search the source
   directly:

   ```bash
   rg -n "Table.GenerateByPage" connectors --glob "*.{pq,pqm,m}"
   rg -l "Authentication\s*=" connectors
   ```

   With the OKF MCP server (`.mcp.json`), use its search and neighbour tools
   instead of reading files one by one.
2. **Read the code, not just the match.** M is a nested functional language: a
   match can sit inside an unused helper. Open the whole top-level binding around
   the match, and follow what calls it (the `shared` entry point, the navigation
   table, the `Authentication` record) before claiming a connector uses it.
3. **Check freshness.** A pattern page with a "Changed since review"
   banner, or a past `stale_after`, may quote outdated lines; confirm against the
   file in `connectors/`. The `okf-consume` skill explains trust tiers and
   staleness if the user asks how far to trust a page.
4. **Answer with citations.** Give the connector, file, and line, and quote the
   relevant lines. When the user wants a URL, take the GitHub link from the
   connector's page in `bundle/connectors/` (its `sources`) and add `#L<line>`. Name more than one connector when they implement it
   differently.

## Rules

- Do not modify the repository; maintenance has its own skills.
- Extracted connector source keeps its owners' rights. Quote what the user needs;
  do not present vendor code as this repository's own.
- A connector missing from a pattern's tag list does not prove it lacks the
  technique; detection is static and approximate.
