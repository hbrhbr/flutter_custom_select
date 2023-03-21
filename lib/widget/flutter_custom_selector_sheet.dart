import 'package:flutter/material.dart';

import '../utils/enum.dart';
import '../utils/flutter_custom_select_item.dart';
import '../utils/utils.dart';
import 'flutter_custom_select_button.dart';

class CustomBottomSheetSelector<T> {
  Future<Map<String, List<T>?>> customBottomSheet(
      {required BuildContext buildContext,
      required String headerName,
      TextStyle? headerNameTextStyle,
      Color? headerNameBackgroundColor,
      required CustomDropdownButtonType buttonType,
      required List<CustomMultiSelectDropdownItem<T>> dropdownItems,
      required List<T> initialSelection,
      required Color selectedItemColor,
      bool isAllOptionEnable = false,
      bool isBarrierDismissible = true,
      String cancelText = "Cancel",
      Color? separatorColor,
      double separatorHeight = 1,
      Color? cancelBackgroundColor,
      Color? dropdownItemBackgroundColor,
      TextStyle? cancelTextStyle,
      TextStyle? itemTextStyle,
      String doneText = "Done",
      String allText = "All"}) async {
    List<T> _selectedList = <T>[];
    bool _selectionDone = false;
    bool isAllSelected = false;
    List<CustomMultiSelectDropdownItem<T>> _searchedItems =
        <CustomMultiSelectDropdownItem<T>>[];

    for (T value in initialSelection) {
      _selectedList.add(value);
    }

    for (int i = 0; i < dropdownItems.length; i++) {
      if (_selectedList.contains(dropdownItems[i].buttonObjectValue)) {
        dropdownItems[i].selected = true;
      }
    }

    if (_selectedList.length == dropdownItems.length) {
      isAllSelected = true;
    }

    await showModalBottomSheet(
        isDismissible: isBarrierDismissible,
        context: buildContext,
        backgroundColor: Colors.transparent,
        enableDrag: true,
        builder: (BuildContext bc) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: dropdownItemBackgroundColor ?? Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: StatefulBuilder(builder: (_, setState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          color:
                              headerNameBackgroundColor ?? Colors.grey.shade200,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            headerName,
                            style: headerNameTextStyle ??
                                const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  // decoration: TextDecoration.underline,
                                ),
                          ),
                        ),
                        Flexible(
                          child: ListView(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              isAllOptionEnable &&
                                      buttonType ==
                                          CustomDropdownButtonType.multiSelect
                                  ? CustomBottomSheetButton(
                                      trailing: Container(
                                        decoration: BoxDecoration(
                                          color: isAllSelected
                                              ? selectedItemColor
                                              : Colors.white,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: isAllSelected
                                                ? Colors.transparent
                                                : Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.done,
                                          color: isAllSelected
                                              ? Colors.white
                                              : Colors.transparent,
                                          size: 20,
                                        ),
                                        padding: const EdgeInsets.all(3),
                                      ),
                                      onPressed: () {
                                        isAllSelected = !isAllSelected;
                                        _selectedList.clear();
                                        for (CustomMultiSelectDropdownItem<
                                            T> value in dropdownItems) {
                                          value.selected = isAllSelected;
                                          if (isAllSelected) {
                                            _selectedList
                                                .add(value.buttonObjectValue);
                                          }
                                        }
                                        setState(() {});
                                      },
                                      buttonTextStyle: defaultTextStyle(
                                          color: isAllSelected
                                              ? selectedItemColor
                                              : Colors.black),
                                      buttonText: allText,
                                    )
                                  : const SizedBox(),
                              isAllOptionEnable &&
                                      buttonType ==
                                          CustomDropdownButtonType.multiSelect
                                  ? Container(
                                      height: 0.5,
                                      width: double.infinity,
                                      color: Colors.grey,
                                    )
                                  : const SizedBox(),
                              Wrap(
                                children: [
                                  for (CustomMultiSelectDropdownItem<T> _item
                                      in _searchedItems.isNotEmpty
                                          ? _searchedItems
                                          : dropdownItems)
                                    Column(
                                      children: [
                                        Container(
                                          height: _item == dropdownItems.first
                                              ? separatorHeight
                                              : (separatorHeight / 2),
                                          width: double.infinity,
                                          color: separatorColor ?? Colors.grey,
                                        ),
                                        CustomBottomSheetButton(
                                          trailing: buttonType ==
                                                  CustomDropdownButtonType
                                                      .multiSelect
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                    color: _item.selected
                                                        ? selectedItemColor
                                                        : Colors.white,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: _item.selected
                                                          ? Colors.transparent
                                                          : Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Icon(
                                                    Icons.done,
                                                    color: _item.selected
                                                        ? Colors.white
                                                        : Colors.transparent,
                                                    size: 20,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                )
                                              : const SizedBox(),
                                          onPressed: () {
                                            if (buttonType ==
                                                CustomDropdownButtonType
                                                    .multiSelect) {
                                              _item.selected = !_item.selected;
                                              if (_item.selected) {
                                                _selectedList.add(
                                                    _item.buttonObjectValue);
                                                if (_selectedList.length ==
                                                    dropdownItems.length) {
                                                  isAllSelected = true;
                                                }
                                              } else {
                                                isAllSelected = false;
                                                _selectedList.remove(
                                                    _item.buttonObjectValue);
                                              }
                                              setState(() {});
                                            } else {
                                              _selectedList.clear();
                                              _selectedList
                                                  .add(_item.buttonObjectValue);
                                              _selectionDone = true;
                                              Navigator.pop(
                                                buildContext,
                                              );
                                            }
                                          },
                                          buttonTextStyle:
                                              itemTextStyle?.copyWith(
                                                      color: _item.selected
                                                          ? selectedItemColor
                                                          : null) ??
                                                  defaultTextStyle(
                                                      color: _item.selected
                                                          ? selectedItemColor
                                                          : Colors.black),
                                          // buttonTextColor: Colors.black,
                                          buttonText: _item.buttonText,
                                        ),
                                        Container(
                                          height: _item == dropdownItems.last
                                              ? separatorHeight
                                              : (separatorHeight / 2),
                                          width: double.infinity,
                                          color: separatorColor ?? Colors.grey,
                                        ),
                                      ],
                                      mainAxisSize: MainAxisSize.min,
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              buttonType == CustomDropdownButtonType.multiSelect
                  ? Container(
                      width: MediaQuery.of(bc).size.width - 40,
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          _selectionDone = true;
                          Navigator.pop(
                            buildContext,
                          );
                        },
                        color: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        minWidth: MediaQuery.of(bc).size.width - 40,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Center(
                            child: Text(
                              doneText,
                              style: const TextStyle(
                                // color: pink,
                                // fontFamily: fontsFamily.MontserratMedium,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(bc).size.width - 40,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          _selectionDone = false;
                          Navigator.pop(buildContext);
                        },
                        color: cancelBackgroundColor ?? Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        minWidth: MediaQuery.of(bc).size.width - 40,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Center(
                            child: Text(
                              cancelText,
                              style: cancelTextStyle ??
                                  const TextStyle(
                                    // color: pink,
                                    // fontFamily: fontsFamily.MontserratMedium,
                                    fontSize: 20,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          );
        });
    return {
      selectedList: _selectionDone ? _selectedList : null,
    };
  }
}
