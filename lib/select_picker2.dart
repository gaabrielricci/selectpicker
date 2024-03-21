import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selectpicker/models/select_picker_item.dart';
import 'package:selectpicker/styles/input_style.dart';
import 'package:selectpicker/widgets/body2/select_picker_input.dart';
import 'package:selectpicker/widgets/select_picker_provider.dart';

class SelectPicker2 extends StatelessWidget {
  const SelectPicker2({
    super.key,
    required this.items,
    this.inputStyle,
    required this.onSelect,
    this.selectedId,
    this.isLoading,
    this.isDisabled,
    this.hint,
  });

  final SelectPickerInputStyle? inputStyle;
  final String? selectedId;
  final Function(SelectPickerItem) onSelect;
  final bool? isLoading;
  final bool? isDisabled;
  final String? hint;
  final List<SelectPickerItem> items;

  @override
  Widget build(BuildContext ctx) {
    return ChangeNotifierProvider.value(
      value: SelectPickerProvider(
        items: items,
        onSelect: onSelect,
        selectedId: selectedId,
      ),
      builder: (context, child) => SelectPickerInputBody(
        inputStyle: inputStyle ?? SelectPickerInputStyle(),
        disabled: isDisabled == true,
        isLoading: isLoading == true,
        hint: hint,
      ),
    );
  }
}
