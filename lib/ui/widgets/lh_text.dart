import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lhbase_v1/global/controllers/controllers.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhText extends StatelessWidget {
  final String data;
  final TextStyle style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  const LhText(
    this.data, {
    Key? key,
    this.style = LhStyle.DEFAULT_12,
    this.textAlign,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
      textAlign: textAlign,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
    );
  }
}
