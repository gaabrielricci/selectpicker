import 'package:flutter/material.dart';

class SelectPickerTopSelectorStyle {
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

  Color? backgroundColor;
  Color? closeIconColor;
  double? height;
  double? borderRadius;
  double? closeIconSize;
  bool? showCloseButton = true;
  Icon? iconTitle;
  TextStyle? textStyle;
}
