---
type: Power Query Pattern
title: Diagnostic tracing
description: Tracing values while preserving return and error behavior.
category: Schema and errors
tags: [schema-and-errors]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: [\bDiagnostics\.Trace\s*\(]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Diagnostics.pqm#L1
  title: Actian/Diagnostics.pqm
- id: caller
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Actian.m#L178
  title: Actian/Actian.m
- id: registration
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Actian.m#L371
  title: Actian/Actian.m
- id: anaplan
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Diagnostics.pqm#L1
  title: Anaplan/Diagnostics.pqm
- id: anaplan-registration
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L810
  title: Anaplan/Anaplan.pq
review:
  content_sha256: 272becb53d833f04c5debf9947a8fa9ca55cca9ab9cd638871c3512b9c13624d
  sources_sha256:
    example: ec0852823d563e91e08f72d06f4a06d577be886c373775390d775409ac8319df
    caller: fd2d31eeba79778f2f1221a22b0dc78942f0b603d8381d4e3dbe7bd8e77a04d7
    registration: fd2d31eeba79778f2f1221a22b0dc78942f0b603d8381d4e3dbe7bd8e77a04d7
    anaplan: 07760d2ccdc44bf7d0d6ef11ce4b3e92588c7e97630e327af9ad0aa6b89b2fd8
    anaplan-registration: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
verified:
  by: claude/claude-haiku-5-5 + codex/gpt-6
  at: '2026-10-19T10:10:51Z'
---

# Diagnostic tracing

## Mechanism

Actian's `Diagnostics.LogValue` converts a value to text for its message and returns the original value through `Diagnostics.Trace`. If the conversion fails, the message says `<error getting value>` instead, and the value is still returned (line 2).[^example]

`LogValue2` takes a separate `result` expression and an optional `delayed` flag. The logged text comes from `value`, while the returned computation is `result`, so the two do not have to be the same object (line 3).[^example]

`LogFailure` evaluates `function()` under `try`. On failure it logs the error through `LogValue2` with `delayed` set to true and the expression `() => error result[Error]`, so the error is raised again when the value is used. On success it returns `result[Value]` (lines 4–8). `WrapFunctionResult` and `WrapHandlers` apply `LogFailure` to each field of a handler record (lines 10–18).[^example]

## Registration and gating

`Actian.m` sets `EnableTraceOutput = false` (line 9), and its comment says the value should be false before release (lines 5–8). Its `Diagnostics.LogValue` is `if (EnableTraceOutput) then Diagnostics[LogValue] else (prefix, value) => value` (line 379), so disabled calls return the value unchanged.[^registration]

`Actian.m` uses only `LogValue` from the module. `LogFailure` and `WrapHandlers` are defined in `Diagnostics.pqm` but no code in `Actian.m` wires them in. Do not describe Actian as wrapping its handlers.[^registration]

Anaplan differs in two ways. It registers `Diagnostics.LogValue = Diagnostics[LogValue]` unconditionally (Anaplan.pq line 811), and its module's `LogValue` takes an optional `delayed` argument. Its serializer uses `Expression.Constant` for dates, times, numbers and text, where Actian writes date and time text by hand.[^anaplan]

## Choosing a helper

Use `LogValue` for an inline trace point that must return its value unchanged. Use `LogFailure` or `WrapHandlers` when a handler should log its failure and still propagate it. Anaplan's unconditional registration shows the form for tracing that is not gated by a switch, but the live Anaplan code does not call it; its only call is in a commented block (line 707). Treat it as an unused pattern unless you add a call site.[^anaplan-registration]

## Adaptation and failure paths

Check whether a wrapper keeps the original evaluation timing as well as the return value. The delayed error expression `() => error result[Error]` (line 8) is part of the propagation behavior. Replacing it with an eager error or a null value changes the operation being observed.[^example]

`SQLColumns` places `Diagnostics.LogValue` calls inside an `if` condition so the traces run before the table is used. The source comment says so (line 180). The comparisons against `"***"` are how that evaluation is forced, not a data check.[^caller]

The serializer visits every record field and writes its value (lines 101–108). It does not mask anything, so a credential, a token, or a whole HTTP payload passed to tracing will be written to the log. Pass deliberate fields instead. The top-level `try Serialize(value) otherwise "<serialization failed>"` catches a serializer failure (line 266), and `LogValue` still returns `value`, so the original error still propagates.[^example]

Check the module's switch before shipping. With tracing on, `SQLGetTypeInfo` and `SQLColumns` log every row (lines 158–190), which can be large. Verify the output size on a real query before enabling it.[^caller]

See [credential access](credentials.md) for what must stay out of traces, [structured errors](errors.md) for the error shapes that traces will reproduce, and [buffering](buffering.md) for evaluation timing.

## Examples

<!-- source: example -->
```powerquery
let
    Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),
    Diagnostics.LogValue2 = (prefix, value, result, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & Diagnostics.ValueToText(value), result, delayed),    
    Diagnostics.LogFailure = (text, function) =>
        let
            result = try function()
        in
            if result[HasError] then Diagnostics.LogValue2(text, result[Error], () => error result[Error], true) else result[Value],

    Diagnostics.WrapFunctionResult = (innerFunction as function, outerFunction as function) as function =>
        Function.From(Value.Type(innerFunction), (list) => outerFunction(() => Function.Invoke(innerFunction, list))),

    Diagnostics.WrapHandlers = (handlers as record) as record =>
        Record.FromList(
            List.Transform(
                Record.FieldNames(handlers),
                (h) => Diagnostics.WrapFunctionResult(Record.Field(handlers, h), (fn) => Diagnostics.LogFailure(h, fn))),
            Record.FieldNames(handlers)),
```

The SQLColumns override uses the logging calls in its condition:

<!-- source: caller -->
```powerquery
        SQLColumns = (catalogName, schemaName, tableName, columnName, source) =>
            if (EnableTraceOutput <> true) then source else
            // the if statement conditions will force the values to evaluated/written to diagnostics
            if (Diagnostics.LogValue("SQLColumns.TableName", tableName) <> "***" and Diagnostics.LogValue("SQLColumns.ColumnName", columnName) <> "***") then
                let
                    // Outputting the entire table might be too large, and result in the value being truncated.
                    // We can output a row at a time instead with Table.TransformRows()
                    rows = Table.TransformRows(source, each Diagnostics.LogValue("SQLColumns", _)),
                    toTable = Table.FromRecords(rows)
                in
                    Value.ReplaceType(toTable, Value.Type(source))
            else
                source,
```

The module load and the gated registration:

<!-- source: registration -->
```powerquery
Extension.LoadFunction = (name as text) =>
    let
        binary = Extension.Contents(name),
        asText = Text.FromBinary(binary)
    in
        Expression.Evaluate(asText, #shared);
// Diagnostics module contains multiple functions. We can take the ones we need.
Diagnostics = Extension.LoadFunction("Diagnostics.pqm");
Diagnostics.LogValue = if (EnableTraceOutput) then Diagnostics[LogValue] else (prefix, value) => value;
// OdbcConstants contains numeric constants from the ODBC header files, and a 
// helper function to create bitfield values.
ODBC = Extension.LoadFunction("OdbcConstants.pqm");
Odbc.Flags = ODBC[Flags];
```

[^example]: Actian/Diagnostics.pqm lines 1–18: `LogValue` (line 2), `LogValue2` (line 3), `LogFailure` with its delayed error (lines 4–8), `WrapFunctionResult` and `WrapHandlers` (lines 10–18); the serializer's record branch (lines 101–108) and its top-level `try` fallback (line 266).
[^caller]: Actian/Actian.m lines 178–190: the gated `SQLColumns` override, the forced-evaluation comment (line 180), and the per-row `LogValue` call (line 185); `SQLGetTypeInfo` (lines 158–166) logs rows the same way.
[^registration]: Actian/Actian.m lines 371–383: module load (line 378) and the gated `Diagnostics.LogValue` (line 379); the switch itself is `EnableTraceOutput = false` at line 9.
[^anaplan]: Anaplan/Diagnostics.pqm line 2 defines `LogValue` with an optional `delayed` argument; lines 138–154 serialize dates, times, numbers and text with `Expression.Constant`.
[^anaplan-registration]: Anaplan/Anaplan.pq lines 810–811 load the module and register `Diagnostics.LogValue = Diagnostics[LogValue]` without a switch.
