import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DataUtils {
  static fromHHMMSStoHHMM(String input) {
    var date = DateFormat('HH:mm').parse(input);
    return DateFormat('kk:mm').format(date);
  }

  static num moneyFormatToNum(String input, String moneyUnit) {
    if (input.isNotEmpty) {
      return num.parse(input
          .replaceAll(moneyUnit, '')
          .replaceAll('.', '')
          .replaceAll(',', ''));
    }
    return 0;
  }

  static ThemeData getGoogleThemeData(String fontFamily) {
    return ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.dark,
      primaryColor: Colors.lightBlue[800],

      // Define the default font family.
      fontFamily: 'Georgia',

      // Define the default `TextTheme`. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: TextTheme(
        headline1: GoogleFonts.getFont(fontFamily),
        headline2: GoogleFonts.getFont(fontFamily),
        headline3: GoogleFonts.getFont(fontFamily),
        headline4: GoogleFonts.getFont(fontFamily),
        headline5: GoogleFonts.getFont(fontFamily),
        headline6: GoogleFonts.getFont(fontFamily),
        subtitle1: GoogleFonts.getFont(fontFamily),
        subtitle2: GoogleFonts.getFont(fontFamily),
        caption: GoogleFonts.getFont(fontFamily),
        bodyText1: GoogleFonts.getFont(fontFamily),
        bodyText2: GoogleFonts.getFont(fontFamily),
        button: GoogleFonts.getFont(fontFamily),
        overline: GoogleFonts.getFont(fontFamily),
      ),
    );
  }
}
