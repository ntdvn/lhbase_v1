import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        TextButton(
          onPressed: () {
            Get.find<GlobalConfigController>().fontFamily = 'Anton';
          },
          child: LhText('Almost before we knew it, we had left the ground.'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/home');
          },
          child: LhText('Login Page'),
        ),
      ],
    )));
  }
}
