import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'dart:ui' as ui;

abstract class LhBaseApp extends StatefulWidget {
  const LhBaseApp({Key? key}) : super(key: key);

  @override
  _LhBaseAppState createState() => _LhBaseAppState();

  LhAppConfiguration onConfig();
}

class _LhBaseAppState extends State<LhBaseApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(414, 890),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: widget.onConfig().title ?? '',
            translations: widget.onConfig().translations,
            locale: widget.onConfig().locale,
            supportedLocales: widget.onConfig().supportedLocales ?? [],
            initialRoute: widget.onConfig().initialRoute,
            getPages: widget.onConfig().getPages,
            initialBinding: widget.onConfig().initialBinding,
            home: widget.onConfig().home,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        });
  }
}
