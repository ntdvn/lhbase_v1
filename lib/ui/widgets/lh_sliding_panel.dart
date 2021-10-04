import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

enum LhSlidingPanelState { MINIMIZE, MAXIMIZE, CLOSED }

class LhSlidingPanel extends StatefulWidget {
  final LhSlidingSheetController controller;
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

  // const LhSlidingPanel(
  //     {Key? key,
  //     required this.controller,
  //     required this.title,
  //     this.titleStyle,
  //     this.titleBackground,
  //     this.draggerColor,
  //     this.titlePadding,
  //     this.bottomSheetPadding,
  //     this.bottomSheetRadius,
  //     this.contentPadding,
  //     required this.child,
  //     required this.height})
  //     : super(key: key);

  LhSlidingPanel(
      {required LhSlidingSheetController controller, required this.child})
      : this.controller = controller,
        super(key: new ValueKey<LhSlidingSheetController>(controller));

  @override
  _LhSlidingPanelState createState() => _LhSlidingPanelState();
}

class _LhSlidingPanelState extends State<LhSlidingPanel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        print('AnimatedBuilder');
        return Container(
          color: Colors.blue,
          child: Column(
            children: [
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  print('onVerticalDragUpdate');
                  // if (widget.controller.currentHeight <=
                  //     widget.controller.maximizeHeight) {
                  print('<=maximizeHeight');
                  widget.controller.animatedTo(
                      widget.controller.currentHeight - details.delta.dy);
                  // if (widget.controller.currentHeight >
                  //     widget.controller.maximizeHeight)
                  //   print('>maximizeHeight');
                  // widget.controller
                  //     .animatedTo(widget.controller.maximizeHeight);
                  // setState(() {});
                  // }
                },
                onVerticalDragEnd: (details) {
                  // if (widget.controller.currentHeight <
                  //         widget.controller.minimizeHeight - 30 &&
                  //     widget.controller.status != LhSlidingPanelState.CLOSED) {
                  //   widget.controller.changeStatus(LhSlidingPanelState.CLOSED);
                  // } else if (widget.controller.currentHeight >
                  //         widget.controller.minimizeHeight + 30 &&
                  //     widget.controller.status !=
                  //         LhSlidingPanelState.MAXIMIZE) {
                  //   widget.controller
                  //       .changeStatus(LhSlidingPanelState.MAXIMIZE);
                  // } else if (widget.controller.currentHeight <
                  //         widget.controller.maximizeHeight - 30 &&
                  //     widget.controller.status !=
                  //         LhSlidingPanelState.MINIMIZE) {
                  //   widget.controller
                  //       .changeStatus(LhSlidingPanelState.MINIMIZE);
                  // }
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
                      // Container(
                      //   color: Colors.transparent,
                      //   height: 5,
                      //   margin: EdgeInsets.symmetric(vertical: 10),
                      //   child: FractionallySizedBox(
                      //       widthFactor: 0.12,
                      //       heightFactor: 1,
                      //       child: Container(
                      //         decoration: BoxDecoration(
                      //             color: Color(0xFFF0F2F5),
                      //             borderRadius: BorderRadius.circular(16.0)),
                      //       )),
                      // ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.0))),
                          child: Column(
                            children: [
                              // Container(
                              //     // color: null,
                              //     padding: EdgeInsets.symmetric(
                              //         vertical: 12, horizontal: 25),
                              //     child: Text(
                              //       'ahahaha',
                              //       style: LhStyle.DEFAULT_18
                              //           .copyWith(fontWeight: FontWeight.w600),
                              //     )),
                              // Container(
                              //   height: 2,
                              //   color: Color(0xFFF0F2F5),
                              // ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .padding
                                          .bottom),
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
