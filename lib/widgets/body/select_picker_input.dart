import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selectpicker/models/select_picker_item.dart';
import 'package:selectpicker/selectpicker_viewmodel.dart';
import 'package:selectpicker/styles/bottomsheet_style.dart';
import 'package:selectpicker/styles/card_item_style.dart';
import 'package:selectpicker/styles/input_style.dart';
import 'package:selectpicker/styles/inputsearch_style.dart';
import 'package:selectpicker/styles/top_selector_style.dart';
import 'package:selectpicker/widgets/body/select_picker_body.dart';

/// The input field widget for the legacy [SelectPicker].
///
/// This widget renders the button-like input that opens the selection bottom sheet.
class SelectPickerInput extends StatefulWidget {
  /// Creates a [SelectPickerInput].
  const SelectPickerInput({
    super.key,
    required this.list,
    required this.selectPickerInputStyle,
    required this.selectFirst,
    required this.onSelect,
    required this.hint,
    required this.selectPickerBottomSheetStyle,
    required this.selectPickerInputSearchStyle,
    required this.selectPickerCardItemStyle,
    required this.selectPickertopSelectorStyle,
    this.hintSearch,
    this.showId,
    this.onSearch,
    this.onClose,
    this.disabled,
    this.inputError,
    this.isLoading,
    this.loadingMessage,
    this.initialItem,
  });

  /// An error message to display below the input.
  final String? inputError;

  /// The search input placeholder.
  final String? hintSearch;

  /// The hint text shown when nothing is selected.
  final String hint;

  /// Whether to show the item ID.
  final bool? showId;

  /// Whether to automatically select the first item.
  final bool selectFirst;

  /// Callback when an item is selected.
  final Function(SelectPickerItem) onSelect;

  /// Custom search function for asynchronous filtering.
  final Future<List<SelectPickerItem>> Function(String? text)? onSearch;

  /// Callback executed when the picker sheet is closed.
  final Function()? onClose;

  /// Whether the input is interactive.
  final bool? disabled;

  /// The list of items to display.
  final List<SelectPickerItem> list;

  /// Style configuration for the input field.
  final SelectPickerInputStyle selectPickerInputStyle;

  /// Style configuration for the bottom sheet.
  final SelectPickerBottomSheetStyle selectPickerBottomSheetStyle;

  /// Style configuration for the internal search input.
  final SelectPickerInputSearchStyle selectPickerInputSearchStyle;

  /// Style configuration for each item card.
  final SelectPickerCardItemStyle selectPickerCardItemStyle;

  /// Style configuration for the top header area.
  final SelectPickerTopSelectorStyle selectPickertopSelectorStyle;

  /// Whether the widget is in a loading state.
  final bool? isLoading;

  /// Message to display while loading.
  final String? loadingMessage;

  /// The initially selected item ID.
  final String? initialItem;

  @override
  State<SelectPickerInput> createState() => _SelectPickerInputState();
}

class _SelectPickerInputState extends State<SelectPickerInput> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = BottomSheet.createAnimationController(this);
    _init();
    super.initState();
  }

  _init() {
    if (widget.list.isNotEmpty) {
      context.read<SelectPickerViewModel>().selectFirst = widget.selectFirst;
      context.read<SelectPickerViewModel>().showId = widget.showId == true;
      context.read<SelectPickerViewModel>().originalListDoNotNotify = widget.list;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.selectFirst) {
          widget.onSelect(context.read<SelectPickerViewModel>().originalList[0]);
        }
        context.read<SelectPickerViewModel>().selectInitial(initialItem: widget.initialItem);
      });
    }
  }

  @override
  void didUpdateWidget(covariant SelectPickerInput oldWidget) {
    if (widget.list != context.read<SelectPickerViewModel>().originalList || widget.initialItem != oldWidget.initialItem) {
      _init();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: widget.selectPickerInputStyle.height,
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: widget.selectPickerInputStyle.elevation,
                  color: widget.disabled == true
                      ? widget.selectPickerInputStyle.backgoundDisabledColor
                      : widget.selectPickerInputStyle.backgroundColor ?? Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.selectPickerInputStyle.borderRadius ?? 0.0),
                    ),
                    side: BorderSide(
                        width: widget.selectPickerInputStyle.borderSize ?? 0,
                        color: widget.selectPickerInputStyle.borderColor ?? Colors.black87),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(widget.selectPickerInputStyle.borderRadius ?? 0.0),
                    onTap: widget.disabled == true || widget.isLoading == true
                        ? null
                        : () {
                            showOptions();
                          },
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: widget.selectPickerInputStyle.internalPadding ?? const EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                context
                                    .watch<SelectPickerViewModel>()
                                    .getHint(widget.hint, widget.isLoading == true, widget.loadingMessage),
                                maxLines: 1,
                                style: context.watch<SelectPickerViewModel>().selectedItem.isNotEmpty
                                    ? widget.selectPickerInputStyle.textStyle
                                    : widget.selectPickerInputStyle.hintStyle,
                              ),
                            ),
                          ),
                        ),
                        if (widget.selectPickerInputStyle.showDropIndicator != false)
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: widget.selectPickerInputStyle.spaceBarSize ?? 2,
                                color: widget.selectPickerInputStyle.iconColor ?? Colors.black87,
                                child: const Text(""),
                              ),
                            ),
                          ),
                        if (widget.isLoading == true)
                          SizedBox(
                            width: (widget.selectPickerInputStyle.height ?? 55) * 0.6,
                            height: (widget.selectPickerInputStyle.height ?? 55) * 0.6,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: widget.selectPickerInputStyle.iconColor ?? Colors.black87,
                              ),
                            ),
                          ),
                        if (widget.selectPickerInputStyle.showDropIndicator != false && widget.isLoading != true)
                          Icon(
                            widget.selectPickerInputStyle.iconDropDwon ?? Icons.arrow_drop_down_rounded,
                            size: widget.selectPickerInputStyle.iconSize ?? (widget.selectPickerInputStyle.height ?? 55) * 0.8,
                            color: widget.selectPickerInputStyle.iconColor ?? Colors.black87,
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        widget.inputError != null
            ? Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      widget.inputError ?? "",
                      style: TextStyle(color: widget.selectPickerInputStyle.errorColor ?? Colors.red),
                    ),
                  )),
                ],
              )
            : const SizedBox(),
      ],
    );
  }

  void showOptions() {
    showModalBottomSheet(
        isScrollControlled: (widget.hintSearch != null && widget.hintSearch != ""),
        backgroundColor: widget.selectPickerBottomSheetStyle.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(widget.selectPickerBottomSheetStyle.borderRadius ?? 25),
            topLeft: Radius.circular(widget.selectPickerBottomSheetStyle.borderRadius ?? 25),
          ),
        ),
        enableDrag: true,
        isDismissible: true,
        context: context,
        showDragHandle: false,
        transitionAnimationController: _animationController,
        useSafeArea: true,
        builder: (_) {
          return SafeArea(
            child: BottomSheet(
                backgroundColor: widget.selectPickerBottomSheetStyle.backgroundColor,
                enableDrag: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(widget.selectPickerBottomSheetStyle.borderRadius ?? 25),
                    topLeft: Radius.circular(widget.selectPickerBottomSheetStyle.borderRadius ?? 25),
                  ),
                ),
                onClosing: () {},
                builder: (contexBuilder) {
                  return ChangeNotifierProvider.value(
                    value: Provider.of<SelectPickerViewModel>(context),
                    child: SelectPickerBody(
                      topSelectorStyle: widget.selectPickertopSelectorStyle,
                      selectPickerCardItemStyle: widget.selectPickerCardItemStyle,
                      selectPickerInputSearchStyle: widget.selectPickerInputSearchStyle,
                      selectPickerBottomSheetStyle: widget.selectPickerBottomSheetStyle,
                      hintSearch: widget.hintSearch,
                      hint: widget.isLoading == true ? widget.loadingMessage ?? widget.hint : widget.hint,
                      onSearch: widget.onSearch,
                      onSelect: widget.onSelect,
                      showId: widget.showId,
                    ),
                  );
                }),
          );
        }).whenComplete(() {
      context.read<SelectPickerViewModel>().reset();
      if (widget.onClose != null) {
        widget.onClose!();
      }
    });
  }
}
