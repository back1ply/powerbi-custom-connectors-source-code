// Smoke queries for the Power Query SDK. Replace the URL with a test account's,
// and set the key with "Power Query: Set credential".
let
    Url = "https://acme.ledgerly.example/api/v2",
    Nav = Ledgerly.Contents(Url),
    Future = Ledgerly.Contents(Url, [UpdatedSince = #datetimezone(2999, 1, 1, 0, 0, 0, 0, 0)]),
    Columns = (t as table) => Text.Combine(Table.ColumnNames(t), ","),
    Rejects = (call as function) => (try Table.RowCount(call()))[HasError],

    Results = [
        NavigatorNames = Nav[Name] = {"Invoices", "Customers", "Payments"},
        Invoices = Table.FirstN(Nav{[Name = "Invoices"]}[Data], 5),
        Customers = Table.FirstN(Nav{[Name = "Customers"]}[Data], 5),
        Payments = Table.FirstN(Nav{[Name = "Payments"]}[Data], 5),
        // Several pages must add up to the same rows as full-size pages.
        // One request per customer: run only against a small test account.
        PagingMatches =
            Table.RowCount(Ledgerly.Contents(Url, [PageSize = 1]){[Name = "Customers"]}[Data])
                = Table.RowCount(Nav{[Name = "Customers"]}[Data]),
        EmptyHasNoRows = Table.IsEmpty(Future{[Name = "Invoices"]}[Data]),
        EmptyKeepsColumns =
            Columns(Future{[Name = "Invoices"]}[Data])
                = "id,number,customer_id,issued_at,due_at,total,currency,status,updated_at",
        RejectsHttp = Rejects(() => Ledgerly.Contents("http://acme.ledgerly.example/api/v2")),
        RejectsPageSize = Rejects(() => Ledgerly.Contents(Url, [PageSize = 201])),
        RejectsUnknownOption = Rejects(() => Ledgerly.Contents(Url, [Limit = 1])),
        TestConnectionProbe = Table.RowCount(Ledgerly.Contents(Url, [TestConnection = true])) = 1
    ]
in
    Results
