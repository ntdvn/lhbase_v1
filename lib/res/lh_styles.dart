import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

import 'res.dart';

abstract class LhStyle {
  LhStyle();

  static const DEFAULT_10 = TextStyle(
      fontSize: LhValue.FONT_SIZE_10, color: LhColors.BLACK, height: 1.4, fontWeight: FontWeight.normal);

  static const DEFAULT_12 = TextStyle(
      fontSize: LhValue.FONT_SIZE_12, color: LhColors.BLACK, height: 1.4, fontWeight: FontWeight.normal);

  static const DEFAULT_14 = TextStyle(
      fontSize: LhValue.FONT_SIZE_14, color: LhColors.BLACK, height: 1.4, fontWeight: FontWeight.normal);

  static const DEFAULT_16 = TextStyle(
      fontSize: LhValue.FONT_SIZE_16, color: LhColors.BLACK, height: 1.4, fontWeight: FontWeight.normal);

  static const DEFAULT_18 = TextStyle(
      fontSize: LhValue.FONT_SIZE_18, color: LhColors.BLACK, height: 1.4, fontWeight: FontWeight.normal);

  static const DEFAULT_20 = TextStyle(
      fontSize: LhValue.FONT_SIZE_20, color: LhColors.BLACK, height: 1.4, fontWeight: FontWeight.normal);
  static const DEFAULT_22 = TextStyle(
      fontSize: LhValue.FONT_SIZE_22, color: LhColors.BLACK, height: 1.4, fontWeight: FontWeight.normal);
  static const DEFAULT_24 = TextStyle(
      fontSize: LhValue.FONT_SIZE_24, color: LhColors.BLACK, height: 1.4, fontWeight: FontWeight.normal);

  // ignore: non_constant_identifier_names
  static final DEFAULT_10_BOLD =
      DEFAULT_10.copyWith(fontWeight: FontWeight.bold);
  // ignore: non_constant_identifier_names
  static final DEFAULT_12_BOLD =
      DEFAULT_12.copyWith(fontWeight: FontWeight.bold);
  // ignore: non_constant_identifier_names
  static final DEFAULT_14_BOLD =
      DEFAULT_14.copyWith(fontWeight: FontWeight.bold);
  // ignore: non_constant_identifier_names
  static final DEFAULT_16_BOLD =
      DEFAULT_16.copyWith(fontWeight: FontWeight.bold);
  // ignore: non_constant_identifier_names
  static final DEFAULT_18_BOLD =
      DEFAULT_18.copyWith(fontWeight: FontWeight.bold);
  // ignore: non_constant_identifier_names
  static final DEFAULT_20_BOLD =
      DEFAULT_20.copyWith(fontWeight: FontWeight.bold);
  // ignore: non_constant_identifier_names
  static final DEFAULT_22_BOLD =
      DEFAULT_20.copyWith(fontWeight: FontWeight.bold);
  // ignore: non_constant_identifier_names
  static final DEFAULT_24_BOLD =
      DEFAULT_24.copyWith(fontWeight: FontWeight.bold);

  Map<String, ThemeData> onConfigSupportedThemes();

  Map<String, ThemeData> getSupportedThemes() {
    var themes = supportedThemes;
    themes.addAll(onConfigSupportedThemes());
    return themes;
  }

  static Map<String, ThemeData> supportedThemes = {
    'Light': ThemeData.light(),
    'Dark': ThemeData.dark(),
    'Anton': DataUtils.getGoogleThemeData('Anton'),
    'Inter': DataUtils.getGoogleThemeData('Inter'),
    'custom1': ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.dark,
      primaryColor: Colors.lightBlue[800],

      // Define the default font family.
      fontFamily: 'Georgia',

      // Define the default `TextTheme`. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    ),
  };
  // ignore: non_constant_identifier_names

  static ThemeData getTheme({String? themeName}) {
    var defaultTheme = ThemeData.light();
    // var theme = themes as Map<String, ThemeData>;
    // print('ThemeData ${theme[themeName]}');
    return supportedThemes[themeName] ?? defaultTheme;
  }
}
