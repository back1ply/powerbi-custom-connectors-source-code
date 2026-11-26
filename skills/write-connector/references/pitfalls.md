# Pitfalls found in certified connectors

Certification did not catch everything. These come from reading archived source in
`connectors/` (not from running it); each gives the correct pattern first, then where
the mistake appears. Copy the pattern, not the example.

## A retry that cannot retry

**Pattern:** with `Value.WaitFor`, the producer returns `null` to ask for another
attempt and a value to stop ([wait-retry](https://learn.microsoft.com/en-us/power-query/wait-retry)).
Return `null` on a retryable status (429, 503), cap the attempts, and raise after the
last one.

**Seen in:** `ZohoCreator/ZohoCreator.m` 56-71. The producer always returns
`Csv.Document(...)`, never `null`, so the loop stops after the first attempt; its only
effect is a one-second wait before the request.

## Retry settings nobody reads

**Pattern:** a retry helper's parameters must reach the code that retries; test with a
forced 500.

**Seen in:** `PowerBIDatamarts/PowerBIDatamarts.pq` 146 passes `{500}` and a retry count
of 5 to `Web.JsonContents` (151-159), which never uses either.

## Checking a status the engine has already raised

**Pattern:** to inspect a status, list it in `ManualStatusHandling`, then read
`Value.Metadata(response)[Response.Status]`
([handling-status-codes](https://learn.microsoft.com/en-us/power-query/handling-status-codes)).
Without it, error statuses raise before your code runs.

**Seen in:** `PowerBIDatamarts/PowerBIDatamarts.pq` 268-275 calls `Web.Contents` with no
`ManualStatusHandling` and then tests the status code.

## Catching a status and ignoring it

**Pattern:** every status in `ManualStatusHandling` needs a branch that handles it,
usually `error Error.Record(...)` with the API's message.

**Seen in:** `ZohoCreator/ZohoCreator.m` 62-66 catches 400, 401 and 500, reads the
status into a value it never uses, and parses the error body as CSV data.

## Tracing left on

**Pattern:** route every `Diagnostics.Trace` through one switch
(`EnableTraceOutput = false` for release) and never trace credentials or rows
([TripPin 8](https://learn.microsoft.com/en-us/power-query/samples/trippin/8-diagnostics/readme)).
The 2024 certification rules required tracing off before submission.

**Seen in:** unconditional traces in `PowerBIDatamarts/PowerBIDatamarts.pq` 187,
`SolarwindsServiceDesk/SolarWindsServiceDesk.pq` 63 and 146, and
`ClickHouseArrowFlight/ClickHouseSqlGenerator.pqm` 144 (the rest of that connector is
correctly gated at `ClickHouseArrowFlight.pq` 209).

## A heavy TestConnection

**Pattern:** `TestConnection` should prove the credentials with a cheap request
([handling-gateway-support](https://learn.microsoft.com/en-us/power-query/handling-gateway-support)),
for example a flag that routes the entry function to a probe, as in
`Bitbucket/Bitbucket.pq` 205-211 and 253.

**Seen in:** `SolarwindsServiceDesk/SolarWindsServiceDesk.pq` 286 tests through
`SolarWindsServiceDesk.Contents`, which loads two years of incidents (20-30).

## PKCE without the method

**Pattern:** send `code_challenge_method = "S256"` with a SHA-256 challenge; without
it the OAuth spec defaults to `plain`. See `Asana/Asana.m` 108-127.

**Seen in:** `PlanviewOKR/PlanviewOKR.m` 85-98 sends an S256 challenge but no method.

## A client secret inside the package

**Pattern:** a `.mez` is a zip anyone can open, so treat everything in it as public. Use
public-client flows (PKCE) or a provider that does not need the secret on the client.
Encoding is not protection.

**Seen in:** `ZohoCreator/WebApp.json` 35-37 shipped a base64-encoded `client_secret`
(redacted in this archive), decoded at `ZohoCreator/ZohoCreator.m` 28.

## Unused code

**Pattern:** delete what the entry points never reach; an unused helper misleads every
later reader, and an unused value can hide a missing step.

**Seen in:** `PlanviewOKR/PlanviewOKR.m` 149-157 (`GetNextLink`, never called), and
`Linkar/LinkarConnector.pq` 156, a credential record that is built but never passed to
the provider. Check the credentials actually reach the driver.
