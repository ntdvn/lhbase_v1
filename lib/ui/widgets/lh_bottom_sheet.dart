import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

enum LhBottomSheetState { DEFAULT, MINIMIZE, MAXIMIZE, CLOSED }

class LhBottomSheet extends StatefulWidget {
  final LhSlidingSheetController controller;

  const LhBottomSheet({Key? key, required this.controller, required this.child})
      : super(key: key);

  // final String title;
  // final TextStyle? titleStyle;
  //
  // final Color? titleBackground;
  //
  // final Color? draggerColor;
  // final EdgeInsets? titlePadding;
  // final EdgeInsets? bottomSheetPadding;
  //
  // final BorderRadius? bottomSheetRadius;
  // final EdgeInsets? contentPadding;
  final Widget child;
  // final double height;
  //
  // const LhBottomSheet({
  //   Key? key,
  //   required this.controller,
  //   required this.title,
  //   this.titleStyle,
  //   this.titleBackground,
  //   this.draggerColor,
  //   this.titlePadding,
  //   this.bottomSheetPadding,
  //   this.bottomSheetRadius,
  //   this.contentPadding,
  //   required this.child,
  //   required this.height,
  // }) : super(key: key);

  @override
  _LhBottomSheetState createState() => _LhBottomSheetState();
}

class _LhBottomSheetState extends State<LhBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        switch (widget.controller.status) {
          case LhSlidingPanelState.CLOSED:
            Get.back();
            break;
          case LhSlidingPanelState.MINIMIZE:
            break;
          case LhSlidingPanelState.MAXIMIZE:
            break;
        }
        return Container(
          child: Column(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () => widget.controller.close(),
                child: Container(
                  color: Colors.transparent,
                ),
              )),
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  widget.controller.setHeightDelta(-details.delta.dy);
                },
                onVerticalDragEnd: (details) {
                  widget.controller.onChangedEnd();
                },
                child: Container(
                  height: widget.controller.currentHeight,
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                  ),
                  color: Colors.transparent,
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
                          // width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.0))),
                          child: Column(
                            children: [
                              Container(
                                height: 40,
                                child: Row(
                                  children: [
                                    if (widget.controller.status ==
                                        LhSlidingPanelState.MAXIMIZE)
                                      Container(
                                        child: LhAppBarAction.icon(
                                          icon: Icon(Icons.close),
                                          onTap: () =>
                                              widget.controller.close(),
                                        ),
                                      ),
                                    Expanded(
                                      child: Text(
                                        'abcd',
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.fade,
                                        style: LhStyle.DEFAULT_18.copyWith(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    if (widget.controller.status ==
                                        LhSlidingPanelState.MAXIMIZE)
                                      Container(
                                        child: LhAppBarAction.icon(
                                          icon: Icon(Icons.arrow_drop_down),
                                          onTap: () {},
                                        ),
                                      ),
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
                                  child: widget.child,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
