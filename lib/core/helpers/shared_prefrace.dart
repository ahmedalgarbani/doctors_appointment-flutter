import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Pref {
  static late SharedPreferences _prefs;
  static final storage = FlutterSecureStorage();
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

  // save Access Token

  static Future<void> setAccessToken(String key, value) async {
    await storage.write(key: key, value: value);
  }

  static Future<void> setRefreshToken(String key, value) async {
    await storage.write(key: key, value: value);
  }

  static Future<String> getAccessToken(String key) async {
    return await storage.read(key: key) ?? '';
  }

  static Future<String> getRefreshToken(String key) async {
    return await storage.read(key: key) ?? '';
  }
  // device id

  static Future<void> saveDeviceId(
      {required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  static Future<String?> loadDeviceId(String key) async {
    return await storage.read(key: key) ?? '';
  }

  // Remove
  static Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  // Remove Secure
  static Future<void> removeSecure(String key) async {
    await storage.delete(key: key);
    (key);
  }
}
