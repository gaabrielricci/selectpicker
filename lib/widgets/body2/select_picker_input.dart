import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selectpicker/styles/input_style.dart';
import 'package:selectpicker/widgets/select_picker_provider.dart';

class SelectPickerInputBody extends StatelessWidget {
  const SelectPickerInputBody({
    super.key,
    required this.inputStyle,
    this.hint,
    required this.disabled,
    required this.isLoading,
  });

  final SelectPickerInputStyle inputStyle;
  final String? hint;
  final bool disabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(inputStyle.borderRadius ?? 0.0),
      elevation: inputStyle.elevation ?? 0,
      child: Ink(
        height: inputStyle.height,
        decoration: BoxDecoration(
          color: disabled ? inputStyle.backgoundDisabledColor : inputStyle.backgroundColor,
          borderRadius: BorderRadius.circular(
            inputStyle.borderRadius ?? 0.0,
          ),
          border: Border.all(
            color: inputStyle.borderColor ?? Theme.of(context).colorScheme.primary,
            width: inputStyle.borderSize ?? 2,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(inputStyle.borderRadius ?? 0.0),
          onTap: disabled || isLoading
              ? null
              : () {
                  //showOptions();
                },
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    context.watch<SelectPickerProvider>().selectedItem?.title ?? hint ?? "",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: inputStyle.spaceBarSize ?? 2,
                    color: inputStyle.iconColor ?? Colors.black87,
                    child: const Text(""),
                  ),
                ),
              ),
              isLoading
                  ? SizedBox(
                      width: 35,
                      height: 35,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: inputStyle.iconColor ?? Colors.black87,
                        ),
                      ),
                    )
                  : Icon(
                      Icons.arrow_drop_down_sharp,
                      size: inputStyle.iconSize ?? 35,
                      color: inputStyle.iconColor ?? Colors.black87,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
