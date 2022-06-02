import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1_example/ui/pages/chat_room_page.dart';
import 'package:lhbase_v1_example/ui/pages/pages.dart';

part 'app_routes.dart';

class AppPages extends LhPages {
  AppPages();

  @override
  List<GetPage> onConfig() {
    return [
      GetPage(name: Routes.examples, page: () => const ExamplesPage()),
      GetPage(name: Routes.alpha, page: () => const AlphaPage()),
      GetPage(name: Routes.story_view, page: () => const StoryViewPage()),
      GetPage(
          name: Routes.video_play_back, page: () => const VideoPlayBackPage()),
      GetPage(name: Routes.media, page: () => const MediaPage()),
      GetPage(name: Routes.chat, page: () => const ChatRoomPage()),
    ];
  }
}
