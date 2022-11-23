import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/screens/Pet%20Details%20Screen/pet_details_screen.dart';

import '../../../Model/PetModel.dart';
import '../../../components/custom_image.dart';
import '../../../providers/pet_provider.dart';
import '../../../theme/my_colors.dart';

class PetItem extends StatelessWidget {
  final PetModel pet;

  const PetItem({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PetDetailsScreen(
                      pet: pet,
                    )));
      },
      child: Container(
        height: 120,
        width: size.width,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black87.withOpacity(0.1),
              blurRadius: 0.5,
              spreadRadius: 0.5,
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Hero(
              tag: pet.id!,
              child: CustomImage(
                pet.imageUrl!,
                radius: 20,
                height: 119,
                width: size.width * 0.38,
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        pet.petName!,
                        style: TextStyle(
                          color: MyColors.mainTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Provider.of<PetProvider>(context, listen: false)
                                .toggleFavoriteStatus(pet);
                          },
                          splashRadius: 20,
                          icon: Icon(
                            pet.isFavorite!
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            size: 22,
                            color: MyColors.secondaryColor,
                          )),
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.orangeAccent,
                        size: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '4.5',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.add_location_rounded,
                        color: MyColors.secondaryColor,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Syria, Damascus',
                        style: TextStyle(color: Colors.grey.withOpacity(0.5)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${pet.sex}, ${pet.age}',
                        style: TextStyle(color: Colors.grey.withOpacity(0.6)),
                      ),
                      Text(
                        '${pet.price!}\$',
                        style: TextStyle(
                          color: MyColors.secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
