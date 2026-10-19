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
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Actian.m#L111
  title: Actian/Actian.m
- id: caller
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Actian.m#L218
  title: Actian/Actian.m
- id: variant
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L316
  title: Anaplan/Anaplan.pq
- id: trace
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Diagnostics.pqm#L101
  title: Actian/Diagnostics.pqm
review:
  content_sha256: ce29a8b374f2485822016e54b031bef923b5091c5722e278a296c8032ee387e8
  sources_sha256:
    example: fd2d31eeba79778f2f1221a22b0dc78942f0b603d8381d4e3dbe7bd8e77a04d7
    caller: fd2d31eeba79778f2f1221a22b0dc78942f0b603d8381d4e3dbe7bd8e77a04d7
    variant: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
    trace: ec0852823d563e91e08f72d06f4a06d577be886c373775390d775409ac8319df
verified:
  by: claude/claude-haiku-5-5 + codex/gpt-6
  at: '2026-10-19T10:10:51Z'
---

# Credential access

## Mechanism

Actian reads the user's credential with `Extension.CurrentCredential()` and selects a branch from its optional `AuthenticationKind` field. For `UsernamePassword` it builds a separate record, `[ UID = Credential[Username], PWD = Credential[Password] ]`. For `Windows` it returns `null`; the SQL Server-only `Trusted_Connection` record is commented out. Any other value, including a missing one, reaches the final `Error.Record` branch.[^example]

The result is passed as `CredentialConnectionString` to `Odbc.DataSource`, next to the connection string. That connection string is either a caller-supplied `DSN=` value or a record of `Driver`, `Server` and `Database` (lines 102–109).[^caller] The source comment says credentials "are not persisted with the query and are set through a separate record field" (lines 112–113). That comment states the intent. This file does not show how the ODBC layer consumes the field.[^example]

`Config_DefaultUsernamePasswordHandling = true` (line 50) describes automatic UID and PWD handling by the base function. No code in `Actian.m` reads that name, so the explicit branch runs whatever its value is. Do not treat it as a switch.[^example]

Anaplan selects on a different key. `Anaplan.Connect` checks `Record.HasFields(credential, "Username")` and otherwise reads `Extension.CurrentCredential()[access_token]` (lines 316–332). That fits a connector that offers OAuth and UsernamePassword and tells them apart by the fields present, not by a kind label.[^variant]

## Choosing this shape

Use `AuthenticationKind` dispatch when the connector declares a fixed set of kinds and each kind has its own branch, as Actian does. Use field-presence dispatch, as Anaplan does, when the credential records differ in structure. For token-based sources, use the [OAuth2](oauth2.md) pattern. For driver configuration, see [ODBC configuration](odbc.md).

## Adaptation and failure paths

Start from the registration, not from a branch. Actian declares `Windows` and `UsernamePassword` (lines 260–263). Keep that list and the branches identical. A registered kind with no branch falls through to the final error.[^example]

A missing kind reaches the final `error`: the optional lookup produces null. M's [text-concatenation rule](https://learn.microsoft.com/en-us/powerquery-m/m-spec-operators#concatenation) makes the constructed message expression null as well. When adapting, provide a readable fallback for a missing kind while preserving the intended failure.[^example]

Anaplan's fallback at line 328 passes `Extension.CurrentCredential(true)` where `GetApiToken` expects a text URL (line 329). Do not copy that expression. This file does not document its argument.[^variant]

Keep `Credential[Password]`, the connection string, and the raw credential record out of traces and error messages. The serializer in Actian's diagnostics helper writes each record field's value without masking.[^trace]

See [diagnostics](diagnostics.md) for trace wrapping and [structured errors](errors.md) for error records.

## Examples

<!-- source: example -->
```powerquery
        // Handle credentials
        // Credentials are not persisted with the query and are set through a separate 
        // record field - CredentialConnectionString. The base Odbc.DataSource function
        // will handle UsernamePassword authentication automatically, but it is explictly
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
                error Error.Record("Error", "Unhandled authentication kind: " & Credential[AuthenticationKind]?),
```

The consumer passes the binding to the ODBC data source function:

<!-- source: caller -->
```powerquery
        OdbcDatasource = Odbc.DataSource(ConnectionString, [
            // A logical (true/false) that sets whether to view the tables grouped by their schema names
            HierarchicalNavigation = true, 
            // Prevents execution of native SQL statements. Extensions should set this to true.
            HideNativeQuery = true,
            // Allows upconversion of numeric types
            SoftNumbers = true,
            // Allow upconversion / resizing of numeric and string types
            TolerateConcatOverflow = true,
            // Enables connection pooling via the system ODBC manager
            ClientConnectionPooling = true,
            // Turn off sending SQL Server compatible connection string for Windows auth;
            // namely, "Trusted_Connection=Yes" (not used by our ODBC driver).
            SqlCompatibleWindowsAuth = false,
            // These values should be set by previous steps
            CredentialConnectionString = CredentialConnectionString,
            //AstVisitor = AstVisitor,
            SqlCapabilities = SqlCapabilities,
            SQLColumns = SQLColumns,
            SQLGetInfo = SQLGetInfo,
            SQLGetTypeInfo = SQLGetTypeInfo
        ])
```

The Anaplan variant selects by field presence:

<!-- source: variant -->
```powerquery
Anaplan.Connect = (apiUrl as text, authUrl as text) as table =>
    let 
        // Create trace context ONCE for entire session
        traceContext = TraceContext[CreateContext]("PowerBi"),
        trimmedApiUrl = Text.Trim(apiUrl),
        trimmedAuthUrl = Text.Trim(authUrl),
        credential = Extension.CurrentCredential() as record,
        configParams = if Record.HasFields(credential, "Username") then
          let
              apiUrl = if trimmedApiUrl <> null and IsValidUrl(trimmedApiUrl) then (trimmedApiUrl & Extension.LoadString("APIVersionPath")) else prodApiHost & Extension.LoadString("APIVersionPath"),
              authUrl = if trimmedAuthUrl <> null and IsValidUrl(trimmedAuthUrl) then trimmedAuthUrl else prodAuthHost,
              apiTokenTry = GetApiToken(authUrl, false),
              authUrlValidated = if apiTokenTry <> null then authUrl else if GetApiToken(prodAuthHost, false) <> null then prodAuthHost else Extension.CurrentCredential(true),
              apiToken = GetApiToken(authUrlValidated, false)
          in
              List.Buffer({apiToken[tokenValue], apiUrl, authUrl, traceContext})
        else List.Buffer({Extension.CurrentCredential()[access_token], trimmedApiUrl & Extension.LoadString("APIVersionPath"), "", traceContext}),
        source = GetWorkspacesTable(configParams)
    in 
        source as table;
```

[^example]: Actian/Actian.m lines 111–127 hold the credential binding; lines 42–50 hold the `Config_DefaultUsernamePasswordHandling` comment; lines 260–263 register `Windows` and `UsernamePassword`.
[^caller]: Actian/Actian.m lines 102–109 build the connection string; lines 218–239 pass `CredentialConnectionString` to `Odbc.DataSource`, with `SqlCompatibleWindowsAuth = false` at line 231.
[^variant]: Anaplan/Anaplan.pq lines 316–335 hold `Anaplan.Connect`, its `Username` check, and the line 328 fallback; lines 226–233 register OAuth and UsernamePassword.
[^trace]: Actian/Diagnostics.pqm lines 101–108 define `Serialize.Record`, which serializes each field value; no masking branch appears in this file.
