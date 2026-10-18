---
type: Power Query Pattern
title: OAuth2 login and token refresh
description: OAuth2 callbacks and refresh-token exchange.
category: Authentication
tags: [authentication]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: ['\b(?:StartLogin|FinishLogin|Refresh)\s*=']
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/GoogleSheets/GoogleSheets.pq#L48
  title: GoogleSheets/GoogleSheets.pq
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:34:39Z'
review:
  content_sha256: e42159856f549125fa2192db04982ff51fc9973be895298c4c121904b290a940
  sources_sha256:
    example: 519949be7c5aeca7a8a3247800070971191df416b28a9b3db18b8a8cdeac7dd9
---

# Mechanism

GoogleSheets registers `StartLogin`, `FinishLogin`, and `Refresh` in its OAuth authentication record. `StartLogin` builds an authorization URL containing `state`, the callback URL, and a read-only spreadsheet scope, and requests offline access and consent. `FinishLogin` extracts the callback query and exchanges its authorization code for a JSON token response.[^example]

`Refresh` is a separate token-endpoint request. It sends `grant_type = "refresh_token"`, the supplied refresh token, the client identifier, and the client secret, then returns the parsed response. The secret in this archive is redacted, so the excerpt is a source-reading example rather than a working registration for a new application.[^example]

# Adaptation and failure paths

Keep the registered callbacks, authorization parameters, token form, and expected token fields consistent when adapting a flow. Check the provider's response contract before adding expiry calculations or replacing refresh-token fields. This implementation returns the parsed token response; it does not demonstrate a general policy for token expiry formats.[^example]

The callback's explicit error branch raises `DataSource.Error` when its `error` query field is present. Read that branch together with the token request; a successful browser redirect is not by itself evidence of a successful token exchange. Review callback-state handling and provider requirements separately before adopting the flow.[^example]

See [PKCE](pkce.md) for verifier transport and [credential access](credentials.md) for consumption of saved credentials.

# Examples

The following excerpt is copied from `GoogleSheets/GoogleSheets.pq`, lines 48–63.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery
Refresh = (resourceUrl, refresh_token) =>
    let
        Response = Web.Contents("https://oauth2.googleapis.com/token", [
            Content = Text.ToBinary(Uri.BuildQueryString([
                grant_type = "refresh_token",
                client_id = ClientId,
                client_secret = ClientSecret,
                refresh_token = refresh_token
                ])),
            Headers = [
                #"Content-type" = "application/x-www-form-urlencoded",
                #"Accept" = "application/json"]]),
        Parts = Json.Document(Response)
    in
        Parts;

```

[^example]: GoogleSheets/GoogleSheets.pq; see the matching `sources` entry.
