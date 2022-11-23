import 'package:flutter/material.dart';

class LabelButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final onPress;

  const LabelButton(
      {Key? key,
      required this.text,
      required this.textColor,
      required this.onPress})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPress,
      splashColor: textColor.withOpacity(0.3),
      highlightColor: textColor.withOpacity(0.3),
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
