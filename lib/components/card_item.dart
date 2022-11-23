import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/Model/product_model.dart';
import '../providers/cart_provider.dart';
import '../screens/product_detail.dart';
import '../theme/my_colors.dart';
import 'custom_image.dart';

class CardItem extends StatelessWidget {
  final ProductModel product;

  const CardItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              product: product,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Hero(
              tag: product.id!,
              child: CustomImage(
                product.imageUrl!,
                radius: 12,
                width: double.infinity,
                height: 135,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: MyColors.mainTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.orangeAccent,
                        size: 16,
                      ),
                      Text(
                        ' 4.5',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${product.price}\$',
                          style: TextStyle(
                              color: MyColors.primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .addItemToCart(
                              product.id!,
                              product.price.toString(),
                              product.title!,
                              product.imageUrl!,
                            );
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                color: Colors.deepOrange.withAlpha(30),
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.add_shopping_cart,
                              size: 18,
                              color: MyColors.secondaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
