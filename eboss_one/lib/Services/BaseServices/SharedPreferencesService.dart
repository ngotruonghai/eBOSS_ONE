import 'package:shared_preferences/shared_preferences.dart';

class KeyServices{
  static String get KeyToken{
    return "Token";
  }
  static String get KeyUserID{
    return "UserID";
  }

  static String get KeyUserName{
    return "UserName";
  }
  static String get keyPassWord{
    return "PassWord";
  }
  static String get keyRefestToken{
    return "RefestToken";
  }
  static String get KeyEmployeeAID{
    return "EmployeeAID";
  }
}

class SharedPreferencesService {
  static late  SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getString(String key, {String defaultValue = ''}) =>
      _prefs.getString(key) ?? defaultValue;

  static Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  static int getInt(String key, {int defaultValue = 0}) =>
      _prefs.getInt(key) ?? defaultValue;

  static Future<bool> setInt(String key, int value) =>
      _prefs.setInt(key, value);

  static bool getBool(String key, {bool defaultValue = false}) =>
      _prefs.getBool(key) ?? defaultValue;

  static Future<bool> setBool(String key, bool value) =>
      _prefs.setBool(key, value);

  static double getDouble(String key, {double defaultValue = 0.0}) =>
      _prefs.getDouble(key) ?? defaultValue;

  static Future<bool> setDouble(String key, double value) =>
      _prefs.setDouble(key, value);

  static Future<bool> clear() => _prefs.clear();
}
