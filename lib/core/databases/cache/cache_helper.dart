import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({required String key}) {
    return _sharedPreferences.get(key);
  }

  static String? getDataString({required String key}) {
    return _sharedPreferences.getString(key);
  }

  static bool? getBool({required String key}) {
    return _sharedPreferences.getBool(key);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await _sharedPreferences.setString(key, value);
    if (value is int) return await _sharedPreferences.setInt(key, value);
    if (value is bool) return await _sharedPreferences.setBool(key, value);
    if (value is double) return await _sharedPreferences.setDouble(key, value);
    if (value is List<String>)
      return await _sharedPreferences.setStringList(key, value);
    return false;
  }

  static bool containsKey({required String key}) {
    return _sharedPreferences.containsKey(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await _sharedPreferences.remove(key);
  }

  static Future<bool> clearData() async {
    return await _sharedPreferences.clear();
  }
}
