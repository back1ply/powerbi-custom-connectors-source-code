# Pattern source review

Reviewed by `codex/gpt-6` on 2026-10-18 at the user's request. The user delegated
the review to an agent and requested maintenance with minimal manual work.
Current per-page verification events and fingerprints are in the pattern
frontmatter; `uv run pqkb verify-reviews` checks whether they still match.

The review checked each pattern's behavioral statements against its cited M
source, including surrounding functions, error branches, callback registration,
and configuration. Excerpts are also checked against the archive by pytest.
The reviewed pages are suitable as a source-reading reference. This review does
not execute vendor connectors, validate their API registrations, assess their
security, or certify their behavior in Power BI, Excel, or other hosts.

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
