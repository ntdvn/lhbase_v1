import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(),
      ),

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

  static void remainingMiliseconds(
      {required Timer? timer,
      required Duration time,
      required int steps,
      required ValueChanged<Duration> remainingTime,
      VoidCallback? onEnd,
      int replay = 1}) {
    int replayCount = 1;
    Future<void> handler() async {
      int maxMilliseconds = time.inMilliseconds;
      int onMilliseconds = maxMilliseconds ~/ steps;
      int count = 0;
      var oneSec = Duration(milliseconds: onMilliseconds);
      timer = new Timer.periodic(
        oneSec,
        (Timer timer) {
          count++;
          remainingTime(Duration(milliseconds: onMilliseconds * count));
          if (count == steps) {
            timer.cancel();
            if (replayCount < replay) {
              replayCount++;

              handler();
              if (onEnd != null) {
                onEnd();
              }
              return;
            }
          }
        },
      );
    }

    handler();
  }

  static durationToTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
