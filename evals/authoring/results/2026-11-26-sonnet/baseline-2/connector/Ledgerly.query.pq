// Test query for the Power Query SDK. Replace the URL with a test tenant and set a Key
// credential for it first. Every row of the result should show Passed = true.
let
    Url = "https://acme.ledgerly.example/api/v2",
    Source = Ledgerly.Contents(Url),
    Columns = (key as text) => Table.ColumnNames(Source{[Key = key]}[Data]),
    // A filter in the far future gives empty tables, which must keep their columns.
    Empty = Ledgerly.Contents(Url, #datetimezone(2999, 1, 1, 0, 0, 0, 0, 0)),
    SameWhenEmpty = (key as text) =>
        Table.IsEmpty(Empty{[Key = key]}[Data]) and Table.ColumnNames(Empty{[Key = key]}[Data]) = Columns(key),
    // Check the message, so that a missing credential does not count as a pass.
    Http = try Ledgerly.Contents("http://acme.ledgerly.example/api/v2"),
    HttpRejected = Http[HasError] and Text.Contains(Http[Error][Message], "HTTPS"),
    Results = #table(
        {"Test", "Passed"},
        {
            {"Navigator lists three tables", Table.Column(Source, "Key") = {"invoices", "customers", "payments"}},
            {"Invoice columns", Columns("invoices") = {"id", "number", "customer_id", "issued_at", "due_at", "total", "currency", "status", "updated_at"}},
            {"Customer columns", Columns("customers") = {"id", "name", "email", "country", "created_at"}},
            {"Payment columns", Columns("payments") = {"id", "invoice_id", "amount", "paid_at", "method"}},
            {"Empty invoices keep columns", SameWhenEmpty("invoices")},
            {"Empty customers keep columns", SameWhenEmpty("customers")},
            {"Empty payments keep columns", SameWhenEmpty("payments")},
            {"Plain HTTP is rejected", HttpRejected}
        }
    )
in
    Results
