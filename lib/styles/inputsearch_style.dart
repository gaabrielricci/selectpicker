import 'package:flutter/material.dart';

/// Customization styles for the legacy [SelectPicker] search input field.
class SelectPickerInputSearchStyle {
  /// Creates a [SelectPickerInputSearchStyle] with default values.
  SelectPickerInputSearchStyle({
    this.borderColor = Colors.white,
    this.backgroundColor = const Color(0xFFf2f2f2),
    this.textColor = const Color(0xFF303030),
    this.height = 0,
    this.borderRadius = 50,
    this.borderSize = 0,
  });

  /// The background color of the search input.
  Color? backgroundColor;

  /// The color of the border of the search input.
  Color? borderColor;

  /// The color of the text in the search input.
  Color? textColor;

  /// The height of the search input field.
  double? height;

  /// The width of the border of the search input.
  double? borderSize;

  /// The border radius of the search input field.
  double? borderRadius;
}
