import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selectpicker/styles/inputsearch_style.dart';

/// A text field widget with no border used for search within the legacy [SelectPicker].
class SelectPickerInputNoBorder extends StatefulWidget {
  /// Creates a [SelectPickerInputNoBorder].
  const SelectPickerInputNoBorder({
    Key? key,
    required this.controller,
    required this.varErro,
    required this.selectPickerInputSearchStyle,
    this.onChangeText,
    required this.label,
    this.labelColor,
    this.onSubmit,
    this.radius,
    this.textInputType,
    this.textCapitalization,
    this.focus,
    this.hint,
    this.formatter,
    this.focusedColor,
    this.backgroundColor,
  }) : super(key: key);

  /// An error message to display.
  final String? varErro;

  /// Callback when text changes.
  final Function(String)? onChangeText;

  /// Callback when submitted.
  final Function(String)? onSubmit;

  /// The text controller.
  final TextEditingController controller;

  /// The label text.
  final String? label;

  /// The color of the label.
  final Color? labelColor;

  /// The border radius.
  final double? radius;

  /// The keyboard type.
  final TextInputType? textInputType;

  /// The text capitalization style.
  final TextCapitalization? textCapitalization;

  /// The focus node.
  final FocusNode? focus;

  /// The hint text.
  final String? hint;

  /// List of input formatters.
  final List<TextInputFormatter>? formatter;

  /// The color when focused.
  final Color? focusedColor;

  /// The background color.
  final Color? backgroundColor;

  /// Style configuration for the search input.
  final SelectPickerInputSearchStyle selectPickerInputSearchStyle;

  @override
  State<SelectPickerInputNoBorder> createState() => _SelectPickerInputNoBorderState();
}

class _SelectPickerInputNoBorderState extends State<SelectPickerInputNoBorder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                inputFormatters: widget.formatter,
                focusNode: widget.focus,
                autofocus: false,
                onSubmitted: widget.onSubmit,
                style: TextStyle(
                  color: widget.labelColor ?? Colors.grey[800],
                ),
                onChanged: widget.onChangeText,
                controller: widget.controller,
                keyboardType: widget.textInputType ?? TextInputType.name,
                textCapitalization: widget.textCapitalization ?? TextCapitalization.sentences,
                decoration: decoration(),
              ),
            ),
          ],
        ),
        widget.varErro != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.varErro ?? "",
                  style: TextStyle(color: Colors.red[600] ?? Colors.red),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  /// Defines the decoration of the input field.
  InputDecoration decoration() {
    return InputDecoration(
      filled: true,
      fillColor: widget.backgroundColor ?? Colors.white,
      contentPadding: EdgeInsets.fromLTRB(30, (widget.selectPickerInputSearchStyle.height ?? 0) / 2, 0,
          (widget.selectPickerInputSearchStyle.height ?? 0) / 2),
      labelStyle: TextStyle(color: widget.labelColor ?? Colors.grey),
      hintText: widget.hint,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintStyle: _hintStyle(),
      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 5))),
      focusedErrorBorder: _focusedErrorBorder(),
      errorBorder: _errorBorder(),
      enabledBorder: _enableBorder(),
      focusedBorder: widget.varErro != null ? _errorBorder() : _focusedBorder(),
      disabledBorder: _disabledBorder(),
    );
  }

  TextStyle _hintStyle() {
    try {
      return TextStyle(
          color: widget.labelColor != null ? _createMaterialColor(widget.labelColor!)[100] : Colors.grey[100]);
    } catch (er) {
      return TextStyle(color: Colors.grey);
    }
  }

  OutlineInputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
          color: widget.selectPickerInputSearchStyle.borderColor ?? Colors.white,
          width: widget.selectPickerInputSearchStyle.borderSize ?? 0),
      borderRadius: BorderRadius.all(
        Radius.circular(
          widget.radius ?? 5,
        ),
      ),
    );
  }

  OutlineInputBorder _disabledBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
          color: widget.selectPickerInputSearchStyle.borderColor ?? Colors.white,
          width: widget.selectPickerInputSearchStyle.borderSize ?? 0),
      borderRadius: BorderRadius.all(
        Radius.circular(
          widget.radius ?? 5,
        ),
      ),
    );
  }

  OutlineInputBorder _enableBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
          color: widget.selectPickerInputSearchStyle.borderColor ?? Colors.white,
          width: widget.selectPickerInputSearchStyle.borderSize ?? 0),
      borderRadius: BorderRadius.all(
        Radius.circular(
          widget.radius ?? 5,
        ),
      ),
    );
  }

  OutlineInputBorder _errorBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide(
            color: widget.selectPickerInputSearchStyle.borderColor ?? Colors.white,
            width: widget.selectPickerInputSearchStyle.borderSize ?? 0),
        borderRadius: BorderRadius.all(
          Radius.circular(
            widget.radius ?? 5,
          ),
        ));
  }

  OutlineInputBorder _focusedErrorBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
          color: widget.selectPickerInputSearchStyle.borderColor ?? Colors.white,
          width: widget.selectPickerInputSearchStyle.borderSize ?? 0),
      borderRadius: BorderRadius.all(
        Radius.circular(
          widget.radius ?? 5,
        ),
      ),
    );
  }

  MaterialColor _createMaterialColor(Color color) {
    final List<double> strengths = <double>[.05];
    final Map<int, Color> swatch = {};
    final int r = (color.r * 255.0).round().clamp(0, 255);
    final int g = (color.g * 255.0).round().clamp(0, 255);
    final int b = (color.b * 255.0).round().clamp(0, 255);

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (double strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.toARGB32(), swatch);
  }
}
