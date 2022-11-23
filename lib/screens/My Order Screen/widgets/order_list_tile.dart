import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:untitled15/components/custom_image.dart';

import '../../../Model/order_item_model.dart';
import '../../../theme/my_colors.dart';
import 'order_pop_menu_button.dart';

class OrderListTile extends StatelessWidget {
  final OrderItemModel myOrder;

  const OrderListTile({Key? key, required this.myOrder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      //padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: BoxDecoration(
        color: MyColors.cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: MyColors.shadowColor!.withOpacity(0.1),
            blurRadius: 0.1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          OrderPopMenuButton(
            orderId: myOrder.orderId!,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order ID : ',
                      style: TextStyle(
                          color: MyColors.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    Text(
                      '${myOrder.hashCode.toString().substring(0, 3)}   ',
                      style: TextStyle(
                          color: MyColors.secondaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Date : ',
                      style: TextStyle(
                          color: MyColors.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    Text(
                      '${myOrder.orderTime!.substring(0, 10)}   ',
                      style: TextStyle(
                          color: MyColors.secondaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Payment Methode : ',
                      style: TextStyle(
                          color: MyColors.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    Text(
                      '${myOrder.paymentMethode}   ',
                      style: TextStyle(
                          color: MyColors.secondaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price : ',
                      style: TextStyle(
                          color: MyColors.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    Text(
                      '\$${myOrder.totalPrice}   ',
                      style: TextStyle(
                          color: MyColors.secondaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Status : ',
                      style: TextStyle(
                          color: MyColors.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    Text(
                      '${myOrder.orderStatus}   ',
                      style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Content :  ',
                      style: TextStyle(
                          color: MyColors.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                      height: 70,
                      enlargeCenterPage: true,
                      disableCenter: true,
                      enableInfiniteScroll: false,
                      initialPage: 0,
                      viewportFraction: .2),
                  items: List.generate(
                      myOrder.orderContent!.length,
                      (index) => CustomImage(
                            myOrder.orderContent![index].imgUrl,
                            radius: 5,
                          )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
