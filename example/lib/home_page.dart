import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        _videoPlayerController.play();
        setState(() {});
      });
    super.initState();
  }

  Future<bool> _onBackButtonTap() async {
    return await ComponentUtils.showConfirmDialog(
        context,
        'form_validate.dialog_back_title'.tr,
        'form_validate.dialog_back_message'.tr,
        negativeTitle: 'form_validate.dialog_back_negative'.tr,
        positiveTitle: 'form_validate.dialog_back_positive'.tr,
        negativeStyle: LhStyle.DEFAULT_14.copyWith(color: Colors.green),
        positiveStyle: LhStyle.DEFAULT_14.copyWith(color: Colors.red),
        positiveTap: () {});
  }

  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return LhBasePage(
      onWillPop: _onBackButtonTap,
      statusBarBrightness: Brightness.dark,
      appBarTop: LhAppBar.topEmpty(
        backgroundColor: Colors.transparent,
      ),
      // appBarTop: LhAppBar.top(
      //   leadingOnTap: _onBackButtonTap,
      //   title: 'abc',
      //   titleStyle: TextStyle(color: Colors.white),
      //   actions: [
      //     LhAppBarAction.icon(
      //       icon: Icon(Icons.light),
      //       badge: 1,
      //       onTap: () {
      //         // ComponentUtils.setStatusBarStyle(
      //         //     brightness: Brightness.light,
      //         //     statusBarIconBrightness: Brightness.light,
      //         //     systemNavigationBarColor: Colors.grey.withOpacity(0.2),
      //         //     statusBarColor: Colors.transparent,
      //         //     systemNavigationBarDividerColor: Colors.transparent);
      //         // Get.changeTheme(ThemeData.light());
      //         ComponentUtils.setStatusBarBrightness(Brightness.light);
      //       },
      //     ),
      //     LhAppBarAction.icon(
      //       icon: Icon(Icons.dark_mode),
      //       badge: 1,
      //       onTap: () {
      //         // ComponentUtils.setStatusBarStyle(
      //         //   brightness: Brightness.dark,
      //         //   statusBarIconBrightness: Brightness.dark,
      //         //   systemNavigationBarColor: Colors.grey.withOpacity(0.2),
      //         //   statusBarColor: Colors.transparent,
      //         //   // systemNavigationBarDividerColor: Colors.pink
      //         // );
      //         // Get.changeTheme(ThemeData.dark());
      //         ComponentUtils.setStatusBarBrightness(Brightness.dark);
      //       },
      //     ),
      //     LhAppBarAction.icon(
      //       icon: Icon(Icons.no_accounts),
      //       badge: 1,
      //       onTap: () {
      //         Get.changeTheme(ThemeData.dark().copyWith(
      //             appBarTheme: AppBarTheme(
      //                 systemOverlayStyle: SystemUiOverlayStyle.dark)));
      //         // Get.find<GlobalConfigController>().changeTheme('Dark');
      //       },
      //     ),
      //     LhAppBarAction.icon(
      //       icon: Icon(Icons.no_accounts),
      //       badge: 1,
      //       onTap: () {
      //         Get.changeTheme(ThemeData.dark().copyWith(
      //             appBarTheme: AppBarTheme(
      //                 systemOverlayStyle: SystemUiOverlayStyle.light)));
      //         // Get.find<GlobalConfigController>().changeTheme('Light');
      //       },
      //     )
      //   ],
      // ),
      child: Container(
        // color: Colors.red,
        child: Container(
            width: double.infinity,
            height: 300,
            child: LhVideoPlayer(
              videoPlayerController: _videoPlayerController,
            )),
      ),
    );
  }

  Widget _renderSearchTextField() {
    return Container(
        color: Colors.blue,
        child: LhInputSearch(
          controller: controller,
          // hint: 'chat_main.search'.tr,
        ));
  }
}
