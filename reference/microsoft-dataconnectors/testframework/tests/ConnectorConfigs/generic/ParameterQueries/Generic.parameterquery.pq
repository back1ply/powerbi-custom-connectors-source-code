Replace with the M query to connect to your data source and retrieve the NycTaxiGreen, NycTaxiGreenDate, TaxiZoneLookup & misc_table tables

// Example:
// let
//     Source = Sql.Database("your_server_name", "your_dabase_name"),
//     NycTaxiGreen_Table = Source{[Schema="your_schema_name",Item="NycTaxiGreen"]}[Data],
//     NycTaxiGreenDate_Table = Source{[Schema="your_schema_name",Item="NycTaxiGreenDate"]}[Data],
//     TaxiZoneLookup_Table =  Source{[Schema="your_schema_name",Item="TaxiZoneLookup"]}[Data],
//     misc_table = Source{[Schema="your_schema_name",Item="misc_table"]}[Data]
// in
//     [taxi_table = NycTaxiGreen_Table, taxi_date_table = NycTaxiGreenDate, zone_table = TaxiZoneLookup_Table, misc_table = misc_table]