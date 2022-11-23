import 'package:flutter/material.dart';

import '../../../theme/my_colors.dart';
import '../../../theme/my_style.dart';

class EmptyFavoritePetsSceen extends StatelessWidget {
  const EmptyFavoritePetsSceen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 75,
            color: MyColors.primaryColor!,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'You don\'t have any favorite pet',
            style: MyStyle.mainTextStyle,
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Explore more and shortlist some pets.',
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
