import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selectpicker/models/select_picker_iten.dart';
import 'package:selectpicker/widgets/body/select_picker_body.dart';
import 'package:selectpicker/widgets/selectpicker_viewmodel.dart';

class SelectPickerInput extends StatefulWidget {
  const SelectPickerInput({
    super.key,
    this.radius,
    this.radiusPicker,
    this.backgroundColor,
    required this.hint,
    this.hintSearch,
    this.showId,
    required this.selectFirst,
    required this.onSelect,
    this.initialText,
    this.inputError,
    this.onSearch,
    this.onClose,
    this.disabled,
    this.initialItem,
    required this.list,
    required this.maxHeight,
    required this.heightInput,
  });

  final double? radius;
  final double? radiusPicker;
  final double? maxHeight;
  final double? heightInput;
  final Color? backgroundColor;
  final String? hintSearch;
  final String hint;
  final bool? showId;
  final bool selectFirst;
  final Function(SelectPickerIten) onSelect;
  final Future<List<SelectPickerIten>> Function(String? text)? onSearch;
  final Function()? onClose;
  final String? initialText;
  final String? inputError;
  final bool? disabled;
  final List<SelectPickerIten> list;
  final String? initialItem;

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
                height: widget.heightInput,
                decoration: BoxDecoration(
                  color: widget.disabled == true ? Colors.grey[300] : widget.backgroundColor ?? Colors.white,
                  border: Border.all(width: 1, color: Colors.grey[900] ?? Colors.black87),
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.radius ?? 0.0),
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
                            color: Colors.grey[900] ?? Colors.black87,
                            width: 1.6,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down_sharp,
                        size: 35,
                        color: Colors.grey[900] ?? Colors.black87,
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
                      style: const TextStyle(color: Colors.red),
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
            topRight: Radius.circular(widget.radiusPicker ?? 25),
            topLeft: Radius.circular(widget.radiusPicker ?? 25),
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
            height: (MediaQuery.of(context).size.height - 80),
            child: BottomSheet(
                enableDrag: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(widget.radiusPicker ?? 25),
                    topLeft: Radius.circular(widget.radiusPicker ?? 25),
                  ),
                ),
                onClosing: () {},
                builder: (_) {
                  return ChangeNotifierProvider.value(
                    value: Provider.of<SelectPickerViewModel>(context),
                    child: SelectPickerBody(
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
