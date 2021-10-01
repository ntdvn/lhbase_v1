import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    print('_HomePageState');
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
        positiveTap: () {
      Get.back();
    });
  }

  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return LhBasePage(
      onWillPop: _onBackButtonTap,
      statusBarBrightness: Brightness.dark,
      appBarTop: LhAppBar.top(
        leadingOnTap: _onBackButtonTap,
        title: 'abc',
        titleStyle: TextStyle(color: Colors.white),
        actions: [
          LhAppBarAction.icon(
            icon: Icon(Icons.light),
            badge: 1,
            onTap: () {
              // ComponentUtils.setStatusBarStyle(
              //     brightness: Brightness.light,
              //     statusBarIconBrightness: Brightness.light,
              //     systemNavigationBarColor: Colors.grey.withOpacity(0.2),
              //     statusBarColor: Colors.transparent,
              //     systemNavigationBarDividerColor: Colors.transparent);
              // Get.changeTheme(ThemeData.light());
              ComponentUtils.setStatusBarBrightness(Brightness.light);
            },
          ),
          LhAppBarAction.icon(
            icon: Icon(Icons.dark_mode),
            badge: 1,
            onTap: () {
              // ComponentUtils.setStatusBarStyle(
              //   brightness: Brightness.dark,
              //   statusBarIconBrightness: Brightness.dark,
              //   systemNavigationBarColor: Colors.grey.withOpacity(0.2),
              //   statusBarColor: Colors.transparent,
              //   // systemNavigationBarDividerColor: Colors.pink
              // );
              // Get.changeTheme(ThemeData.dark());
              ComponentUtils.setStatusBarBrightness(Brightness.dark);
            },
          ),
          LhAppBarAction.icon(
            icon: Icon(Icons.no_accounts),
            badge: 1,
            onTap: () {
              Get.changeTheme(ThemeData.dark().copyWith(
                  appBarTheme: AppBarTheme(
                      systemOverlayStyle: SystemUiOverlayStyle.dark)));
              // Get.find<GlobalConfigController>().changeTheme('Dark');
            },
          ),
          LhAppBarAction.icon(
            icon: Icon(Icons.no_accounts),
            badge: 1,
            onTap: () {
              Get.changeTheme(ThemeData.dark().copyWith(
                  appBarTheme: AppBarTheme(
                      systemOverlayStyle: SystemUiOverlayStyle.light)));
              // Get.find<GlobalConfigController>().changeTheme('Light');
            },
          )
        ],
      ),
      child: Container(
        color: Colors.red,
        child: Center(
            child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              child: LhText('Login Page'),
            ),
            _renderSearchTextField(),
            Container(
              // height: 115,
              // width: 115,
              child: LhAvatar(
                  borderWidth: 1,
                  onDelete: () {
                    print('onDelete');
                  },
                  onEdit: () {
                    print('onEdit');
                  },
                  height: 120,
                  width: 120,
                  isOnline: true,
                  imageUrl:
                      'https://i.pinimg.com/736x/70/ed/da/70edda522b0e5673b231dad1b425b904.jpg'),
            )
          ],
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
