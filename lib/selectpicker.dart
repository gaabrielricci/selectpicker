/// A modern and legacy Select Picker library for Flutter.
library selectpicker;

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:selectpicker/styles/bottomsheet_style.dart';
import 'package:selectpicker/styles/card_item_style.dart';
import 'package:selectpicker/styles/inputsearch_style.dart';
import 'package:selectpicker/styles/input_style.dart';
import 'package:selectpicker/models/select_picker_item.dart';
import 'package:selectpicker/styles/top_selector_style.dart';
import 'package:selectpicker/widgets/body/select_picker_input.dart';
import 'package:selectpicker/selectpicker_viewmodel.dart';

export 'select_picker_new.dart';
export 'models/select_picker_item.dart';
export 'styles/bottomsheet_style.dart';
export 'styles/card_item_style.dart';
export 'styles/input_style.dart';
export 'styles/inputsearch_style.dart';
export 'styles/top_selector_style.dart';

/// A legacy Select Picker widget.
///
/// [SelectPicker] is now deprecated in favor of [SelectPickerNew], which offers
/// a generic interface, better UI, and built-in search capabilities.
@Deprecated('Use SelectPickerNew instead for a more flexible and modern interface.')
class SelectPicker extends StatelessWidget {
  /// Creates a [SelectPicker] instance.
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
    this.selectPickerTopSelectorStyle,
    this.onSearch,
    this.onClose,
    this.inputError,
    this.hintSearch,
    this.showId,
    this.initialItem,
    this.disabled,
    this.isLoading,
    this.loadingMessage,
  });

  /// The error message to display below the input field.
  final String? inputError;

  /// The hint text for the search input in the bottom sheet.
  final String? hintSearch;

  /// The primary hint text shown on the selector.
  final String hint;

  /// The list of items available for selection.
  final List<SelectPickerItem> list;

  /// The initially selected item ID.
  final String? initialItem;

  /// Whether to display the item ID in the list.
  final bool? showId;

  /// Whether to automatically select the first item.
  final bool selectFirst;

  /// Callback executed when an item is selected.
  final Function(SelectPickerItem) onSelect;

  /// Custom search function for asynchronous data loading.
  final Future<List<SelectPickerItem>> Function(String? text)? onSearch;

  /// Callback executed when the picker sheet is closed.
  final Function()? onClose;

  /// Whether the picker is interactive.
  final bool? disabled;

  /// Customization style for the input field.
  final SelectPickerInputStyle? selectPickerInputStyle;

  /// Customization style for the bottom sheet.
  final SelectPickerBottomSheetStyle? selectPickerBottomSheetStyle;

  /// Customization style for the search input field.
  final SelectPickerInputSearchStyle? selectPickerInputSearchStyle;

  /// Customization style for each item in the list.
  final SelectPickerCardItemStyle? selectPickerCardItemStyle;

  /// Customization style for the top header of the bottom sheet.
  final SelectPickerTopSelectorStyle? selectPickerTopSelectorStyle;

  /// Whether the widget is currently in a loading state.
  final bool? isLoading;

  /// The message to display while loading.
  final String? loadingMessage;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SelectPickerViewModel()),
      ],
      child: SelectPickerInput(
        initialItem: initialItem,
        loadingMessage: loadingMessage,
        isLoading: isLoading,
        hint: hint,
        selectFirst: selectFirst,
        onSelect: onSelect,
        list: list,
        hintSearch: hintSearch,
        showId: showId,
        onSearch: onSearch,
        onClose: onClose,
        disabled: disabled,
        inputError: inputError,
        selectPickerInputStyle: selectPickerInputStyle ?? SelectPickerInputStyle(),
        selectPickerBottomSheetStyle: selectPickerBottomSheetStyle ?? SelectPickerBottomSheetStyle(),
        selectPickerInputSearchStyle: selectPickerInputSearchStyle ?? SelectPickerInputSearchStyle(),
        selectPickerCardItemStyle: selectPickerCardItemStyle ?? SelectPickerCardItemStyle(),
        selectPickertopSelectorStyle: selectPickerTopSelectorStyle ?? SelectPickerTopSelectorStyle(),
      ),
    );
  }
}
