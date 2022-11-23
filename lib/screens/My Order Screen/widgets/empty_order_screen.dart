import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled15/components/my_button.dart';
import 'package:untitled15/root_app.dart';
import 'package:untitled15/screens/main%20screen/main_screen.dart';

import '../../../theme/my_colors.dart';
import '../../../theme/my_style.dart';

class EmptyOrderScreen extends StatelessWidget {
  const EmptyOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/box.svg',
            color: MyColors.primaryColor,
            width: 120,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            'No Orders Yet!',
            style: MyStyle.mainTextStyle,
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            'Explore more and shortlist some products & pets.',
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(
            height: 40,
          ),
          MyButton(
              title: 'Go to shop',
              width: 160,
              bgColor: MyColors.primaryColor!.withOpacity(0.5),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => RootApp()));
              }),
        ],
      ),
    );
  }
}
