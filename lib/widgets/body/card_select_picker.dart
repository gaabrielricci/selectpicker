import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:selectpicker/models/select_picker_iten.dart';
import 'package:selectpicker/widgets/selectpicker_viewmodel.dart';

class CardSelectPicker extends StatelessWidget {
  const CardSelectPicker({Key? key, required this.iten, required this.onCLick, required this.showId}) : super(key: key);

  final SelectPickerIten iten;
  final bool showId;
  final Function(SelectPickerIten) onCLick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<SelectPickerViewModel>().selectedItem = iten.title;
        onCLick(iten);
        Navigator.pop(context);
      },
      child: (Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(showId ? "${iten.id} - ${iten.title}" : iten.title),
                ),
              )
            ],
          ),
          Divider(height: 10)
        ],
      )),
    );
  }
}
