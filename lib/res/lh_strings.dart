import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhStrings extends Translations implements LhStringsConfig {
  LhStrings();

  Map<String, Map<String, String>> _config = {};

  static const content_type = 'Content-Type';
  static const multipart_form_data = 'multipart/form-data';
  static const application_json = 'application/json; charset=utf-8';
  static String appName = '';
  @override
  Map<String, Map<String, String>> get keys {
    Map<String, Map<String, String>> translate = {
      'en_US': {
        'api.notification': 'Notification',
        'api.success': 'Success',
        'api.failed': 'Failure',
        'connectivity.oops': 'Oops!',
        'connectivity.no_internet': 'There is no Internet connection',
        'connectivity.check': 'Please check your Internet connection',
        'connectivity.try_again': 'Try again',
      },
      'vi_VN': {
        'api.notification': 'Thông báo',
        'api.success': 'Thành công',
        'api.failed': 'Thất bại',
        'connectivity.oops': 'Oops!',
        'connectivity.no_internet': 'Hiện không có kết nối Internet',
        'connectivity.check': 'Vui lòng kiểm tra lại kết nối Internet của bạn',
        'connectivity.try_again': 'Thử lại',
      },
    };

    _config = onConfig({});

    translate.keys.forEach((tk) {
      _config.keys.forEach((ck) {
        if (tk == ck) {
          translate[tk]!.addAll(_config[ck]!);
        }
      });
    });

    return translate;
  }

  @override
  Map<String, Map<String, String>> onConfig(
      Map<String, Map<String, String>> strings) {
    return strings;
  }
}
