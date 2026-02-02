import 'package:flutter/material.dart';

/// Customization styles for the legacy [SelectPicker] bottom sheet.
class SelectPickerBottomSheetStyle {
  /// Creates a [SelectPickerBottomSheetStyle] with default values.
  SelectPickerBottomSheetStyle({
    this.borderRadius = 15,
    this.height,
    this.closeIconColor = Colors.black87,
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.iconSize = 30,
    this.showSeparatorAboveTitle = false,
  });

  /// The color of the close icon.
  Color? closeIconColor;

  /// The background color of the bottom sheet.
  Color? backgroundColor;

  /// The size of the icons in the bottom sheet.
  double? iconSize;

  /// The height of the bottom sheet.
  double? height;

  /// The border radius of the top corners of the bottom sheet.
  double? borderRadius;

  /// Whether to show a separator line above the title.
  bool? showSeparatorAboveTitle;
}
