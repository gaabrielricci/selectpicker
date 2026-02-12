/// The modern implementation of the Select Picker.
library select_picker_new;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:selectpicker/utils/string_utils.dart';

/// A modern, generic Select Picker widget that supports any data type [T].
///
/// This widget provides a cleaner interface, custom builders, and built-in search.
/// It is the recommended replacement for the legacy [SelectPicker].
///
/// Example usage:
/// ```dart
/// SelectPickerNew<String>(
///   items: ['Apple', 'Banana', 'Orange'],
///   onChanged: (value) => print(value),
///   hint: 'Select a fruit',
/// )
/// ```
class SelectPickerNew<T> extends StatefulWidget {
  /// The list of items to select from.
  final List<T>? items;

  /// A function to get the display title of an item.
  ///
  /// This is used for the default list tile and for local search filtering.
  /// If [T] is not [String], this property is highly recommended.
  final String Function(T item)? titleBuilder;

  /// A function to build a custom list item widget in the selection sheet.
  ///
  /// Parameters:
  /// * [context]: The build context.
  /// * [item]: The item to build the widget for.
  /// * [isSelected]: Whether this item is currently selected.
  /// * [onTap]: The callback to execute when the item is pressed.
  final Widget Function(BuildContext context, T item, bool isSelected, VoidCallback onTap)? itemBuilder;

  /// The initially selected item value.
  final T? initialValue;

  /// Called when the user selects an item from the picker.
  ///
  /// Returns the selected item or null if cleared.
  final ValueChanged<T?>? onChanged;

  /// Placeholder text displayed when no item is selected.
  final String hint;

  /// Placeholder text for the search input field.
  final String searchHint;

  /// Whether to display a search field at the top of the selection sheet.
  ///
  /// Defaults to true.
  final bool showSearch;

  /// An optional callback for asynchronous search.
  ///
  /// If provided, this function will be called with the search query.
  /// It should return a [Future] that resolves to a list of matching items.
  final Future<List<T>> Function(String query)? onSearch;

  /// Whether the picker is interactive.
  ///
  /// When true, the picker will not respond to touch events.
  final bool disabled;

  /// The decoration to apply to the main input field.
  ///
  /// Uses [InputDecorator] internally, allowing for full customization of
  /// borders, colors, and icons.
  final InputDecoration? decoration;

  /// A widget to display when the list of items is empty or no search results are found.
  final Widget? emptyWidget;

  /// A widget to display while an asynchronous search is in progress.
  final Widget? loadingWidget;

  /// Whether the widget is currently in a loading state.
  final bool isLoading;

  /// The message to display while loading.
  final String? loadingMessage;

  /// A custom function to determine if two items are equal.
  ///
  /// Used to highlight the currently selected item in the list.
  /// If null, default equality [==] is used.
  final bool Function(T a, T b)? compareFn;

  /// An error message to display below the input field.
  ///
  /// If null, no error message is shown.
  final String? errorText;

  /// Creates a new [SelectPickerNew] instance.
  const SelectPickerNew({
    Key? key,
    this.items,
    this.titleBuilder,
    this.itemBuilder,
    this.initialValue,
    this.onChanged,
    this.hint = 'Select',
    this.searchHint = 'Search...',
    this.showSearch = true,
    this.onSearch,
    this.disabled = false,
    this.decoration,
    this.emptyWidget,
    this.loadingWidget,
    this.errorText,
    this.contentPadding,
    this.isLoading = false,
    this.loadingMessage,
  }) : super(key: key);

  /// Custom padding inside the input field.
  ///
  /// If null, uses [decoration.contentPadding] or a default of
  /// [EdgeInsets.symmetric(horizontal: 16, vertical: 12)].
  final EdgeInsetsGeometry? contentPadding;

  @override
  State<SelectPickerNew<T>> createState() => _SelectPickerNewState<T>();
}

class _SelectPickerNewState<T> extends State<SelectPickerNew<T>> {
  T? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant SelectPickerNew<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _selectedItem = widget.initialValue;
    }
  }

  String _getItemTitle(T item) {
    if (widget.titleBuilder != null) {
      return widget.titleBuilder!(item);
    }
    return item.toString();
  }

  bool _isEqual(T a, T b) {
    if (widget.compareFn != null) {
      return widget.compareFn!(a, b);
    }
    return a == b;
  }

  void _showSelector() {
    if (widget.disabled) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _SelectPickerSheet<T>(
        items: widget.items ?? [],
        selectedItem: _selectedItem,
        titleBuilder: _getItemTitle,
        itemBuilder: widget.itemBuilder,
        onSelected: (item) {
          setState(() {
            _selectedItem = item;
          });
          widget.onChanged?.call(item);
          Navigator.pop(context);
        },
        searchHint: widget.searchHint,
        showSearch: widget.showSearch,
        onSearch: widget.onSearch,
        emptyWidget: widget.emptyWidget,
        loadingWidget: widget.loadingWidget,
        isEqual: _isEqual,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPlaceholder = _selectedItem == null;
    final isLoading = widget.isLoading;

    final displayText = isLoading
        ? (widget.loadingMessage ?? widget.hint)
        : (_selectedItem != null ? _getItemTitle(_selectedItem as T) : widget.hint);

    final effectiveDecoration = (widget.decoration ?? const InputDecoration());
    final effectiveFillColor = effectiveDecoration.filled == true ? effectiveDecoration.fillColor : null;

    return Material(
      color: effectiveFillColor ?? Colors.transparent,
      borderRadius: effectiveDecoration.border?.isOutline == true && effectiveDecoration.border is OutlineInputBorder
          ? (effectiveDecoration.border as OutlineInputBorder).borderRadius
          : BorderRadius.circular(12),
      child: InkWell(
        onTap: widget.disabled || isLoading ? null : _showSelector,
        borderRadius: effectiveDecoration.border?.isOutline == true && effectiveDecoration.border is OutlineInputBorder
            ? (effectiveDecoration.border as OutlineInputBorder).borderRadius
            : BorderRadius.circular(12),
        child: InputDecorator(
          decoration: effectiveDecoration.copyWith(
            enabled: !widget.disabled,
            errorText: widget.errorText,
            filled: false,
            // Set to false because Material handles the background now
            contentPadding:
                widget.contentPadding ?? effectiveDecoration.contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            suffixIcon: isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: effectiveDecoration.suffixIconColor ?? theme.primaryColor,
                      ),
                    ),
                  )
                : (effectiveDecoration.suffixIcon ??
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: widget.disabled ? theme.disabledColor : theme.iconTheme.color,
                    )),
          ),
          child: Text(
            displayText,
            style: isPlaceholder ? theme.textTheme.bodyLarge?.copyWith(color: theme.hintColor) : theme.textTheme.bodyLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

class _SelectPickerSheet<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final String Function(T) titleBuilder;
  final Widget Function(BuildContext, T, bool, VoidCallback)? itemBuilder;
  final ValueChanged<T> onSelected;
  final String searchHint;
  final bool showSearch;
  final Future<List<T>> Function(String)? onSearch;
  final Widget? emptyWidget;
  final Widget? loadingWidget;
  final bool Function(T, T) isEqual;

  const _SelectPickerSheet({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.titleBuilder,
    this.itemBuilder,
    required this.onSelected,
    required this.searchHint,
    required this.showSearch,
    this.onSearch,
    this.emptyWidget,
    this.loadingWidget,
    required this.isEqual,
  }) : super(key: key);

  @override
  State<_SelectPickerSheet<T>> createState() => _SelectPickerSheetState<T>();
}

class _SelectPickerSheetState<T> extends State<_SelectPickerSheet<T>> {
  late List<T> _filteredItems;
  bool _isLoading = false;
  Timer? _debounce;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () async {
      if (widget.onSearch != null) {
        setState(() => _isLoading = true);
        try {
          final results = await widget.onSearch!(query);
          if (mounted) {
            setState(() {
              _filteredItems = results;
              _isLoading = false;
            });
          }
        } catch (e) {
          if (mounted) setState(() => _isLoading = false);
        }
      } else {
        // Local filtering
        if (query.isEmpty) {
          setState(() => _filteredItems = widget.items);
        } else {
          setState(() {
            final normalizedQuery = query.toLowerCase().normalize();
            _filteredItems = widget.items.where((item) {
              return widget.titleBuilder(item).toLowerCase().normalize().contains(normalizedQuery);
            }).toList();
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          if (widget.showSearch)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: widget.searchHint,
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onChanged: _onSearchChanged,
              ),
            ),

          if (_isLoading)
            Expanded(
              child: Center(
                child: widget.loadingWidget ?? const CircularProgressIndicator(),
              ),
            )
          else if (_filteredItems.isEmpty)
            Expanded(
              child: Center(
                child: widget.emptyWidget ??
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off_rounded, size: 48, color: theme.disabledColor),
                        const SizedBox(height: 16),
                        Text("No results found", style: theme.textTheme.bodyLarge?.copyWith(color: theme.disabledColor)),
                      ],
                    ),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _filteredItems.length,
                separatorBuilder: (context, index) =>
                    Divider(height: 1, indent: 16, endIndent: 16, color: theme.dividerColor.withValues(alpha: 0.1)),
                itemBuilder: (context, index) {
                  final item = _filteredItems[index];
                  final isSelected = widget.selectedItem != null && widget.isEqual(item, widget.selectedItem as T);

                  if (widget.itemBuilder != null) {
                    return widget.itemBuilder!(context, item, isSelected, () => widget.onSelected(item));
                  }

                  return Material(
                    color: Colors.transparent,
                    child: ListTile(
                      title: Text(
                        widget.titleBuilder(item),
                        style: isSelected ? TextStyle(color: theme.primaryColor, fontWeight: FontWeight.w600) : null,
                      ),
                      trailing: isSelected ? Icon(Icons.check_circle_rounded, color: theme.primaryColor) : null,
                      onTap: () => widget.onSelected(item),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
