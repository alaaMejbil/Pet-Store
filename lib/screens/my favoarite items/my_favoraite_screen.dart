import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/Model/PetModel.dart';
import 'package:untitled15/providers/pet_provider.dart';
import 'package:untitled15/screens/my%20favoarite%20items/widgets/empty_favorite_pets_screen.dart';
import 'package:untitled15/screens/my%20favoarite%20items/widgets/favorite_pet_card.dart';

import '../../components/custom_image.dart';
import '../../theme/my_colors.dart';
import '../../theme/my_style.dart';
import '../Pet Details Screen/pet_details_screen.dart';

class MyFavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final petProvider = Provider.of<PetProvider>(context);
    List<PetModel> myFavoritePets = petProvider.getMyFavoriteItems();
    print('this build will execute one time only!!!!');
    return myFavoritePets.isNotEmpty
        ? ListView.builder(
            itemCount: myFavoritePets.length,
            itemBuilder: (context, index) {
              return FavoritePetCard(
                pet: myFavoritePets[index],
              );
            })
        : const EmptyFavoritePetsSceen();
  }
}
