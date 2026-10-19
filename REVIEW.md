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
| [Pagination](knowledge/patterns/pagination.md) | Qualified offset/limit transmission with the actual `__sendsLimit(url)` condition. | [Attio request construction](connectors/Attio/Attio.pq#L98) |
| [Native queries](knowledge/patterns/native-query.md) | Described the alternative navigation-table binding without implying that it is always evaluated whenever display names are requested. | [Native-query handler and final selection](connectors/CommonDataService/CommonDataService.pq#L75) |
| [ODBC](knowledge/patterns/odbc.md) | Replaced an inferred UI effect with the literal `HideNativeQuery` option; the source alone does not establish a general UI contract. | [ODBC options](connectors/AmazonAthena/AmazonAthena.m#L124) |
| [Web requests](knowledge/patterns/web-requests.md) | Distinguished the inner null branches from `GetApiToken`'s declared `as record` return contract. | [Authentication helper](connectors/Anaplan/Anaplan.pq#L655) |

## Review lifecycle

Stable patterns carry an agent verification event, a fingerprint of their
authored metadata and prose, and fingerprints of the complete cited files.
Generated match lists live only in `build/knowledge/` and are excluded from authored review scope.
CRLF and LF line endings are treated equivalently.

Changing reviewed prose, detection rules, citation metadata, or cited source
expires the review. A build returns an affected page to draft and removes its
current verification event. The recorded baseline remains available for drift
diagnosis. A new source review must check and, where necessary, repair the page
before recording replacement fingerprints. Hashes detect changes; they do not
perform the review or authenticate a reviewer.

Routine refreshes can merge automatically after all checks pass on the exact PR
commit. Expired reviews and other failures leave a draft PR for repair. Pages
publication performs validation again. No workflow creates human-review labels
or blindly renews pattern source reviews.

## Presentation cleanup

On 2026-10-18, the agent checked the presentation-only diff: behavioral prose,
source excerpts, citation metadata, and cited source bytes were unchanged.
Repeated scope notices and generated match lists moved out of authored patterns;
the shared scope notice appears on the site overview. Review fingerprints were
updated for these deletions without attributing a human review.

## Connector candidate assessments

Candidate reviews are separate from the pattern-prose review above. The evidence
scanner masks comments and literals, then collects labelled signals across each
connector. Claude Haiku or DeepSeek Flash reviews selected source windows and lexical symbol
mentions; it does not receive a complete parsed call graph. Its supported,
uncertain, and rejected decisions and exact citations are stored in
`knowledge/match-reviews.json`. The recorded model is the agent actor.

`pqkb verify-matches` checks every current candidate, full connector-source and
rule/scope fingerprints, and quotes against the supplied context. It does not
prove that the model's reasoning is correct. Confidence is qualitative. These
assessments never certify runtime behavior or renew authored prose reviews.

OpenCode's DeepSeek path uses an isolated temporary profile with all tools
denied and no MCP servers. Its recorded model comes from the exported session,
not just the requested command-line name. Provider-specific protocol hashes
bind the CLI version, model, and review policy. Current reviews from either
provider can be reused without attributing one model's work to another.

For SurveyMonkey, the supervising `codex/gpt-6` agent checked the shared entry,
domain-selection requests, module loading, and tracing gate, then added the
underlying `Web.Contents` and `Diagnostics.Trace` citations to Haiku's assessment.
The original verdicts and reasons remain unchanged. Tracing is disabled by
default; the assessment describes conditional wiring, not active trace output.
These citation supplements carry their own actor and timestamp in the ledger.
