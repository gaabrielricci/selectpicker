import 'package:flutter/material.dart';

/// Customization styles for the legacy [SelectPicker] input field.
class SelectPickerInputStyle {
  /// Creates a [SelectPickerInputStyle] with default values.
  SelectPickerInputStyle({
    this.borderColor = Colors.black87,
    this.backgroundColor = Colors.white,
    this.height = 55,
    this.borderRadius = 50,
    this.errorColor = const Color(0xFFD32F2F),
    this.spaceBarSize = 1.6,
    this.iconColor = Colors.black87,
    this.borderSize = 1,
    this.backgoundDisabledColor = const Color(0xFFD6D6D6),
    this.iconColorDisabled = Colors.black87,
    this.iconSize,
    this.elevation = 0,
    this.hintStyle,
    this.textStyle,
    this.internalPadding,
    this.showDropIndicator,
    this.iconDropDwon,
  });

  /// The color of the border.
  Color? borderColor;

  /// The background color of the input.
  Color? backgroundColor;

  /// The background color when the input is disabled.
  Color? backgoundDisabledColor;

  /// The icon color when the input is disabled.
  Color? iconColorDisabled;

  /// The color of the trailing icon.
  Color? iconColor;

  /// The icon to display for the dropdown.
  IconData? iconDropDwon;

  /// The color of the error message text.
  Color? errorColor;

  /// The size of the space bar separator.
  double? spaceBarSize;

  /// The size of the trailing icon.
  double? iconSize;

  /// The height of the input field.
  double? height;

  /// The width of the border.
  double? borderSize;

  /// The border radius of the input field.
  double? borderRadius;

  /// The elevation of the input card.
  double? elevation;

  /// The style for the hint text.
  TextStyle? hintStyle;

  /// The style for the selected item text.
  TextStyle? textStyle;

  /// The internal padding of the input field.
  EdgeInsets? internalPadding;

  /// Whether to show the dropdown arrow/indicator.
  bool? showDropIndicator = true;
}
