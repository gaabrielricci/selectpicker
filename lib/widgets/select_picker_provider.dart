import 'package:flutter/material.dart';
import 'package:selectpicker/models/select_picker_item.dart';

class SelectPickerProvider extends ChangeNotifier {
  SelectPickerProvider({
    String? selectedId,
    required this.onSelect,
    bool? isLoading,
    required List<SelectPickerItem> items,
  }) {
    this.isLoading = isLoading == true;
    this.items = items;
    if (selectedId != null) {
      selectInitialItem(selectedId);
    }
  }

  List<SelectPickerItem> _items = [];
  final Function(SelectPickerItem) onSelect;
  SelectPickerItem? _selectedItem;
  bool _isLoading = false;

  SelectPickerItem? get selectedItem => _selectedItem;

  set selectedItem(SelectPickerItem? value) {
    _selectedItem = value;
    notifyListeners();
  }

  List<SelectPickerItem> get items => _items;

  set items(List<SelectPickerItem> value) {
    _items = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  selectInitialItem(String selectedId) {
    try {
      for (SelectPickerItem item in items) {
        if (item.id == selectedId) {
          selectedItem = item;
          onSelect(item);
          break;
        }
      }
    } catch (e) {}
  }
}
