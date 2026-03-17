# Power Query Patterns: ODBC Bitwise Flag Composition

ODBC-based DirectQuery connectors must declare their SQL conformance level and capability flags to `Odbc.DataSource`. These flags (defined in the ODBC specification header `sqlext.h`) are bitmask constants — a driver may support a combination of capabilities represented by OR-ing multiple constant values together.

Writing the final OR result as a single hardcoded integer is unreadable and error-prone. Microsoft Certified ODBC connectors instead ship a shared `OdbcConstants.pqm` module that defines all constants as named fields and provides a `Flags` accumulator function that OR-combines a list of named constants into one integer.

## The `Flags` + `List.Generate` + `Number.BitwiseOr` Pattern

### 1. The `OdbcConstants.pqm` helper module

_Note: This is an exact extraction from Microsoft's AmazonAthena and ClickHouse connectors — it appears verbatim across all ODBC-based certified connectors._

```powerquery
// OdbcConstants.pqm
// Values from https://github.com/Microsoft/ODBC-Specification/blob/master/Windows/inc/sqlext.h
[
    // Accumulates a list of bitmask constants into a single OR-combined integer.
    Flags = (flags as list) =>
        if (List.IsEmpty(flags)) then 0 else
        let
            // List.Generate iterates, carrying state: {i, Combined}
            // - Init:      i=0, Combined=flags{0}  (seed with the first flag)
            // - Condition: i < List.Count(flags)
            // - Next:      Combined = Combined OR flags{i}, i = i + 1
            // - Selector:  emit [Combined] at each step
            Loop = List.Generate(
                ()    => [i = 0, Combined = flags{0}],
                each  [i] < List.Count(flags),
                each  [Combined = Number.BitwiseOr([Combined], flags{i}), i = [i]+1],
                each  [Combined]
            ),
            Result = List.Last(Loop)   // final accumulated value
        in
            Result,

    // SQL Conformance constants (SQL_SC_*)
    SQL_SC =
    [
        SQL_SC_SQL92_ENTRY            = 1,
        SQL_SC_FIPS127_2_TRANSITIONAL = 2,
        SQL_SC_SQL92_INTERMEDIATE     = 4,
        SQL_SC_SQL92_FULL             = 8
    ],

    // ... (additional constant groups: SQL_AF, SQL_CB, SQL_FN_*, etc.)
]
```

### 2. Selecting a conformance level at the connector root

```powerquery
// AmazonAthena.m — top of file, before any function definitions.
// Selecting SQL_SC_SQL92_FULL (= 8) tells the engine the driver supports
// the full SQL-92 standard, enabling maximum query folding.
Config_SqlConformance = SQL_SC[SQL_SC_SQL92_FULL];  // null, 1, 2, 4, 8
```

### 3. Composing flags for `SqlCapabilities`

```powerquery
// AmazonAthena.m — building the SqlCapabilities record passed to Odbc.DataSource
Connect = Odbc.DataSource(ConnectionString, [
    HierarchicalNavigation = true,

    SqlCapabilities = [
        PrepareStatements = true,
        SupportsTop       = false,

        // Compose the SQL function support flags using the Flags() accumulator.
        // Each named constant is OR-combined: the result is a single integer
        // that the ODBC layer decodes bit-by-bit.
        SupportedNumericFunctions = ODBC[Flags]({
            ODBC[SQL_FN_NUM][SQL_FN_NUM_ABS],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_CEILING],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_FLOOR],
            ODBC[SQL_FN_NUM][SQL_FN_NUM_ROUND]
        }),

        SupportedStringFunctions = ODBC[Flags]({
            ODBC[SQL_FN_STR][SQL_FN_STR_CONCAT],
            ODBC[SQL_FN_STR][SQL_FN_STR_LENGTH],
            ODBC[SQL_FN_STR][SQL_FN_STR_SUBSTRING]
        }),

        SQL_CONVERT_FUNCTIONS = 0x2  // SQL_FN_CVT_CAST
    ],

    // Pass the conformance level from the top-level config constant
    SQLGetInfo = [
        SQL_SQL_CONFORMANCE = Config_SqlConformance
    ]
])
```

### 4. How `List.Generate` accumulates the OR

`List.Generate` is M's imperative loop construct. It carries mutable state as a record across iterations:

| Argument | Role |
|----------|------|
| `() => [i=0, Combined=flags{0}]` | Initial state — seed `Combined` with the first flag to avoid an OR-with-zero identity step |
| `each [i] < List.Count(flags)` | Loop condition |
| `each [Combined = Number.BitwiseOr([Combined], flags{i}), i = [i]+1]` | State transition — OR the current flag into `Combined`, advance index |
| `each [Combined]` | Selector — emit only the `Combined` field at each step |

`List.Last(Loop)` retrieves the final record's `Combined` value after all flags have been OR-ed in.

### 5. Why not just write the integer directly

```powerquery
// Avoid — what does 0x00027BE7 mean?
SupportedNumericFunctions = 163815,

// Prefer — self-documenting, survives ODBC spec updates
SupportedNumericFunctions = ODBC[Flags]({
    ODBC[SQL_FN_NUM][SQL_FN_NUM_ABS],
    ODBC[SQL_FN_NUM][SQL_FN_NUM_CEILING],
    ODBC[SQL_FN_NUM][SQL_FN_NUM_FLOOR]
}),
```

Named constants make code reviews tractable and allow adding or removing capabilities by editing the list rather than recalculating the bitmask.
