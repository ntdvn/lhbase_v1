import 'package:flutter/material.dart';

class LhInkwell extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  BorderRadius? borderRadius;
  final Alignment? alignment;
  final BoxDecoration? decoration;
  LhInkwell({
    Key? key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.margin,
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
    return Container(
      margin: margin,
      alignment: alignment,
      decoration: decoration != null
          ? decoration!.copyWith(borderRadius: borderRadius)
          : BoxDecoration(borderRadius: borderRadius),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: borderRadius,
          child:
              Container(padding: padding ?? EdgeInsets.all(5.0), child: child),
        ),
      ),
    );
  }

  //  @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     margin: margin,
  //             alignment: alignment,
  //             decoration: decoration != null
  //                 ? decoration!.copyWith(borderRadius: borderRadius)
  //                 : decoration,
  //     child: Stack(
  //       children: [

  //         Positioned.fill(
  //           child: Material(
  //             color: Colors.transparent,
  //             child: InkWell(
  //               onTap: onTap,
  //               borderRadius: borderRadius,
  //             ),
  //           ),
  //         ),
  //         Container(padding: padding ?? EdgeInsets.all(5.0), child: child),
  //       ],
  //     ),
  //   );
  // }
}
