import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1_example/home_page.dart';
import 'package:lhbase_v1_example/login_page.dart';

class AppPages extends LhPages {
  AppPages();

  static const initial = '/login';
  static const login = '/login';

  @override
  List<GetPage> onConfig() {
    return [
      GetPage(name: '/login', page: () => const LoginPage()),
      GetPage(name: '/home', page: () => const HomePage()),
    ];
  }
}
