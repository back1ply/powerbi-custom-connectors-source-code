---
type: Power Query Connector
title: FHIR
description: Connect to FHIR server
tags: [aad, anonymous, diagnostics, errors, navigation, packaging, pagination, parameter-metadata, response-metadata, schema, table-view, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.5
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/DSTU2-ChoiceReshapers.pqm
  title: DSTU2-ChoiceReshapers.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/DSTU2-ContainedReshapers.pqm
  title: DSTU2-ContainedReshapers.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/DSTU2-FhirTypes.pqm
  title: DSTU2-FhirTypes.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/DSTU2-SearchParameterFoldingPatterns.pqm
  title: DSTU2-SearchParameterFoldingPatterns.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/DocumentationTestCases.pqm
  title: DocumentationTestCases.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Fhir.pq
  title: Fhir.pq
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Folding.pqm
  title: Folding.pqm
- id: file-9
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/R4-ChoiceReshapers.pqm
  title: R4-ChoiceReshapers.pqm
- id: file-10
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/R4-ContainedReshapers.pqm
  title: R4-ContainedReshapers.pqm
- id: file-11
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/R4-FhirTypes.pqm
  title: R4-FhirTypes.pqm
- id: file-12
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/R4-SearchParameterFoldingPatterns.pqm
  title: R4-SearchParameterFoldingPatterns.pqm
- id: file-13
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/STU3-ChoiceReshapers.pqm
  title: STU3-ChoiceReshapers.pqm
- id: file-14
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/STU3-ContainedReshapers.pqm
  title: STU3-ContainedReshapers.pqm
- id: file-15
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/STU3-FhirTypes.pqm
  title: STU3-FhirTypes.pqm
- id: file-16
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/STU3-SearchParameterFoldingPatterns.pqm
  title: STU3-SearchParameterFoldingPatterns.pqm
- id: file-17
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Fhir/1.0.5/Fhir_1.0.5.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T11:49:44Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.5 | Aad, Anonymous |

# Source files

* [DSTU2-ChoiceReshapers.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/DSTU2-ChoiceReshapers.pqm)
* [DSTU2-ContainedReshapers.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/DSTU2-ContainedReshapers.pqm)
* [DSTU2-FhirTypes.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/DSTU2-FhirTypes.pqm)
* [DSTU2-SearchParameterFoldingPatterns.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/DSTU2-SearchParameterFoldingPatterns.pqm)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Diagnostics.pqm)
* [DocumentationTestCases.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/DocumentationTestCases.pqm)
* [Fhir.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Fhir.pq)
* [Folding.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Folding.pqm)
* [R4-ChoiceReshapers.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/R4-ChoiceReshapers.pqm)
* [R4-ContainedReshapers.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/R4-ContainedReshapers.pqm)
* [R4-FhirTypes.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/R4-FhirTypes.pqm)
* [R4-SearchParameterFoldingPatterns.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/R4-SearchParameterFoldingPatterns.pqm)
* [STU3-ChoiceReshapers.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/STU3-ChoiceReshapers.pqm)
* [STU3-ContainedReshapers.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/STU3-ContainedReshapers.pqm)
* [STU3-FhirTypes.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/STU3-FhirTypes.pqm)
* [STU3-SearchParameterFoldingPatterns.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/STU3-SearchParameterFoldingPatterns.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Table.ToNavigationTable.pqm)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Uncertain match (older review)**
    * [Fhir.pq line 214](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Fhir.pq#L214) — `defaultResponseBuffered = Binary.Buffer(defaultResponse),`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Fhir.pq line 78](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Fhir.pq#L78) — `fhirVersion = Diagnostics.Trace(TraceLevel.Information, "fhirVersion: " & _fhirVersion, _fhirVersion)`
    * [Fhir.pq line 78](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Fhir.pq#L78) — `fhirVersion = Diagnostics.Trace(TraceLevel.Information, "fhirVersion: " & _fhirVersion, _fhirVersion)`
    * [Folding.pqm line 295](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Folding.pqm#L295) — `Diagnostics.Trace(TraceLevel.Error, "Pattern matching failed on pattern:#(cr)#(lf)" & Diagnostics.ValueToText(pattern),`
    * [Folding.pqm line 295](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Folding.pqm#L295) — `Diagnostics.Trace(TraceLevel.Error, "Pattern matching failed on pattern:#(cr)#(lf)" & Diagnostics.ValueToText(pattern),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Fhir.pq line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Fhir.pq#L48) — `Documentation.FieldCaption = Extension.LoadString("UrlFieldCaption"),`
    * [Fhir.pq line 60](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Fhir.pq#L60) — `shared Fhir.Contents = Value.ReplaceType(FhirNavTable, Fhir.Contents.Type);`
    * [Fhir.pq line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Fhir.pq#L46) — `Fhir.Contents.Type = type function (`
    * [Folding.pqm line 904](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Folding.pqm#L904) — `VisitRowExpression = (expression, rootType) => expression & [ Value = visit(expression[Value], rootType), Type = type function (row as rootType) as logical ]`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Fhir.pq line 118](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Fhir.pq#L118) — `navTable = Table.ToNavigationTable(withIsLeaf, { "Name" }, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Table.ToNavigationTable.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Table.ToNavigationTable.pqm#L14) — `NavigationTable.NameColumn = nameColumn,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [DSTU2-ChoiceReshapers.pqm line 1923](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/DSTU2-ChoiceReshapers.pqm#L1923) — `#"page" = if r[#"page"]? = null then null else List.Transform(r[#"page"]?, @ImplementationGuide_page.Reshape)`
    * [DSTU2-FhirTypes.pqm line 2902](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/DSTU2-FhirTypes.pqm#L2902) — `#"page" = [`
    * [Fhir.pq line 226](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Fhir.pq#L226) — `List.Generate(`
    * [R4-ChoiceReshapers.pqm line 3575](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/R4-ChoiceReshapers.pqm#L3575) — `#"page" = ImplementationGuide_definition_page.Reshape(r[#"page"]?),`
    * [R4-FhirTypes.pqm line 854](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/R4-FhirTypes.pqm#L854) — `#"offset" = Int32.Type`
    * [STU3-ChoiceReshapers.pqm line 2935](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/STU3-ChoiceReshapers.pqm#L2935) — `#"page" = if r[#"page"]? = null then null else List.Transform(r[#"page"]?, @ImplementationGuide_page.Reshape)`
    * [STU3-FhirTypes.pqm line 694](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/STU3-FhirTypes.pqm#L694) — `#"offset" = Int32.Type`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Fhir.pq line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Fhir.pq#L29) — `Label = Extension.LoadString("DataSourceLabel")`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 276](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Diagnostics.pqm#L276) — `metadata = Value.Metadata(x),`
    * [Fhir.pq line 219](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Fhir.pq#L219) — `if Value.Metadata(defaultResponse)[Response.Status] = 200 then defaultResponseBuffered else fallbackResponse,`
    * [Fhir.pq line 69](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Fhir.pq#L69) — `response = Web.Contents(metadataUri, [ Headers = [ Accept = "application/json" ] ]),`
    * [Folding.pqm line 141](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Folding.pqm#L141) — `f1MetadataName = Value.Metadata(Value.Type(f1))[Documentation.Name]?,`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [DSTU2-ChoiceReshapers.pqm line 6446](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/DSTU2-ChoiceReshapers.pqm#L6446) — `type table [ ResourceTypeName = text, Reshaper = function (r as nullable record) as nullable record ],`
    * [DSTU2-FhirTypes.pqm line 11625](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/DSTU2-FhirTypes.pqm#L11625) — `#table(type table [ResourceTypeName = text, Type = Type.Type, SchemaApplyFunction = function ], {`
    * [DSTU2-SearchParameterFoldingPatterns.pqm line 68019](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/DSTU2-SearchParameterFoldingPatterns.pqm#L68019) — `type table [`
    * [Diagnostics.pqm line 197](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Diagnostics.pqm#L197) — `if base = type table then "table" else`
    * [Fhir.pq line 60](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Fhir.pq#L60) — `shared Fhir.Contents = Value.ReplaceType(FhirNavTable, Fhir.Contents.Type);`
    * [Fhir.pq line 111](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Fhir.pq#L111) — `withData = Table.AddColumn(renamed, "Data", each Fhir.View(url, [Name], fhirVersion, searchQuery), type table),`
    * [R4-ChoiceReshapers.pqm line 12712](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/R4-ChoiceReshapers.pqm#L12712) — `type table [ ResourceTypeName = text, Reshaper = function (r as nullable record) as nullable record ],`
    * [R4-FhirTypes.pqm line 22959](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/R4-FhirTypes.pqm#L22959) — `#table(type table [ResourceTypeName = text, Type = Type.Type, SchemaApplyFunction = function ], {`
    * [R4-SearchParameterFoldingPatterns.pqm line 143064](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/R4-SearchParameterFoldingPatterns.pqm#L143064) — `type table [`
    * [STU3-ChoiceReshapers.pqm line 9299](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/STU3-ChoiceReshapers.pqm#L9299) — `type table [ ResourceTypeName = text, Reshaper = function (r as nullable record) as nullable record ],`
    * [STU3-FhirTypes.pqm line 17017](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/STU3-FhirTypes.pqm#L17017) — `#table(type table [ResourceTypeName = text, Type = Type.Type, SchemaApplyFunction = function ], {`
    * [STU3-SearchParameterFoldingPatterns.pqm line 96765](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/STU3-SearchParameterFoldingPatterns.pqm#L96765) — `type table [`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [DSTU2-ChoiceReshapers.pqm line 3788](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/DSTU2-ChoiceReshapers.pqm#L3788) — `#"error" = if r[#"error"]? = null then null else List.Transform(r[#"error"]?, ClaimResponse_error.Reshape),`
    * [DSTU2-FhirTypes.pqm line 1185](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/DSTU2-FhirTypes.pqm#L1185) — `#"error" = table [`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Fhir.pq line 77](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Fhir.pq#L77) — `if Text.StartsWith(fhirVersionString, "4.") then "R4" else error(Text.Format(Extension.LoadString("UnknownFhirVersionError"), fhirVersionString)),`
    * [Folding.pqm line 146](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Folding.pqm#L146) — `patternMatchingFailureErrorRecord = Error.Record("Pattern matching failure"),`
    * [Folding.pqm line 147](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Folding.pqm#L147) — `PatternMatchingFailure = () => error patternMatchingFailureErrorRecord,`
    * [R4-ChoiceReshapers.pqm line 8247](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/R4-ChoiceReshapers.pqm#L8247) — `#"error" = if r[#"error"]? = null then null else List.Transform(r[#"error"]?, ClaimResponse_error.Reshape),`
    * [R4-FhirTypes.pqm line 2127](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/R4-FhirTypes.pqm#L2127) — `#"error" = table [`
    * [STU3-ChoiceReshapers.pqm line 5791](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/STU3-ChoiceReshapers.pqm#L5791) — `#"error" = if r[#"error"]? = null then null else List.Transform(r[#"error"]?, ClaimResponse_error.Reshape),`
    * [STU3-FhirTypes.pqm line 1716](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/STU3-FhirTypes.pqm#L1716) — `#"error" = table [`
* [Table.View handlers](../patterns/table-view.md)
  * **Match from a review of older source**
    * [Fhir.pq line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Fhir.pq#L124) — `View = (state as record) => Table.View(null, Diagnostics.WrapHandlers([`
    * [Fhir.pq line 127](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Fhir.pq#L127) — `GetType = () =>`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Fhir.pq line 69](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Fhir/Fhir.pq#L69) — `response = Web.Contents(metadataUri, [ Headers = [ Accept = "application/json" ] ]),`
