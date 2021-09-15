import 'package:flutter/material.dart';

class LhSpacer extends StatelessWidget {
  final double? _height;
  final double? _width;

  LhSpacer({double height = 0, double width = 0})
      : this._height = height,
        this._width = width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      width: _width,
    );
  }
}
