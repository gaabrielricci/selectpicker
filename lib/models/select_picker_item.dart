/// A model representing an item in the legacy [SelectPicker].
class SelectPickerItem {
  /// Creates a [SelectPickerItem].
  SelectPickerItem(this.title, this.id, this.object);

  /// The display title of the item.
  String title = "";

  /// The unique identifier of the item.
  String id = "";

  /// An optional payload object associated with the item.
  dynamic object;

  /// Whether the item is currently checked (used in legacy selection).
  bool isChecked = false;
}
