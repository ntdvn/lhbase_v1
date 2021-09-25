import 'package:lhbase_v1/lhbase.dart';

class TestString extends LhStrings {
  TestString();

  @override
  Map<String, Map<String, String>> onConfig() {
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
