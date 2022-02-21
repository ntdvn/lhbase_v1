import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class WebServiceStateController extends GetxController {
  RxDouble networkProgress = RxDouble(0.0);
  RxInt loading = RxInt(0);

  setNetworkProgress(num progress) {
    networkProgress.value = progress.toDouble();
  }

  pushLoading() {
    loading.value++;
    print('pushLoading ${loading.value}');
    if (isLoading() && Get.isDialogOpen != true) {
      // Get.dialog(Container(
      //   color: Colors.transparent,
      //   child: GestureDetector(
      //     onTap: () {},
      //     child: Center(child: CircularProgressIndicator()),
      //   ),
      // ));
      Get.dialog(Container(
        height: 20,
        width: 20,
        child: Lottie.asset(
          'assets/lotties/8311-loading.json',
        ),
      ));
    }
  }

  popLoading() {
    loading.value > 0 ? loading.value-- : loading.value = 0;
    if (!this.isLoading() && Get.isDialogOpen == true) {
      Get.back();
    }
    print('popLoading ${loading.value}');
  }

  bool isLoading() {
    return loading.value > 0;
  }
}
