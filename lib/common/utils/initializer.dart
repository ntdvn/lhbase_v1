import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

typedef InitServices = Future<void> Function();

class Initializer {
  // static final Initializer instance = Initializer._internal();
  // factory Initializer() => instance;
  // Initializer._internal();
  Initializer({InitServices? initServices});

  void init(VoidCallback runApp) {
    ErrorWidget.builder = (errorDetails) {
      // return CustomErrorWidget(
      //   message: errorDetails.exceptionAsString(),
      // );
      return Text(errorDetails.exceptionAsString());
    };

    runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (details) {
        FlutterError.dumpErrorToConsole(details);
        // printInfo(info: details.stack.toString());
      };

      await _initServices();
      runApp();
    }, (error, stack) {
      // printInfo(info: 'runZonedGuarded: ${stack.toString()}');
    });
  }

  Future<void> _initServices() async {
    try {
      await _initStorage();
      // FirebaseApp firebase = await Firebase.initializeApp();
      _initApis();
      _initLocalNotification();
      _initCloudMessaging();
    } catch (err) {
      rethrow;
    }
  }

  void _initApis() {
    // Get.put<CommonRepository>(CommonRepository(DioProvider.instance()));
    // Get.put<SessionRepository>(SessionRepository(pref: LocalPref()));
    // // Get.put<CommonRepository>(CommonRepository(Dio()));
    //
    // Get.put<CloudMessagingUtil>(CloudMessagingUtil());
  }

  Future<void> _initStorage() async {
    // await GetStorage.init();
  }

  Future<void> _initLocalNotification() async {
    // await LocalNotificationUtils().init();
  }

  Future<void> _initCloudMessaging() async {
    // Get.find<CloudMessagingUtil>().init();
    // await Get.find<CloudMessagingUtil>().init();
    // await Get.find<CloudMessagingUtil>().getToken();
  }

  void _initScreenPreference() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  //Local notification

}
