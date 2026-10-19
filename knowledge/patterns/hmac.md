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
- id: caller
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/ShortcutsBI.pq#L28
  title: ShortcutsBI/ShortcutsBI.pq
- id: timestamp
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Function.TimestampGenerator.pqm#L1
  title: ShortcutsBI/Function.TimestampGenerator.pqm
- id: nonce
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Function.RandomStringGenerator.pqm#L1
  title: ShortcutsBI/Function.RandomStringGenerator.pqm
- id: access
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Function.GetAccessCode.pqm#L3
  title: ShortcutsBI/Function.GetAccessCode.pqm
review:
  content_sha256: c381dd9588a7f379c28075b72234eaec95eb414a56461829538ce70f355b7f66
  sources_sha256:
    example: 386be20de30e6051da9bb4697b0642066f0b23f89af211a953716bb9c1c77f99
    caller: 60f0e7fdd1a7b966a9b819e82aadb58f8512646b72518e32cd26d416b548db8d
    timestamp: f1c398d6f2e09c5f06250a050fe79caa6c8fec298b663925b98540e867952b7e
    nonce: 6d58761083c7439cc739a5740e5309c5cbda49277fe4bb491f73e949c3ffe822
    access: 4c5d09ba50fc278be64e369362fc443f27ee3a76c6c3a7f2dec46cdffa1b9d3c
verified:
  by: claude/claude-haiku-5-5 + codex/gpt-6
  at: '2026-10-19T10:10:51Z'
---

# HMAC request signing

## Mechanism

`OAuthSignatureGenerator` receives the consumer key and secret, the token and token secret, a nonce, and a timestamp. It joins the OAuth parameters in a fixed order, builds a base string from `POST`, a fixed endpoint, and the escaped parameter string, and forms the key from the consumer secret and token secret joined by `&` (lines 3–15).[^example]

It calls `Crypto.CreateHmac` with SHA-1, converts the signature to Base64 text, and percent-encodes that text. Both `Text.ToBinary` calls pass `BinaryEncoding.Base64` as the second argument. That is the binary-encoding constant family, while this argument selects a text encoding. Use an explicit provider-compatible text encoding when adapting, and verify the resulting bytes against a known signing vector.[^example]

Coverage is limited. A search of `connectors/` finds one `Crypto.CreateHmac` call, in this helper, so there is no second implementation to compare against.

## Caller and inputs

Within the ShortcutsBI connector, the only caller is `ShortcutsBIImpl`. It splits the credential `Key` on `-` and assigns the first four parts to the consumer key, consumer secret, access token and access token secret. Missing parts default to empty text. It then creates the timestamp and nonce, calls the signature helper, and passes the credentials, nonce, timestamp and signature to `GetAccessCode` (lines 28–47).[^caller]

`timestampGenerator()` subtracts a zone-less `#datetime(1970, 1, 1, 0, 0, 0)` from `DateTime.LocalNow()` and rounds the seconds. This calculation uses the host's wall clock without converting it to UTC. A machine with a nonzero UTC offset can therefore produce an offset timestamp. Adapt it using a UTC clock and UTC epoch, then test the provider's accepted timestamp window.[^timestamp] `randomStringGenerator()` draws eight characters with `Number.RandomBetween`.[^nonce]

`GetAccessCode` puts the signature in an `Authorization: OAuth` header with `ManualCredentials = true` and sends the body `{"credential_type_code":"oauth"}`. It returns the value of the first field in the JSON response, selected by position through `Record.ToTable(Auth){0}`, not by name.[^access]

## Adaptation and failure paths

Treat canonicalization as the contract. This helper escapes the joined parameter text; it does not separately encode each name and value before joining. Check that behavior, parameter order, the method, endpoint, and key format against the provider's specification and known signing vectors. Keep the signing algorithm aligned with that protocol.[^example]

A hyphen inside a component changes the split. `Text.Split` returns every part, but the caller reads only indices 0 through 3, so later parts are dropped without a local validation error. The resulting credentials or signature can be incorrect; this source does not establish the provider's response.[^caller]

Missing parts become empty text, so signing can continue with empty values. The `delimeterCount > 0` check is effectively always true because `Text.Split` returns at least one element. Test malformed credentials before submitting them; the source supplies no useful component-count validation.[^caller]

The helper returns only the signature text. It does not send the request, check clock skew, or retry. The first-field lookup in `GetAccessCode` also accepts whatever the provider places first, so a single-field error object would be returned as the access code. Test that response shape.[^access]

Do not log the consumer or token secrets, the signature base string, or the `Authorization` header. See [diagnostic tracing](diagnostics.md) and [credential access](credentials.md). For a different SHA-256 use, see [PKCE hashing and encoding](pkce.md).

## Examples

<!-- source: example -->
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

The connector's caller splits the key and produces the inputs:

<!-- source: caller -->
```powerquery
ShortcutsBIImpl = () as table =>
    let
        powerBiKey = Extension.CurrentCredential()[Key],
        delimeterCount = List.Count(Text.Split(powerBiKey,"-")),
        powerBiKeySplit = if delimeterCount > 0 then Text.Split(powerBiKey, "-") else powerBiKey,
        consumerKey = if List.Count(powerBiKeySplit) < 1 then "" else powerBiKeySplit{0},
        consumerSecret = if List.Count(powerBiKeySplit) < 2 then "" else powerBiKeySplit{1},
        accessToken = if List.Count(powerBiKeySplit) < 3 then "" else powerBiKeySplit{2},
        accessTokenSecret = if List.Count(powerBiKeySplit) < 4 then "" else powerBiKeySplit{3},

        //Generate timestamp which is used in oauth1 signature generation
        oauthTimestamp = timestampGenerator(),
        //Generate random letter/number combination which is used in oauth1 signature generation
        oauthNonce = randomStringGenerator(),
        //Oauth1 signature generator which gets used when calling the authenticate endpoint
        oauthSignature = oauthSignatureGenerator(consumerKey, consumerSecret, accessToken, accessTokenSecret, oauthNonce, oauthTimestamp),
        //Function to call the authenticate endpoint providing it with oauth1 credentials, which will return a oauth2 jwt access code
        access_code = getAccessCode(consumerKey, consumerSecret, accessToken, accessTokenSecret, oauthNonce, oauthTimestamp, oauthSignature),
        //CommunityID extracted from JWT
        communityID = extractCommunityID(access_code),
```

The timestamp helper is the source of the value the signature includes:

<!-- source: timestamp -->
```powerquery
// Generate time stamp helper function for oauth signature
let 
    TimeStampGenerator = () as text =>
        let
            currentDateTime = DateTime.LocalNow(),
            currentTimestamp=Text.From(Number.Round(Duration.TotalSeconds(currentDateTime-#datetime(1970, 1, 1, 0, 0, 0))))
        in
            currentTimestamp
in
    TimeStampGenerator
```

[^example]: ShortcutsBI/Function.OAuthSignatureGenerator.pqm lines 1–21: parameter string and base string (lines 6–15), key construction (line 7), the HMAC-SHA1 call and Base64 conversion (lines 16–17). A search of `connectors/` for `CreateHmac` matched only this file.
[^caller]: ShortcutsBI/ShortcutsBI.pq lines 28–47: key splitting and defaults (lines 30–36), timestamp, nonce and signature calls (lines 39–43), and the `getAccessCode` call (line 45).
[^timestamp]: ShortcutsBI/Function.TimestampGenerator.pqm lines 3–8: `DateTime.LocalNow()` minus a zone-less epoch, passed through `Duration.TotalSeconds` and `Number.Round`.
[^nonce]: ShortcutsBI/Function.RandomStringGenerator.pqm lines 3–9: an eight-character string from a 62-character alphabet using `Number.RandomBetween`.
[^access]: ShortcutsBI/Function.GetAccessCode.pqm lines 3–36: the `Authorization` header (lines 10–19), the request body (line 28), and the first-field lookup (lines 33–34).
