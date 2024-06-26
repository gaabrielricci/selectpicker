import 'package:flutter/material.dart';
import 'package:selectpicker/models/select_picker_item.dart';

class SelectPickerViewModel with ChangeNotifier {

  TextEditingController searchController = TextEditingController();
  String _selectedItem = "";
  String? searchError;
  bool selectFirst = false;
  bool showId = false;
  List<SelectPickerItem> _listToShow = [];
  List<SelectPickerItem> _originalList = [];

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
    if (initialItem == null || initialItem == "") {
      selectedItem = "";
      return;
    }
    for (SelectPickerItem item in originalList) {
      if (item.id == initialItem) {
        selectedItem = "${showId ? "${item.id} - " : ""}${item.title}";
      }
    }
  }

  set listToShow(List<SelectPickerItem> list) {
    _listToShow = list;
    notifyListeners();
  }

  set listToShowDoNotNotify(List<SelectPickerItem> list) {
    _listToShow = list;
  }

  List<SelectPickerItem> get listToShow => _listToShow;

  set originalList(List<SelectPickerItem> list) {
    _originalList = list;
    _listToShow = list;
    _selectFirst();
  }

  set originalListDoNotNotify(List<SelectPickerItem> list) {
    _originalList = list;
    listToShowDoNotNotify = list;
    _selectFirst();
  }

  List<SelectPickerItem> get originalList => _originalList;

  String getHint(String hint, bool loading, String? loadingMessage) {
    try {
      if (loading == true) {
        return loadingMessage ?? _defineMessage(hint);
      } else {
        return _defineMessage(hint);
      }
    } catch (e) {
      return "";
    }
  }

  String _defineMessage(String hint) {
    try {
      return selectedItem.isNotEmpty ? selectedItem : hint;
    } catch (e) {
      return "";
    }
  }

  _selectFirst() {
    if (selectFirst) {
      if (originalList.isNotEmpty) {
        _selectedItem = "${showId ? "${originalList[0].id} - " : ""}${originalList[0].title}";
      }
    }
  }

  selectItem({required SelectPickerItem item}) {
    selectedItem = "${showId ? "${item.id} - " : ""}${item.title}";
  }

  reset() {
    searchController = TextEditingController();
    searchError = null;
    listToShow = originalList;
  }
}
