import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selectpicker/styles/bottomsheet_style.dart';
import 'package:selectpicker/styles/inputsearch_style.dart';
import 'package:selectpicker/models/select_picker_item.dart';
import 'package:selectpicker/widgets/body/card_select_picker.dart';
import 'package:selectpicker/widgets/input/input_no_border.dart';
import 'package:selectpicker/selectpicker_viewmodel.dart';

class SelectPickerBody extends StatefulWidget {
  const SelectPickerBody({
    super.key,
    required this.hintSearch,
    required this.hint,
    required this.onSearch,
    required this.onSelect,
    required this.selectPickerBottomSheetStyle,
    required this.selectPickerInputSearchStyle,
    this.showId = false,
  });

  final String? hintSearch;
  final String hint;
  final Future<List<SelectPickerItem>> Function(String? text)? onSearch;
  final Function(SelectPickerItem) onSelect;
  final bool? showId;
  final SelectPickerBottomSheetStyle selectPickerBottomSheetStyle;
  final SelectPickerInputSearchStyle selectPickerInputSearchStyle;

  @override
  State<SelectPickerBody> createState() => _SelectPickerBodyState();
}

class _SelectPickerBodyState extends State<SelectPickerBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: (Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Align(
                    alignment: FractionalOffset.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 20, 0),
                      child: Container(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        widget.hint,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Icon(
                            Icons.close,
                            color: widget.selectPickerBottomSheetStyle.closeIconColor,
                            size: widget.selectPickerBottomSheetStyle.iconSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          widget.hintSearch != null
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 15),
                  child: SelectPickerInputNoBorder(
                    selectPickerInputSearchStyle: widget.selectPickerInputSearchStyle,
                    controller: context.read<SelectPickerViewModel>().searchController,
                    varErro: context.read<SelectPickerViewModel>().searchError,
                    hint: widget.hintSearch,
                    label: "",
                    radius: widget.selectPickerInputSearchStyle.borderRadius,
                    onChangeText: (text) async {
                      if (widget.onSearch != null) {
                        widget.onSearch!(text);
                      } else {
                        context.read<SelectPickerViewModel>().search(text);
                      }
                    },
                  ),
                )
              : const SizedBox(),
          Container(
            color: Colors.grey[300] ?? Colors.grey,
            height: 2,
          ),
          Expanded(
            child: ListView(
              shrinkWrap: false,
              padding: const EdgeInsets.all(10),
              children: [
                for (SelectPickerItem item in context.watch<SelectPickerViewModel>().listToShow)
                  CardSelectPicker(
                    item: item,
                    onCLick: widget.onSelect,
                    showId: widget.showId == true,
                  )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
