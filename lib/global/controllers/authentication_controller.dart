import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

class AuthenticationController extends LhBaseController {
  RxBool _isLoggedIn = RxBool(false);

  @override
  void onReady() async {
    super.onReady();
  }

  set isLoggedIn(bool isLoggedIn) {
    _isLoggedIn.value = false;
  }

  bool get weight => _isLoggedIn.value;

  performedLoggedIn(String accessToken, {String? navigateRoute}) {
    _isLoggedIn.value = true;
    lhSessionRepository.saveAuthorizationToken(accessToken);
    if (navigateRoute != null) Get.offAllNamed(navigateRoute);
  }

  performedLoggedOut({String? navigateRoute}) {
    _isLoggedIn.value = false;
    lhSessionRepository.saveAuthorizationToken('');
    if (navigateRoute != null) Get.offAllNamed(navigateRoute);
  }
}
