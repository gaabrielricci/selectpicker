import 'package:flutter/material.dart';

class SelectPickerInputStyle {
  SelectPickerInputStyle({
    this.borderColor = Colors.black87,
    this.backgroundColor = Colors.white,
    this.height = 50,
    this.borderRadius = 50,
    this.errorColor = const Color(0xFFD32F2F),
    this.spaceBarSize = 1.6,
    this.iconColor = Colors.black87,
    this.borderSize = 1,
    this.backgoundDisabledColor = const Color(0xFFD6D6D6),
    this.iconColorDisabled = Colors.black87,
    this.iconSize = 40,
  });

  Color? borderColor;
  Color? backgroundColor;
  Color? backgoundDisabledColor;
  Color? iconColorDisabled;
  Color? iconColor;
  Color? errorColor;
  double? spaceBarSize;
  double? iconSize;
  double? height;
  double? borderSize;
  double? borderRadius;
}
