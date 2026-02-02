import 'package:flutter/material.dart';

/// Customization styles for the legacy [SelectPicker] top header area.
class SelectPickerTopSelectorStyle {
  /// Creates a [SelectPickerTopSelectorStyle] with default values.
  SelectPickerTopSelectorStyle({
    this.backgroundColor = const Color(0xFFeeeef7),
    this.closeIconColor = const Color(0xFFE40101),
    this.textStyle = const TextStyle(
      fontSize: 18,
      height: 1,
      color: const Color(0xFF303030),
    ),
    this.height = 45,
    this.borderRadius = 15,
    this.iconTitle,
  });

  /// The background color of the top header.
  Color? backgroundColor;

  /// The color of the close icon in the header.
  Color? closeIconColor;

  /// The height of the top header area.
  double? height;

  /// The border radius of the top header corners.
  double? borderRadius;

  /// The size of the close icon.
  double? closeIconSize;

  /// Whether to show the close button in the header.
  bool? showCloseButton = true;

  /// An optional icon to display next to the header title.
  Icon? iconTitle;

  /// The text style for the header title.
  TextStyle? textStyle;
}
