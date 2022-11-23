import 'package:flutter/material.dart';

import '../../../theme/my_colors.dart';

class CustomCardWithTitle extends StatelessWidget {
  final String title;
  final String value;
  final Color colorCard;

  const CustomCardWithTitle(
      {Key? key,
      required this.title,
      required this.value,
      required this.colorCard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      //height: 75,
      padding: const EdgeInsets.symmetric(
        vertical: 18,
      ),
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: colorCard,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black54.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 0.5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                color: MyColors.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
