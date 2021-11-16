import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1_example/my_app.dart';

void main() {
  Initializer(initServices: () async {
    // print('hehe');
    // Get.put<dynamic>(LhCommonRepository(DioProvider.instance()),
    //     tag: 'commonRepository');
  }).init(() {
    runApp(const MyApp());
  });
}
