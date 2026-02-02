import 'package:flutter/material.dart';

/// Customization styles for the legacy [SelectPicker] list items.
class SelectPickerCardItemStyle {
  /// Creates a [SelectPickerCardItemStyle] with default values.
  SelectPickerCardItemStyle({
    this.dividerColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black87,
    this.dividerHeight = 1,
  });

  /// The color of the divider between items.
  Color? dividerColor;

  /// The height of the divider between items.
  double? dividerHeight;

  /// The background color of the list item card.
  Color? backgroundColor;

  /// The color of the text within the list item.
  Color? textColor;
}
