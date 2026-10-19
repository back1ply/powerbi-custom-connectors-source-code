---
type: Power Query Pattern
title: Asynchronous exports and result downloads
description: Starting export tasks, polling state, and assembling chunked results.
category: Data retrieval
tags: [data-retrieval]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-19T09:37:15.890078+00:00'
detect: [\btaskState\b]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L618
  title: Anaplan/Anaplan.pq
- id: chunks
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L563
  title: Anaplan/Anaplan.pq
- id: caller
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L550
  title: Anaplan/Anaplan.pq
- id: entry
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L478
  title: Anaplan/Anaplan.pq
- id: errors
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L735
  title: Anaplan/Anaplan.pq
verified:
  by: codex/gpt-6
  at: '2026-10-19T10:10:51Z'
review:
  content_sha256: 7eea54a26a4555bf8f38e6343e45e4cadc5c30718008d58e7559d409cb80af97
  sources_sha256:
    example: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
    chunks: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
    caller: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
    entry: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
    errors: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
---

# Asynchronous exports and result downloads

## When to choose this pattern

Use a job workflow when a request starts server-side work and returns an identifier instead of the final rows. Keep three operations separate: submit the export, poll the task, and fetch the completed result. Retrying a failed HTTP request is a different operation; see [retries and polling](retry-polling.md). The Anaplan example combines all three and exposes useful failure boundaries.[^example]

## Follow the task into a table

`RunExportAction` reaches this path through `DownloadFileChunks`. Its separate `status` binding contains an in-progress check and a POST helper, but is unused by the returned expression. It therefore supplies no enforced duplicate-job guard. `DownloadFileChunks` reads export metadata and selects `GetWebContentsExportRunSuccess` when the parsed body's `status.code` is 200. This is a body field, not the HTTP status.[^entry][^caller]

The export helper posts a locale body to `/tasks` and passes `exportRunResp[task][taskId]` into `fileDownload`. Its result is a table, not a job handle: it selects a status response and then calls the chunk downloader.[^example]

The poller builds attempt numbers with `List.Numbers(1, MaxAttempts)`. Its delay expression gives the first attempt a zero duration and subsequent attempts the supplied interval. The call supplies 200 attempts and a ten-second interval. Those constants describe the configured list and delay; they do not establish a measured total duration or a guarantee that every numbered request is evaluated.[^example]

The acceptance condition is **not** a positive success check. It selects a non-null response whose `taskState` differs from the localized `TaskInProgress` string. A failed or cancelled terminal state could therefore reach the download branch unless the service's state contract rules that out. The archive does not enumerate successful, failed, and cancelled states here.[^example]

`DownloadFileListAccumulate` retrieves chunk records, extracts their IDs, requests each chunk as binary, combines those binaries, and parses either an Excel workbook or CSV according to export metadata. Delimiter, column count, and export format are dependencies of parsing, not properties inferred from the downloaded file.[^chunks]

## Boundaries to preserve when adapting

| Boundary | What this implementation does | What to validate in an adaptation |
| --- | --- | --- |
| Submission | Parses the POST body and indexes `task/taskId`. | A handled HTTP error must not be mistaken for a task envelope. |
| Completion | Accepts any state other than the configured in-progress value. | Enumerate successful and unsuccessful terminal states explicitly. |
| Exhaustion | Calls `ErrorTable(2, Number.From(taskId))`. | Define the timeout result and avoid assuming all job IDs are numeric. |
| Parsing | Selects Excel or CSV using export metadata. | Test missing chunks, invalid binary, and incompatible metadata. |

`ErrorTable` builds error rows for categories 1–5. The exhaustion branch first converts `taskId` with `Number.From`; a non-numeric identifier can raise before the error table is built. The caller uses `exportRun` only for a null comparison, then returns a separate `DownloadFileListAccumulate` call. A non-null error table therefore does not stop that call; the helper's first result is not the returned table. This does not establish how many HTTP requests caching or lazy evaluation will perform.[^example][^errors][^caller]

The chunk helper's `returNothingJustCheck` and `_` checks are unused `let` bindings. Their presence does not enforce the status or empty-list errors. Similarly, the poller has no catch around malformed task bodies or unhandled HTTP failures. Test those separately from normal exhaustion.[^chunks][^example]

## Examples

### Submission and state polling

This is the complete export helper. It depends on the token/configuration record, localized strings, `DownloadFileListAccumulate`, and `ErrorTable` in the surrounding module.[^example]

<!-- source: example -->

```powerquery
GetWebContentsExportRunSuccess = (url as text, exportKey as text, configParams as list, exportMetadata as record) as table => 
    let
        apiTokenValue = configParams{ConfigParamsIndex[apiToken]},
        exportUrl = url & "exports/"  & exportKey & "/tasks",
        fileUrl = url & "files/" & exportKey,
        body = "{""localeName"":""en_US""}",
        
        exportRunResp = Json.Document(Binary.Buffer(Web.Contents(exportUrl, [Headers = [#"Authorization" = Extension.LoadString("AnaplanAuthTokenPrefix") & apiTokenValue, #"Content-Type"="application/json", #"x-aconnect-client"=Extension.LoadString("AConnectHeaderValue"), #"User-Agent"=Extension.LoadString("AConnectHeaderValue")], 
            Content = Text.ToBinary(body), ManualStatusHandling = {500, 501, 502, 503}]))),
        
        fileDownload = (taskId as text) =>
            let
                // noCache = #"NoCache"= Number.ToText(count + Number.Random())
                getTaskStatus = (count as number) => Binary.Buffer(Web.Contents(exportUrl & "/" & taskId, 
                    [Headers = [#"Authorization" = Extension.LoadString("AnaplanAuthTokenPrefix") & apiTokenValue, #"x-aconnect-client"=Extension.LoadString("AConnectHeaderValue"), #"User-Agent"=Extension.LoadString("AConnectHeaderValue"), #"NoCache"= Number.ToText(count + Number.Random()) ]])),
         
                getTaskStatusLoop = (MaxAttempts, DelayBetweenAttempts) =>
                    let
                        Numbers = List.Numbers(1, MaxAttempts),
                        WebServiceCalls = List.Transform(Numbers, each Function.InvokeAfter(() => getTaskStatus(_), if _ > 1 then DelayBetweenAttempts else #duration(0,0,0,0))),
                        OnlySuccessful = List.Select(WebServiceCalls, each _ <> null and Json.Document(_)[task][taskState] <> Extension.LoadString("TaskInProgress")),
                        Result = List.First(OnlySuccessful, null),
                        res = if Result <> null then DownloadFileListAccumulate(fileUrl, configParams, exportMetadata) else ErrorTable(2, Number.From(taskId))
                    in
                        res,

                // todo: evaluate proper duration & retries
                result = getTaskStatusLoop(200, #duration(0,0,0,10))            
            in 
                result
    in
        fileDownload(exportRunResp[task][taskId]);
```

### Assemble chunks only after a deliberate completion decision

The complete download helper makes the output boundary visible: list records become binaries, then a parsed table or workbook value. Review the service-state decision above before copying this stage into a new connector.[^chunks]

<!-- source: chunks -->

```powerquery
DownloadFileListAccumulate = (url as text, configParams as list, exportMetadata as record) as table =>
    let 
        delimiter = exportMetadata[separator]?,
        columnCount = exportMetadata[columnCount]?,
        format = exportMetadata[exportFormat]?,

        fileChunkUrl = url & "/chunks/",

        resp2 = GetWebContents(fileChunkUrl, configParams),
        statusCode =try resp2[status][code] otherwise 500,
        returNothingJustCheck =if statusCode <> 200 then error "Chunks API failed with code " & Number.ToText(statusCode) else null,

        chunks = try resp2[chunks] otherwise error "Chunks list not found in response",
        _ = if List.Count(chunks) = 0 then error "No chunks found in response" else null,

        chunkIds = List.Transform(chunks, each _[id]),
        // 4. Download each chunk 
        binaryList = List.Transform( chunkIds, each let resp = GetWebContents(fileChunkUrl & _, configParams, true) in if Value.Is(resp, type binary) then resp else error "Chunk " & _ & " did not return binary" ),
        binaryCombined = Binary.Combine(binaryList),

        result =try if format <> null and format = ExcelFormat then Excel.Workbook(binaryCombined, false, true) else Csv.Document( binaryCombined, [Delimiter = delimiter, Columns = columnCount])
            otherwise ErrorTable(4, 999)
    in
        result;
```

See [buffering](buffering.md), [structured errors](errors.md), and [response metadata](response-metadata.md).

[^example]: Anaplan export submission, task identifier, poll selection, and configured attempt/delay values.
[^chunks]: Anaplan chunk enumeration, binary combination, and parser selection.
[^caller]: Anaplan metadata check and the caller's second download decision.
[^entry]: Anaplan export action returns DownloadFileChunks without using its status binding.
[^errors]: Anaplan error-table construction and returned columns.
