# Select Picker

A modern, generic, and highly customizable Select Picker for Flutter. Supports generic types, custom builders, asynchronous search, and validation with a premium look and feel.

## Features

- **Generic Support**: Works with any data type `T`.
- **Modern UI**: Rounded bottom sheets, drag handles, and smooth animations.
- **Asynchronous Search**: Support for remote data searching with debouncing.
- **Custom Builders**: Fully customize how items look in the list.
- **Validation**: Built-in support for `errorText`.
- **Backward Compatibility**: Maintains support for legacy `SelectPicker`.

## Images

<div style="display: flex;">
<img src="https://riccimobile.com.br/github/flutter/selectpicker/1.png" alt="Start" style="flex: 1; padding: 10px;" width="324" height="720">
<img src="https://riccimobile.com.br/github/flutter/selectpicker/2.png" alt="All" style="flex: 1; padding: 10px;" width="324" height="720">
<img src="https://riccimobile.com.br/github/flutter/selectpicker/3.png" alt="Filter" style="flex: 1; padding: 10px;" width="324" height="720">
<img src="https://riccimobile.com.br/github/flutter/selectpicker/4.png" alt="Select" style="flex: 1; padding: 10px;" width="324" height="720">
</div>

## Getting started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  selectpicker: ^2.0.2
```

Import the package:

```dart
import 'package:selectpicker/selectpicker.dart';
```

## Basic Usage (Modern API)

The new `SelectPickerNew` is the recommended way to use the library.

```dart
SelectPickerNew<String>(
  items: ['Apple', 'Banana', 'Cherry'],
  hint: "Select a fruit",
  onChanged: (value) {
    print("Selected: $value");
  },
)
```

## Advanced Usage (Generic Objects)

You can use complex objects by providing a `titleBuilder`.

```dart
SelectPickerNew<User>(
  items: userList,
  hint: "Select a user",
  titleBuilder: (user) => user.name,
  onChanged: (user) {
    setState(() => _selectedUser = user);
  },
  decoration: InputDecoration(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    prefixIcon: Icon(Icons.person),
  ),
  errorText: _hasError ? "Field is required" : null,
)
```

## Asynchronous Search

```dart
SelectPickerNew<City>(
  onSearch: (query) async {
    return await api.fetchCities(query);
  },
  hint: "Search for a city",
  titleBuilder: (city) => city.name,
  onChanged: (city) => print(city?.name),
)
```

## Example

Check out the full example in the [example directory](https://github.com/gaabrielricci/selectpicker/blob/main/example/lib/main.dart).

## Legacy Usage

For those still using the previous version, `SelectPicker` remains available for backward compatibility but is marked as deprecated.

```dart
SelectPicker(
  hint: "Select an item",
  list: [
    SelectPickerItem("Item 1", "1", null),
    SelectPickerItem("Item 2", "2", null),
  ],
  selectFirst: true,
  onSelect: (value) => print(value.title),
)
```

## Credits

- Created by [Ricci Mobile](https://riccimobile.com.br)
