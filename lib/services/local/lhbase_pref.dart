import 'package:shared_preferences/shared_preferences.dart';

class LhbasePref extends Pref {
  static const String auth_token = "auth_token";
  static const String language = "app_language";
  static const String theme = "app_theme";
  static const String is_first_run = "is_first_run";
  static const String remember_password = "remember_password";
  @override
  Future<bool> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }
  @override
  Future<bool> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
  @override
  Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key.toString());
  }
}

class MemoryPref extends Pref {
  Map<String, Object> memoryMap = new Map<String, Object>();

  @override
  Future<String?> getString(String key) {
    return Future.value(memoryMap[key].toString());
  }
  @override
  Future<bool?> getBool(String key) {
    return Future.value(memoryMap[key] as bool);
  }

  @override
  Future<bool> saveString(String key, String value) async {
    memoryMap[key] = value;
    return Future.value(true);
  }
  @override
  Future<bool> saveBool(String key, bool value) async {
    memoryMap[key] = value;
    return Future.value(true);
  }
}

abstract class Pref {
  Future<bool> saveString(String key, String value);
  Future<bool> saveBool(String key, bool value);

  Future<String?> getString(String key);
  Future<bool?> getBool(String key);
}
