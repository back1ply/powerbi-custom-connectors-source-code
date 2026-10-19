---
type: Power Query Pattern
title: Function parameters and data-source identity
description: Typed exported functions, parameter documentation, and data-source path exclusions.
category: Navigation and UI
tags: [navigation-and-ui]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-19T09:37:15.893347+00:00'
detect: [\bDocumentation\.FieldCaption\s*=]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m#L99
  title: SingleStoreODBC/SingleStoreODBC.m
- id: variant
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Bloomberg.m#L63
  title: Bloomberg/Bloomberg.m
- id: registration
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m#L399
  title: SingleStoreODBC/SingleStoreODBC.m
- id: binding
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Bloomberg.m#L7
  title: Bloomberg/Bloomberg.m
- id: consumer
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m#L355
  title: SingleStoreODBC/SingleStoreODBC.m
- id: ssl
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m#L166
  title: SingleStoreODBC/SingleStoreODBC.m
- id: validation
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Bloomberg.m#L96
  title: Bloomberg/Bloomberg.m
- id: connection
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m#L446
  title: SingleStoreODBC/SingleStoreODBC.m
verified:
  by: codex/gpt-6
  at: '2026-10-19T10:10:51Z'
review:
  content_sha256: dfd0de92df6dd940670e6d869f5e855130a6466839b4139bfc2aa9b82964eb1a
  sources_sha256:
    example: 593c578f7107251b6c2c6ccac6235a10a07971d3e2ecaad0ff6b44b2befca1ff
    variant: db725e4012b15f843ec0fca43c0a9982808171e4287d78c079218e624e7e88a4
    registration: 593c578f7107251b6c2c6ccac6235a10a07971d3e2ecaad0ff6b44b2befca1ff
    binding: db725e4012b15f843ec0fca43c0a9982808171e4287d78c079218e624e7e88a4
    consumer: 593c578f7107251b6c2c6ccac6235a10a07971d3e2ecaad0ff6b44b2befca1ff
    ssl: 593c578f7107251b6c2c6ccac6235a10a07971d3e2ecaad0ff6b44b2befca1ff
    validation: db725e4012b15f843ec0fca43c0a9982808171e4287d78c079218e624e7e88a4
    connection: 593c578f7107251b6c2c6ccac6235a10a07971d3e2ecaad0ff6b44b2befca1ff
---

# Function parameters and data-source identity

## Choose the function surface deliberately

Use function metadata when designing what callers supply to a connector: server names, database names, query text, or optional settings. This is distinct from [schema enforcement](schema.md), which concerns returned data. A well-documented parameter still needs an implementation and an exported binding; a metadata record by itself does not prove that users can invoke it.[^registration][^binding]

SingleStore defines several function types and attaches them to different shared functions using `Value.ReplaceType`. `SingleStoreODBC.Contents` uses the main type, `DataSource` and the compatibility alias `Database` use the SSL-aware type, and `Query` uses the custom-SQL type. Compare these bindings before changing a label or assuming a type declaration is the active public surface.[^registration]

## Compare two designs

In `SingleStoreConnectorMeta`, the required server and database parameters carry localized captions, descriptions, and sample values. The optional logical `UseSSL` parameter declares `Documentation.AllowedValues = {true, false}`. `SingleStoreConnectorImpl` forwards that value in the options record sent to `GetODBCDataSource`; the UI metadata is not the only place the option must be maintained.[^example][^consumer]

Bloomberg's `EntryPointType` has a single text parameter, marks it `DataSource.Path = false`, and adds multiline/code formatting metadata. Both `Bloomberg.Query` and the older `BQL.Query` receive that type. They use separate data-source kinds; sharing a type does not establish shared credential identity. The required query parameter is explicitly excluded from path calculation.[^variant][^binding]

Microsoft documents the host's path rules in [Handling data source paths](https://learn.microsoft.com/en-us/power-query/handling-resource-path) and [Handling data access](https://learn.microsoft.com/en-us/power-query/handling-data-access). Consult those rules before deciding which inputs should distinguish credential locations. The archived declarations show the chosen flags; they do not test credential reuse across machines or hosts.

## Practical adaptation checks

- Keep parameter order and types aligned between the type value, implementation, and every public alias. SingleStore's SSL variant has a different third parameter from the main and custom-query variants.[^example][^registration]
- Treat sample values as examples, not as implementation defaults. Follow the actual consumer to find null handling and fallback values.[^example][^consumer]
- Check resource keys before copying localized captions. The source retains `Extension.LoadString` calls, while this archive strips packaged resource files; it cannot establish the rendered dialog text from those calls alone.[^example]
- Decide which values describe a location and which describe a query within that location. Review Bloomberg's explicit exclusion as a design choice, rather than copying it to a server or tenant argument without checking the intended identity boundary.[^variant]
- Validate actual inputs in the implementation. A field caption, code-formatting hint, or allowed-values declaration is not evidence that the full driver/request path handles every malformed input.[^example][^consumer]

SingleStore's omitted or null `UseSSL` falls back to the credential's `EncryptConnection` field, defaulting to true unless that field is false. Its `TestConnection` returns the compatibility alias with server and database only, so that path does not exercise an explicit `UseSSL` argument. Test those entry points separately.[^ssl][^connection]

Bloomberg also implements input guards: it rejects null and text that becomes empty after `Text.Clean`. That is separate from its editor metadata and is not a whitespace-trimming check. For adaptations, test omitted arguments, explicit null, blank query text, and compatibility aliases against the actual consumers.[^validation]

## Examples

### A typed server/database function with an optional setting

This complete type value is attached to SingleStore's exported SSL-aware functions. Its resource strings and ODBC consumer are dependencies outside the excerpt.[^example][^registration]

<!-- source: example -->

```powerquery
SingleStoreConnectorMeta = type function (
    ServerAddr as ( type text meta [
        Documentation.FieldCaption = Extension.LoadString("ServerFieldCaption"),
        Documentation.FieldDescription = Extension.LoadString("ServerFieldDescription"),
        Documentation.SampleValues = {Extension.LoadString("ServerFieldSample")}
    ]),
    Database as ( type text meta [
        Documentation.FieldCaption = Extension.LoadString("DBFieldCaption"),
        Documentation.FieldDescription = Extension.LoadString("DBFieldsDescription"),
        Documentation.SampleValues = {Extension.LoadString("DBFieldSample")}
    ]),
    optional UseSSL as (type logical meta [
        Documentation.FieldCaption = Extension.LoadString("UseSSLFieldCaption"),
        Documentation.FieldDescription = Extension.LoadString("UseSSLFieldDescription"),
        Documentation.AllowedValues = {true, false}
    ])
    ) as table meta [
        Documentation.Name = Extension.LoadString("SSObjectName"),
        Documentation.LongDescription = Extension.LoadString("SSObjectLongDescription")
    ];
```

### Query text excluded from the data-source path

Bloomberg's complete type value pairs a path exclusion with editor formatting. Follow its shared bindings before deciding how to adapt the identity policy.[^variant][^binding]

<!-- source: variant -->

```powerquery
EntryPointType = type function (
    Bloomberg as (type text meta [
        DataSource.Path = false,
        Documentation.FieldCaption = Extension.LoadString("Bql.Query.Dialog.Argument.Caption"),
        Documentation.SampleValues = { Extension.LoadString("Bloomberg.Query.SampleValue") },
        Formatting.IsMultiLine = true,
        Formatting.IsCode = true
    ])
    )
    as table meta [
        Documentation.Name = Extension.LoadString("Bql.Query.Dialog.Title") & "  v" & ConnectorVersion,
        Documentation.Description = Extension.LoadString("Bql.Function.Description")
    ];


```

See [credential access](credentials.md), [resources and module loading](packaging.md), and [navigation](navigation.md).

[^example]: SingleStore SSL-aware parameter type and documentation metadata.
[^variant]: Bloomberg query parameter type, formatting, and path exclusion.
[^registration]: SingleStore shared bindings and compatibility alias.
[^binding]: Bloomberg and BQL shared bindings to EntryPointType.
[^consumer]: SingleStore implementation forwards UseSSL to its ODBC options.
[^ssl]: SingleStore SSL selection from explicit options and the credential encryption setting.
[^validation]: Bloomberg EntryPointImpl query guards before GetData.
[^connection]: SingleStore TestConnection invokes the Database alias with two arguments.
