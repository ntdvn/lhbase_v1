import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1_example/app_binding.dart';
import 'package:lhbase_v1_example/app_pages.dart';
import 'package:lhbase_v1_example/test_string.dart';

class MyApp extends LhBaseApp {
  const MyApp({Key? key}) : super(key: key);

  @override
  LhAppConfiguration onConfig() {
    return LhAppConfiguration(
        title: 'nam loading',
        // locale: Locale('vi', 'VN'),
        locale: Locale('en', 'US'),
        supportedLocales: [Locale('vi', 'VN')],
        translations: TestString(),
        initialBinding: AppBinding(),
        initialRoute: '/login',
        getPages: AppPages().routes);
  }
}
