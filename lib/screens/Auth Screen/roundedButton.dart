import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color colorButton;
  final Color textColor;
  final onPressed;
  final double width;

  RoundedButton(
      {required this.text,
      required this.colorButton,
      @required this.onPressed,
      this.textColor = Colors.black,
      this.width = 150});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        elevation: 5.0,
        color: this.colorButton,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          textColor: textColor,
          onPressed: this.onPressed,
          minWidth: width,
          height: 42.0,
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
