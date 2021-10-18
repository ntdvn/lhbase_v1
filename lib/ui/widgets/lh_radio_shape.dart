import 'package:flutter/material.dart';
import 'package:lhbase_v1/res/res.dart';

class LhRadioShape extends StatelessWidget {
  final bool isSelected;
  final double? size;
  final double borderWidth;
  final Color? color;
  final EdgeInsets? innerMargin;
  final BorderRadius? outerRadius;
  final BorderRadius? innerRadius;

  const LhRadioShape(
      {Key? key,
      this.isSelected = false,
      this.size = 20,
      this.borderWidth = 2,
      this.color,
      this.innerMargin,
      this.outerRadius,
      this.innerRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              borderRadius: outerRadius ?? LhValue.circleRadius,
              border:
                  Border.all(color: color ?? Colors.green, width: borderWidth)),
        ),
        Positioned.fill(
          child: AnimatedOpacity(
            opacity: isSelected ? 1 : 0,
            duration: Duration(milliseconds: 200),
            child: Container(
              margin: innerMargin ?? EdgeInsets.all(4.0),
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: innerRadius ?? LhValue.circleRadius,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
