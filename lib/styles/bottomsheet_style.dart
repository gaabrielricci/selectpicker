import 'package:flutter/material.dart';

class SelectPickerBottomSheetStyle {
  SelectPickerBottomSheetStyle({
    this.borderRadius = 15,
    this.height,
    this.closeIconColor = Colors.black87,
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.iconSize = 30,
    this.showSeparatorAboveTitle = false,
  });

  Color? closeIconColor;
  Color? backgroundColor;
  double? iconSize;
  double? height;
  double? borderRadius;
  bool? showSeparatorAboveTitle;
}
