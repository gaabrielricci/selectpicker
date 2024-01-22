import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selectpicker/styles/inputsearch_style.dart';

class SelectPickerInputNoBorder extends StatefulWidget {
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

  final String? varErro;
  final Function(String)? onChangeText;
  final Function(String)? onSubmit;
  final TextEditingController controller;
  final String? label;
  final Color? labelColor;
  final double? radius;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;
  final FocusNode? focus;
  final String? hint;
  final List<TextInputFormatter>? formatter;
  final Color? focusedColor;
  final Color? backgroundColor;
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

  //define default decoration of input
  InputDecoration decoration() {
    return InputDecoration(
      filled: true,
      fillColor: widget.backgroundColor ?? Colors.white,
      contentPadding: EdgeInsets.fromLTRB(30, (widget.selectPickerInputSearchStyle.height ?? 0) / 2, 0,
          (widget.selectPickerInputSearchStyle.height ?? 0) / 2),
      labelStyle: TextStyle(color: widget.labelColor ?? Colors.grey),
      //labelText: widget.label,
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


  //define style of hint
  TextStyle _hintStyle() {
    try {
      return TextStyle(
          color: widget.labelColor != null ? _createMaterialColor(widget.labelColor!)[100] : Colors.grey[100]);
    } catch (er) {
      return TextStyle(color: Colors.grey);
    }
  }

//default border style
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

  //border style of disabled input
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

  //focused border style
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

  //error border style
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
//focused border style
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

  //create a material color to define hint faded of label color
  MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
