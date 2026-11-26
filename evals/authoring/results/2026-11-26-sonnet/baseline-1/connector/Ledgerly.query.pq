// SDK test query. Set a Key credential for this URL before evaluating.
let
    Source = Ledgerly.Contents("https://acme.ledgerly.example/api/v2"),
    Invoices = Source{[Key = "invoices"]}[Data]
in
    Invoices
