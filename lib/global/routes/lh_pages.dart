import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

part 'lh_routes.dart';

class LhPages extends ILhPages implements ILhPagesConfiguration {
  LhPages();

  static const splash = LhRoutes.no_internet;

  @override
  List<GetPage> get routes {
    return [
      ...onConfig([]),
      GetPage(
        name: LhRoutes.no_internet,
        page: () => const LhNoInternetPage(),
        transition: Transition.cupertinoDialog,
      ),
    ];
  }

  @override
  List<GetPage> onConfig(List<GetPage> getPages) {
    return getPages;
  }
}
