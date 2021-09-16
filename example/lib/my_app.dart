import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1_example/app_binding.dart';
import 'package:lhbase_v1_example/home_page.dart';
import 'package:lhbase_v1_example/login_page.dart';
import 'package:lhbase_v1_example/test_string.dart';
import 'package:get/get.dart';

class MyApp extends LhBaseApp {
  const MyApp({Key? key}) : super(key: key);

  @override
  LhAppConfiguration onConfig(LhAppConfiguration config) {
    return LhAppConfiguration(
        title: 'namloz',
        // locale: Locale('vi', 'VN'),
        locale: Locale('en', 'US'),
        supportedLocales: [Locale('vi', 'VN')],
        translations: TestString(),
        initialBinding: AppBinding(),
        initialRoute: '/home',
        getPages: [
          GetPage(
            name: '/login',
            page: () => LoginPage(),
            middlewares: [GlobalMiddleware()],
          ),
          GetPage(
            name: '/home',
            page: () => HomePage(),
            middlewares: [GlobalMiddleware()],
          ),
        ]);
  }
}
