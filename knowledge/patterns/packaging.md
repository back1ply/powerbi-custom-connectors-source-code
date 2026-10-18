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
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:34:39Z'
review:
  content_sha256: 46e8b7b6605d96e3f3b4b8214e2074b79e6a9fcbd06288116dabdfd95641dea0
  sources_sha256:
    example: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
---

# Mechanism

Asana loads `Config.json` with `Extension.Contents`, parses it with `Json.Document`, and binds its client identifier, callback URI, token URI, authorization URI, and API URL from that record. The exported function's type and publishing metadata also call `Extension.LoadString` for UI text.[^example]

The same file references image resources in its icon declarations. Source references can therefore remain even when the extraction pipeline has removed localization and image files. The source archive is useful for inspecting these bindings, but it is not a complete runnable package.[^example]

# Adaptation and failure paths

Follow a resource name to the actual retained file before describing its content. Keep code, configuration, localized strings, and images distinct when planning a new package. If a configuration or module is missing, do not infer its values from a loader call alone.

Rebuild a distributable connector from its own package resources rather than treating this stripped archive as a drop-in package. Preserve the relationship between resource keys and call sites, and review credential-bearing configuration separately from public identifiers. The redaction rules and removed-resource list are documented in the repository README; they are properties of this archive's tooling, not behavior supplied by `Extension.Contents`.

See [OAuth2 configuration](oauth2.md), [navigation metadata](navigation.md), and [credential access](credentials.md).

# Examples

The following excerpt is copied from `Asana/Asana.m`, lines 2–13.[^example] It is a partial excerpt; follow the source link for the complete implementation.

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

[^example]: Asana/Asana.m; see the matching `sources` entry.
