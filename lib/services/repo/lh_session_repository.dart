import 'package:lhbase_v1/lhbase.dart';

class LhSessionRepository {
  Pref pref;

  LhSessionRepository({required this.pref});

  Future<String?> getFirstRun() async {
    return await pref.getString(LhbasePref.is_first_run);
  }

  Future<bool> saveFirstRun() {
    return pref.saveString(LhbasePref.is_first_run, '1');
  }

  Future<bool> saveAuthorizationToken(String token) {
    return pref.saveString(LhbasePref.auth_token, token);
  }

  Future<String?> getAuthorizationToken() async {
    return await pref.getString(LhbasePref.auth_token);
  }

  Future<bool> saveAppLanguage(String languageTag) {
    return pref.saveString(LhbasePref.language, languageTag);
  }

  Future<String?> getAppLanguage() async {
    return await pref.getString(LhbasePref.language);
  }

  Future<bool> saveAppTheme(String themeTag) {
    return pref.saveString(LhbasePref.theme, themeTag);
  }

  Future<String?> getAppTheme() async {
    return await pref.getString(LhbasePref.theme);
  }

  Future<bool> saveRememberPassword(bool isRemembered) {
    return pref.saveBool(LhbasePref.remember_password, isRemembered);
  }

  Future<bool?> getRememberPassword() async {
    return await pref.getBool(LhbasePref.remember_password);
  }
}
