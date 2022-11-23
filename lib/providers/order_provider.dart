import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:random_string/random_string.dart';
import 'package:untitled15/Model/address_model.dart';
import 'package:untitled15/Model/order_item_model.dart';
import 'package:untitled15/theme/my_colors.dart';

import '../Model/cart_item.dart';
import 'package:http/http.dart' as http;
import 'package:untitled15/components/timer_snackbar.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderItemModel> myOrders = [];
  String? authToken;
  String? userId;
  bool isLoading = false;

  void getData(String? token, String? uId, List<OrderItemModel> myOrders) {
    this.myOrders = myOrders;
    userId = uId;
    authToken = token;

    notifyListeners();
  }

  Future<void> fetchMyOrders() async {
    final url =
        'https://pets-store-6f3d1-default-rtdb.firebaseio.com/orders/$userId.json';
    try {
      final res = await http.get(Uri.parse(url));
      final extractData = jsonDecode(res.body);
      print(res.body);

      List<OrderItemModel> tempList = [];
      extractData.forEach((orderId, order) {
        tempList.add(OrderItemModel.fromJson(order, orderId));
      });
      myOrders = tempList;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> addNewOrder(List<CartModel> cartItemsList, double totalPrice,
      String userAddress, String paymentMethode) async {
    //1- add to Backend
    String url =
        "https://pets-store-6f3d1-default-rtdb.firebaseio.com/orders/$userId.json";
    isLoading = true;
    notifyListeners();
    try {
      final res = await http
          .post(Uri.parse(url),
              body: json.encode({
                'totalPrice': totalPrice,
                'orderStatus': 'pending',
                'orderTime': DateTime.now().toIso8601String(),
                'destinationAddress': userAddress,
                'paymentMethode': paymentMethode,
                'orderContent': cartItemsList
                    .map((product) => {
                          'productId': product.id,
                          'price': product.price,
                          'quantity': product.quantity,
                          'title': product.title,
                          'imageUrl': product.imgUrl,
                        })
                    .toList(),
              }))
          .then((value) {
        //2- add to frontend
        myOrders.insert(
            0,
            OrderItemModel(
              orderId: jsonDecode(value.body)['name'],
              orderTime: DateTime.now().toIso8601String(),
              destinationAddress: userAddress,
              totalPrice: totalPrice,
              orderStatus: 'pending',
              paymentMethode: paymentMethode,
              orderContent: cartItemsList,
            ));
      });
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      isLoading = false;
      return false;
    }
  }

  Future<void> deleteOrder(BuildContext context, String id) async {
    final url =
        'https://pets-store-6f3d1-default-rtdb.firebaseio.com/orders/$userId/$id.json';
    // 1- delete this item from UI (state array)
    int removedItemIndex =
        myOrders.indexWhere((element) => element.orderId == id);
    OrderItemModel deletedOrder = myOrders[removedItemIndex];
    myOrders.removeAt(removedItemIndex);
    //notifyListeners();

    //2- delete from Backend
    try {
      final res = await http.delete(Uri.parse(url));
      if (res.statusCode >= 400) {
        //myOrders.insert(removedItemIndex, deletedOrder);
      } else {
        print('deleted Success !!');
      }
    } catch (e) {
      print(e.toString());
      //myOrders.insert(removedItemIndex, deletedOrder);
    }

    // 3 - undo procces
    timerSnackBar(
      context: context,
      contentText: 'Delete this order',
      onPressed: () {
        print('Undo.............');
        //ScaffoldMessenger.of(context).hideCurrentSnackBar();
        addNewOrder(deletedOrder.orderContent!, deletedOrder.totalPrice,
            deletedOrder.destinationAddress!, deletedOrder.paymentMethode!);
      },
    );
    notifyListeners();
  }
}
