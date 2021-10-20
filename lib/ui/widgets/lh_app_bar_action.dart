import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhAppBarAction extends StatelessWidget {
  final Widget? child;
  final int? badge;
  final VoidCallback? onTap;
  final double? sizeFactor;

  const LhAppBarAction({
    Key? key,
    this.badge,
    this.child,
    this.onTap,
    this.sizeFactor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(alignment: Alignment.center, child: child),
        if (badge != null && badge! > 0)
          Positioned(
            top: 5,
            right: 5,
            child: Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                padding: EdgeInsets.all(1.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500.0),
                  color: Colors.red,
                ),
                child: LhText(
                  badge! > 99 ? '99+' : '$badge',
                  style: LhStyle.DEFAULT_12.copyWith(color: Colors.white),
                )),
          )
      ],
    );
  }

  factory LhAppBarAction.custom(
      {required Widget child, int? badge, VoidCallback? onTap}) {
    return LhAppBarAction(
      child: Stack(
        children: [
          Container(
              alignment: Alignment.center,
              height: double.infinity,
              child: child),
          if (onTap != null)
            Positioned.fill(
                child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
              ),
            )),
        ],
      ),
      badge: badge,
    );
  }

  factory LhAppBarAction.icon(
      {required Widget icon,
      int? badge,
      VoidCallback? onTap,
      double? iconFactor,
      double? sizeFactor}) {
    return LhAppBarAction(
      child: Stack(
        children: [
          AspectRatio(
              aspectRatio: sizeFactor ?? 0.75,
              child: FractionallySizedBox(
                  widthFactor: iconFactor ?? 0.6,
                  heightFactor: iconFactor ?? 0.6,
                  child: icon)),
          if (onTap != null)
            Positioned.fill(
                child: Material(
              color: Colors.transparent,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.zero,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(500.0),
                    onTap: onTap,
                  ),
                ),
              ),
            )),
        ],
      ),
      badge: badge,
    );
  }

  // factory LhAppBarAction.icon(
  //     {required Widget icon,
  //     int? badge,
  //     VoidCallback? onTap,
  //     double? iconFactor,
  //     double? sizeFactor}) {
  //   return LhAppBarAction(
  //       child: Container(
  //         color: Colors.red,
  //         child: AspectRatio(
  //     aspectRatio: 1,
  //     child: LhInkwell(
  //         borderRadius: BorderRadius.circular(500.0),
  //         onTap: onTap,
  //         alignment: Alignment.center,
  //         child: FractionallySizedBox(
  //             widthFactor: iconFactor ?? 0.6,
  //             heightFactor: iconFactor ?? 0.6,
  //             child: icon),
  //     ),
  //   ),
  //       ));
  // }
}
