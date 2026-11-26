# Quality bar

## Publishing today

New certification submissions closed in October 2025; Microsoft builds new connectors
itself, and custom connectors remain supported in Power BI Desktop and through the
on-premises data gateway. So a production connector today is a signed custom
connector:

- **Signed `.mez`.** Sign it ([handling-connector-signing](https://learn.microsoft.com/en-us/power-query/handling-connector-signing))
  and give users the thumbprint to trust, so they need not lower Power BI Desktop's
  extension security setting.
- **Scheduled refresh works.** The service refreshes through the gateway, which needs
  `TestConnection` and, for OAuth, the `state` parameter passed through `StartLogin`.
  The [development FAQ](https://learn.microsoft.com/en-us/power-query/custom-connector-development-faq)
  names both as common causes of failures seen only in the service.
- **Versioned.** Raise `[Version = "x.y.z"]` on every release
  ([handling-versioning](https://learn.microsoft.com/en-us/power-query/handling-versioning)).

## The retired certification rules (2024)

Microsoft's last certification page (archived 2024-08-09; link in
[sources.md](sources.md)) is still the best published bar for a connector others will
rely on. Paraphrased:

**Must**

- Section document format, with a version header above it.
- Function documentation metadata.
- A `TestConnection` handler.
- Naming `DataSourceKind.FunctionName`, with a function name that suits the domain
  (`Contents`, `Tables`, `Document`, `Databases`); no "Power BI", "Connector" or "API"
  in names or in the `.mez` file name.
- `Beta = true` on the initial release.

**Should**

- Icons.
- A navigation table.
- Display strings in `resources.resx`; URLs and values stay in code.

**Security**

- Credentials (`Extension.CurrentCredential`): use them only where needed, send them
  only over HTTPS, and prefer POST to GET; when a GET must carry a secret, pass it with
  `CredentialQueryString` in the `Web.Contents` options.
- Diagnostics: trace no personal data and no bulk data; put tracing behind a switch and
  turn it off before release.
- `Expression.Evaluate`: never on user input or on text fetched at runtime.

**Before submission (then)** Microsoft also asked for a sample `.pbix` with a query
per navigation item, a persistent test account, testing instructions, and an
end-to-end refresh tested in the Power BI service. These remain good release
criteria.

`uv run pqkb certification --path <folder>` checks the must, should and security items
it can read from source and marks the rest `review`.
