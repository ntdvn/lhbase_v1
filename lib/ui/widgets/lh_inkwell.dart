import 'package:flutter/material.dart';

class LhInkwell extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Alignment? alignment;
  final Decoration? decoration;
  const LhInkwell(
      {Key? key,
      required this.child,
      this.onTap,
      this.padding,
      this.borderRadius,
      this.alignment,
      this.decoration,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(5.0),
      child: Stack(
        children: [
          Container(
              padding: padding ?? EdgeInsets.all(5.0),
              alignment: alignment,
              decoration: decoration,
              child: child),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: borderRadius ?? BorderRadius.circular(5.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
