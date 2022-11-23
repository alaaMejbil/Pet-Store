import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/components/custom_image.dart';
import 'package:untitled15/providers/product_provider.dart';
import 'package:untitled15/theme/my_colors.dart';
import 'package:untitled15/theme/my_style.dart';

import '../../components/card_item.dart';
import '../../components/custom_card.dart';
import '../../components/product_cart_item.dart';
import '../../components/search_text_field.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: const [
              SizedBox(
                height: 120,
              ),
              SearchTextField(),
              SizedBox(
                height: 25,
              ),
              AllProductsGrid()
            ],
          ),
        ),
      ),
    );
  }
}

class AllProductsGrid extends StatelessWidget {
  const AllProductsGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductProvider>(context);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: provider.allProducts.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2 / 2.98,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
      itemBuilder: (context, index) => CardItem(
        product: provider.allProducts[index],
      ),
    );
  }
}
