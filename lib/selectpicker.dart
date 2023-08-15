import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:selectpicker/models/bottomSheetStyle.dart';
import 'package:selectpicker/styles/inputSearchStyle.dart';
import 'package:selectpicker/styles/inputStyle.dart';
import 'package:selectpicker/models/select_picker_iten.dart';
import 'package:selectpicker/widgets/body/select_picker_input.dart';
import 'package:selectpicker/selectpicker_viewmodel.dart';

class SelectPicker extends StatelessWidget {
  const SelectPicker({
    super.key,
    required this.selectPickerInputStyle,
    required this.hint,
    required this.list,
    required this.selectFirst,
    required this.onSelect,
    this.selectPickerBottomSheetStyle,
    this.selectPickerInputSearchStyle,
    this.onSearch,
    this.onClose,
    this.inputError,
    this.hintSearch,
    this.showId,
    this.initialItem,
    this.disabled,
  });

  final String? inputError;
  final String? hintSearch;
  final String hint;
  final List<SelectPickerIten> list;
  final String? initialItem;
  final bool? showId;
  final bool selectFirst;
  final Function(SelectPickerIten) onSelect;
  final Future<List<SelectPickerIten>> Function(String? text)? onSearch;
  final Function()? onClose;
  final bool? disabled;
  final SelectPickerInputStyle selectPickerInputStyle;
  final SelectPickerBottomSheetStyle? selectPickerBottomSheetStyle;
  final SelectPickerInputSearchStyle? selectPickerInputSearchStyle;

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
          hintSearch: hintSearch,
          showId: showId,
          onSearch: onSearch,
          initialItem: initialItem,
          onClose: onClose,
          disabled: disabled,
          inputError: inputError,
          selectPickerInputStyle: selectPickerInputStyle,
          selectPickerBottomSheetStyle: selectPickerBottomSheetStyle ?? SelectPickerBottomSheetStyle(),
          selectPickerInputSearchStyle: selectPickerInputSearchStyle ?? SelectPickerInputSearchStyle()),
    );
  }
}
