/*
Note: These tests will fail for BigQuery because of the below bug
Bug 1768851: ADBC - BigQuery - Tests fail due to the Decimal Precision returning more digits after the decimal than expected
*/

(parameter) =>
let
    T = Table.Sort(parameter[taxi_table],{{"total_amount", Order.Descending}}),
    T0 = Table.FirstN(T,5),
    T1 = Table.SelectColumns(T0,{"passenger_count","total_amount"}),
    T13 = Table.AddColumn(T1,"DivideDecimalPrecision", each Number.RoundDown(Value.Divide([passenger_count],[total_amount],Precision.Decimal), 5)),
    Result = Table.FirstN(T13,1)
in
    Result
