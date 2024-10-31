import 'package:flutter/material.dart';

class SelectPickerCardItemStyle {
  SelectPickerCardItemStyle({
    this.dividerColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black87,
    this.dividerHeight = 1,
  });

  Color? dividerColor;
  double? dividerHeight;
  Color? backgroundColor;
  Color? textColor;
}
