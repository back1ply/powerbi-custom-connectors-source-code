You are labelling the GOLD SET for an evaluation. Accuracy matters more than speed: these labels are the ground truth that an LLM's answers will be scored against.

Repository (read-only except for your output files): this repository; run commands from its root, the folder that holds `AGENTS.md`.
- Connector source: `connectors/<Name>/` (`.pq`/`.m` section documents, `.pqm` modules, `Config.json`, `.resx`, etc.).
- The questions and allowed answer ids: `knowledge/checklist.yaml`. Read it first and use ONLY its answer ids.
- Function index: run `uv run pqkb functions <Name>` from the repo root (lists every top-level function with file, line range, and calls). Use it to navigate, then read the full source. Read every source file of the connector, including `.pqm` modules; do not label from function names alone.

For EACH connector assigned to you, write `evals/gold/<Name>.yaml` (exact folder name as in `connectors/`). Do not modify any other file. Do not run git commands.

Format (YAML):

```yaml
connector: <Name>
labelled_by: claude-code/<your model id>
source_note: <one line: files read, total lines>
answers:
  auth:
    values: [oauth]            # answer ids from checklist.yaml; several only if multi: true
    evidence:
      - {file: Asana.m, lines: "81-90", function: Asana, note: "Authentication = [OAuth = [StartLogin, FinishLogin, Refresh]]"}
    sub:
      oauth-pkce:
        values: [yes]
        evidence: [{file: Asana.m, lines: "217-241", function: GenerateCodeVerifier, note: "code_challenge S256"}]
      oauth-refresh:
        values: [yes]
        evidence: [...]
  http-errors:
    values: [not-applicable]   # only when the question's applies_when excludes this connector
  paging:
    values: [none]
    evidence: [...]            # for "none"/negative answers, cite where data is fetched to show no paging
    sub: {}
  ...                          # every top-level question id, in checklist order
notes: |
  Anything ambiguous: dead code, disabled branches, helpers defined but never called, behaviour that depends on runtime options.
```

Rules:
1. Answer every top-level question. Answer a sub-question only when its `when` answers were given (sub-questions with no `when` are always answered). `free_text: true` sub-questions use `text: "..."` instead of `values`, plus evidence.
2. An answer must reflect code that is actually wired and reachable from the connector's entry points (`shared` functions, the data source kind record, `Publish`). If a helper exists but is never called, do NOT count it; mention it in `notes`.
3. Evidence: every non-negative value needs at least one citation with the file, exact 1-based line range, and the function name. Line numbers must be correct: verify them against the file.
4. Use `other` only when no answer id fits, and explain it in that evidence note. Never invent answer ids.
5. `http-errors`: "default" means status codes are left to the engine's default handling for the requests that matter; list `manual-status-handling` if any request sets `ManualStatusHandling`, `retry-with-delay` if it re-issues requests after a delay, `rate-limit-aware` only if it specifically handles 429 or Retry-After.
6. `user-inputs` is about the parameters of the shared entry function(s) and any options record they accept.
7. When done, reply with a short summary per connector: the answers in one line, and any judgement calls you were unsure about.

Your assigned connectors:
