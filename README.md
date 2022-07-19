
# Multi Select Flutter

[![Pub Version](https://img.shields.io/badge/pub-v0.0.2-blue)](https://pub.dev/packages/flutter_custom_selector)

FLutter Custom Selector is a package for creating single-select as well ass multi-select widgets with an awesome and unique user interface.

| <img src="https://djku7spo6dfd0.cloudfront.net/public/messageImages/image_1658199970YpK03nPdty6.gif" width="250"/><br /><sub><b>Single Selection</b></sub> | <img src="https://djku7spo6dfd0.cloudfront.net/public/messageImages/image_1658200005uuJ8hq27IvK.gif" width="250"/><br /><sub><b>Multi Selection</b></sub>
| :---: | :---: |

## Features
- Supports FormField features like validator.
- Awesome default design.
- BottomSheet widget.
- Make your multi selection awesome.
- All selection field is enabled in multi selection field.

## Usage

### CustomSingleSelectField
<img src="https://djku7spo6dfd0.cloudfront.net/public/messageImages/image_1658199970YpK03nPdty6.gif" />

This widget provide an GestureDetector which open the bottom sheet and are equipped with FormField features. You can customize it using the provided parameters.

To store the selected values, you can use the `onSelectionDone` parameter.


```dart
CustomSingleSelectField<String>(
  items: dataString,
  title: "Country",
  onSelectionDone: (value){
    selectedString = value;
    setState(() {});
  },
  itemAsString: (item)=>item,
),
```

### CustomMultiSelectField
<img src="https://djku7spo6dfd0.cloudfront.net/public/messageImages/image_1658200005uuJ8hq27IvK.gif"/>

This widget provide an GestureDetector which open the bottom sheet and are equipped with FormField features. You can customize it using the provided parameters.

To store the selected values, you can use the `onSelectionDone` parameter.

```dart
CustomMultiSelectField<String>(
  title: "Country",
  items: dataString, 
  enableAllOptionSelect: true,
  onSelectionDone: _onCountriesSelectionComplete,
  itemAsString: (item) => item.toString(),
),
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.