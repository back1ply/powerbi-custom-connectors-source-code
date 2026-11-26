# Design record

Answer ids come from the connector checklist (Power Query SDK topics).

| Question | Answer | Reason |
| --- | --- | --- |
| auth | key (key-placement: header) | `Authorization: Bearer`, read only in `RequestHeaders`. `ManualCredentials = true` because the connector sets the header itself. |
| transport | web-contents | Fixed base URL with `RelativePath` and `Query`. Server-supplied URLs are never followed. |
| user-inputs | url-or-server, options-record (`UpdatedSince`, `PageSize`) | Only the URL forms the credential key. |
| paging | cursor-token (list-generate) | Stops on null `next_cursor`. `List.Generate` instead of the `Table.GenerateByPage` helper, which stops at an empty first page even if a cursor follows. |
| data-formats | json | |
| schema | declared-schema, explicit-type-conversion (empty result keeps columns: yes) | UTC `datetime`, because the model has no zone type. Amounts are `number` (Decimal Number), matching the API's "decimal". |
| http-errors | manual-status-handling, structured-error-records, retry-with-delay, rate-limit-aware | 429, 502, 503, 504; 5 retries; `Retry-After` up to 300 s. |
| documentation | function-documentation, parameter-captions, parameter-descriptions, sample-values | |
| navigation | fixed-list | The API has three fixed list endpoints. |
| test-connection | dedicated-probe | A hidden `TestConnection` option calls `/me`. Normal navigation does not, to save requests. |
| folding | none | Possible later: `updated_at` filters to `updated_since`. The API has no upper bound, select or sort. |
| packaging | single-file, localized-strings, icons, beta-flag | Icon PNGs still to be supplied. |
| diagnostics | none | No tracing, so nothing can leak keys or rows. |
| long-running | none | |
| writes | none | |

## To confirm by running

These come from reading documentation and other connectors' source, not from tests:

- `RelativePath` keeps the `/api/v2` part of the base URL.
- `ManualCredentials = true` works with a Key credential in Desktop and the gateway.
- `Date.FromText` and `DateTimeZone.FromText` accept the API's exact formats.
- The retry request count, and that `IsRetry` avoids a cached response.
- The gateway passes the URL to `TestConnection` as typed.
