# Power Query Patterns: Base64URL Encoding

Standard Base64 (RFC 4648 §4) uses three characters that are not safe in URLs and HTTP headers without percent-encoding: `+`, `/`, and the `=` padding character. RFC 4648 §5 defines Base64URL as the URL-safe variant: `+` becomes `-`, `/` becomes `_`, and trailing `=` padding is omitted.

Power Query's `Binary.ToText` with `BinaryEncoding.Base64` produces standard Base64. There is no built-in `BinaryEncoding.Base64Url`. Connectors that need URL-safe Base64 — most commonly for OAuth2 PKCE `code_challenge` values, JWT construction, or embedding binary data in query parameters — must apply the three-character transformation themselves using `Text.Replace`.

This pattern is also used in reverse when embedding binary image data in Data URIs for Power BI visuals: standard Base64 (with `+` and `/`) is correct for `data:` URI payloads, so the transformation is intentionally omitted in that context.

## The Pattern

### 1. The `Base64UrlEncode` Helper Function

The canonical form is a small inline helper that chains three `Text.Replace` calls. Because `Text.Replace` returns a new `text` value at each step, the calls can be nested (innermost executes first) or written sequentially as named `let` bindings.

**Nested form** (compact, common in `StartLogin`):

```powerquery
Base64UrlEncode = (binaryData as binary) as text =>
    let
        // Step 1: encode to standard Base64
        base64 = Binary.ToText(binaryData, BinaryEncoding.Base64),
        // Step 2: replace URL-unsafe characters and strip padding
        //   '+' → '-'   (RFC 4648 §5)
        //   '/' → '_'   (RFC 4648 §5)
        //   '=' → ''    (remove padding; receivers must re-pad if needed)
        urlSafe = Text.Replace(Text.Replace(Text.Replace(base64, "+", "-"), "/", "_"), "=", "")
    in
        urlSafe;
```

### 2. Applying It to a PKCE `code_challenge`

The most common use is hashing a PKCE `code_verifier` with SHA-256 and then Base64URL-encoding the digest before embedding it in the authorization URL. `Crypto.CreateHash` and `CryptoAlgorithm.SHA256` are undocumented functions available only within the Custom Connectors SDK.

```powerquery
StartLogin = (resourceUrl, state, display) =>
    let
        Base64UrlEncode = (binaryData as binary) as text =>
            let
                base64  = Binary.ToText(binaryData, BinaryEncoding.Base64),
                urlSafe = Text.Replace(Text.Replace(Text.Replace(base64, "+", "-"), "/", "_"), "=", "")
            in
                urlSafe,

        // Generate the verifier: two concatenated GUIDs give ~256 bits of entropy
        codeVerifier  = Text.NewGuid() & Text.NewGuid(),

        // Hash the verifier and Base64URL-encode the digest to produce the challenge
        codeChallenge = Base64UrlEncode(
            Crypto.CreateHash(
                CryptoAlgorithm.SHA256,
                Text.ToBinary(codeVerifier, TextEncoding.Ascii)
            )
        ),

        AuthorizeUrl = "https://auth.example.com/oauth2/authorize?" & Uri.BuildQueryString([
            client_id             = client_id,
            response_type         = "code",
            state                 = state,
            redirect_uri          = redirect_uri,
            code_challenge        = codeChallenge,   // Base64URL-encoded SHA-256 digest
            code_challenge_method = "S256"
        ])
    in
        [
            LoginUri    = AuthorizeUrl,
            CallbackUri = redirect_uri,
            Context     = [ CodeVerifier = codeVerifier ]
        ];
```

### 3. Plain Verifier Mode (Without Hashing)

Some identity providers accept `code_challenge_method = "plain"`, where the `code_challenge` is the raw verifier string rather than a hash. The Anaplan connector uses this variant, passing `codeVerifier` directly without hashing or Base64URL encoding:

```powerquery
// Plain PKCE: the verifier IS the challenge — no hashing, no Base64URL transformation
AuthorizeUrl = "https://" & oauthHost & "/auth/authorize?" & Uri.BuildQueryString([
    client_id             = PickClientId(oauthHost),
    response_type         = "code",
    code_challenge_method = "plain",
    code_challenge        = codeVerifier,   // raw GUID string, not encoded
    state                 = state,
    redirect_uri          = redirect_uri
])
```

Use `"S256"` (with `Base64UrlEncode`) whenever the identity provider supports it; `"plain"` offers no security improvement over the standard Authorization Code flow.

### 4. Standard Base64 for Data URI Payloads (No Transformation)

When embedding binary image data in a `data:` URI for Power BI, standard Base64 with `+` and `/` is correct — Data URIs are not URL-encoded and must not use the URL-safe alphabet. In this case `Binary.ToText` is used directly without the `Text.Replace` chain:

```powerquery
BinaryToPbiImage = (BinaryContent as binary) as text =>
    let
        // Standard Base64 is correct here — Data URIs do not require URL-safe encoding
        Base64 = "data:image/jpeg;base64, " & Binary.ToText(BinaryContent, BinaryEncoding.Base64)
    in
        Base64;
```

This is the intentional _absence_ of the Base64URL transformation and should not be "fixed."

## Why This Pattern Works

**`Text.Replace` is the only available tool.** Power Query's M standard library has no `BinaryEncoding.Base64Url` constant and no built-in URL-safe encoder. The three-replace chain is the canonical workaround used across the Microsoft connector ecosystem.

**Order of replacements is arbitrary but consistent.** Each `Text.Replace` call targets a disjoint character set (`+`, `/`, `=`), so the three operations commute — their order does not affect the result. The nested form is idiomatic because it avoids intermediate variable names for a transformation that is conceptually a single step.

**Padding removal is safe for PKCE.** RFC 7636 (PKCE) specifies Base64URL encoding _without_ padding. The identity provider's token endpoint reconstructs padding from the string length before decoding. Stripping `=` is correct and required; leaving it would cause some IdPs to reject the `code_challenge` with an invalid-request error.

**`Crypto.CreateHash` is SDK-only.** This function and `CryptoAlgorithm.SHA256` are not available in standard Power BI Dataflows or Power Query Online without a gateway. They are part of the Custom Connectors SDK runtime. Attempting to use them outside the SDK will produce `Expression.Error: The name 'Crypto' wasn't recognized`.

---

## See Also

- [`oauth2_pkce_pattern.md`](oauth2_pkce_pattern.md) — The full OAuth2 PKCE implementation: `StartLogin` + `FinishLogin` with `Context` state management. `Base64UrlEncode` is an inline helper within that pattern.
