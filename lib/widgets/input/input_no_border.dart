import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selectpicker/styles/inputSearchStyle.dart';

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
    this.password = false,
    this.hint,
    this.formatter,
    this.focusedColor,
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
  final bool password;
  final String? hint;
  final List<TextInputFormatter>? formatter;
  final Color? focusedColor;
  final SelectPickerInputSearchStyle selectPickerInputSearchStyle;

  @override
  State<SelectPickerInputNoBorder> createState() => _SelectPickerInputNoBorderState();
}

class _SelectPickerInputNoBorderState extends State<SelectPickerInputNoBorder> {
  late bool passwordVisible;

  @override
  void initState() {
    passwordVisible = widget.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                inputFormatters: widget.formatter,
                obscureText: passwordVisible,
                focusNode: widget.focus,
                autofocus: false,
                onSubmitted: widget.onSubmit,
                style: TextStyle(
                  color: Colors.grey[800],
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

  InputDecoration decoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.fromLTRB(30, (widget.selectPickerInputSearchStyle.height ?? 0) / 2, 0,
          (widget.selectPickerInputSearchStyle.height ?? 0) / 2),
      suffixIcon: widget.password ? iconPassword() : null,
      labelStyle: TextStyle(color: widget.labelColor ?? Colors.grey),
      //labelText: widget.label,
      hintText: widget.hint,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintStyle: TextStyle(color: widget.labelColor ?? Colors.grey),
      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 5))),
      focusedErrorBorder: focusedErrorBorder(),
      errorBorder: errorBorder(),
      enabledBorder: enableBorder(),
      focusedBorder: widget.varErro != null ? errorBorder() : focusedBorder(),
      disabledBorder: disabledBorder(),
    );
  }

  IconButton iconPassword() {
    return IconButton(
      icon: Icon(
        // Based on passwordVisible state choose the icon
        passwordVisible ? Icons.visibility : Icons.visibility_off,
        color: Theme.of(context).primaryColorDark,
      ),
      onPressed: () {
        // Update the state i.e. toogle the state of passwordVisible variable
        setState(() {
          passwordVisible = !passwordVisible;
        });
      },
    );
  }

  OutlineInputBorder focusedBorder() {
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

  OutlineInputBorder disabledBorder() {
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

  OutlineInputBorder enableBorder() {
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

  OutlineInputBorder errorBorder() {
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

  OutlineInputBorder focusedErrorBorder() {
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
}
