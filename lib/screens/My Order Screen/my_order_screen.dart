import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled15/Model/order_item_model.dart';
import 'package:untitled15/providers/order_provider.dart';
import 'package:untitled15/screens/My%20Order%20Screen/widgets/empty_order_screen.dart';
import 'package:untitled15/screens/My%20Order%20Screen/widgets/order_list_tile.dart';
import 'package:untitled15/theme/my_colors.dart';
import 'package:untitled15/theme/my_style.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orderProvider = Provider.of<OrderProvider>(context);
    return orderProvider.myOrders.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: ListView.builder(
                itemCount: orderProvider.myOrders.length,
                itemBuilder: (context, index) => OrderListTile(
                      myOrder: orderProvider.myOrders[index],
                    )),
          )
        : const EmptyOrderScreen();
  }
}
