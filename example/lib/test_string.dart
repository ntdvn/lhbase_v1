import 'package:lhbase_v1/lhbase.dart';

class TestString extends LhStrings {
  TestString();

  @override
  Map<String, Map<String, String>> onConfig(
      Map<String, Map<String, String>> strings) {
    return {
      'en_US': {
        'namloz': 'tieng anh ne',
      },
      'vi_VN': {
        'namloz': 'tieng viet',
      }
    };
  }
}
