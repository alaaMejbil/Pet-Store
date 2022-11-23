import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:untitled15/Model/PetModel.dart';
import 'package:untitled15/Model/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> allProducts = [];
  String? authToken;
  String? userId;
  bool isLoading = false;

  void getData(String? token, String? uId, List<ProductModel> allProducts) {
    this.allProducts = allProducts;
    userId = uId;
    authToken = token;

    notifyListeners();
  }

  Future<void> fetchAllProducts() async {
    const url =
        "https://pets-store-6f3d1-default-rtdb.firebaseio.com/products.json";

    String urlMyFavoritesItem =
        'https://pets-store-6f3d1-default-rtdb.firebaseio.com/userFavoraties/$userId.json';
    try {
      isLoading = true;
      // get All products
      final res = await http.get(Uri.parse(url));
      final extractData = jsonDecode(res.body);
      print(res.body);

      // get My Favorites Item
      final resFavorites = await http.get(Uri.parse(urlMyFavoritesItem));
      Map<String, dynamic> extractFavData = jsonDecode(resFavorites.body);
      List<ProductModel> tempList = [];
      extractData.forEach((productId, productItem) {
        tempList.add(ProductModel.fromJson(productItem, productId, false));
      });
      allProducts = tempList;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

// Future<void> toggleFavoriteStatus(PetModel pet) async {
//   String url =
//       'https://pets-store-6f3d1-default-rtdb.firebaseio.com/userFavoraties/$userId/${pet.id}.json';
//   // toggle favorite status in Frontend
//   final oldStatus = pet.isFavorite;
//   int itemIndex = allPets.indexWhere((element) => element.id == pet.id);
//
//   allPets[itemIndex].isFavoriteSetValue(!pet.isFavorite!);
//   notifyListeners();
//
//   // toggle favorite status in Backend
//   try {
//     final res =
//     await http.put(Uri.parse(url), body: json.encode(pet.isFavorite!));
//     if (res.statusCode >= 400) {
//       //an Error happened
//       allPets[itemIndex].isFavoriteSetValue(oldStatus!);
//     }
//   } catch (e) {
//     print(e.toString());
//     allPets[itemIndex].isFavoriteSetValue(oldStatus!);
//   }
// }

}
