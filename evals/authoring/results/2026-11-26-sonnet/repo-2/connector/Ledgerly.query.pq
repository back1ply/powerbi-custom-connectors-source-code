// SDK test query. Set Url to a test account, set a Key credential, then evaluate.
// Expected: one row per table with SchemaOk and EmptyFilterOk = true. EmptyFilterOk
// uses a future UpdatedSince, so each table is empty but keeps its columns.
let
    Url = "https://acme.ledgerly.example/api/v2",
    Expected = [
        invoices = {"id", "number", "customer_id", "issued_at", "due_at", "total", "currency", "status", "updated_at"},
        customers = {"id", "name", "email", "country", "created_at"},
        payments = {"id", "invoice_id", "amount", "paid_at", "method"}
    ],
    All = Ledgerly.Contents(Url),
    None = Ledgerly.Contents(Url, [UpdatedSince = #datetime(2999, 1, 1, 0, 0, 0)]),
    Check = (key as text) =>
        let
            full = All{[Key = key]}[Data],
            empty = None{[Key = key]}[Data],
            columns = Record.Field(Expected, key)
        in
            [
                Table = key,
                Rows = Table.RowCount(full),
                SchemaOk = Table.ColumnNames(full) = columns,
                EmptyFilterOk = Table.IsEmpty(empty) and Table.ColumnNames(empty) = columns
            ]
in
    Table.FromRecords(List.Transform(Record.FieldNames(Expected), Check))
