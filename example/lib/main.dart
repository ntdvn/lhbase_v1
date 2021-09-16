import 'package:flutter/material.dart';
import 'dart:async';

import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1_example/my_app.dart';

void main() {
  Initializer(initServices: () async {
    print('hehe');
  }).init(() {
    runApp(const MyApp());
  });
}
