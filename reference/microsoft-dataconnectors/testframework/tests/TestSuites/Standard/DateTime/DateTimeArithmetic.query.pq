/*
Note: This test will fail for ADBC: Bug 1610491 Snowflake Adbc test failure: DateTimeArithmetic.query.pq -  https://dev.azure.com/powerbi/Power%20Query/_workitems/edit/1610491/
#table( type table [PULocationID = number, lpep_pickup_datetime = datetime, Diff1 = any, Diff2 = any, Diff3 = any] , {{3, #datetime(2023, 2, 8, 0, 36, 0), 7603200000000000, 5050944000000000, 4868640000000000} , {7, #datetime(2023, 2, 1, 13, 21, 0), 7597152000000000, 5044896000000000, 4862592000000000} , {7, #datetime(2023, 2, 1, 16, 8, 0), 7597152000000000, 5044896000000000, 4862592000000000} , {7, #datetime(2023, 2, 1, 18, 33, 0), 7597152000000000, 5044896000000000, 4862592000000000} } ) 
*/

(parameter) =>
let
    Sorted = Table.Sort(parameter[taxi_table], {"RecordID"}),
    T2 = Table.SelectColumns(Sorted, {"PULocationID","lpep_pickup_datetime"}),
    T3 = Table.Sort(T2, {"PULocationID"}),
    T4 = Table.AddColumn(T3, "Diff1", each [lpep_pickup_datetime] - #datetime(1999,1,5,0,0,0)),
    T5 = Table.AddColumn(T4, "Diff2", each [lpep_pickup_datetime] - #datetime(2007,2,6,0,0,0)),
    T6 = Table.AddColumn(T5, "Diff3", each [lpep_pickup_datetime] - #datetime(2007,9,5,0,0,0)),
    TA = Table.FirstN(T6, 4)
in
    TA