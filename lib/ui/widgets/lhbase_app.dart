import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhBaseApp extends StatelessWidget implements LhBaseAppConfig {
  const LhBaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(fontFamily: 'OpenSans'),
      translations: onConfig(LhAppConfiguration()).translations,
      locale: onConfig(LhAppConfiguration()).locale,
      supportedLocales: onConfig(LhAppConfiguration()).supportedLocales ?? [],
      initialRoute: onConfig(LhAppConfiguration()).initialRoute,
      getPages: onConfig(LhAppConfiguration()).getPages,
      initialBinding: onConfig(LhAppConfiguration()).initialBinding,
      home: onConfig(LhAppConfiguration()).home,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }

  @override
  LhAppConfiguration onConfig(LhAppConfiguration config) {
    return config;
  }
}

abstract class LhBaseAppConfig {
  LhAppConfiguration onConfig(LhAppConfiguration config);
}
