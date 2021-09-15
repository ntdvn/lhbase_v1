import 'package:shared_preferences/shared_preferences.dart';

class LhbasePref extends Pref {
  static const String AUTH_TOKEN = "auth_token";
  static const String LANGUAGE = "app_language";
  static const String THEME = "app_theme";
  static const String IS_FIRST_RUN = "is_first_run";
  static const String REMEMEBER_PASSWORD = "remember_password";
  @override
  Future<bool> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}

class MemoryPref extends Pref {
  Map<String, Object> memoryMap = new Map<String, Object>();

  @override
  Future<String?> getString(String key) {
    return Future.value(memoryMap[key].toString());
  }

  @override
  Future<bool> saveString(String key, String value) async {
    memoryMap[key] = value;
    return Future.value(true);
  }
}

abstract class Pref {
  Future<bool> saveString(String key, String value);

  Future<String?> getString(String key);
}
