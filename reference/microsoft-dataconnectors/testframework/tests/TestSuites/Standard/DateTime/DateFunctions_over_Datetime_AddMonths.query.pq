/*
Note: Created a copy of this test with different output in the datasource specific folder for Bigquery to address
"Bug 1763585: GQL Issue - DataConnectors - BigQuery - ODBC - Date functions over datetime ignore the time in the output"
*/
(parameter) =>
let
    T2 = Table.SelectColumns(parameter[taxi_table], {"RecordID","lpep_dropoff_datetime"}),
    T3 = Table.Sort(T2, {"RecordID"}),
    T6 = Table.AddColumn(T3, "M+1", each Date.AddMonths([lpep_dropoff_datetime], 1)),
    T9 = Table.FirstN(T6, 1)
in
    Table.Buffer(T9)
