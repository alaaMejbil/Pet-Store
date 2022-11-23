import 'package:untitled15/Model/cart_item.dart';

/// destinationAddress : "Homs, syria "
/// orderContent : [{"imageUrl":"https://firebasestorage.googleapis.com/v0/b/pets-store-6f3d1.appspot.com/o/pet_images%2Fdata%2Fuser%2F0%2Fcom.example.untitled15%2Fcache%2Fscaled_image_picker3182128705178213254.jpg?alt=media&token=01a3244e-3a1a-4649-9575-00375a03f847","price":33,"productId":"2022-10-25 20:41:10.799529","quantity":1,"title":"الل"},{"imageUrl":"https://firebasestorage.googleapis.com/v0/b/pets-store-6f3d1.appspot.com/o/pet_images%2Fdata%2Fuser%2F0%2Fcom.example.untitled15%2Fcache%2Fscaled_image_picker2293131367485751507.jpg?alt=media&token=83290843-ec64-475c-a968-e56199dfd7f5","price":200,"productId":"2022-10-25 20:41:14.730708","quantity":1,"title":"dog"},{"imageUrl":"https://firebasestorage.googleapis.com/v0/b/pets-store-6f3d1.appspot.com/o/pet_images%2Fdata%2Fuser%2F0%2Fcom.example.untitled15%2Fcache%2Fscaled_image_picker1577708830303262257.jpg?alt=media&token=a6373842-b86a-4973-b85f-1f3aa80b61c8","price":100,"productId":"2022-10-25 20:41:17.308527","quantity":1,"title":"koki"}]
/// orderStatus : "pending"
/// orderTime : "2022-10-25T20:46:18.249633"
/// paymentMethode : "paypal"
/// totalPrice : 333

class OrderItemModel {
  String? _orderId;
  String? _destinationAddress;
  List<CartModel>? _orderContent;
  String? _orderStatus;
  String? _orderTime;
  String? _paymentMethode;
  dynamic? _totalPrice;

  OrderItemModel({
    String? orderId,
    String? destinationAddress,
    List<CartModel>? orderContent,
    String? orderStatus,
    String? orderTime,
    String? paymentMethode,
    dynamic? totalPrice,
  }) {
    _orderId = orderId;
    _destinationAddress = destinationAddress;
    _orderContent = orderContent;
    _orderStatus = orderStatus;
    _orderTime = orderTime;
    _paymentMethode = paymentMethode;
    _totalPrice = totalPrice;
  }

  OrderItemModel.fromJson(dynamic json, String id) {
    _orderId = id;
    _destinationAddress = json['destinationAddress'];
    _orderStatus = json['orderStatus'];
    _orderTime = json['orderTime'];
    _paymentMethode = json['paymentMethode'];
    _totalPrice = json['totalPrice'];
    if (json['orderContent'] != null) {
      _orderContent = [];
      json['orderContent'].forEach((v) {
        _orderContent?.add(CartModel(
          productId: v['productId'],
          title: v['title'],
          quantity: v['quantity'],
          imgUrl: v['imageUrl'],
          price: v['price'],
          id: DateTime.now().toIso8601String(),
        ));
      });
    }
  }
  String? get orderId => _orderId;
  String? get destinationAddress => _destinationAddress;
  List<CartModel>? get orderContent => _orderContent;
  String? get orderStatus => _orderStatus;
  String? get orderTime => _orderTime;
  String? get paymentMethode => _paymentMethode;
  dynamic? get totalPrice => _totalPrice;
}
