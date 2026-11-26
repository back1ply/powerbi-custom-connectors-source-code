/*
Note: Created a copy of this test with different output in the datasource specific folder for Bigquery to address
"Bug 1763585: GQL Issue - DataConnectors - BigQuery - ODBC - Date functions over datetime ignore the time in the output"
*/
(parameter) =>
let
    T2 = Table.SelectColumns(parameter[taxi_table], {"RecordID","lpep_dropoff_datetime"}),
    T3 = Table.Sort(T2, {"RecordID"}),
    T7 = Table.AddColumn(T3, "W+1", each Date.AddWeeks([lpep_dropoff_datetime], 1)),
    T9 = Table.FirstN(T7, 1)
in
    T9
