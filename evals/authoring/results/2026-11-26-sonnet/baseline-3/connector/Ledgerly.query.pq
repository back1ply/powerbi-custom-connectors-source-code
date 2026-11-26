// Test query. Replace the URL with a test tenant and set an API key credential for it first.
let
    source = Ledgerly.Contents("https://acme.ledgerly.example/api/v2"),
    invoices = source{[Key = "Invoices"]}[Data]
in
    invoices
