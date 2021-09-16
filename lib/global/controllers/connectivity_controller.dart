import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/global/global.dart';
import 'package:lhbase_v1/global/routes/lh_pages.dart';
import 'package:lhbase_v1/lhbase.dart';

class ConnectivityController extends GetxController {
  //this variable 0 = No Internet, 1 = connected to WIFI ,2 = connected to Mobile Data.
  int connectionType = 0;
  //Instance of Flutter Connectivity
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;
  String previous2NoInternetRoute = '';
  String previous1NoInternetRoute = '';

  @override
  void onInit() {
    getConnectionType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
    super.onInit();
  }

  // a method to get which connection result, if you we connected to internet or no if yes then which network
  Future<void> getConnectionType() async {
    var connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      print(e);
    }
    return _updateState(connectivityResult);
  }

  // state update, of network, if you are connected to WIFI connectionType will get set to 1,
  // and update the state to the consumer of that variable.
  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType = 1;
        update();
        onInternetReturned();
        break;
      case ConnectivityResult.mobile:
        connectionType = 2;
        update();
        onInternetReturned();
        break;
      case ConnectivityResult.none:
        previous2NoInternetRoute = Get.previousRoute;
        previous1NoInternetRoute = Get.currentRoute;
        Get.toNamed(LhRoutes.no_internet);
        connectionType = 0;
        update();
        break;
      default:
        Get.snackbar('Network Error', 'Failed to get Network Status');
        break;
    }
  }

  onInternetReturned() {
    if (Get.currentRoute == LhRoutes.no_internet) {
      Get.offNamedUntil(previous1NoInternetRoute, (Route<dynamic> route) {
        print('route ${route.settings.name}');
        if (route.settings.name == previous2NoInternetRoute) {
          return true;
        }
        return false;
      });
      // Get.toNamed(Get.previousRoute);
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}
