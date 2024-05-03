import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  //save
  static saveStringToPref({required String key, required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static saveIntToPref({required String key, required int value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static saveBoolToPref({required String key, required bool value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static saveDoubleToPref({required String key, required double value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

//Read
  static Future<String?> getStringFromPref({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString(key);
    return stringValue;
  }

  static Future<int?> getIntFromPref({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? intValue = prefs.getInt(key);
    return intValue;
  }

  static Future<bool?> getBoolFromPref({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? boolValue = prefs.getBool(key);
    return boolValue;
  }

  static Future<double?> getDoubleFromPref({required String key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? boolValue = prefs.getDouble(key);
    return boolValue;
  }
}
