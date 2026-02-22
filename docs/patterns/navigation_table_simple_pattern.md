# Power Query Patterns: Simple Navigation Tables

In the `table_navigation_metadata_pattern.md` guide, we documented how to build a Navigation Table manually from scratch by manipulating the underlying M Object Metadata using `Value.ReplaceType`.

While understanding the underlying metadata is important for architecture, it requires a lot of verbose boilerplate code.

To speed up development, Microsoft engineers utilize a standardized helper function called `Table.ToNavigationTable` (sometimes called `NavigationTable.Simple`). This single function abstracts all the metadata manipulation away.

## The `Table.ToNavigationTable` Pattern

If you open the source code for almost any certified custom connector (e.g., Zendesk, QuickBooks, Smartsheet), you will find this exact helper script pasted at the bottom of the main `.pq` file or loaded via `Extension.LoadFunction("Table.ToNavigationTable.pqm")`.

### 1. The Helper Function

Copy and paste this exact function into your connector. 

```powerquery
// Boilerplate Helper Function: Do Not Modify
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
        newTableType = Type.AddTableKey(tableType, keyColumns, true) meta 
        [
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

### 2. Implementation

To use the helper function, you first generate a standard Power Query table with the required columns, and then you pass it into the helper function.

```powerquery
shared MyConnector.Contents = () =>
    let
        // 1. Build a standard flat table representing your UI hierarchy
        source = #table(
            {"Name", "Key", "Data", "ItemKind", "ItemName", "IsLeaf"},
            {
                // A folder that contains more items
                {"Financials", "financials_folder", GetFinancialNavigation(), "Folder", "Folder", false},
                
                // A leaf node that actually returns tabular data
                {"Users", "users_table", GetUsersData(), "Table", "Table", true},
                
                // A leaf node that returns a scalar function
                {"Get User By ID", "get_user_func", GetUserById, "Function", "Function", true}
            }
        ),
        
        // 2. Pass the table to the helper function to instantly convert it into a UI Navigation Menu
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

// Mock functions for demonstration
GetFinancialNavigation = () => "Folder containing financial data";
GetUsersData = () => #table({"Id", "Name"}, {{1, "Alice"}, {2, "Bob"}});
```

### Why Use the Helper?
Writing the nested `Type.AddTableKey` and `Value.ReplaceType` logic in multiple places throughout a connector (especially if your API has multiple nested folders) introduces massive code duplication. The `Table.ToNavigationTable` function allows you to define complex hierarchies entirely using standard `Table.InsertRows` operations before stamping the metadata on at the very end.
