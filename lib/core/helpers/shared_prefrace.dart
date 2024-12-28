import 'package:shared_preferences/shared_preferences.dart';

abstract class Pref {
  static late SharedPreferences _prefs;
   static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //boolean
  static Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  static Future<bool> getBool(String key) async {
    return await _prefs.getBool(key) ?? false;
  }

  // String
  static Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static Future<String> getString(String key) async {
    return await _prefs.getString(key) ?? '';
  }

  // Integer
  static Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  static Future<int> getInt(String key) async {
    return await _prefs.getInt(key) ?? 0;
  }

  // Double
  static Future<void> setDoube(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  static Future<double> getDouble(String key) async {
    return await _prefs.getDouble(key) ?? 0.0;
  }
}
