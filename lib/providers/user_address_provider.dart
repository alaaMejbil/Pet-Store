import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:untitled15/Model/address_model.dart';
import 'package:http/http.dart' as http;

class UserAddressProvider extends ChangeNotifier {
  List<AddressModel> userAddresses = [];

  String? authToken;
  String? userId;
  bool isLoading = false;
  int currentUserAddress = 0;

  void getData(String? token, String? uId, List<AddressModel> userAddresses) {
    this.userAddresses = userAddresses;
    userId = uId;
    authToken = token;

    notifyListeners();
  }

  AddressModel get destinationAddress {
    return userAddresses[currentUserAddress];
  }

  Future<void> getUserAddresses() async {
    final url =
        "https://pets-store-6f3d1-default-rtdb.firebaseio.com/userAddress/$userId.json";

    try {
//      isLoading = true;
      //    notifyListeners();

      // get All Addresses
      final res = await http.get(Uri.parse(url));
      Map<String, dynamic> extractData = jsonDecode(res.body);
      print(res.body);

      List<AddressModel> tempList = [];
      extractData.forEach((addressId, addressData) {
        tempList.add(AddressModel.fromJson(addressData));
      });
      userAddresses = tempList;
      //  isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addNewAddress(AddressModel newAddress) async {
    String url =
        "https://pets-store-6f3d1-default-rtdb.firebaseio.com/userAddress/$userId.json";

    try {
      isLoading = true;
      notifyListeners();

      // add to firebase
      final res = await http
          .post(Uri.parse(url),
              body: jsonEncode({
                "address": newAddress.address,
                "city": newAddress.city,
                "phoneNumber": newAddress.phoneNumber,
                "userName": newAddress.userName,
                "zip": newAddress.zip,
              }))
          .then((response) {
        //add to state array
        userAddresses.add(AddressModel(
          address: newAddress.address,
          city: newAddress.city,
          phoneNumber: newAddress.phoneNumber,
          userName: newAddress.userName,
          zip: newAddress.zip,
        ));

        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }
}
