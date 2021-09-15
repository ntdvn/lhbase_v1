import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1_example/test_string.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GestureDetector(
              onTap: () {},
              child: Wrap(
                children: [
                  Text('namloz'.tr),
                  Text('api.notification'.tr),
                  Text('')
                ],
              ))),
    );
  }
}
