import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhBottomSheet extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;

  final Color? titleBackground;

  final Color? draggerColor;
  final EdgeInsets? titlePadding;
  final EdgeInsets? bottomSheetPadding;

  final BorderRadius? bottomSheetRadius;
  final EdgeInsets? contentPadding;
  final Widget child;
  final double? height;

  const LhBottomSheet(
      {Key? key,
      required this.title,
      this.titleStyle,
      this.titleBackground,
      this.draggerColor,
      this.titlePadding,
      this.bottomSheetPadding,
      this.bottomSheetRadius,
      this.contentPadding,
      required this.child,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: bottomSheetPadding ??
          EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
      color: Colors.transparent,
      height: height,
      // padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            color: Colors.transparent,
            height: 5,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: FractionallySizedBox(
                widthFactor: 0.12,
                heightFactor: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFF0F2F5),
                      borderRadius: BorderRadius.circular(16.0)),
                )),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: bottomSheetRadius ??
                      BorderRadius.vertical(top: Radius.circular(16.0))),
              child: Column(
                children: [
                  Container(
                      color: titleBackground,
                      padding: titlePadding ??
                          EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                      child: Text(
                        title,
                        style: titleStyle ??
                            LhStyle.DEFAULT_18
                                .copyWith(fontWeight: FontWeight.w600),
                      )),
                  Container(
                    height: 2,
                    color: Color(0xFFF0F2F5),
                  ),
                  Expanded(
                    child: Container(
                      padding: contentPadding ??
                          EdgeInsets.only(
                              bottom: MediaQuery.of(context).padding.bottom),
                      child: child,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
