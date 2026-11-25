# Vendored OKF viewer

Copied from `open-knowledge-format/open-knowledge-format` at commit
`527e81aff55992be21507e97004286789126f88c`
(`src/reference_agent/viewer/` and `src/reference_agent/bundle/document.py`),
Apache-2.0 (see `skills/OKF-LICENSE.md`). The only change is the import path:
`reference_agent.bundle.document` and `reference_agent.viewer.generator` became
`pqkb.viz.document` and `pqkb.viz.generator`. Re-sync by copying the same files
again and reapplying those two import edits.
