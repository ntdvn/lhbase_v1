import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

class AppStyle extends LhStyle {
  @override
  Map<String, ThemeData> onConfigSupportedThemes() {
    return {
      'Light': ThemeData.light(),
      'Dark': ThemeData.dark(),
    };
  }
}
