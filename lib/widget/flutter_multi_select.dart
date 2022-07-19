import 'package:flutter/material.dart';
import '../utils/enum.dart';
import '../utils/flutter_custom_select_item.dart';
import '../utils/utils.dart';
import 'flutter_custom_selector_sheet.dart';

class CustomMultiSelectField<T> extends StatefulWidget
    with CustomBottomSheetSelector<T> {
  final double? width;
  final String title;
  final InputDecoration? decoration;
  final String Function(dynamic T)? itemAsString;
  final String? Function(List<T>)? validator;
  final void Function(List<T>)? onSelectionDone;
  final List<T>? initialValue;
  final Color selectedItemColor;
  final List<T> items;
  final bool enableAllOptionSelect;

  CustomMultiSelectField({
    Key? key,
    required this.items,
    required this.title,
    required this.onSelectionDone,
    this.width,
    this.decoration,
    this.validator,
    this.initialValue,
    this.itemAsString,
    this.selectedItemColor = Colors.redAccent,
    this.enableAllOptionSelect = false,
  }) : super(key: key);

  @override
  State<CustomMultiSelectField> createState() => _CustomMultiSelectFieldState();
}

class _CustomMultiSelectFieldState<T> extends State<CustomMultiSelectField<T>> {
  final TextEditingController _controller = TextEditingController();
  late List<T> selectedItems;
  late List<CustomMultiSelectDropdownItem<T>> _customMultiSelectDropdownItem;

  @override
  void initState() {
    selectedItems = widget.initialValue ?? [];
    _controller.text = widget.title;
    _customMultiSelectDropdownItem = _getDropdownItems(list: widget.items);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            Map<String, List<T>?> result =
                await CustomBottomSheetSelector<T>().customBottomSheet(
              buildContext: context,
              selectedItemColor: widget.selectedItemColor,
              initialSelection: selectedItems,
              buttonType: CustomDropdownButtonType.multiSelect,
              headerName: widget.title,
              dropdownItems: _customMultiSelectDropdownItem,
              isAllOptionEnable: widget.enableAllOptionSelect,
            );
            if (result[selectedList] != null &&
                widget.onSelectionDone != null) {
              widget.onSelectionDone!(result[selectedList]!);
              selectedItems = result[selectedList]!;
            }
            setState(() {});
          },
          child: SizedBox(
            width: widget.width ?? double.infinity,
            child: TextFormField(
              controller: _controller,
              readOnly: true,
              enabled: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (String? value) {
                String? validationText;
                if (widget.validator != null) {
                  validationText = widget.validator!(selectedItems);
                }
                debugPrint("validationText:-> $validationText");
                return validationText;
              },
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
                    labelStyle:
                        defaultTextStyle(color: labelColor, fontSize: 16),
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
        ),
        selectedItems.isNotEmpty
            ? Wrap(
                children: [
                  for (CustomMultiSelectDropdownItem<T> item
                      in _customMultiSelectDropdownItem)
                    selectedItems.contains(item.buttonObjectValue)
                        ? item.buttonText.length < 2
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 3),
                                child: Chip(
                                  label: Text(
                                    item.buttonText,
                                    style: defaultTextStyle(),
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  backgroundColor: Colors.grey.shade300,
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 3),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  item.buttonText,
                                  style: defaultTextStyle(),
                                ),
                              )
                        : const SizedBox()
                ],
              )
            : const SizedBox(),
        selectedItems.isNotEmpty
            ? const SizedBox(
                height: 5,
              )
            : const SizedBox(),
      ],
    );
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
