import 'package:flutter/material.dart';

class LhAppBarAction extends StatelessWidget {
  final Widget? child;
  final int badge;

  const LhAppBarAction({Key? key, this.badge = 0, this.child})
      : super(key: key);

  static bool isRenderBadge = false;

  Widget _renderBadge() {
    return Positioned(
      top: 5,
      right: 7,
      child: Container(
        color: Colors.green,
        alignment: Alignment.centerRight,
        child: Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            padding: EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(500.0),
              color: Colors.red,
            ),
            child: Text(
              badge > 99 ? '99+' : '$badge',
              // style: AppStyles.SMALL_TEXT_STYLE.copyWith(color: Colors.white),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(alignment: Alignment.center, child: child),
        ),
        Positioned.fill(
            child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkResponse(
              // splashColor: Colors.red,
              // hoverColor: Colors.blue,
              // focusColor: Colors.yellow,

              radius: 30,
              borderRadius: BorderRadius.circular(500.0),
              onTap: () {
                print('123');
              },
            ),
          ),
        )),
        if (badge > 0) _renderBadge()
      ],
    );
  }
}
