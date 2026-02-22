# Power Query Patterns: Customizing the "Get Data" UI

When building a custom connector, the default experience is quite basic. Your connector appears in the "Other" category in Power BI Desktop's "Get Data" dialog with a generic cube icon.

To make your connector look professional (with brand colors, custom icons, beta tags, and proper categorization), you must configure the `Publish` record.

## The Publish Record

The `Publish` record is linked to your main function via metadata.

```powerquery
[DataSource.Kind="MyConnector", Publish="MyConnector.Publish"]
shared MyConnector.Contents = () => ...
```

### Configuration Options

The `Publish` record controls exactly how your connector appears in Power BI Desktop.

```powerquery
MyConnector.Publish = [
    // 1. Beta Tag
    // Set to true to display the yellow (Beta) warning when users connect
    Beta = true,
    
    // 2. Category
    // Where does your connector live? "Online Services", "Database", "Azure", "Other"
    Category = "Online Services",
    
    // 3. Button Text
    // The text shown in the Get Data dialog. Array of { "Title", "Subtitle/Help Text" }
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    
    // 4. Custom Icons
    // A record containing the Base64 images for the 16x16, 20x20, 24x24, and 32x32 UI elements
    SourceImage = MyConnector.Icons,
    SourceTypeImage = MyConnector.Icons
];
```

### Adding Custom Icons

Power BI requires icons in four specific pixel sizes: 16x16, 20x20, 24x24, and 32x32. These are usually PNG files embedded directly into the project directory.

The standard pattern is to define an `Icons` record that uses `Extension.Contents()` to load the PNG files from your project folder and construct the image structures Power BI expects.

```powerquery
MyConnector.Icons = [
    Icon16 = { Extension.Contents("Icon16.png"), Extension.Contents("Icon20.png"), Extension.Contents("Icon24.png"), Extension.Contents("Icon32.png") },
    Icon32 = { Extension.Contents("Icon32.png"), Extension.Contents("Icon40.png"), Extension.Contents("Icon48.png"), Extension.Contents("Icon64.png") }
];
```

*Note: The `Icon16` actually takes four files (1x, 1.25x, 1.5x, 2x scaling) just for the 16px slot to handle high-DPI monitors. The same applies to `Icon32` taking the larger variants.*
