import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selectpicker/models/select_picker_item.dart';
import 'package:selectpicker/selectpicker_viewmodel.dart';

class CardSelectPicker extends StatelessWidget {
  const CardSelectPicker({Key? key, required this.item, required this.onCLick, required this.showId}) : super(key: key);

  final SelectPickerItem item;
  final bool showId;
  final Function(SelectPickerItem) onCLick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<SelectPickerViewModel>().selectedItem = item.title;
        onCLick(item);
        Navigator.pop(context);
      },
      child: (Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(showId ? "${item.id} - ${item.title}" : item.title),
                ),
              )
            ],
          ),
          const Divider(height: 10)
        ],
      )),
    );
  }
}
