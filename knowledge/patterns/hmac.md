---
type: Power Query Pattern
title: HMAC request signing
description: HMAC request signing in extracted connector implementations.
category: Authentication
tags: [authentication]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: [\bCrypto\.CreateHmac\s*\(]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Function.OAuthSignatureGenerator.pqm#L1
  title: ShortcutsBI/Function.OAuthSignatureGenerator.pqm
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:00:47Z'
review:
  content_sha256: ee36a1403dfde9602cb6b0bb39f0f4a8ae55e7f960227324b19d5de9c38122ff
  sources_sha256:
    example: 386be20de30e6051da9bb4697b0642066f0b23f89af211a953716bb9c1c77f99
---

**Review scope:** static source review; vendor connector runtime behavior is not tested.

# Mechanism

ShortcutsBI's signature helper accepts consumer and token identifiers, their corresponding secrets, a nonce, and a timestamp. It builds a parameter string in a fixed order, constructs a base string containing the POST method and a fixed authentication endpoint, and combines the two secrets with an ampersand for its signing key.[^example]

The helper calls `Crypto.CreateHmac` with SHA-1, converts the resulting signature to Base64 text, then URI-escapes it. The source also passes `BinaryEncoding.Base64` as the second argument to its `Text.ToBinary` calls. These are the exact vendor expressions, not a general instruction to decode Base64 text that way.[^example]

# Adaptation and failure paths

Canonicalization is part of the signing contract. Changing parameter order, escaping, the HTTP method, endpoint, or key construction changes the input this helper signs. Do not replace SHA-1 with another algorithm merely because a different connector uses that algorithm; first obtain the target protocol's specification and known signing vectors.

The helper returns the signature text. It does not send the request, validate clock skew, or implement retry handling in this file. Trace the caller to see how nonce, timestamp, and credentials are supplied, and verify exact byte encodings with a known vector before treating the excerpt as interoperable signing code.[^example]

Keep secrets and canonical strings out of diagnostic output when reviewing failures. A mathematically computed HMAC is not by itself evidence that the provider's canonicalization requirements were met.

See [PKCE hashing and encoding](pkce.md), [credential access](credentials.md), and [diagnostic tracing](diagnostics.md).

# Examples

The following excerpt is copied from `ShortcutsBI/Function.OAuthSignatureGenerator.pqm`, lines 1–21.[^example] Follow the source for the surrounding implementation.

```powerquery
// Generate OAuth Signature
let
    OAuthSignatureGenerator = (oauthConsumerKey as text, oauthConsumerSecret as text, oauthToken as text, oauthTokenSecret as text, nonce as text, timestamp as text) =>
        let
            url = "https://api.shortcutssoftware.io/authenticate",
            baseString = Text.Combine({Uri.EscapeDataString("POST"), "&", Uri.EscapeDataString(Text.Combine({url})), "&", Uri.EscapeDataString(oauthParameters)}),
            signatureKey = Text.Combine({oauthConsumerSecret, "&", oauthTokenSecret}),
            oauthParameters = Text.Combine({
            "oauth_consumer_key=",oauthConsumerKey,
            "&oauth_nonce=",nonce,
            "&oauth_signature_method=HMAC-SHA1",
            "&oauth_timestamp=",timestamp,
            "&oauth_token=",oauthToken,
            "&oauth_version=1.0"
            }),
            signature = Crypto.CreateHmac(CryptoAlgorithm.SHA1, Text.ToBinary(signatureKey,BinaryEncoding.Base64), Text.ToBinary(baseString,BinaryEncoding.Base64)),
            oauthSignature = Uri.EscapeDataString(Binary.ToText(signature,BinaryEncoding.Base64))
        in
            oauthSignature
in
    OAuthSignatureGenerator
```

[^example]: ShortcutsBI/Function.OAuthSignatureGenerator.pqm; see the matching `sources` entry.

# Detection limits

The list below is generated from this page's `detect` expressions. It reports the first matching line per source file, including comments and helper definitions. A match is a source-reading lead, not a runtime or compatibility guarantee.

# Seen in

<!-- seen-in:start -->

Detected in **1** connector in this archive.

* [Shortcuts Business Insights](../connectors/ShortcutsBI.md): [Function.OAuthSignatureGenerator.pqm line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Function.OAuthSignatureGenerator.pqm#L16)

<!-- seen-in:end -->
