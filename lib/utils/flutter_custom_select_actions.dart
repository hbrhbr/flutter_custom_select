import 'flutter_custom_select_item.dart';

class CustomMultiSelectDropdownActions<T> {
  List<T> onItemCheckedChange(
      List<T> selectedValues, T itemValue, bool checked) {
    if (checked) {
      selectedValues.add(itemValue);
    } else {
      selectedValues.remove(itemValue);
    }
    return selectedValues;
  }

  List<CustomMultiSelectDropdownItem<T>> updateSearchQuery(
      String? val, List<CustomMultiSelectDropdownItem<T>> allItems) {
    if (val != null && val.trim().isNotEmpty) {
      List<CustomMultiSelectDropdownItem<T>> filteredItems = [];
      for (var item in allItems) {
        if (item.buttonText.toLowerCase().contains(val.toLowerCase())) {
          filteredItems.add(item);
        }
      }
      return filteredItems;
    } else {
      return allItems;
    }
  }
}
