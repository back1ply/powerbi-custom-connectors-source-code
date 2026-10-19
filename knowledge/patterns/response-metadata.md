---
type: Power Query Pattern
title: Response and pagination metadata
description: Pagination state versus HTTP response metadata.
category: Data retrieval
tags: [data-retrieval]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: [\bValue\.Metadata\s*\(]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L64
  title: AzureResourceGraph/AzureResourceGraph.pq
- id: caller
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L52
  title: AzureResourceGraph/AzureResourceGraph.pq
- id: option
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L32
  title: AzureResourceGraph/AzureResourceGraph.pq
- id: status
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L85
  title: AzureResourceGraph/AzureResourceGraph.pq
- id: skipReader
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L153
  title: AzureResourceGraph/AzureResourceGraph.pq
- id: postContent
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L120
  title: AzureResourceGraph/AzureResourceGraph.pq
- id: variant
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq#L462
  title: DeltaSharing/DeltaSharing.pq
review:
  content_sha256: f4772bcaa130e54125e809debfeaa406274da3811148f19a51e95202a82f8670
  sources_sha256:
    example: a725cec6c35b49a84c0381dec02ff666451c3f1b4dda29c66e54da7882b733ce
    caller: a725cec6c35b49a84c0381dec02ff666451c3f1b4dda29c66e54da7882b733ce
    option: a725cec6c35b49a84c0381dec02ff666451c3f1b4dda29c66e54da7882b733ce
    status: a725cec6c35b49a84c0381dec02ff666451c3f1b4dda29c66e54da7882b733ce
    skipReader: a725cec6c35b49a84c0381dec02ff666451c3f1b4dda29c66e54da7882b733ce
    postContent: a725cec6c35b49a84c0381dec02ff666451c3f1b4dda29c66e54da7882b733ce
    variant: aae79f0dc3f8db7e72f897197af3fac23cadb4ed969505e303138ca13e82654d
verified:
  by: claude/claude-haiku-5-5 + codex/gpt-6
  at: '2026-10-19T10:10:51Z'
---

# Response and pagination metadata

## Mechanism

AzureResourceGraph keeps its continuation state on the table. `GetPage` attaches `meta [SkipToken = nextSkipToken]` to its result (line 83).[^example] The `ARGImpl` callback reads that value with `Value.Metadata(previous)[SkipToken]?`. The first call starts from an empty string, and a null read ends paging (lines 56–59).[^caller]

`GetPage` sets its local `resultTruncated` to true when the option is absent or null, making `nextSkipToken` null. The default therefore stops after one page. Any non-null option value makes that local flag false and reads the continuation token from the body, including an explicit false. The type's sample `{true}` is an example value, not a declared default. Test omission, null, true, and false separately when adapting this contract.[^example][^option]

The HTTP status is a different contract. `WaitForResult` reads `Value.Metadata(result)[Response.Status]` on a `Web.Contents` result (lines 96–98).[^status] That is response state, not page state, and the presence of `Value.Metadata` alone does not show which contract is in use.

## Selection and dependencies

Attach page state as metadata when it is not part of the item rows and the next call can read it. The input is the continuation field from the response body, read by `GetSkipToken`. The output is a `SkipToken` value on the table. A later transform can lose metadata; check the actual returned value rather than assuming every transform preserves or drops it.[^skipReader]

For header or status handling, DeltaSharing's `SendRequest` is the contrast. It reads `Value.Metadata(resp)` before buffering, then passes the captured record to `HandleError`. `HandleError` maps 400, 403, and 404 to errors and returns other responses unchanged.[^variant] Use [pagination](pagination.md) for the callback shape and [web requests](web-requests.md) for request options.

## Adaptation and failure paths

Keep attachment and retrieval together. If an intermediate step loses `SkipToken` metadata, the callback's optional read produces null and ends paging without an error. Test that boundary after changing the table transforms.[^example]

`GetSkipToken` uses `Record.FieldOrDefault`: a missing token field or null body yields null. A non-null body of the wrong type can raise instead. A changed response shape can therefore resemble a final page; validate the body contract before treating a null token as successful completion.[^skipReader]

The first request sends an empty token. `nextToken` is `""` on the first call (line 56). `AddFieldOrNull` adds `$skipToken` whenever the value is not null (line 137), and `""` is not null, so the first body includes the field.[^postContent] Check that the API accepts an empty initial token before you copy the pattern.

Not every option value is a page setting. `resultTruncated` is tested only for presence (line 73), so `false` enables continuation too. A caller who passes `false` to mean "no paging" gets the opposite behavior.[^example]

## Validation checklist

- Decide the initial token: send `""` as this source does, or omit the field.
- Confirm the token is a top-level field of the body (`GetSkipToken`, line 153).
- Confirm which option value enables continuation, and document the default.
- Confirm that the table returned by the page function still carries its metadata.
- Check the HTTP statuses that reach your code. `ManualStatusHandling = {500, 400}` (line 94) is the list this source reads manually.

## Examples

Page state from `GetPage`, AzureResourceGraph lines 64–83:

<!-- source: example -->
```powerquery
GetPage = (query as text, skipToken as text, optional scope as nullable text, optional subscription as text, optional managementGroup as text, optional options as record) as table =>
    let
        scopeValue = if scope = null then "Tenant" else scope,
        subscription =  if subscription = null then "" else subscription,
        managementGroup =  if managementGroup = null then "" else managementGroup,
        scopeCheck = if scopeValue = "Tenant" and ((subscription <> "") or (managementGroup <> "")) then error Extension.LoadString("scopeCheckErrorMessage") else null,
        emptyScopeCheck = if scopeValue <> "Tenant" and ((subscription = "") and (managementGroup = "")) then error Extension.LoadString("expectedScopeParameters") else null,
        subscriptionValueCheck = if scopeValue = "Subscription" and managementGroup <> "" then error Extension.LoadString("ScopeSubscriptionMismatch") else null,
        managementgroupValueCheck = if scopeValue = "Management group" and subscription <> "" then error Extension.LoadString("ScopeManagementGroupMismatch") else null,
        resultTruncated = if options[resultTruncated]? = null then true else false,
        postData = BuildPostContent(query, skipToken, scopeValue, subscription, managementGroup, resultTruncated),
        response = WaitForResult(postData),
        body = if response[IsError] = false then response[Content] else null, 
        errorCheck = if response[IsError] then error response[Content] else null,
        nextSkipToken = if resultTruncated = true then null else GetSkipToken(body),
        resultTable = if errorCheck = null then Table.FromList(body[data]?, Splitter.SplitByNothing(), null, null, ExtraValues.Error) else null,
        processedResult = if errorCheck = null and not Table.IsEmpty(resultTable) then Table.ExpandRecordColumn(resultTable, "Column1", Record.FieldNames(Table.Column(resultTable, "Column1"){0})) else null,
        output = if processedResult = null then #table({"Results"}, {{"No results"}}) else processedResult
    in
        if scopeCheck <> null then scopeCheck else if emptyScopeCheck <> null then emptyScopeCheck else if subscriptionValueCheck <> null then subscriptionValueCheck else if managementgroupValueCheck <> null then managementgroupValueCheck else if errorCheck <> null then errorCheck else output meta [SkipToken = nextSkipToken];
```

Callback that reads the token, lines 52–62:

<!-- source: caller -->
```powerquery
ARGImpl = (query as text, optional scope as nullable text, optional subscription as text, optional managementGroup as text, optional options as record) as table =>
    Table.GenerateByPage((previous) => 
        let
            // if previous is null, then this is our first page of data
            nextToken = if (previous = null) then "" else Value.Metadata(previous)[SkipToken]?,
            // if NextToken was set to null by the previous call, we know we have no more 
            delay = Number.RandomBetween(1, 3),
            page = if (nextToken <> null) then Function.InvokeAfter(() => GetPage(query, nextToken, scope, subscription, managementGroup, options), #duration(0,0,0,delay)) else null
        in
            page
    );
```

Status read before buffering, DeltaSharing lines 462–484:

<!-- source: variant -->
```powerquery
SendRequest = (url as text, options as record) as binary =>
    let
        credential = Extension.CurrentCredential(),
        AuthenticationMode =  credential[AuthenticationKind],
        token = if AuthenticationMode = "Key" then credential[Key] else credential[access_token],
        headers = [#"Authorization" = "Bearer " & token] & (if options[Headers]? = null then [] else options[Headers]),
        resp = RetryWithBackoff(
            (isRetry as logical) => Web.Contents(url, options & [Headers=headers] & [ManualStatusHandling={400, 403, 404, 429, 503}] & [IsRetry = isRetry])
        ), 
        respMetadata = Value.Metadata(resp)
    in
        HandleError(Binary.Buffer(resp), respMetadata);

HandleError = (resp, respMetadata) =>
    let
        respCode = respMetadata[Response.Status],
        finalResp = 
            if respCode = 400 then error Error.Record("DataSource.Error", Text.Format(Extension.LoadString("ErrorInvalidConnectionString"), {Text.FromBinary(resp)}))
            else if respCode = 403 then error Extension.CredentialError(Credential.AccessForbidden, Text.Format(Extension.LoadString("ErrorInvalidCredentials"), {Text.FromBinary(resp)}))
            else if respCode = 404 then error Error.Record("DataSource.Error", Text.Format(Extension.LoadString("ErrorResourceNotFound"), {Text.FromBinary(resp)}))
            else resp
    in
        finalResp;
```

[^example]: AzureResourceGraph/AzureResourceGraph.pq lines 64–83 (`GetPage`): option check (line 73), token selection (78), request body (74), error branches, and `meta [SkipToken = nextSkipToken]` (83).
[^caller]: AzureResourceGraph/AzureResourceGraph.pq lines 52–62 (`ARGImpl`): the `Table.GenerateByPage` callback reads `Value.Metadata(previous)[SkipToken]?` (line 56) and gates the next page (line 59).
[^option]: AzureResourceGraph/AzureResourceGraph.pq lines 32–41: the `options` type declares `resultTruncated` with `Documentation.SampleValues = {true}` (line 37).
[^status]: AzureResourceGraph/AzureResourceGraph.pq lines 85–108 (`WaitForResult`): reads `Response.Status` from a `Web.Contents` result (lines 96–98) and handles 500 and 400 manually (line 94).
[^skipReader]: AzureResourceGraph/AzureResourceGraph.pq lines 151–153 (`GetSkipToken`): `Record.FieldOrDefault(response, "$skipToken")` on the parsed body.
[^postContent]: AzureResourceGraph/AzureResourceGraph.pq lines 120–142 (`BuildPostContent`): `AddFieldOrNull` adds `$skipToken` when the value is not null (line 137).
[^variant]: DeltaSharing/DeltaSharing.pq lines 462–484: `SendRequest` captures `Value.Metadata(resp)` (line 471) before `Binary.Buffer` (line 473), and `HandleError` maps status codes (lines 475–484).
