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
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L217
  title: Asana/Asana.m
- id: caller
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L108
  title: Asana/Asana.m
- id: callback
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L129
  title: Asana/Asana.m
- id: anaplan
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L54
  title: Anaplan/Anaplan.pq
review:
  content_sha256: b222e16e2b36cee26d1fa36ec6733199cd0a556861b7a1cba53e3e8b893e0f24
  sources_sha256:
    example: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
    caller: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
    callback: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
    anaplan: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
verified:
  by: claude/claude-haiku-5-5 + codex/gpt-6
  at: '2026-10-19T10:10:51Z'
---

# PKCE and URL-safe encoding

## Mechanism

Asana creates a verifier in `StartLogin` with `GenerateCodeVerifier()`, sends `GenerateCodeChallenge(code_verifier)` with `code_challenge_method = "S256"`, and returns the verifier in the login result's `Context` (lines 108–127).[^caller]

`FinishLogin` passes that context to `TokenMethod`. `TokenMethod` adds `code_verifier` to the token form only when `Record.HasFields(context, "code_verifier")` is true. Otherwise the field is omitted and the request continues without it (lines 129–154).[^callback]

The generator draws 50 characters from a 62-character ASCII alphabet with `Number.RandomBetween` (lines 217–223). The challenge helper hashes the verifier's ASCII bytes with SHA-256, converts the digest to Base64, replaces `+` with `-` and `/` with `_`, and removes `=` padding (lines 225–241). That matches the base64url, no-padding encoding used by the S256 method. Check [RFC 7636](https://www.rfc-editor.org/rfc/rfc7636) for the exact definition rather than relying on this summary.[^example]

Anaplan takes a different approach. Its `StartLogin` sends the verifier itself as `code_challenge` with `code_challenge_method = "plain"`, so there is no hashing step. Its verifier comes from two `Text.NewGuid()` values, and its `Base64UrlEncodeWithoutPadding` helper (lines 45–51) is defined but never called in the file.[^anaplan]

## Choosing this shape

Use S256 with a verifier that is kept and returned at the token step, as Asana does. Use the `plain` method only when the provider requires it, and then accept that the challenge reveals the verifier to anyone who sees the authorization request. For a flow without PKCE, see [OAuth2](oauth2.md).

## Adaptation and failure paths

Preserve the verifier across the callback, not the challenge. Asana stores the verifier in `Context` (line 126) and reads it in `TokenMethod` (line 151). If the context held the challenge instead, the token request would no longer carry the value the challenge was derived from.[^callback]

Review verifier generation separately from hashing. `Number.RandomBetween` is the generator at line 221, and the presence of SHA-256 does not assess its quality. Confirm that the verifier length and characters meet RFC 7636 (43 to 128 unreserved characters). The 50-character alphanumeric output at lines 219–221 falls within that range.[^example]

`TextEncoding.Ascii` on line 233 is safe only because the generator at lines 219–221 emits ASCII letters and digits. Any change to the alphabet needs a review of that conversion.[^example]

The missing-context branch in `TokenMethod` omits the verifier rather than generating a new one (lines 150–152). When a token exchange is rejected, compare the retained context, the method label, and the exact bytes hashed before changing unrelated credential code.[^callback]

See [HMAC signing](hmac.md) for another signing flow and [credential access](credentials.md) for the saved credential.

## Examples

<!-- source: example -->
```powerquery
GenerateCodeVerifier = () =>
    let
        ValidCharacters = Text.ToList("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456879"),
        StrLenght = 50,
        Result = Text.Combine(List.Transform( {1..StrLenght}, each ValidCharacters{Int32.From(Number.RandomBetween(0, List.Count(ValidCharacters)-1))}))
    in
        Result;

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

The login start creates the verifier and sends its challenge:

<!-- source: caller -->
```powerquery
StartLogin = (resourceUrl, state, display) =>
    let
        code_verifier = GenerateCodeVerifier(),
        authorizeUrl = authorize_uri & "?" & Uri.BuildQueryString([
            response_type = "code",
            client_id = client_id,
            redirect_uri = redirect_uri,
            state = state,
            display_ui = "always",
            code_challenge = GenerateCodeChallenge(code_verifier),
            code_challenge_method = "S256"
        ])
    in
        [
            LoginUri = authorizeUrl,
            CallbackUri = redirect_uri,
            WindowHeight = 720,
            WindowWidth = 1024,
            Context = [code_verifier = code_verifier]
        ];
```

The callback reads the saved verifier and adds it to the token form:

<!-- source: callback -->
```powerquery
FinishLogin = (context, callbackUri, state) =>
    let
        // parse the full callbackUri, and extract the Query string
        parts = Uri.Parts(callbackUri)[Query],
        // if the query string contains an "error" field, raise an error
        // otherwise call TokenMethod to exchange our code for an access_token
        result = if (Record.HasFields(parts, {"error", "error_description"})) then
                    error Error.Record(parts[error], parts[error_description], parts)
                 else
                    TokenMethod("authorization_code", "code", parts[code], context)
    in
        result;

TokenMethod = (grantType, tokenField, code, context) =>
    let
        queryString = [
            grant_type = grantType,
            redirect_uri = redirect_uri,
            client_id = client_id
        ],
        queryWithCodeVerifier =
            if Record.HasFields(context, "code_verifier") then
                Record.AddField(queryString, "code_verifier", context[code_verifier])
            else queryString,

        queryWithCode = Record.AddField(queryWithCodeVerifier, tokenField, code),
```

[^example]: Asana/Asana.m lines 217–241 hold the verifier generator, the S256 challenge helper, and the URL-safe replacement; lines 217–223 define the 50-character generator.
[^caller]: Asana/Asana.m lines 108–127 hold `StartLogin`, which builds `code_challenge` with `S256` and returns `Context = [code_verifier = code_verifier]`.
[^callback]: Asana/Asana.m lines 129–154 hold `FinishLogin` and the start of `TokenMethod`, including the `code_verifier` check at lines 150–152 and the context read at line 151.
[^anaplan]: Anaplan/Anaplan.pq lines 54–78 hold `StartLogin`, which sends `code_challenge = codeVerifier` with `code_challenge_method = "plain"` (lines 67–68); lines 45–51 define the unused Base64 helper.
