import 'package:flutter/material.dart';
import '../utils/enum.dart';
import '../utils/flutter_custom_select_item.dart';
import '../utils/utils.dart';
import 'flutter_custom_selector_sheet.dart';

class CustomSingleSelectField<T> extends StatefulWidget
    with CustomBottomSheetSelector<T> {
  final double? width;
  final String title;
  final String Function(dynamic value)? itemAsString;
  final InputDecoration? decoration;
  final String? Function(String?)? validator;
  final void Function(dynamic value)? onSelectionDone;
  final T? initialValue;
  final Color selectedItemColor;
  final List<T> items;

  CustomSingleSelectField({
    Key? key,
    required this.items,
    required this.title,
    required this.onSelectionDone,
    this.width,
    this.itemAsString,
    this.decoration,
    this.validator,
    this.initialValue,
    this.selectedItemColor = Colors.redAccent,
  }) : super(key: key);

  @override
  State<CustomSingleSelectField> createState() =>
      _CustomSingleSelectFieldState();
}

class _CustomSingleSelectFieldState<T>
    extends State<CustomSingleSelectField<T>> {
  final TextEditingController _controller = TextEditingController();
  T? selectedItem;

  @override
  void initState() {
    selectedItem = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = _selectedItemAsString(selectedItem);
    return GestureDetector(
      onTap: () async {
        Map<String, List<T>?> result =
            await CustomBottomSheetSelector<T>().customBottomSheet(
          buildContext: context,
          selectedItemColor: widget.selectedItemColor,
          initialSelection: selectedItem != null ? [selectedItem!] : [],
          buttonType: CustomDropdownButtonType.singleSelect,
          headerName: widget.title,
          dropdownItems: _getDropdownItems(list: widget.items),
        );

        if (result[selectedList] != null) {
          if (widget.onSelectionDone != null) {
            widget.onSelectionDone!(result[selectedList]!.first);
          }
          selectedItem = result[selectedList]!.first;
          _controller.text = _selectedItemAsString(selectedItem);
          setState(() {});
        }
      },
      child: SizedBox(
        width: widget.width ?? double.infinity,
        child: TextFormField(
          controller: _controller,
          readOnly: true,
          enabled: false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.validator,
          style: defaultTextStyle(
            fontSize: 16,
          ),
          decoration: widget.decoration ??
              InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                errorBorder: inputFieldBorder(color: errorColor),
                errorMaxLines: 2,
                errorStyle: defaultTextStyle(
                  color: errorColor,
                  fontSize: 11,
                ),
                floatingLabelStyle:
                    defaultTextStyle(color: labelColor, fontSize: 14),
                labelText: widget.title,
                labelStyle: defaultTextStyle(color: labelColor, fontSize: 16),
                suffixIcon: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                ),
                suffixIconColor: Colors.black,
                enabledBorder: inputFieldBorder(),
                border: inputFieldBorder(),
                focusedBorder: inputFieldBorder(),
                focusedErrorBorder: inputFieldBorder(color: errorColor),
              ),
        ),
      ),
    );
  }

  String _selectedItemAsString(T? data) {
    if (data == null) {
      return "";
    } else if (widget.itemAsString != null) {
      return widget.itemAsString!(data);
    } else {
      return data.toString();
    }
  }

  List<CustomMultiSelectDropdownItem<T>> _getDropdownItems(
      {required List<T> list}) {
    List<CustomMultiSelectDropdownItem<T>> _list =
        <CustomMultiSelectDropdownItem<T>>[];
    for (T _item in list) {
      _list.add(CustomMultiSelectDropdownItem(_item, _item.toString()));
    }
    return _list;
  }
}
