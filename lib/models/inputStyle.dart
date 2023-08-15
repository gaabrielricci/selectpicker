import 'package:flutter/material.dart';

class SelectPickerInputStyle {
  SelectPickerInputStyle({
    this.borderColor,
    this.backgroundColor,
    this.height,
    this.borderRadius,
    this.errorColor,
    this.spaceBarSize,
    this.iconColor,
    this.borderSize,
    this.backgoundDisabledColor,
    this.iconColorDisabled,
    this.iconSize,
  });

  Color? borderColor = Colors.black87;
  Color? backgroundColor = Colors.white;
  Color? backgoundDisabledColor = Colors.grey[300] ?? Colors.grey;
  Color? iconColorDisabled = Colors.black87;
  Color? iconColor = Colors.black87;
  Color? errorColor = Colors.red[700] ?? Colors.red;
  double? spaceBarSize = 1.6;
  double? iconSize = 40;
  double? height = 45;
  double? borderSize = 1;
  double? borderRadius = 5;
}
