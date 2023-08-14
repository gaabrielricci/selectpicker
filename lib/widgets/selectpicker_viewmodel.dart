import 'package:flutter/material.dart';
import 'package:selectpicker/models/select_picker_iten.dart';

class SelectPickerViewModel with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  String _selectedItem = "";
  String? initialItem;
  String? searchError;
  List<SelectPickerIten> _listToShow = [];
  List<SelectPickerIten> _originalList = [];

  set selectedItem(String item) {
    _selectedItem = item;
    notifyListeners();
  }

  String get selectedItem => _selectedItem;

  search(String? text) {
    if (text == null || text.isEmpty) {
      _listToShow = originalList;
      notifyListeners();
      return;
    }

    _listToShow = originalList
        .where((element) =>
            element.title.toUpperCase().contains(text.toUpperCase()) ||
            element.id.toUpperCase().contains(text.toUpperCase()))
        .toList();
    notifyListeners();
  }

  _selectInitial() {
    for (SelectPickerIten item in _listToShow) {
      if (item.id == initialItem) {
        selectedItem = item.title;
      }
    }
    initialItem = null;
  }

  set listToShow(List<SelectPickerIten> list) {
    _listToShow = list;
    if (initialItem != null) {
      _selectInitial();
    }
    notifyListeners();
  }

  set listToShowDoNotNotify(List<SelectPickerIten> list) {
    _listToShow = list;
    if (initialItem != null) {
      _selectInitial();
    }
  }

  List<SelectPickerIten> get listToShow => _listToShow;

  set originalList(List<SelectPickerIten> list) {
    _originalList = list;
    _listToShow = list;
    if (initialItem != null) {
      _selectInitial();
    }
  }

  set originalListDoNotNotify(List<SelectPickerIten> list) {
    _originalList = list;
    listToShowDoNotNotify = list;
    if (initialItem != null) {
      _selectInitial();
    }
  }

  List<SelectPickerIten> get originalList => _originalList;

  reset() {
    searchController = TextEditingController();
    initialItem = "";
    searchError = null;
    listToShow = originalList;
  }
}
