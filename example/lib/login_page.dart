import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lhbase_v1/lhbase.dart';
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
        appBarTop: LhAppBarTop(
          leading: LhAppBarAction(
            child: Text(
              'abc',
            ),
          ),
        ),
        child: Center(
            child: Column(
          children: [
            ...List.generate(
                AppStyle().getSupportedThemes().length,
                (index) => TextButton(
                    onPressed: () {
                      // Get.find<GlobalConfigController>().changeTheme(
                      //     LhStyle.supportedThemes.keys.elementAt(index));
                      ComponentUtils.showCupertinoDatePicker(context,
                          onSubmitted: (value) {
                        print(value);
                      },
                          onDelete: () {},
                          initialDateTime: DateTime(
                            1998,
                            03,
                            13,
                          ),
                          minimumDate: DateTime(
                            1997,
                            03,
                            13,
                          ),
                          maximumDate: DateTime(
                            2000,
                            03,
                            13,
                          ));
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
