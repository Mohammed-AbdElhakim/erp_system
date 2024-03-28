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

  // static Future<bool> saveImage({
  //   required String key,
  //   required String link,
  // }) async {
  //   http.Response response = await http.get(Uri.https(link));
  //
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (response.statusCode == 200) {
  //     String base64Image = base64Encode(response.bodyBytes);
  //     return prefs.setString(key, base64Image);
  //   } else {
  //     return prefs.setString(key, '');
  //   }
  // }
  //
  // static Future<Uint8List> getImage({required String key}) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   Uint8List bytes = base64Decode(prefs.getString(key) ?? "");
  //   return bytes;
  // }
}
