# Power Query Patterns: DateTime Zone Coercion

API filter parameters that accept dates often accept multiple input types: a bare `Date`, a `DateTime`, or a fully time-zone-aware `DateTimeZone`. When a connector exposes such a parameter to Power BI users, the parameter can arrive as any of these three types depending on how the user filled in the dialog.

Passing a mismatched type to `DateTimeZone.ToText` (which many connectors use to build URL query strings) will throw a type mismatch error at runtime. The fix is to normalize all three possible input types to `DateTimeZone` before doing anything else with the value.

## The `DateTime.AddZone` Normalization Pattern

### 1. The three-way type guard

_Note: This is an exact extraction from AssembleViews.m._

```powerquery
// viewAtDate can be null, Date, DateTime, or DateTimeZone — handle all cases.
viewDate =
    if viewAtDate = null then
        null
    else if Value.Is(viewAtDate, DateTimeZone.Type) then
        // Already correct type — pass through unchanged.
        viewAtDate
    else if Value.Is(viewAtDate, DateTime.Type) then
        // Attach the local machine's UTC offset so the type becomes DateTimeZone.
        DateTime.AddZone(viewAtDate, DateTimeZone.ZoneHours(DateTimeZone.LocalNow()))
    else if Value.Is(viewAtDate, Date.Type) then
        // Promote Date → DateTime (midnight) then attach the local offset.
        DateTime.AddZone(DateTime.From(viewAtDate), DateTimeZone.ZoneHours(DateTimeZone.LocalNow()))
    else
        error Error.Record(
            "InvalidParameterType",
            "Parameter 'viewAtDate' must be a date, datetime, or datetimezone type."
        ),

// Now safe to serialize — viewDate is always null or DateTimeZone
viewDateParam = if viewDate = null then "" else "?viewAtDate=" & DateTimeZone.ToText(viewDate),
ApiUrl = Uri.Combine(url, "/api/v1/views/" & viewId & "/instances" & viewDateParam),
```

### 2. Key functions explained

| Function | Purpose |
|----------|---------|
| `Value.Is(x, DateTimeZone.Type)` | Runtime type check — does not coerce, just tests |
| `DateTime.From(date)` | Promotes a `Date` to `DateTime` at midnight (`00:00:00`) |
| `DateTimeZone.LocalNow()` | Returns current local time with the machine's UTC offset attached |
| `DateTimeZone.ZoneHours(dtz)` | Extracts the integer UTC offset hours from a `DateTimeZone` value |
| `DateTime.AddZone(dt, hours)` | Attaches a UTC offset to a `DateTime`, producing a `DateTimeZone` |
| `DateTimeZone.ToText(dtz)` | Serializes a `DateTimeZone` to ISO 8601 text for use in URLs / API calls |

### 3. Why `ZoneHours` instead of a hardcoded offset

Using `DateTimeZone.ZoneHours(DateTimeZone.LocalNow())` reads the offset from the machine running the query (the Power BI gateway or Desktop session). This respects daylight saving time transitions and avoids hardcoding a UTC+N constant that would be wrong half the year in DST-observing regions.

```powerquery
// Do this:
localOffset = DateTimeZone.ZoneHours(DateTimeZone.LocalNow()),  // e.g. 3 or -5
normalized  = DateTime.AddZone(myDatetime, localOffset)

// Not this — brittle, wrong during DST:
normalized  = DateTime.AddZone(myDatetime, 3)
```

### 4. Reusable helper form

Extract this into a shared function when multiple endpoints need the same normalization:

```powerquery
// Utils.pqm
NormalizeDateTimeZone = (input as any) as nullable datetimezone =>
    if input = null then null
    else if Value.Is(input, DateTimeZone.Type) then input
    else if Value.Is(input, DateTime.Type) then
        DateTime.AddZone(input, DateTimeZone.ZoneHours(DateTimeZone.LocalNow()))
    else if Value.Is(input, Date.Type) then
        DateTime.AddZone(DateTime.From(input), DateTimeZone.ZoneHours(DateTimeZone.LocalNow()))
    else
        error Error.Record("InvalidParameterType",
            "Expected date, datetime, or datetimezone. Got: " & Value.Type(input));

// Usage at any endpoint
startParam = if NormalizeDateTimeZone(startDate) = null then ""
             else "&start=" & DateTimeZone.ToText(NormalizeDateTimeZone(startDate)),
```

### 5. Common mistake: skipping the `Date` branch

A frequent bug is handling `DateTimeZone` and `DateTime` but forgetting `Date`. Power BI's date picker returns a plain `Date` when the user does not include a time component. Skipping the `Date` branch causes a silent fall-through to the `else error` arm and surfaces as a cryptic type error to the end user.

Always include all three branches: `DateTimeZone.Type` → `DateTime.Type` → `Date.Type` → `else error`.
