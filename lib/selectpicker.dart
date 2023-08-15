import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:selectpicker/models/select_picker_iten.dart';
import 'package:selectpicker/widgets/body/select_picker_input.dart';
import 'package:selectpicker/selectpicker_viewmodel.dart';

class SelectPicker extends StatelessWidget {
  const SelectPicker({
    super.key,
    this.radius,
    this.backgroundColor,
    required this.hint,
    required this.list,
    this.hintSearch,
    this.showId,
    required this.selectFirst,
    required this.onSelect,
    this.initialItem,
    this.initialText,
    this.inputError,
    this.onSearch,
    this.onClose,
    this.disabled,
    this.height,
    required this.heightInput,
    this.radiusPicker
  });

  final double? radius;
  final double? radiusPicker;
  final double? height;
  final double heightInput;
  final Color? backgroundColor;
  final String? hintSearch;
  final String hint;
  final List<SelectPickerIten> list;
  final String? initialItem;
  final bool? showId;
  final bool selectFirst;
  final Function(SelectPickerIten) onSelect;
  final Future<List<SelectPickerIten>> Function(String? text)? onSearch;
  final Function()? onClose;
  final String? initialText;
  final String? inputError;
  final bool? disabled;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: SelectPickerViewModel(),
        ),
      ],
      child: SelectPickerInput(
        hint: hint,
        selectFirst: selectFirst,
        onSelect: onSelect,
        list: list,
        maxHeight: height,
        heightInput: heightInput,
        hintSearch: hintSearch,
        showId: showId,
        onSearch: onSearch,
        initialItem: initialItem,
        radius: radius,
        radiusPicker: radiusPicker,
        onClose: onClose,
        inputError: inputError,
        initialText: initialText,
        backgroundColor: backgroundColor,
        disabled: disabled,
      ),
    );
  }
}
