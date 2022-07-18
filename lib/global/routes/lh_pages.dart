import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

part 'lh_routes.dart';

abstract class LhPages extends ILhPages {
  LhPages();

  List<GetPage> onConfig();

  static const splash = LhRoutes.no_internet;
  static const play_video_online_screen = LhRoutes.play_video_online_screen;

  @override
  List<GetPage> get routes {
    return [
      ...onConfig(),
      GetPage(
        name: LhRoutes.no_internet,
        page: () => const LhNoInternetPage(),
        transition: Transition.cupertinoDialog,
      ),
      GetPage(
        name: LhRoutes.play_video_online_screen,
        page: () => PlayVideoOnlineBackScreen(),
        transition: Transition.cupertinoDialog,
      ),
    ];
  }
}
