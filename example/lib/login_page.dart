import 'package:flutter/material.dart';
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
            child: TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/home');
      },
      child: Text('Home Page'),
    )));
  }
}
