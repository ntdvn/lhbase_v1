import 'package:get/get.dart';

import 'app_pages.dart';

class AppNavigator {
  AppNavigator._();

  static navigateBack() async => Get.back();
  static navigateExamples() async => await Get.toNamed(Routes.examples);
  static navigateStoryView() async => await Get.toNamed(Routes.story_view);
  static navigateVideoPlayBack() async =>
      await Get.toNamed(Routes.video_play_back);
}
