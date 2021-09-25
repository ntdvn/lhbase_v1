import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

abstract class LhBaseApp extends StatelessWidget {
  const LhBaseApp({Key? key}) : super(key: key);

  LhAppConfiguration onConfig();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(fontFamily: 'OpenSans'),

      translations: onConfig().translations,
      locale: onConfig().locale,
      supportedLocales: onConfig().supportedLocales ?? [],
      initialRoute: onConfig().initialRoute,
      getPages: onConfig().getPages,
      initialBinding: onConfig().initialBinding,
      home: onConfig().home,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
