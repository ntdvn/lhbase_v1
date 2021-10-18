import 'package:lhbase_v1/lhbase.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1_example/login_controller.dart';

class AppBinding extends LhBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.put(LoginController());
  }
}
