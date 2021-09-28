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
  @override
  void initState() {
    print('_LoginPageState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LhBasePage(
        appBarTop: LhAppBar.top(
          title: 'abc',
          titleStyle: TextStyle(color: Colors.white),
          backgroundImage: LhCachedImageWidget(
            imageUrl:
                'https://mondaycareer.com/wp-content/uploads/2020/11/background-%C4%91%E1%BA%B9p-3-1024x682.jpg',
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
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Get.back();
                      },
                      child: GestureDetector(
                        onTap: () {},
                        child: DraggableScrollableSheet(
                          initialChildSize: 0.5, // half screen on load
                          maxChildSize: 1, // full screen on scroll
                          minChildSize: 0.5,
                          expand: true,
                          builder: (context, scrollController) {
                            // scrollController.

                            return LhBottomSheet(
                              title: "Title",
                              child: ListView(
                                // controller: scrollController,
                                children: [],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    isScrollControlled: true,
                    ignoreSafeArea: false);
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
        child: Center(
            child: Column(
          children: [
            ...List.generate(
                AppStyle().getSupportedThemes().length,
                (index) => TextButton(
                    onPressed: () {
                      Get.find<GlobalConfigController>().changeTheme(
                          LhStyle.supportedThemes.keys.elementAt(index));
                    },
                    child:
                        Text(LhStyle.supportedThemes.keys.elementAt(index)))),
            GestureDetector(
                onTap: () {
                  Get.find<GlobalConfigController>().changeLanguage();
                },
                child: LhText('connectivity.no_internet'.tr)),
            TextField(
              decoration: InputDecoration(
                hintText: 'connectivity.no_internet'.tr,
              ),
            )
          ],
        )));
  }
}
