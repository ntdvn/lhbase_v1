import 'package:flutter/material.dart';

class LhText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  const LhText(
    this.data, {
    Key? key,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
    );
  }
}
