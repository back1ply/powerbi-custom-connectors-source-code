# Power Query Patterns: Feature Switches (Flighting)

When Microsoft or large enterprise developers build custom connectors, they often need to test new API endpoints, beta features, or major architectural changes without breaking the connector for existing users.

To achieve this, they use "Flighting" or Feature Switches via the undocumented `Environment.FeatureSwitch` function.

## The `Environment.FeatureSwitch` Pattern

This function allows your M code to read hidden environment variables or Power BI desktop diagnostic settings to toggle code paths dynamically.

### Implementation

You provide the name of the switch and a default value (what the value should be if the switch is not explicitly enabled by the user or the environment).

```powerquery
// 1. Define your feature switches at the top of your connector
// If the user hasn't set this switch, it defaults to false.
UseNewV2Api = Value.ConvertToLogical(Environment.FeatureSwitch("MyConnector_UseNewV2Api", false));

// If you want to default a feature to ON, but allow users to disable it:
EnableAdvancedCaching = Value.ConvertToLogical(Environment.FeatureSwitch("MyConnector_EnableCaching", true));

shared MyConnector.Contents = () =>
    let
        // 2. Read the switch and branch your logic
        data = if (UseNewV2Api) then
            // Use the brand new experimental V2 endpoint
            Web.Contents("https://api.mycompany.com/v2/data")
        else
            // Fall back to the stable V1 endpoint
            Web.Contents("https://api.mycompany.com/v1/data")
    in
        Json.Document(data);
```

### How Users Enable Feature Switches

Feature switches are not visible in the Power BI UI by default. They are usually enabled via system environment variables or through hidden registry keys during testing.

In Power Query Desktop testing, a developer can set an environment variable on their Windows machine:
`MyConnector_UseNewV2Api = true`

When Power BI starts, the M engine reads this environment variable, and `Environment.FeatureSwitch` evaluates to `true`, executing the experimental code path.

### Why this is powerful

1. **A/B Testing**: Roll out a completely rewritten parser (`Csv.Document` vs `Json.Document`) but wrap it in a feature switch.
2. **Safe Refactoring**: When migrating to new API versions, you don't need to release "MyConnector" and "MyConnector V2". You release one connector, tell your beta testers to enable the feature switch, and if it crashes, it only affects those who opted in.
3. **Cloud vs Desktop**: Microsoft frequently uses `Environment.FeatureSwitch("Cloud", "global")` to detect if the connector is running in Power BI Desktop vs Power BI Service vs US Government Cloud, automatically adjusting base URLs without user intervention.
