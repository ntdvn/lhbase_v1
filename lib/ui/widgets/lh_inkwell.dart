import 'package:flutter/material.dart';

class LhInkwell extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  BorderRadius? borderRadius;
  final Alignment? alignment;
  final BoxDecoration? decoration;
  LhInkwell({
    Key? key,
    required this.child,
    this.onTap,
    this.padding,
    this.borderRadius,
    this.alignment,
    this.decoration,
  }) : super(key: key) {
    var defaultRadius = BorderRadius.circular(5.0);
    borderRadius = borderRadius ?? defaultRadius;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        children: [
          Container(
              padding: padding ?? EdgeInsets.all(5.0),
              alignment: alignment,
              decoration: decoration != null
                  ? decoration!.copyWith(borderRadius: borderRadius)
                  : decoration,
              child: child),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: borderRadius,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
