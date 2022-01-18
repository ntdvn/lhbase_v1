import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhBottomSheetUi extends StatelessWidget {
  final Widget child;
  final List<Widget>? left;
  final List<Widget>? right;
  final String? title;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final Color? color;
  final double? heightTitle;
  const LhBottomSheetUi(
      {Key? key,
      required this.child,
      this.left,
      this.right,
      this.title,
      this.titleStyle,
      this.backgroundColor,
      this.color = Colors.white, this.heightTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? LhColors.backdropColor,
      child: Column(
        children: [
          Container(
            color: Colors.red,
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
              // width: double.infinity,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16.0))),
              child: Column(
                children: [
                  Container(
                    height:heightTitle?? 40,
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            if (left != null)
                              Row(
                                children: left!,
                              ),
                            Expanded(
                              child: Container(),
                            ),
                            if (right != null)
                              Row(
                                children: right!,
                              ),
                          ],
                        ),
                        if (title != null)
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              title ?? '',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.fade,
                              style: titleStyle ??
                                  LhStyle.DEFAULT_18
                                      .copyWith(fontWeight: FontWeight.w500),
                            ),
                          )
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Color(0xFFF0F2F5),
                  ),
                  Flexible(
                    flex: 9,
                    child: Container(
                      // padding: EdgeInsets.only(
                      //     bottom: MediaQuery.of(context)
                      //         .padding
                      //         .bottom),
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
