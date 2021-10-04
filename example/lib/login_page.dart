import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1/ui/widgets/lh_cached_image.dart';
import 'package:lhbase_v1_example/app_style.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LhSlidingSheetController _slidingController;

  @override
  void initState() {
    _slidingController = LhSlidingSheetController(
        minimizeHeight: 300,
        maximizeHeight: Get.height,
        onAnimatedEnded: () {
          setState(() {});
        })
      ..onStatusChanged(() {
        print('wtf');
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LhBasePage(
        statusBarBrightness: Brightness.light,
        appBarTop: LhAppBar.top(
          title: 'abc',
          titleStyle: TextStyle(color: Colors.white),
          backgroundImage: LhCachedImageWidget(
            imageUrl:
                'https://baoquocte.vn/stores/news_dataimages/dieulinh/012020/29/15/nhung-buc-anh-dep-tuyet-voi-ve-tinh-ban.jpg',
          ),
          actions: [
            LhAppBarAction.custom(
              child: Text('Thêm người dùng'),
              badge: 2,
              onTap: () {
                // Get.bottomSheet(MediaSelectPage(
                //   type: MediaSelectType.MULTIPLE,
                //   number: 10,
                // ));
                Get.bottomSheet(
                    LhBottomSheet(
                      controller: _slidingController..minimize(),
                      child: Container(
                        child: Text('abcdef'),
                      ),
                    ),
                    isScrollControlled: true,
                    ignoreSafeArea: false,
                    enableDrag: false);
              },
            ),
            LhAppBarAction.icon(
              icon: Icon(Icons.minimize),
              badge: 1,
              onTap: () {
                _slidingController.minimize();
                // setState(() {});
              },
            ),
            LhAppBarAction.icon(
              icon: Icon(Icons.maximize),
              badge: 1,
              onTap: () {
                _slidingController.toggleMaximize();
                // setState(() {});
              },
            ),
            LhAppBarAction.icon(
              icon: Icon(Icons.no_accounts),
              badge: 1,
              onTap: () {
                Get.toNamed('/home');
                Get.find<GlobalConfigController>().changeTheme('Light');
              },
            )
          ],
          titles: Column(
            children: [Text('123')],
          ),
        ),
        appBarBottom: LhAppBar.bottom(
          backgroundImage: LhCachedImageWidget(
            imageUrl:
                'https://mondaycareer.com/wp-content/uploads/2020/11/background-%C4%91%E1%BA%B9p-3-1024x682.jpg',
          ),
          actions: [
            LhAppBarAction.custom(
              child: Text('Thêm người dùng'),
              badge: 2,
              onTap: () {
                print('hahah');
              },
            ),
            LhAppBarAction.icon(
              icon: Icon(Icons.no_accounts),
              badge: 1,
              onTap: () {
                Get.toNamed('/home');
              },
            )
          ],
          titles: Column(
            children: [Text('123')],
          ),
        ),
        // appBarTop: LhAppBar.topEmpty(),
        // appBarBottom: LhAppBar.bottom(),
        // bottomSlidingPanel: LhSlidingPanel(
        //   controller: _slidingController,
        //   child: Container(),
        // ),
        child: SingleChildScrollView(
          child: Container(
            // color: Colors.blue,
            child: Center(
                child: Column(
              children: [
                ...List.generate(123, (index) => Text('hehe $index')),
                GestureDetector(
                    onTap: () {
                      Get.find<GlobalConfigController>().changeLanguage();
                    },
                    child: LhText('connectivity.no_internet'.tr)),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'connectivity.no_internet'.tr,
                  ),
                ),
              ],
            )),
          ),
        ));
  }
}
