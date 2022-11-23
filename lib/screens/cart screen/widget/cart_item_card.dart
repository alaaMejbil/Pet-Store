import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Model/cart_item.dart';
import '../../../components/custom_image.dart';
import '../../../providers/cart_provider.dart';
import '../../../theme/my_colors.dart';

class CartItemCard extends StatelessWidget {
  final CartModel cartItem;

  const CartItemCard({Key? key, required this.cartItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CartProvider>(context);
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black54.withOpacity(0.1),
            blurRadius: .5,
            spreadRadius: .5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          CustomImage(
            cartItem.imgUrl,
            radius: 12,
            height: 100,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        cartItem.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: MyColors.mainTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          provider
                              .removeItemsWithAllQuantity(cartItem.productId);
                        },
                        icon: const Icon(
                          Icons.delete_outline_sharp,
                          color: Colors.grey,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${cartItem.price * cartItem.quantity}\$',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: MyColors.secondaryColor),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            provider.decreaseQuantityCart(cartItem.productId);
                          },
                          splashRadius: 20,
                          icon: const Icon(
                            Icons.remove,
                            size: 18,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          cartItem.quantity.toInt().toString(),
                          style: TextStyle(
                              color: MyColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        IconButton(
                          onPressed: () {
                            provider.increaseQuantityCart(cartItem.productId);
                          },
                          splashRadius: 20,
                          icon: const Icon(
                            Icons.add,
                            size: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
