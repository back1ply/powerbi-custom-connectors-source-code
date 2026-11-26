// Test queries for the Power Query SDK. Set a Key credential first.
// Every field of the result should be true. Replace the URL with a test account's.
let
    Url = "https://acme.ledgerly.example/api/v2",
    Source = Ledgerly.Contents(Url),

    HasColumns = (data as table, expected as list) => Table.ColumnNames(data) = expected,
    InvoiceColumns = {"id", "number", "customer_id", "issued_at", "due_at", "total", "currency", "status", "updated_at"},
    CustomerColumns = {"id", "name", "email", "country", "created_at"},
    PaymentColumns = {"id", "invoice_id", "amount", "paid_at", "method"},

    // A filter in the far future returns an empty list, which must keep its columns.
    Empty = Ledgerly.Contents(Url, [UpdatedSince = #datetimezone(2999, 1, 1, 0, 0, 0, 0, 0)]),
    EmptyInvoices = Empty{[Key = "invoices"]}[Data],

    Fails = (action as function) => (try action())[HasError],

    Results = [
        Navigator = Source[Name] = {"Invoices", "Customers", "Payments"},
        Invoices = HasColumns(Source{[Key = "invoices"]}[Data], InvoiceColumns),
        Customers = HasColumns(Source{[Key = "customers"]}[Data], CustomerColumns),
        Payments = HasColumns(Source{[Key = "payments"]}[Data], PaymentColumns),
        EmptyIsEmpty = Table.IsEmpty(EmptyInvoices),
        EmptyKeepsColumns = HasColumns(EmptyInvoices, InvoiceColumns),
        RejectsHttp = Fails(() => Ledgerly.Contents("http://acme.ledgerly.example/api/v2")),
        RejectsQueryString = Fails(() => Ledgerly.Contents(Url & "?key=abc")),
        RejectsUnknownOption = Fails(() => Ledgerly.Contents(Url, [Nope = 1]))
    ]
in
    Results

// Manual checks against a mock server (a real account cannot force these):
//   401                      -> credential prompt with the "rejected the API key" message
//   404                      -> "did not find" message
//   429 + Retry-After: 5     -> waits 5 s, then succeeds
//   503 five times           -> "temporarily unavailable ... 5 attempt(s)"
//   503 with an HTML body    -> same message, no JSON parse error
//   three pages, one page, an empty page with a next cursor, a repeated cursor
