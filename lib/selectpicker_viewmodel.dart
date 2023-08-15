import 'package:flutter/material.dart';
import 'package:selectpicker/models/select_picker_iten.dart';

class SelectPickerViewModel with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  String _selectedItem = "";
  String? searchError;
  bool selectFirst = false;
  bool showId = false;
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

  selectInitial({String? initialItem}) {
    for (SelectPickerIten item in originalList) {
      if (item.id == initialItem) {
        selectedItem = "${showId ? "${item.id} - " : ""}${item.title}";
      }
    }
  }

  set listToShow(List<SelectPickerIten> list) {
    _listToShow = list;
    notifyListeners();
  }

  set listToShowDoNotNotify(List<SelectPickerIten> list) {
    _listToShow = list;
  }

  List<SelectPickerIten> get listToShow => _listToShow;

  set originalList(List<SelectPickerIten> list) {
    _originalList = list;
    _listToShow = list;
    _selectFirst();
  }

  set originalListDoNotNotify(List<SelectPickerIten> list) {
    _originalList = list;
    listToShowDoNotNotify = list;
    _selectFirst();
  }

  List<SelectPickerIten> get originalList => _originalList;

  _selectFirst() {
    if (selectFirst) {
      if (originalList.isNotEmpty) {
        _selectedItem = "${showId ? "${originalList[0].id} - " : ""}${originalList[0].title}";
      }
    }
  }

  reset() {
    searchController = TextEditingController();
    searchError = null;
    listToShow = originalList;
  }
}
