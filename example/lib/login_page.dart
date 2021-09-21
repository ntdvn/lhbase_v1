import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lhbase_v1/lhbase.dart';

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
        child: Center(
            child: Column(
      children: [
        ...List.generate(
            LhStyle.supportedThemes.keys.length,
            (index) => TextButton(
                onPressed: () {
                  Get.find<GlobalConfigController>().changeTheme(
                      context, LhStyle.supportedThemes.keys.elementAt(index));
                },
                child: Text(LhStyle.supportedThemes.keys.elementAt(index)))),
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
