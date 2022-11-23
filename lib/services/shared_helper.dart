import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedMethod {
  static String token = "token";

  static Future<bool> saveUserToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', token);
  }

  //
  //
  //  get data
  //
  //

  static getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(token);
  }
}
