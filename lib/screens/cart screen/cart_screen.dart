import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/components/my_button.dart';
import 'package:untitled15/providers/cart_provider.dart';
import 'package:untitled15/screens/Checkout%20Screen/checkout_screen.dart';
import 'package:untitled15/screens/cart%20screen/widget/cart_item_card.dart';
import 'package:untitled15/screens/cart%20screen/widget/empty_cart_screen.dart';
import 'package:untitled15/theme/my_style.dart';
import '../../theme/my_colors.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: MyColors.appBgColor,
      appBar: getAppBar(context),
      body: provider.cartItems.isNotEmpty
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    ...List.generate(
                      provider.cartItems.length,
                      (index) => CartItemCard(
                        cartItem: provider.cartItems.values.toList()[index],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const EmptyCartScreen(),
      bottomNavigationBar: provider.cartItems.isNotEmpty
          ? getBottomNavBar(context)
          : const SizedBox(
              height: 10,
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

  Container getBottomNavBar(BuildContext context) {
    var provider = Provider.of<CartProvider>(context);
    return Container(
      color: MyColors.appBgColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 110,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Price',
                style: MyStyle.mainTextStyle,
              ),
              Text(
                '${provider.totalAmount}\$',
                style: TextStyle(
                  color: MyColors.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          MyButton(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CheckOutScreen()));
            },
            title: 'Order Now',
            bgColor: MyColors.primaryColor!,
          ),
        ],
      ),
    );
  }

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
        'Cart',
        style: MyStyle.mainTextStyle,
      ),
    );
  }
}
