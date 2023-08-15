import 'package:flutter/material.dart';

class SelectPickerBottomSheetStyle {
  SelectPickerBottomSheetStyle({
    this.borderRadius = 25,
    this.height,
    this.closeIconColor = Colors.black87,
    this.iconSize = 30,
  });

  Color? closeIconColor;
  double? iconSize;
  double? height;
  double? borderRadius;
}
