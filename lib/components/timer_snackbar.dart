import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:async';

import '../theme/my_colors.dart';

void timerSnackBar({
  required BuildContext context,
  required String contentText,
  required VoidCallback? onPressed,
  String buttonLabel = 'Undo',
  int second = 4,

  ///  default is: Colors.grey[850]!.withOpacity(0.9),
  Color? backgroundColor,

  /// default TextStyle is none.
  TextStyle? contentTextStyle,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: 22.0),
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: second * 1000.toDouble()),
                duration: Duration(seconds: second),
                builder: (context, double value, child) {
                  return Stack(
                    fit: StackFit.loose,
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 20.0,
                        width: 20.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          value: value / (10 * 1000),
                          color: Colors.grey[850],
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Center(
                        child: Text(
                          (second - (value / 1000)).toInt().toString(),
                          textScaleFactor: 0.85,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
                child: Text(
              contentText,
              style: contentTextStyle ?? const TextStyle(),
            )),
            TextButton(
              onPressed: onPressed,
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/undo_icon.svg',
                    color: MyColors.secondaryColor,
                    width: 18,
                    height: 18,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    buttonLabel,
                    style: TextStyle(
                        color: MyColors.secondaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        duration: Duration(seconds: second),
        backgroundColor: backgroundColor ?? Colors.grey[850]!.withOpacity(0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
}
