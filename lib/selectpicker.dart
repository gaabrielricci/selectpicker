import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:selectpicker/styles/bottomsheet_style.dart';
import 'package:selectpicker/styles/card_item_style.dart';
import 'package:selectpicker/styles/inputsearch_style.dart';
import 'package:selectpicker/styles/input_style.dart';
import 'package:selectpicker/models/select_picker_item.dart';
import 'package:selectpicker/widgets/body/select_picker_input.dart';
import 'package:selectpicker/selectpicker_viewmodel.dart';

class SelectPicker extends StatelessWidget {
  const SelectPicker({
    super.key,
    required this.hint,
    required this.list,
    required this.selectFirst,
    required this.onSelect,
    this.selectPickerInputStyle,
    this.selectPickerBottomSheetStyle,
    this.selectPickerInputSearchStyle,
    this.selectPickerCardItemStyle,
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
  final List<SelectPickerItem> list;
  final String? initialItem;
  final bool? showId;
  final bool selectFirst;
  final Function(SelectPickerItem) onSelect;
  final Future<List<SelectPickerItem>> Function(String? text)? onSearch;
  final Function()? onClose;
  final bool? disabled;
  final SelectPickerInputStyle? selectPickerInputStyle;
  final SelectPickerBottomSheetStyle? selectPickerBottomSheetStyle;
  final SelectPickerInputSearchStyle? selectPickerInputSearchStyle;
  final SelectPickerCardItemStyle? selectPickerCardItemStyle;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SelectPickerViewModel()),
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
          selectPickerInputStyle: selectPickerInputStyle ?? SelectPickerInputStyle(),
          selectPickerBottomSheetStyle: selectPickerBottomSheetStyle ?? SelectPickerBottomSheetStyle(),
          selectPickerInputSearchStyle: selectPickerInputSearchStyle ?? SelectPickerInputSearchStyle(),
          selectPickerCardItemStyle: selectPickerCardItemStyle ?? SelectPickerCardItemStyle()),
    );
  }
}
