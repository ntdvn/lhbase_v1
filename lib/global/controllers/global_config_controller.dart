import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

class GlobalConfigController extends LhBaseController {
  @override
  void onReady() async {
    super.onReady();
    _initConfig();
  }

  changeTheme(String themeName) {
    var theme = LhStyle.getTheme(themeName: themeName);
    Get.changeTheme(theme);

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     systemNavigationBarColor: Colors.blue, // navigation bar color
    //     statusBarColor: Colors.pink, // status bar co
    //     statusBarBrightness: theme.brightness // lor
    //
    //     ));
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
