# Power Query Patterns: Custom Navigation Tables

By default, if you return a simple record of tables from your Power Query connector, Power BI will try to generate a basic navigation UI. However, to get a clean, deeply nested folder structure (like the ones used by enterprise databases or services like Databricks and Zendesk), you must build a custom Navigation Table using `Table.ToNavigationTable`.

While understanding the underlying metadata (`Value.ReplaceType`, `Type.AddTableKey`) is important for architecture, it requires a lot of verbose boilerplate code. To speed up development, Microsoft engineers utilize a standardized helper function. This single function abstracts all the metadata manipulation away.

## 1. The `Table.ToNavigationTable` Helper

Across the certified connectors, almost all use the exact same helper function to attach the necessary `NavigationTable.*` metadata to a standard table. Paste this into your connector.

```powerquery
Table.ToNavigationTable = (
    table as table,
    keyColumns as list,
    nameColumn as text,
    dataColumn as text,
    itemKindColumn as text,
    itemNameColumn as text,
    isLeafColumn as text
) as table =>
    let
        tableType = Value.Type(table),
        newTableType = Type.AddTableKey(tableType, keyColumns, true) meta [
            NavigationTable.NameColumn = nameColumn,
            NavigationTable.DataColumn = dataColumn,
            NavigationTable.ItemKindColumn = itemKindColumn,
            Preview.DelayColumn = itemNameColumn,
            NavigationTable.IsLeafColumn = isLeafColumn
        ],
        navigationTable = Value.ReplaceType(table, newTableType)
    in
        navigationTable;
```

## 2. Flat Base Navigation Structure

To use the helper function, you first generate a standard Power Query table with the required columns, and then you pass it into the helper function.

```powerquery
MyConnector.NavTable = () as table =>
    let
        // 1. Define the rows of your Navigation Tree
        source = #table(
            // Column Definitions
            {"Name", "Key", "Data", "ItemKind", "ItemName", "IsLeaf"},
            // Row Data
            {
                { "Users",      "users",      GetApiData("https://api.example.com/users"),      "Table", "Table", true },
                { "Invoices",   "invoices",   GetApiData("https://api.example.com/invoices"),   "Table", "Table", true },
                { "Get UserId", "get_userid", GetUserById,                                      "Function", "Function", true }
            }
        ),

        // 2. Wrap it with the helper function
        navTable = Table.ToNavigationTable(
            source,
            {"Key"},       // The column to use as the unique identifier
            "Name",        // The column containing the display name
            "Data",        // The column containing the actual Table/Function/Folder data
            "ItemKind",    // "Table", "Folder", "Function", "Database"
            "ItemName",    // "Table", "Folder", "Function", "Database"
            "IsLeaf"       // true if it contains data, false if it's a folder
        )
    in
        navTable;
```

## 3. Nested Folder Structures

If you have a complex API, you want to group tables into "Folders" which the user can expand in the Power BI UI.

A "Folder" in Power Query is simply a row in a Navigation Table where:

- `ItemKind` = `"Folder"`
- `IsLeaf` = `false`
- `Data` = Another Navigation Table!

```powerquery
MyConnector.NestedNavTable = () as table =>
    let
        // The sub-table that goes inside the "HR Data" folder
        hrFolderTable = #table(
            {"Name", "Key", "Data", "ItemKind", "ItemName", "IsLeaf"},
            {
                { "Employees", "emp", GetApiData(".../employees"), "Table", "Table", true },
                { "Timeoff",   "pto", GetApiData(".../timeoff"),   "Table", "Table", true }
            }
        ),
        hrNav = Table.ToNavigationTable(hrFolderTable, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf"),

        // The sub-table that goes inside the "Finance Data" folder
        financeFolderTable = #table(
            {"Name", "Key", "Data", "ItemKind", "ItemName", "IsLeaf"},
            {
                { "Invoices",  "inv", GetApiData(".../invoices"), "Table", "Table", true }
            }
        ),
        financeNav = Table.ToNavigationTable(financeFolderTable, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf"),

        // The Root Table (what the user sees first)
        rootTable = #table(
            {"Name", "Key", "Data", "ItemKind", "ItemName", "IsLeaf"},
            {
                { "Human Resources", "hr",  hrNav,      "Folder", "Folder", false }, // Note IsLeaf = false
                { "Finance",         "fin", financeNav, "Folder", "Folder", false }
            }
        ),

        finalNavTable = Table.ToNavigationTable(rootTable, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        finalNavTable;
```

### Supported `ItemKind` Values

When defining the `ItemKind` column, Power BI uses this to determine what icon to show in the UI:

- `"Table"` (Standard data table)
- `"Folder"` (Expandable folder icon)
- `"Database"` (Database server icon)
- `"Function"` (Fx icon, useful for parameterized calls)
- `"View"` (Database view icon)
- `"Schema"` (Schema icon)
