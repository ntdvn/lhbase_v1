import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return LhBasePage(
        appBarTop: LhAppBar.top(
          titles: Text('123'),
        ),
        child: Center(
            child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              child: LhText('Login Page'),
            ),
          ],
        )));
  }
}
