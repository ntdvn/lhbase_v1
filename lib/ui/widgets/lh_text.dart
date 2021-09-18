import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LhText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  const LhText(
    this.data, {
    Key? key,
    this.style,
    this.textAlign,
    this.overflow,
    this.textScaleFactor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: GoogleFonts.inter(
        textStyle: style,
      ),
      textAlign: textAlign,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
    );
  }
}
