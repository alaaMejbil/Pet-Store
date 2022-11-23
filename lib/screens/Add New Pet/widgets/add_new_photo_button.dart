import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/providers/pet_provider.dart';

import '../../../theme/my_colors.dart';

class AddPhotoButton extends StatelessWidget {
  const AddPhotoButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Provider.of<PetProvider>(context, listen: false).pickImages();
      },
      radius: 12,
      borderRadius: BorderRadius.circular(12),
      highlightColor: MyColors.secondaryColor,
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black87.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt,
              color: MyColors.secondaryColor,
              size: 35,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Add Photo',
              style: TextStyle(
                color: MyColors.secondaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
