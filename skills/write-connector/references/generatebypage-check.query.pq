// Runs three Table.GenerateByPage helpers over page sequences that include empty pages.
// Run with PQTest against any connector, e.g.:
//   PQTest.exe run-test -e Any.mez -q generatebypage-check.query.pq -p
// Columns: pages served "empty" / "a, b" / "empty, a, b" / "a, empty, b"; the right
// answers are none / a,b / a,b / a,b. Result with PQTest 2.160.2:
//   sample-inline (TripPin 5, GitHub sample): null / a,b / null,a,b / a,null,b
//   sample-pqm (TripPin 7+, Learn helper-functions): none / a,b / none / a,null,b
//   combine (Table.GenerateByPage.pqm here): none / a,b / a,b / a,b
let
    Inline = (getNextPage as function) as table =>
        let
            listOfPages = List.Generate(
                () => getNextPage(null), (lastPage) => lastPage <> null, (lastPage) => getNextPage(lastPage)
            ),
            tableOfPages = Table.FromList(listOfPages, Splitter.SplitByNothing(), {"Column1"}),
            firstRow = tableOfPages{0}?
        in
            if (firstRow = null) then
                Table.FromRows({})
            else
                Value.ReplaceType(
                    Table.ExpandTableColumn(tableOfPages, "Column1", Table.ColumnNames(firstRow[Column1])),
                    Value.Type(firstRow[Column1])
                ),
    Pqm = (getNextPage as function) as table =>
        let
            listOfPages = List.Generate(
                () => getNextPage(null), (lastPage) => lastPage <> null, (lastPage) => getNextPage(lastPage)
            ),
            tableOfPages = Table.FromList(listOfPages, Splitter.SplitByNothing(), {"Column1"}),
            firstRow = tableOfPages{0}?
        in
            if (firstRow = null) then
                Table.FromRows({})
            else if (Table.IsEmpty(firstRow[Column1])) then
                firstRow[Column1]
            else
                Value.ReplaceType(
                    Table.ExpandTableColumn(tableOfPages, "Column1", Table.ColumnNames(firstRow[Column1])),
                    Value.Type(firstRow[Column1])
                ),
    Combine = (getNextPage as function) as table =>
        let
            listOfPages = List.Generate(
                () => getNextPage(null), (lastPage) => lastPage <> null, (lastPage) => getNextPage(lastPage)
            ),
            firstPage = List.First(listOfPages, null)
        in
            if firstPage = null then
                Table.FromRows({})
            else
                Value.ReplaceType(Table.Combine(listOfPages), Value.Type(firstPage)),
    PageType = type table [id = text],
    E = #table(PageType, {}),
    A = #table(PageType, {{"a"}}),
    B = #table(PageType, {{"b"}}),
    // Serves the given pages in order; the page index rides in metadata like a cursor.
    Run = (helper as function, pages as list) as text =>
        let
            result = helper(
                (previous) =>
                    let
                        i = if previous = null then 0 else Value.Metadata(previous)[i] + 1
                    in
                        if i >= List.Count(pages) then null else pages{i} meta [i = i]
            ),
            ids = List.Transform(Table.Column(result, "id"), each if _ = null then "null" else _)
        in
            if List.IsEmpty(ids) then "none" else Text.Combine(ids, ","),
    Cases = {{"empty", {E}}, {"a, b", {A, B}}, {"empty, a, b", {E, A, B}}, {"a, empty, b", {A, E, B}}},
    Helpers = {{"sample-inline", Inline}, {"sample-pqm", Pqm}, {"combine", Combine}},
    Rows = List.Transform(
        Helpers, (h) => {h{0}} & List.Transform(Cases, (c) => Run(h{1}, c{1}))
    ),
    Result = #table({"helper"} & List.Transform(Cases, each _{0}), Rows)
in
    Result
