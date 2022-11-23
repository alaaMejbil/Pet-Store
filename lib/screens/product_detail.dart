import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/components/cart_icon_with_notification.dart';

import '../Model/product_model.dart';
import '../components/custom_image.dart';
import '../components/my_button.dart';
import '../providers/cart_provider.dart';
import '../theme/my_colors.dart';
import '../theme/my_style.dart';
import 'Pet Details Screen/widgets/custom_slider.dart';
import 'Pet Details Screen/widgets/phone_button.dart';
import 'cart screen/cart_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      //extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: MyColors.appBgColor,
      appBar: getAppBar(context),
      bottomNavigationBar: buildBottomNavigationBar(context, product),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: AnimationLimiter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => ScaleAnimation(
                  //horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  CustomImage(
                    product.imageUrl!,
                    radius: 12,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          product.title!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: MyStyle.mainTextStyle,
                        ),
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
                          '${product.price}\$',
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
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orangeAccent,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        '4.6',
                        style: TextStyle(
                          color: Colors.grey.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Description',
                    style: MyStyle.mainTextStyle,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    product.description.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Quantity',
                        style: MyStyle.mainTextStyle,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              cartProvider.decreaseQuantity(product);
                            },
                            splashRadius: 22,
                            icon: const Icon(
                              Icons.remove,
                              size: 22,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              getProductQuantity(context, product.id!)
                                  .toString(),
                              style: TextStyle(
                                  color: MyColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              cartProvider.increaseQuantity(product);
                            },
                            splashRadius: 22,
                            icon: const Icon(
                              Icons.add,
                              size: 22,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
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

  int getProductQuantity(BuildContext context, String productID) {
    var provider = Provider.of<CartProvider>(context);
    if (provider.cartItems.containsKey(productID)) {
      return provider.cartItems[productID]!.quantity.toInt();
    } else {
      return 1;
    }
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
        product.title!,
        style: TextStyle(
            color: MyColors.mainTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 20),
      ),
      actions: [
        Consumer<CartProvider>(
          builder: (context, cart, _) => CartWithNotification(
            iconColor: Colors.black,
            count: cart.cartItemsLength,
            onPress: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
          ),
        ),
      ],
    );
  }

  Padding buildBottomNavigationBar(BuildContext context, ProductModel product) {
    int currentProductQuantity = getProductQuantity(context, product.id!);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
              child: MyButton(
                  height: 60,
                  title: 'Add To Cart',
                  bgColor: MyColors.secondaryColor!,
                  icon: Icons.add_shopping_cart,
                  onTap: () async {
                    Provider.of<CartProvider>(context, listen: false)
                        .addItemToCart(
                      product.id!,
                      product.price.toString(),
                      product.title!,
                      product.imageUrl!,
                    );
                  })),
        ],
      ),
    );
  }
}
