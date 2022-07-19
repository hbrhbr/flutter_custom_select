import 'package:flutter/material.dart';
import '../utils/utils.dart';

class CustomBottomSheetButton extends StatelessWidget {
  const CustomBottomSheetButton(
      {Key? key,
      required this.onPressed,
      required this.buttonText,
      this.leading,
      this.buttonTextStyle,
      this.trailing})
      : super(key: key);

  final void Function()? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final String buttonText;
  final TextStyle? buttonTextStyle;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      splashColor: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            leading ?? const SizedBox(),
            SizedBox(
              width: leading != null ? 10 : 0,
            ),
            Expanded(
              child: Text(
                buttonText,
                style: buttonTextStyle ?? defaultTextStyle(),
              ),
            ),
            SizedBox(width: trailing != null ? 10 : 0),
            trailing ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
