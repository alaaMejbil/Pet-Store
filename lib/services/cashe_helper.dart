import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData(
      {@required dynamic key, @required dynamic value}) async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (value is bool) {
      return await sharedPreferences!.setBool(key, value);
    }
    if (value is double) {
      return await sharedPreferences!.setDouble(key, value);
    }
    if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    }
    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    }
    return true;
  }

  static Future<String> getData({@required dynamic key}) async {
    sharedPreferences = await SharedPreferences.getInstance();
    String x = sharedPreferences!.getString(key)!;
    return x;
  }

  static Future<bool> removeData({@required dynamic key}) async {
    sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences!.remove(key);
  }
}
