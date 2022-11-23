import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/Model/PetModel.dart';
import 'package:untitled15/components/my_button.dart';
import 'package:untitled15/screens/Pet%20Details%20Screen/widgets/custom_card.dart';
import 'package:untitled15/screens/cart%20screen/cart_screen.dart';
import 'package:untitled15/theme/my_colors.dart';
import 'package:untitled15/theme/my_style.dart';

import '../../components/cart_icon_with_notification.dart';
import '../../providers/cart_provider.dart';
import 'widgets/custom_slider.dart';
import 'widgets/phone_button.dart';

class PetDetailsScreen extends StatelessWidget {
  final PetModel pet;

  const PetDetailsScreen({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      //extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: MyColors.appBgColor,
      appBar: getAppBar(context),
      bottomNavigationBar: buildBottomNavigationBar(context, pet),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: AnimationLimiter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  Hero(
                    tag: pet.id!,
                    child: CustomSliderWidget(
                      items: pet.album!,
                    ),
                  ),
                  if (pet.album!.length > 1)
                    const SizedBox(
                      height: 15,
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        pet.petName!,
                        style: MyStyle.mainTextStyle,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        //height: 30,
                        decoration: BoxDecoration(
                          color: MyColors.primaryColor!.withAlpha(30),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '${pet.price}\$',
                          style: TextStyle(
                            color: MyColors.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Colors.grey.withOpacity(0.4),
                        size: 20,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        'An Address',
                        style: TextStyle(
                          color: Colors.grey.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomCardWithTitle(
                        title: 'Age',
                        value: pet.age.toString(),
                        colorCard: Colors.orangeAccent.shade100,
                      ),
                      CustomCardWithTitle(
                        title: 'Gender',
                        value: pet.sex!,
                        colorCard: Colors.deepPurple.shade100,
                      ),
                      CustomCardWithTitle(
                        title: 'Weight',
                        value: pet.weight.toString(),
                        colorCard: Colors.pink.shade100,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Description',
                    style: MyStyle.mainTextStyle,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    pet.description.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /*
  *
  *
  *
  *
  *
  *
  *
  *
  *
  *
  *
  *
  *
  *
  *
  *
  *
  *
  *
  *
   */

  AppBar getAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: MyColors.mainTextColor,
          ),
          splashRadius: 22,
          onPressed: () {
            Navigator.pop(context);
          }),
      backgroundColor: MyColors.appBarColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        pet.petName!,
        style: TextStyle(
            color: MyColors.mainTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 20),
      ),
      actions: [
        Consumer<CartProvider>(
          builder: (context, cart, _) => CartWithNotification(
            count: cart.cartItemsLength,
            iconColor: Colors.black,
            onPress: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
          ),
        ),
      ],
    );
  }

  Padding buildBottomNavigationBar(BuildContext context, PetModel pet) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          PhoneButton(
            phoneNumber: pet.ownerPhone,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
              child: MyButton(
                  height: 60,
                  title: 'Adopt Now',
                  bgColor: MyColors.secondaryColor!,
                  icon: Icons.add_shopping_cart,
                  onTap: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .addItemToCart(
                            pet.id!, pet.price, pet.petName!, pet.imageUrl!);
                  })),
        ],
      ),
    );
  }
}
