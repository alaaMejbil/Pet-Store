import 'package:flutter/material.dart';

import '../../../theme/my_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      //margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: MyColors.textFieldColor, //Colors.white60
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black87.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.6),
          ),
          prefixIcon: prefixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        ),
      ),
    );
  }
}
