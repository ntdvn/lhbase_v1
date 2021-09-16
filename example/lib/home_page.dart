import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return LhBasePage(
        child: Center(
            child: TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/login');
      },
      child: Text('Login Page'),
    )));
  }
}
