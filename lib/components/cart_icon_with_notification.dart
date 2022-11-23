import 'package:flutter/material.dart';
import '../theme/my_colors.dart';

class CartWithNotification extends StatelessWidget {
  final int count;
  final onPress;
  final Color? iconColor;

  const CartWithNotification(
      {Key? key,
      required this.count,
      required this.onPress,
      this.iconColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: onPress,
          splashRadius: 20,
          iconSize: 26,
          icon: Icon(
            Icons.add_shopping_cart,
            color: iconColor,
          ),
        ),
        if (count > 0)
          Positioned(
            top: 4,
            left: 3,
            child: CircleAvatar(
              radius: 9,
              backgroundColor: MyColors.secondaryColor!,
              child: Text(
                count.toString(),
                style: const TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
