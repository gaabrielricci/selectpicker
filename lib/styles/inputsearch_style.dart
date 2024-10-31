import 'package:flutter/material.dart';

class SelectPickerInputSearchStyle {
  SelectPickerInputSearchStyle({
    this.borderColor = Colors.white,
    this.backgroundColor = const Color(0xFFf2f2f2),
    this.textColor = const Color(0xFF303030),
    this.height = 0,
    this.borderRadius = 50,
    this.borderSize = 0,
  });

  Color? backgroundColor;
  Color? borderColor;
  Color? textColor;
  double? height;
  double? borderSize;
  double? borderRadius;
}
