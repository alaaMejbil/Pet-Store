import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../theme/my_colors.dart';

class CategoryItem extends StatelessWidget {
  final dynamic data;
  final onTap;
  final bool isSelected;
  const CategoryItem(
      {Key? key,
      required this.data,
      required this.onTap,
      required this.isSelected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInToLinear,
        width: 80,
        height: 80,
        margin: const EdgeInsets.only(left: 11, bottom: 10),
        decoration: BoxDecoration(
          color: isSelected ? MyColors.secondaryColor : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black87.withOpacity(0.1),
              spreadRadius: .5,
              blurRadius: .5,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              data['icon'],
              width: 35,
              fit: BoxFit.cover,
              color: isSelected ? Colors.white : MyColors.secondaryColor,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              data['name'],
              style: TextStyle(
                  color: isSelected ? Colors.white : MyColors.secondaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
