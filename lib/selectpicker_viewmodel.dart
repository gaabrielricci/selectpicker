import 'package:flutter/material.dart';
import 'package:selectpicker/models/select_picker_item.dart';

/// View model that manages the state of the legacy [SelectPicker].
class SelectPickerViewModel with ChangeNotifier {
  /// Controller for the search input field.
  TextEditingController searchController = TextEditingController();
  
  String _selectedItem = "";
  
  /// Current search error message.
  String? searchError;
  
  /// Whether to automatically select the first item.
  bool selectFirst = false;
  
  /// Whether to show the item ID.
  bool showId = false;
  
  List<SelectPickerItem> _listToShow = [];
  List<SelectPickerItem> _originalList = [];

  /// Updates the currently selected item label and notifies listeners.
  set selectedItem(String item) {
    _selectedItem = item;
    notifyListeners();
  }

  /// Gets the currently selected item label.
  String get selectedItem => _selectedItem;

  /// Normalizes a string by removing accents/diacritics.
  /// 
  /// This allows accent-insensitive searching. For example:
  /// "Médico" becomes "Medico", "São Paulo" becomes "Sao Paulo"
  String _normalizeString(String text) {
    const withAccents = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÇçÌÍÎÏìíîïÙÚÛÜùúûüÿÑñ';
    const withoutAccents = 'AAAAAAaaaaaaOOOOOOooooooEEEEeeeeCcIIIIiiiiUUUUuuuuyNn';
    
    String normalized = text;
    for (int i = 0; i < withAccents.length; i++) {
      normalized = normalized.replaceAll(withAccents[i], withoutAccents[i]);
    }
    return normalized;
  }

  /// Filters the list based on the provided search text.
  /// 
  /// The search is case-insensitive and accent-insensitive, so searching for
  /// "medi" will match "Médico", "medico", "MEDICO", etc.
  void search(String? text) {
    if (text == null || text.isEmpty) {
      _listToShow = originalList;
      notifyListeners();
      return;
    }

    final normalizedSearch = _normalizeString(text.toUpperCase());

    _listToShow = originalList
        .where((element) =>
            _normalizeString(element.title.toUpperCase()).contains(normalizedSearch) ||
            _normalizeString(element.id.toUpperCase()).contains(normalizedSearch))
        .toList();
    notifyListeners();
  }

  /// Sets the initial selection based on the provided ID.
  void selectInitial({String? initialItem}) {
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

  /// Updates the list currently being displayed in the UI.
  set listToShow(List<SelectPickerItem> list) {
    _listToShow = list;
    notifyListeners();
  }

  /// Updates the list currently being displayed without notifying listeners.
  set listToShowDoNotNotify(List<SelectPickerItem> list) {
    _listToShow = list;
  }

  /// Gets the list currently being displayed.
  List<SelectPickerItem> get listToShow => _listToShow;

  /// Updates the basic original list and refreshes the display list.
  set originalList(List<SelectPickerItem> list) {
    _originalList = list;
    _listToShow = list;
    _selectFirst();
  }

  /// Updates the original list without notifying listeners.
  set originalListDoNotNotify(List<SelectPickerItem> list) {
    _originalList = list;
    listToShowDoNotNotify = list;
    _selectFirst();
  }

  /// Gets the original unfiltered list.
  List<SelectPickerItem> get originalList => _originalList;

  /// Determines the appropriate hint or selected value to display in the input.
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

  void _selectFirst() {
    if (selectFirst) {
      if (originalList.isNotEmpty) {
        _selectedItem = "${showId ? "${originalList[0].id} - " : ""}${originalList[0].title}";
      }
    }
  }

  /// Selects a specific item and updates the UI label.
  void selectItem({required SelectPickerItem item}) {
    selectedItem = "${showId ? "${item.id} - " : ""}${item.title}";
  }

  /// Resets the search state.
  void reset() {
    searchController = TextEditingController();
    searchError = null;
    listToShow = originalList;
  }
}
