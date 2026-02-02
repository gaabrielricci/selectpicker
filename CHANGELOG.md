## 2.0.3

* **README Update**: Modernized documentation with new API examples and features.

## 2.0.2

* **Documentation**: Acheived 100% public API documentation coverage.
* **Example**: Moved example to the official directory structure and added a dedicated pubspec.
* **Static Analysis**: Fixed all linting issues, missing type annotations, and deprecated member usages.
* **Metadata**: Improved package description.

## 2.0.1

* **Validation Support**: Added `errorText` property to `SelectPickerNew` to display validation error messages below the input field.

## 2.0.0

* **New Widget**: Introduced `SelectPickerNew<T>`, a generic, modern, and more flexible selector;
* **Generics Support**: Now supports any data type `T` with `titleBuilder` and `itemBuilder`;
* **Modern UI/UX**: Improved input field aesthetics, rounded bottom sheet with drag handle, and optimized InkWell ripple effects;
* **Built-in Search**: Enhanced local filtering and support for asynchronous remote search (`onSearch`);
* **Deprecation Notice**: Marked the legacy `SelectPicker` as deprecated in favor of the new generic implementation;
* **Documentation**: Added comprehensive documentation comments to all public APIs for better pub.dev score and developer experience;
* **Example**: Added a high-quality example demonstrating the new features.

## 1.1.6

* Parameterized dropdown icon;

## 1.1.5

* Fix hintStyle;

## 1.1.4

* Default padding adjusted for input;

## 1.1.3

* Included some properties on slectPickerInputStyle: TextStyle? hintStyle, TextStyle? textStyle,
  EdgeInsets? internalPadding, bool? showDropIndicator = true;

## 1.1.2

* Fix CircularProgressIndicator on isloading

## 1.1.1

* SelectPickerBottomSheetStyle backgroundColor default white

* SelectPickerInputSearchStyle default color const Color(0xFFf2f2f2),

## 1.1.0

* SelectPickerBottomSheetStyle added property showSeparatorAboveTitle

* SelectPickerCardItemStyle changed dividerColor to grey

* Created TopSelectorStyle for style of bottomsheet top.

* Recreated the top of bottomsheet

## 1.0.20

* Added fontSize on SelectPickerInputStyle;
* Fix icon size on input.

## 1.0.19

* Fix update initial item.

## 1.0.18

* isChecked var in SelectPickerItem Model.

## 1.0.17

* Loading message.

## 1.0.16

* Elevation on input.

## 1.0.15

* Selector is no longer taking up the entire screen when there is little data.

## 1.0.14

* It is possible to inform whether the selectPicker data is being loaded by the isLoading property.
  If loading, the selector cannot be opened.
* Selector is no longer taking up the entire screen when there is little data.
* Improved selector click.

## 1.0.13

* Improved search field style;
* Visual improvement implemented in the item selection shadow;
* Improved display of the selector title;
* Removed unused code;

## 1.0.12

* Changed default color of bottomsheet background to Color(0xFAFAFAFF)

## 1.0.11

* Adjusted hintColor property to inputStyle

## 1.0.10

* Added hintColor property to inputStyle default grey

## 1.0.9

* Added textColor property to inputStyle default black87
* Added backgroundColor property to BottomSheetStyle default white70
* Created CustomStyle for itens on list

## 1.0.8

* Function onSearch, you can pass a function that will be executed in the onChangeText of the
  inputSearch of the selectpicker. This function must receive a nullable string and return a Future<
  List<SelectPickerItem>>

## 1.0.7

* Important correction on didUpdateWidget updating current selection.

## 1.0.6

* Important correction on selectPickerViewModel Provider.

## 1.0.5

* Adjusted examples.

## 1.0.4

* spelling corrected.

## 1.0.3

* Created styles to customize selectpicker.
* Changed import package.
* Corrections on parameters showId and selectFirst and initialItem.

## 1.0.2

* Add example.dart link.
* Changed import package.

## 1.0.1

* Adjusted examples.

## 1.0.0

* Created the selector with bottom sheet. 
