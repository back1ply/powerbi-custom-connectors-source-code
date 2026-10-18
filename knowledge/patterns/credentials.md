---
type: Power Query Pattern
title: Credential access
description: Authentication-kind dispatch and credential connection strings.
category: Authentication
tags: [authentication]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: [\bExtension\.CurrentCredential\s*\(]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Actian.m#L115
  title: Actian/Actian.m
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:34:38Z'
review:
  content_sha256: 9c35a03a7523bc2cd38a2915682b2fa812c0615f7537e2ff7b797d80acd0fb8e
  sources_sha256:
    example: fd2d31eeba79778f2f1221a22b0dc78942f0b603d8381d4e3dbe7bd8e77a04d7
---

# Mechanism

Actian obtains a credential record through `Extension.CurrentCredential()` and dispatches on its optional `AuthenticationKind` field. For `UsernamePassword` it constructs a separate `CredentialConnectionString` record containing `UID` and `PWD`. For `Windows` it returns `null`; the SQL Server-specific trusted-connection record in the file is commented out.[^example]

The surrounding function constructs ordinary connection properties such as driver, server, and database separately from this credential record. That separation makes it possible to inspect connection routing without replacing the user-supplied username and password with literals in the query.[^example]

# Adaptation and failure paths

Read the authentication declaration and the consumer of `CredentialConnectionString` before copying a branch. A field used by an OAuth connector is not a substitute for the username/password fields shown here. Keep secret values out of examples, connection labels, and diagnostic messages when adapting the pattern.

The final branch raises `Error.Record` for an unhandled authentication kind; it does not silently fall back to anonymous access. The optional field lookup in the condition also means the code can reach that failure path when the expected kind is absent. Include that path when checking a connector against its supported authentication modes.[^example]

See [ODBC configuration](odbc.md), [diagnostics](diagnostics.md), and [OAuth2](oauth2.md).

# Examples

The following excerpt is copied from `Actian/Actian.m`, lines 115–126.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery
        // handled here as an example. 
        //
        Credential = Extension.CurrentCredential(),
        CredentialConnectionString =
            if Credential[AuthenticationKind]? = "UsernamePassword" then
                // set connection string parameters used for basic authentication
                [ UID = Credential[Username], PWD = Credential[Password] ]
            else if (Credential[AuthenticationKind]? = "Windows") then
                // set connection string parameters used for windows/kerberos authentication
                //[ Trusted_Connection="Yes" ]    SQLServer only
                null
            else
```

[^example]: Actian/Actian.m; see the matching `sources` entry.
