import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selectpicker/models/select_picker_item.dart';
import 'package:selectpicker/selectpicker_viewmodel.dart';
import 'package:selectpicker/styles/card_item_style.dart';

/// A widget that renders a single selectable item in the legacy [SelectPicker] list.
class CardSelectPicker extends StatelessWidget {
  /// Creates a [CardSelectPicker].
  const CardSelectPicker({
    Key? key,
    required this.item,
    required this.onCLick,
    required this.showId,
    required this.selectPickerCardItemStyle,
  }) : super(key: key);

  /// The item to display.
  final SelectPickerItem item;

  /// Whether to display the item ID alongside the title.
  final bool showId;

  /// Callback executed when the item is tapped.
  final Function(SelectPickerItem) onCLick;

  /// Customization style for the card item.
  final SelectPickerCardItemStyle selectPickerCardItemStyle;

  @override
  Widget build(BuildContext context) {
    return (Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  context.read<SelectPickerViewModel>().selectItem(item: item);
                  onCLick(item);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    showId ? "${item.id} - ${item.title}" : item.title,
                    style: TextStyle(color: selectPickerCardItemStyle.textColor),
                  ),
                ),
              ),
            )
          ],
        ),
        Divider(
          height: 10,
          color: selectPickerCardItemStyle.dividerColor,
        )
      ],
    ));
  }
}
