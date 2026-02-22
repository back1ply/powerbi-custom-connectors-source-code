# Power Query Patterns: Custom HMAC API Signing

While most modern APIs use standard `Bearer` tokens for authentication, some legacy systems, banking APIs, and high-security platforms (like AWS with Signature Version 4 or Twitter OAuth 1.0a) require you to dynamically sign every single HTTP request.

These APIs require a custom HTTP header (like `X-Signature`) that contains a cryptographic hash of the URL, the current timestamp, and the request body, signed using a secret key.

Power Query provides native hashing functions via `Crypto.CreateHmac` to facilitate this.

## The HMAC Message Signing Pattern

If an API documentation states: 
*"Authenticate by generating a SHA-256 HMAC of the request URL + Timestamp, signed with your Secret Key, and encoded as Base64."* 

You must implement a dynamic signature generator.

### Implementation

```powerquery
shared MyConnector.GetSignedData = () =>
    let
        // 1. Get credentials from the user
        credentials = Extension.CurrentCredential(),
        secretKey = credentials[Key],
        
        // 2. Generate the dynamic components
        requestUrl = "https://api.mybank.com/v1/accounts",
        
        // Get the current Unix timestamp (seconds since 1970)
        currentTimestamp = Text.From(
            Duration.TotalSeconds(DateTimeZone.UtcNow() - #datetimezone(1970, 1, 1, 0, 0, 0, 0, 0))
        ),
        
        // 3. Build the exact "Base String" the API expects to be signed
        // Most APIs specify exactly how this string must be formatted.
        // E.g., "GET\n{URL}\n{Timestamp}"
        baseString = "GET" & Character.FromNumber(10) & 
                     requestUrl & Character.FromNumber(10) & 
                     currentTimestamp,
        
        // 4. Generate the Cryptographic HMAC Signature
        // The algorithm (SHA256), the Key (binary), and the Content (binary)
        hashBinary = Crypto.CreateHmac(
            CryptoAlgorithm.SHA256, 
            Text.ToBinary(secretKey, BinaryEncoding.Base64), // Key must be binary
            Text.ToBinary(baseString, BinaryEncoding.Base64) // Payload must be binary
        ),
        
        // 5. Convert the resulting raw bytes into a Base64 string for the HTTP header
        signatureString = Binary.ToText(hashBinary, BinaryEncoding.Base64),
        
        // 6. Make the network request
        response = Web.Contents(requestUrl, [
            Headers = [
                #"X-Api-Timestamp" = currentTimestamp,
                #"X-Api-Signature" = signatureString
            ]
        ])
    in
        Json.Document(response);
```

### Supported Cryptography Algorithms
Power Query supports several hashing algorithms natively:
- `CryptoAlgorithm.MD5`
- `CryptoAlgorithm.SHA1` (Used in legacy OAuth 1.0a)
- `CryptoAlgorithm.SHA256` (Modern standard)
- `CryptoAlgorithm.SHA384`
- `CryptoAlgorithm.SHA512`

### Important Warnings
- **Time Drift**: API servers will reject signed requests if the timestamp is more than ~5 minutes out of sync with their server time. Ensure you use `DateTimeZone.UtcNow()` and not `DateTime.LocalNow()`!
- **Binary Encoding Errors**: `Crypto.CreateHmac` expects type `binary` for both the Key and the Message. If the API documentation says the key is "Hex encoded", you must use `BinaryEncoding.Hex` in `Text.ToBinary()`. If you use the wrong encoding algorithm, the signature will be perfectly valid mathematically, but the server will reject it because the input bytes were wrong.
