import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

typedef InitServices = Future<void> Function();

class Initializer {
  // static final Initializer instance = Initializer._internal();
  // factory Initializer() => instance;
  // Initializer._internal();
  final InitServices initServices;
  Initializer({required this.initServices});

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
      _initScreenPreference();
      await initServices();
      await _initLhBaseServices();
      runApp();
    }, (error, stack) {
      // printInfo(info: 'runZonedGuarded: ${stack.toString()}');
    });
  }

  Future<void> _initLhBaseServices() async {
    try {
      await _initStorage();
      // FirebaseApp firebase = await Firebase.initializeApp();
      _initRepos();
      _initLocalNotification();
      _initCloudMessaging();
    } catch (err) {
      rethrow;
    }
  }

  void _initRepos() {
    Get.put<LhSessionRepository>(LhSessionRepository(pref: LhbasePref()));
    Get.put(WebServiceStateController());
    Get.put(GlobalConfigController());
    // Get.put(GlobalConfigController());
    // Get.put<CommonRepository>(CommonRepository(DioProvider.instance()));

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
