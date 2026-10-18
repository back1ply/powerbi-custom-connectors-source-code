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
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:34:38Z'
review:
  content_sha256: 9afa76933f98509105e6ed39563daec7e7ea865ada9d81c899e42642a0456b72
  sources_sha256:
    example: ec0852823d563e91e08f72d06f4a06d577be886c373775390d775409ac8319df
---

# Mechanism

Actian's `Diagnostics.LogValue` converts a value to text for its message and returns the original value through `Diagnostics.Trace`. `LogValue2` accepts a separate result expression and an optional delayed flag, so the logged representation and returned computation do not have to be the same object.[^example]

`LogFailure` evaluates a function under `try`. On failure it logs the error and uses a delayed function that raises that error again; on success it returns `result[Value]`. `WrapHandlers` applies this behavior to each field in a handler record through `WrapFunctionResult`.[^example]

# Adaptation and failure paths

Check whether a wrapper preserves evaluation timing as well as its return value. The delayed error expression is part of this implementation's propagation behavior. Replacing it with an eagerly evaluated error or a null value would change the operation being observed.[^example]

Review message contents before adding tracing around credentials or whole HTTP payloads. The serializer has a record branch that visits record fields and serializes their values; the excerpt does not show credential-field masking. Prefer deliberate diagnostic fields over passing arbitrary records to a generic serializer, and verify that conversion failures do not conceal the original operation's failure.[^example]

See [credential access](credentials.md), [structured errors](errors.md), and [buffering](buffering.md).

# Examples

The following excerpt is copied from `Actian/Diagnostics.pqm`, lines 1–11.[^example] It is a partial excerpt; follow the source link for the complete implementation.

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
```

[^example]: Actian/Diagnostics.pqm; see the matching `sources` entry.
