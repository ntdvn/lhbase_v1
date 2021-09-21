import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

class GlobalConfigController extends LhBaseController {
  @override
  void onReady() async {
    super.onReady();
    _initConfig();
  }

  changeTheme(BuildContext context, String themeName) {
    Get.changeTheme(LhStyle.getTheme(themeName: themeName));

    lhSessionRepository.saveAppTheme(themeName);
  }

  _initConfig() async {
    var _themeName = await lhSessionRepository.getAppTheme();
    if (_themeName != null) {
      Get.changeTheme(LhStyle.getTheme(themeName: _themeName));
    }
  }

  changeLanguage() {
    Get.updateLocale(Locale('vi', 'VN'));
  }
}
