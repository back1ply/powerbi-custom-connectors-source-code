---
type: Power Query Pattern
title: PKCE and URL-safe encoding
description: PKCE verifier transport, SHA-256, and URL-safe encoding.
category: Authentication
tags: [authentication]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: [code_challenge\s*=]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L225
  title: Asana/Asana.m
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:34:39Z'
review:
  content_sha256: da10b63f4552d43789aa66f202cde727599c80e934b4e0c0bc367d3e230bc3d0
  sources_sha256:
    example: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
---

# Mechanism

Asana creates a verifier in `StartLogin`, sends `GenerateCodeChallenge(code_verifier)` with `code_challenge_method = "S256"`, and returns the original verifier in the login result's `Context` record. `FinishLogin` passes that context into `TokenMethod`, which adds the verifier to the token form when the field exists. The context is therefore the link between authorization and token exchange in this implementation.[^example]

The challenge helper hashes the verifier's ASCII bytes with SHA-256, converts the hash to Base64 text, replaces `+` and `/` with URL-safe characters, and removes `=` padding. The encoding steps are visible below; the surrounding file contains the authorization request and token form.[^example]

# Adaptation and failure paths

Preserve the original verifier across the callback. Sending the challenge again in place of the verifier would change the data this implementation puts in its token request. Review verifier generation separately from hashing: this connector's generator uses `Number.RandomBetween`, and the presence of SHA-256 does not itself assess that generator.[^example]

Follow the missing-context branch in `TokenMethod` as well. It omits the verifier field instead of generating a new verifier. When debugging a rejected exchange, compare the retained context, algorithm label, and exact bytes used to compute the challenge before changing unrelated credential code.[^example]

See [OAuth2 callbacks](oauth2.md) and [HMAC signing](hmac.md).

# Examples

The following excerpt is copied from `Asana/Asana.m`, lines 225–241.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery
GenerateCodeChallenge = (code_verifier) =>
    let
        hash = Replace(HashString(code_verifier))
    in
        hash;

HashString = (str as text) =>
    let
        result = Binary.ToText(Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(str, TextEncoding.Ascii)), BinaryEncoding.Base64)
    in
        result;

Replace = (str) =>
    let
        result = Text.Replace(Text.Replace(Text.Replace(str, "+", "-"), "/", "_"), "=", "")
    in
        result;
```

[^example]: Asana/Asana.m; see the matching `sources` entry.
