
import 'dart:async';

import 'package:flutter/services.dart';

class LhbaseV1 {
  static const MethodChannel _channel = MethodChannel('lhbase_v1');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
