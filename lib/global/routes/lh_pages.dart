import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

part 'lh_routes.dart';

abstract class LhPages extends ILhPages {
  LhPages();

  List<GetPage> onConfig();

  static const splash = LhRoutes.no_internet;

  @override
  List<GetPage> get routes {
    return [
      ...onConfig(),
      GetPage(
        name: LhRoutes.no_internet,
        page: () => const LhNoInternetPage(),
        transition: Transition.cupertinoDialog,
      ),
    ];
  }
}
