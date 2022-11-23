import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../theme/my_colors.dart';

class PhoneButton extends StatelessWidget {
  const PhoneButton({
    Key? key,
    this.phoneNumber,
  }) : super(key: key);

  final int? phoneNumber;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: MyColors.secondaryColor,
      splashColor: MyColors.secondaryColor,
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        openWhatsapp(
            text: ' ', context: context, number: phoneNumber.toString());
      },
      child: Container(
        width: 60,
        height: 60,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: MyColors.secondaryColor!,
            width: 2.5,
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Theme.of(context).shadowColor.withOpacity(0.1),
          //     spreadRadius: .5,
          //     blurRadius: .5,
          //     offset: const Offset(0, 1),
          //   ),
          // ],
        ),
        child: SvgPicture.asset(
          'assets/icons/whatsapp-icon.svg',
          width: 10,
          height: 10,
          fit: BoxFit.cover,
          color: MyColors.secondaryColor!,
        ),
      ),
    );
  }

  void openWhatsapp(
      {required BuildContext context,
      required String text,
      required String number}) async {
    var whatsapp = number; //+92xx enter like this
    var whatsappURlAndroid =
        "whatsapp://send?phone=" + whatsapp + "&text=$text";
    var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(Uri.parse(
          whatsappURLIos,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    }
  }
}
