# Pattern source review

Source reviews are performed by agents at the user's request. The user delegated
the review and requested maintenance with minimal manual work.
Current per-page verification events and fingerprints are in the pattern
frontmatter; `uv run pqkb verify-reviews` checks whether they still match.

The review checked each pattern's behavioral statements against its cited M
source, including surrounding functions, error branches, callback registration,
and configuration. Excerpts are also checked against the archive by pytest.
The reviewed pages are suitable as a source-reading reference. This review does
not execute vendor connectors, validate their API registrations, assess their
security, or certify their behavior in Power BI, Excel, or other hosts.

## Expanded guidance, 2026-10-19

All 20 existing explanations were expanded with execution paths, dependencies,
failure cases, selection guidance, and adaptation checks. Three topics were added:
asynchronous exports, date-range request filters, and function-parameter metadata.
The 23 pages contain 70 archived excerpts. Every excerpt is compared with its
cited file and line range by tests and receives separate source links on the site.

Claude Haiku (`claude-haiku-5-5`) drafted the expansions and performed separate
source audits. The drafting CLI also reported `claude-opus-5-5` advisor calls.
The supervising `codex/gpt-6` agent checked additional source ranges, resolved
findings, and checked language and host contracts against Microsoft references.
Verification events identify agent reviewers; they do not imply human approval.

The audit caught incorrect claims about refresh-token handling, URI parameter
types, current request hosts, option scope, and metadata preservation. It also
identified unused validation bindings, polling that accepts non-success states,
and different retry budgets at HTTP and GraphQL levels. These are source findings,
not results from executing the archived connectors.

## Corrections made

| Pattern | Finding and correction | Source evidence |
| --- | --- | --- |
| [Pagination](../knowledge/patterns/pagination.md) | Qualified offset/limit transmission with the actual `__sendsLimit(url)` condition. | [Attio request construction](../connectors/Attio/Attio.pq#L98) |
| [Native queries](../knowledge/patterns/native-query.md) | Described the alternative navigation-table binding without implying that it is always evaluated whenever display names are requested. | [Native-query handler and final selection](../connectors/CommonDataService/CommonDataService.pq#L75) |
| [ODBC](../knowledge/patterns/odbc.md) | Replaced an inferred UI effect with the literal `HideNativeQuery` option; the source alone does not establish a general UI contract. | [ODBC options](../connectors/AmazonAthena/AmazonAthena.m#L124) |
| [Web requests](../knowledge/patterns/web-requests.md) | Distinguished the inner null branches from `GetApiToken`'s declared `as record` return contract. | [Authentication helper](../connectors/Anaplan/Anaplan.pq#L655) |

## Review lifecycle

Stable patterns carry an agent verification event, a fingerprint of their
authored metadata and prose, and fingerprints of the complete cited files.
Generated match lists are excluded from authored review scope.
CRLF and LF line endings are treated equivalently.

Changing reviewed prose, authored metadata, citations, or cited source
expires the review. Since 2026-11-25 an expired review is reported, not
enforced: the authored page is left unchanged (frozen), and its copy in
`bundle/` gets OKF `stale_after` (the refresh receipt time) and a "Changed since
review" banner. OKF treats stale content as "check again", not as false.
The excerpt test enforces exact quotes only on pages whose review is current.
A new source review must check and, where necessary, repair the page before
recording replacement fingerprints (`skills/review-pattern`). Hashes detect
changes; they do not perform the review or authenticate a reviewer.

Refreshes merge automatically when tests, lint, the official OKF validator, the
secret scan, and the site build pass on the exact PR commit; review drift is
listed in the PR body without blocking. Pages
publication performs validation again. No workflow creates human-review labels
or blindly renews pattern source reviews.

## Link and actor migration, 2026-11-25

The repository's default branch was renamed from `master` to `main`, so every
source URL in the pattern pages moved from `blob/master` to `blob/main`. For the
23 pages whose reviews were current, `content_sha256` was recomputed for the new
URLs; `verified` events were not changed and no claim was re-reviewed. In 20
pages the combined verifier `claude/claude-haiku-5-5 + codex/gpt-6` was split into
two `verified` events with the same time, so each names one valid OKF actor.

## Unused field removal, 2026-11-28

The `category`, `tags`, and `detect` fields were removed from all 23 pages:
topics in `knowledge/topics.yaml` replaced the categories, and the scanner that
read `detect` was retired. Prose, citations, and cited source were unchanged.
`content_sha256` was recomputed; `verified` events were not changed and no claim
was re-reviewed.

## Presentation cleanup

On 2026-10-18, the agent checked the presentation-only diff: behavioral prose,
source excerpts, citation metadata, and cited source bytes were unchanged.
Repeated scope notices and generated match lists moved out of authored patterns;
the shared scope notice appears on the site overview. Review fingerprints were
updated for these deletions without attributing a human review.

## Connector candidate assessments (retired 2026-11-28)

An earlier pipeline scanned every connector for pattern evidence and had Claude
Haiku or DeepSeek Flash label each candidate as supported, uncertain, or rejected
(`knowledge/match-reviews.json`). These labels stopped appearing on the site on
2026-11-25, when per-connector checklist profiles (`knowledge/profiles/`, scored
against the hand labels in `evals/`) replaced them, and the pipeline was removed
on 2026-11-28. Its code, ledger, and review notes remain in git history at commit
3ee577b. They never renewed pattern-prose reviews.
