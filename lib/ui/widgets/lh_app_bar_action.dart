import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhAppBarAction extends StatelessWidget {
  final Widget? child;
  final int? badge;
  final VoidCallback? onTap;

  const LhAppBarAction({Key? key, this.badge, this.child, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(alignment: Alignment.center, child: child),
        // Positioned.fill(
        //     child: Material(
        //   color: Colors.transparent,
        //   child: InkWell(
        //     onTap: () {
        //       print('123');
        //     },
        //   ),
        // )),
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
      {required Widget icon, int? badge, VoidCallback? onTap}) {
    return LhAppBarAction(
      child: Stack(
        children: [
          AspectRatio(
              aspectRatio: 1,
              child: FractionallySizedBox(
                  widthFactor: 0.6, heightFactor: 0.6, child: icon)),
          Positioned.fill(
              child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(500.0),
                onTap: onTap,
              ),
            ),
          )),
        ],
      ),
      badge: badge,
    );
  }
}
