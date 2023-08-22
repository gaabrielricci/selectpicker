import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selectpicker/styles/bottomsheet_style.dart';
import 'package:selectpicker/styles/card_item_style.dart';
import 'package:selectpicker/styles/inputsearch_style.dart';
import 'package:selectpicker/styles/input_style.dart';
import 'package:selectpicker/models/select_picker_item.dart';
import 'package:selectpicker/widgets/body/select_picker_body.dart';
import 'package:selectpicker/selectpicker_viewmodel.dart';

class SelectPickerInput extends StatefulWidget {
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
    this.hintSearch,
    this.showId,
    this.onSearch,
    this.onClose,
    this.disabled,
    this.initialItem,
    this.inputError,
  });

  final String? inputError;
  final String? hintSearch;
  final String hint;
  final bool? showId;
  final bool selectFirst;
  final Function(SelectPickerItem) onSelect;
  final Future<List<SelectPickerItem>> Function(String? text)? onSearch;
  final Function()? onClose;
  final bool? disabled;
  final List<SelectPickerItem> list;
  final String? initialItem;
  final SelectPickerInputStyle selectPickerInputStyle;
  final SelectPickerBottomSheetStyle selectPickerBottomSheetStyle;
  final SelectPickerInputSearchStyle selectPickerInputSearchStyle;
  final SelectPickerCardItemStyle selectPickerCardItemStyle;

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
    if (widget.list != context.read<SelectPickerViewModel>().originalList) {
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
              child: Container(
                height: widget.selectPickerInputStyle.height,
                decoration: BoxDecoration(
                  color: widget.disabled == true
                      ? widget.selectPickerInputStyle.backgoundDisabledColor
                      : widget.selectPickerInputStyle.backgroundColor ?? Colors.white,
                  border: Border.all(
                      width: widget.selectPickerInputStyle.borderSize ?? 0,
                      color: widget.selectPickerInputStyle.borderColor ?? Colors.black87),
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.selectPickerInputStyle.borderRadius ?? 0.0),
                  ),
                ),
                child: InkWell(
                  onTap: widget.disabled == true
                      ? null
                      : () {
                          showOptions();
                        },
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                context.watch<SelectPickerViewModel>().selectedItem.isNotEmpty
                                    ? context.watch<SelectPickerViewModel>().selectedItem
                                    : widget.hint,
                                maxLines: 1,
                              )),
                        ),
                      ),
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
                      Icon(
                        Icons.arrow_drop_down_sharp,
                        size: widget.selectPickerInputStyle.iconSize ?? 35,
                        color: widget.selectPickerInputStyle.iconColor ?? Colors.black87,
                      )
                    ],
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
        backgroundColor: widget.selectPickerBottomSheetStyle.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(widget.selectPickerBottomSheetStyle.borderRadius ?? 25),
            topLeft: Radius.circular(widget.selectPickerBottomSheetStyle.borderRadius ?? 25),
          ),
        ),
        isScrollControlled: true,
        enableDrag: false,
        isDismissible: true,
        context: context,
        showDragHandle: false,
        transitionAnimationController: _animationController,
        builder: (_) {
          return SizedBox(
            height: widget.selectPickerBottomSheetStyle.height ?? (MediaQuery.of(context).size.height - 80),
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
                builder: (_) {
                  return ChangeNotifierProvider.value(
                    value: Provider.of<SelectPickerViewModel>(context),
                    child: SelectPickerBody(
                      selectPickerCardItemStyle: widget.selectPickerCardItemStyle,
                      selectPickerInputSearchStyle: widget.selectPickerInputSearchStyle,
                      selectPickerBottomSheetStyle: widget.selectPickerBottomSheetStyle,
                      hintSearch: widget.hintSearch,
                      hint: widget.hint,
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
