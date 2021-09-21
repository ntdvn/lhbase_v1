import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ConnectivityController());

    Get.put(AuthenticationController());
  }
}
