import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selectpicker/models/bottomSheetStyle.dart';
import 'package:selectpicker/models/inputStyle.dart';
import 'package:selectpicker/models/select_picker_iten.dart';
import 'package:selectpicker/widgets/body/select_picker_body.dart';
import 'package:selectpicker/selectpicker_viewmodel.dart';

class SelectPickerInput extends StatefulWidget {
  const SelectPickerInput({
    super.key,
    required this.list,
    required this.maxHeight,
    required this.selectPickerInputStyle,
    required this.selectFirst,
    required this.onSelect,
    required this.hint,
    required this.selectPickerBottomSheetStyle,
    this.radiusPicker,
    this.backgroundColor,
    this.hintSearch,
    this.showId,
    this.initialText,
    this.onSearch,
    this.onClose,
    this.disabled,
    this.initialItem,
    this.inputError,
  });

  final double? radiusPicker;
  final double? maxHeight;
  final Color? backgroundColor;
  final String? inputError;
  final String? hintSearch;
  final String hint;
  final bool? showId;
  final bool selectFirst;
  final Function(SelectPickerIten) onSelect;
  final Future<List<SelectPickerIten>> Function(String? text)? onSearch;
  final Function()? onClose;
  final String? initialText;
  final bool? disabled;
  final List<SelectPickerIten> list;
  final String? initialItem;
  final SelectPickerInputStyle selectPickerInputStyle;
  final SelectPickerBottomSheetStyle selectPickerBottomSheetStyle;

  @override
  State<SelectPickerInput> createState() => _SelectPickerInputState();
}

class _SelectPickerInputState extends State<SelectPickerInput> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    Provider.of<SelectPickerViewModel>(context, listen: false).originalListDoNotNotify = widget.list;
    _animationController = BottomSheet.createAnimationController(this);

    super.initState();
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
                      color: widget.selectPickerInputStyle.borderColor),
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
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            color: widget.selectPickerInputStyle.iconColor ?? Colors.black87,
                            width: widget.selectPickerInputStyle.spaceBarSize,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down_sharp,
                        size: widget.selectPickerInputStyle.iconSize,
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
            : const SizedBox()
      ],
    );
  }

  void showOptions() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(widget.selectPickerBottomSheetStyle.borderRadius),
            topLeft: Radius.circular(widget.selectPickerBottomSheetStyle.borderRadius),
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
                enableDrag: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(widget.selectPickerBottomSheetStyle.borderRadius),
                    topLeft: Radius.circular(widget.selectPickerBottomSheetStyle.borderRadius),
                  ),
                ),
                onClosing: () {},
                builder: (_) {
                  return ChangeNotifierProvider.value(
                    value: Provider.of<SelectPickerViewModel>(context),
                    child: SelectPickerBody(
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
