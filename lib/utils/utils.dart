import 'package:flutter/material.dart';

Color borderColor = const Color(0xFF35343E).withOpacity(.10);
Color labelColor = Colors.black.withOpacity(.44);
Color errorColor = const Color(0xFFFF5858);
Color disabledFieldBackgroundShadowColor = Colors.grey.shade100;
Color earningFieldBackgroundShadowColor = disabledFieldBackgroundShadowColor;
const double borderRadius = 44;
const String isSelectionDone = "isSelectionConfirmed";
const String selectedList = "selection";

TextStyle defaultTextStyle({
  double fontSize = 15,
  FontWeight fontWeight = FontWeight.w400,
  String? fontFamily,
  TextDecoration decoration = TextDecoration.none,
  Color color = Colors.black,
  FontStyle fontStyle = FontStyle.normal,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: fontFamily,
    decoration: decoration,
    color: color,
    fontStyle: fontStyle,
  );
}

Widget postCheckBox({
  required String checkBoxText,
  required void Function()? onPressed,
  required bool value,
}) {
  return MaterialButton(
    onPressed: onPressed,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          checkBoxText,
          style: defaultTextStyle(),
        ),
        Checkbox(
          value: value,
          onChanged: (value) {
            if (onPressed != null) {
              onPressed();
            }
          },
        ),
      ],
    ),
  );
}

InputBorder inputFieldBorder({
  Color? color,
}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(borderRadius),
    borderSide: BorderSide(width: 1, color: color ?? borderColor),
  );
}
