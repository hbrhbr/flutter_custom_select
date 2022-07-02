/// A model class used to represent a selectable item.
class CustomMultiSelectDropdownItem<T> {
  final T buttonObjectValue;
  final String buttonText;
  bool selected = false;

  CustomMultiSelectDropdownItem(this.buttonObjectValue, this.buttonText);
}
