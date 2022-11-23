import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled15/Model/http_excaption.dart';
import 'package:untitled15/costants.dart';
import 'package:untitled15/services/cashe_helper.dart';

enum AuthMode { signUp, login }

class AuthProvider extends ChangeNotifier {
  String? _token;
  String? userId;
  DateTime? expiryDate;
  AuthMode currentAuthMode = AuthMode.login;
  bool isLoading = false;

  String? get token {
    if (_token != null &&
        expiryDate != null &&
        expiryDate!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  bool get isAuth {
    return token != null;
  }

  Future<void> authentication(
      String userName, String password, String urlSegment) async {
    isLoading = true;
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=${Constants.apiKey}';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': userName,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseData = jsonDecode(response.body);
      print(response.body);
      // error message from backend
      if (responseData['error'] != null) {
        throw responseData['error']['message'];
      }

      if (response.statusCode == 200) {
        // 1- save data in state
        _token = responseData['refreshToken'];
        userId = responseData['localId'];
        expiryDate = DateTime.now()
            .add(Duration(seconds: int.parse(responseData['expiresIn'])));

        // 2- save data in shared Preferences
        CasheHelper.putData(key: 'token', value: _token);
        CasheHelper.putData(key: 'userId', value: userId);
        CasheHelper.putData(
            key: 'expiryDate', value: expiryDate!.toIso8601String());
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print('error catch is : ${e.toString()}');
      String errorMessage =
          'Could not authenticate you. please try again later';
      print('Could not authenticate you. please try again later');
      Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          fontSize: 15.0);
      //rethrow;
    }
  }

  Future<void> login(String userName, String password) async {
    await authentication(userName, password, 'signInWithPassword');
  }

  Future<void> signUp(String userName, String password) async {
    await authentication(userName, password, 'signUp').then((value) {
      String url =
          "https://pets-store-6f3d1-default-rtdb.firebaseio.com/userFavoraties/$userId/'0'.json";
      http.put(Uri.parse(url), body: json.encode(false));
    });
  }

  Future<void> logout() async {
    // // 1- delete value in state
    _token = null;
    userId = null;
    expiryDate = null;
    //
    // // 2- delete value in shared Preference
    await CasheHelper.removeData(key: 'token');
    await CasheHelper.removeData(key: 'userId');
    await CasheHelper.removeData(key: 'expiryDate');
    notifyListeners();
    print(isAuth);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<bool> tryAutoLogin() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('token') && !pref.containsKey('expiryDate')) {
      return false;
    }

    // check expire date if valid
    if (DateTime.parse(await CasheHelper.getData(key: 'expiryDate'))
        .isBefore(DateTime.now())) {
      return false;
    }

    // read data from local storage and save them in state
    _token = await CasheHelper.getData(key: 'token');
    userId = await CasheHelper.getData(key: 'userId');
    expiryDate = DateTime.parse(await CasheHelper.getData(key: 'expiryDate'));
    notifyListeners();
    print('try auto login is finshed !!!!');
    autoLogout();

    return true;
  }

  void autoLogout() {
    final timeToExpireInSeconds =
        expiryDate!.difference(DateTime.now()).inSeconds;
    Timer(Duration(seconds: timeToExpireInSeconds), logout);
  }

  void changeAuthMode() {
    if (currentAuthMode == AuthMode.login) {
      currentAuthMode = AuthMode.signUp;
    } else {
      currentAuthMode = AuthMode.login;
    }
    notifyListeners();
  }
}
