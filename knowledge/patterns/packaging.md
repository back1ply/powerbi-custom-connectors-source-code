---
type: Power Query Pattern
title: Resources and modular source loading
description: Configuration resources, localization calls, and extracted archives.
category: Packaging
tags: [packaging]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: ['\b(?:Extension\.Contents|Extension\.LoadString|Expression\.Evaluate)\s*\(']
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L2
  title: Asana/Asana.m
- id: loader
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L243
  title: Asana/Asana.m
- id: publish
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L93
  title: Asana/Asana.m
- id: icons
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L102
  title: Asana/Asana.m
- id: hardcoded
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L173
  title: Asana/Asana.m
- id: config
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Config.json#L2
  title: Asana/Config.json
- id: configComma
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Config.json#L6
  title: Asana/Config.json
- id: variant
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L802
  title: Anaplan/Anaplan.pq
- id: inlineNav
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L754
  title: Anaplan/Anaplan.pq
review:
  content_sha256: 01cb80b53aaf605c7cf4253fa7f6bb639d4ace40ec7e1746ca5b784f226ff4ad
  sources_sha256:
    example: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
    loader: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
    publish: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
    icons: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
    hardcoded: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
    config: b99f40ec06d0136f9a8a8ab5230aba848e74fd5d5d91055a39a90c9a64bddbb4
    configComma: b99f40ec06d0136f9a8a8ab5230aba848e74fd5d5d91055a39a90c9a64bddbb4
    variant: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
    inlineNav: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
verified:
  by: claude/claude-haiku-5-5 + codex/gpt-6
  at: '2026-10-19T10:10:51Z'
---

# Resources and modular source loading

## Mechanism

`Asana.m` loads its configuration with `Extension.Contents("Config.json")` and `Json.Document`. It binds the client ID, redirect URI, token URI, authorize URI, and API URL from the parsed record (lines 4–9). The shared `Asana.Tables` function is declared with `DataSource.Kind="Asana"` (line 11) and typed on line 12.[^example]

`Config.json` holds those five values, along with nothing else. They are client identifiers and URLs, not secrets.[^config] Its `api_url` line ends with a comma before the closing brace on line 7. Strict JSON parsers reject a trailing comma. Whether `Json.Document` accepts this one is untested here.[^configComma]

`Asana.Publish` takes its button text from `Extension.LoadString` (line 96). The function's type takes its captions and descriptions from `Extension.LoadString` as well (lines 14–23). `Asana.Icons` names PNG files (lines 102–105).[^publish][^icons]

The Asana folder holds `Asana.m`, `Config.json`, and `Table.ToNavigationTable.pqm`, without the named PNG or string-resource files. The [archive extractor](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/src/pqkb/package.py#L50) removes localization, images, and packaging noise after extraction. A source archive therefore has different dependencies from an installable connector package.

`Extension.LoadFunction` (lines 243–248) reads a named file with `Extension.Contents`, decodes it with `Text.FromBinary`, and evaluates it with `Expression.Evaluate(asText, #shared)`. Line 250 binds `Table.ToNavigationTable` to the module `Table.ToNavigationTable.pqm`, which is in the folder.[^loader] Anaplan uses the same loader for `TraceContext.pqm` and `Diagnostics.pqm` (lines 802–811), and both files are present in its folder. Anaplan also defines `Table.ToNavigationTable` inline (line 754).[^variant][^inlineNav]

## Selection and dependencies

Keep configuration in a package file when its values belong to the connector build. A `.pqm` module can hold helpers used by multiple files in that package. The inputs are packaged files and resource keys; the outputs are values and functions. Match each `Extension.Contents` filename and `Extension.LoadString` key to the corresponding packaged resource.[^example][^loader]

Anaplan's inline copy of `Table.ToNavigationTable` shows the other option. It needs no extra file, but the helper is repeated in every connector that needs it. Load a module when the same helper appears in several files, and define it inline when a file must stand alone.[^inlineNav] For OAuth bindings, see [OAuth2](oauth2.md). For navigation tables, see [navigation](navigation.md). For credential handling, see [credential access](credentials.md).

## Adaptation and failure paths

Match each name to a file or key. Asana's `Extension.LoadString` keys, such as `ButtonTitle` (line 96) and `AuthenticationLabel` (line 87), and its PNG names (lines 102–105) have no matching files in this archive. The archive is therefore not a drop-in package. Those values are unknown here, not empty.[^publish][^icons]

Use one source for each host. `GetTasks` calls `https://reporting-api.integrations.asana.plus` as a literal (line 176). The `api_url` value in Config.json is the same string, but changing `api_url` does not change that request.[^hardcoded]

Validate JSON with a strict parser before you ship a config file. The trailing comma on Config.json line 6 is the case to test first.[^configComma]

This config holds a public client ID and URLs. Keep public identifiers separate from secrets when creating a package, and follow the archive's [redaction and refresh guidance](https://github.com/back1ply/powerbi-custom-connectors-source-code#refreshing-the-archive) before contributing extracted source.[^config]

Check module names. The loader calls name `Table.ToNavigationTable.pqm`, `TraceContext.pqm`, and `Diagnostics.pqm` exactly. The file names in each folder must match those strings.[^loader][^variant]

## Validation checklist

- List each `Extension.Contents`, `Extension.LoadString`, and `Extension.LoadFunction` name, and confirm the file or key exists in the package.
- Confirm that each `.pqm` name matches its loader string exactly.
- Use one source for each host or URL that appears in more than one place.
- Parse each config file with a strict JSON parser.
- Review config values for secrets, and keep public identifiers separate from them.

## Examples

Config bindings and shared entry point, Asana lines 2–12:

<!-- source: example -->
```powerquery
section Asana;

config = Json.Document ( Extension.Contents( "Config.json") );
client_id=  config[client_id];
redirect_uri = config[redirect_uri];
token_uri = config[token_uri];
authorize_uri = config [authorize_uri];
api_url = config [api_url];

[DataSource.Kind="Asana", Publish="Asana.Publish"]
shared Asana.Tables =  Value.ReplaceType(AsanaNavTable, Asana_Type);
```

Module loader, Asana lines 243–250:

<!-- source: loader -->
```powerquery
Extension.LoadFunction = (name as text) =>
    let
        binary = Extension.Contents(name),
        asText = Text.FromBinary(binary)
    in
        Expression.Evaluate(asText, #shared);

Table.ToNavigationTable = Extension.LoadFunction("Table.ToNavigationTable.pqm");
```

Loader with two modules, Anaplan lines 802–811:

<!-- source: variant -->
```powerquery
Extension.LoadFunction = (name as text) =>
    let
        binary = Extension.Contents(name),
        asText = Text.FromBinary(binary)
    in
        Expression.Evaluate(asText, #shared);

TraceContext = Extension.LoadFunction("TraceContext.pqm");
Diagnostics = Extension.LoadFunction("Diagnostics.pqm");
Diagnostics.LogValue = Diagnostics[LogValue];
```

[^example]: Asana/Asana.m lines 2–12: `section Asana;` (line 2), the five `Config.json` bindings (lines 4–9), `DataSource.Kind` (line 11), and the shared `Asana.Tables` (line 12).
[^config]: Asana/Config.json lines 2–6: `client_id`, `redirect_uri`, `token_uri`, `authorize_uri`, and `api_url`. The values are client identifiers and URLs.
[^configComma]: Asana/Config.json line 6: `"api_url"` ends with a comma, and the closing brace is on line 7.
[^publish]: Asana/Asana.m lines 93–100 (`Asana.Publish`): `ButtonText` from `Extension.LoadString` (line 96) and `LearnMoreUrl` as a literal (line 97). Lines 14–23 take captions from `Extension.LoadString` (lines 16–22).
[^icons]: Asana/Asana.m lines 102–105 (`Asana.Icons`): PNG names passed to `Extension.Contents`.
[^hardcoded]: Asana/Asana.m lines 173–176 (`GetTasks`): the literal host in `Web.Contents` (line 176). `api_url` is read at line 9.
[^loader]: Asana/Asana.m lines 243–250 (`Extension.LoadFunction`): `Extension.Contents`, `Text.FromBinary`, and `Expression.Evaluate` (lines 245–248), then the bound `Table.ToNavigationTable` (line 250).
[^variant]: Anaplan/Anaplan.pq lines 802–811: the same loader, with `TraceContext.pqm` (line 809) and `Diagnostics.pqm` (line 810) loaded, and `Diagnostics.LogValue` bound (line 811).
[^inlineNav]: Anaplan/Anaplan.pq lines 754–775 (`Table.ToNavigationTable`): the navigation helper defined inline in the connector file.
