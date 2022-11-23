import 'package:flutter/cupertino.dart';
import 'package:untitled15/Model/product_model.dart';

import '../Model/cart_item.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get cartItems {
    return {..._cartItems};
  }

  int get cartItemsLength {
    return _cartItems.length;
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void increaseQuantity(ProductModel product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems.update(
          product.id!,
          (oldCartItem) => CartModel(
                id: oldCartItem.id,
                title: oldCartItem.title,
                price: oldCartItem.price,
                quantity: oldCartItem.quantity + 1,
                productId: product.id!,
                imgUrl: oldCartItem.imgUrl,
              ));
    } else {
      //add this item to the cart with quantity 1
      _cartItems.putIfAbsent(
        product.id!,
        () => CartModel(
          id: DateTime.now().toString(),
          title: product.title!,
          price: product.price,
          quantity: 1,
          productId: product.id!,
          imgUrl: product.imageUrl!,
        ),
      );
    }
    notifyListeners();
  }

  void decreaseQuantity(ProductModel product) {
    if (_cartItems.containsKey(product.id)) {
      if (_cartItems[product.id]!.quantity > 1) {
        _cartItems.update(
          product.id!,
          (oldCartItem) => CartModel(
            id: oldCartItem.id,
            title: oldCartItem.title,
            price: oldCartItem.price,
            quantity: oldCartItem.quantity - 1,
            productId: product.id!,
            imgUrl: oldCartItem.imgUrl,
          ),
        );
      }
    } else {}

    notifyListeners();
  }

  void increaseQuantityCart(String cartId) {
    if (_cartItems.containsKey(cartId)) {
      _cartItems.update(
          cartId,
          (oldCartItem) => CartModel(
                id: oldCartItem.id,
                title: oldCartItem.title,
                price: oldCartItem.price,
                quantity: oldCartItem.quantity + 1,
                productId: cartId,
                imgUrl: oldCartItem.imgUrl,
              ));
    }
    notifyListeners();
  }

  void decreaseQuantityCart(String cartId) {
    if (_cartItems.containsKey(cartId)) {
      if (_cartItems[cartId]!.quantity > 1) {
        _cartItems.update(
          cartId,
          (oldCartItem) => CartModel(
            id: oldCartItem.id,
            title: oldCartItem.title,
            price: oldCartItem.price,
            quantity: oldCartItem.quantity - 1,
            productId: cartId,
            imgUrl: oldCartItem.imgUrl,
          ),
        );
      }
    }

    notifyListeners();
  }

  void addItemToCart(
      String productId, dynamic price, String title, String imgUrl,
      [int? quantity = 1]) {
    if (quantity! > 0) {
      _cartItems.putIfAbsent(
        productId,
        () => CartModel(
          id: DateTime.now().toString(),
          title: title,
          price: double.parse(price),
          quantity: quantity.toDouble(),
          productId: productId,
          imgUrl: imgUrl,
        ),
      );
      notifyListeners();
      return;
    }

    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (oldCartItem) => CartModel(
                id: oldCartItem.id,
                title: oldCartItem.title,
                price: oldCartItem.price,
                quantity: oldCartItem.quantity + 1,
                productId: productId,
                imgUrl: oldCartItem.imgUrl,
              ));
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartModel(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
          productId: productId,
          imgUrl: imgUrl,
        ),
      );
    }
    notifyListeners();
  }

  void removeSingleItemFromCart(String productId) {
    if (!_cartItems.containsKey(productId)) {
      return;
    }
    if (_cartItems[productId]!.quantity > 1) {
      _cartItems.update(
        productId,
        (oldCartItem) => CartModel(
            id: oldCartItem.id,
            title: oldCartItem.title,
            price: oldCartItem.price,
            quantity: oldCartItem.quantity - 1,
            productId: productId,
            imgUrl: oldCartItem.imgUrl),
      );
    } else {
      _cartItems.remove(productId);
    }
    notifyListeners();
  }

  void removeItemsWithAllQuantity(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearAllItemsFromCart() {
    _cartItems = {};
    notifyListeners();
  }
}
