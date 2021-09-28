import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

enum LhSlidingPanelState { DEFAULT, MINIMIZE, MAXIMIZE, CLOSED }

class LhSlidingPanel extends StatefulWidget {
  final LhSlidingPanelController controller;
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
      {required LhSlidingPanelController controller, required this.child})
      : this.controller = controller,
        super(key: new ValueKey<LhSlidingPanelController>(controller));

  @override
  _LhSlidingPanelState createState() => _LhSlidingPanelState();
}

class _LhSlidingPanelState extends State<LhSlidingPanel> {
  @override
  void initState() {
    super.initState();
  }

  late Timer _timer;

  void expandHeightSize(double expandHeight) {
    var originHeight = widget.controller.minimizeHeight;
    const double stepValue = 4;
    const oneSec = const Duration(microseconds: 1000);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (widget.controller.minimizeHeight == expandHeight) {
          setState(() {
            timer.cancel();
          });
        } else {
          if (originHeight < expandHeight) {
            setState(() {
              widget.controller.currentHeight += stepValue;
            });
            if (widget.controller.currentHeight > expandHeight) {
              setState(() {
                widget.controller.currentHeight = expandHeight;
                timer.cancel();
              });
            }
          } else if (originHeight > expandHeight) {
            setState(() {
              widget.controller.currentHeight -= stepValue;
            });
            if (widget.controller.currentHeight < expandHeight) {
              setState(() {
                widget.controller.currentHeight = expandHeight;
                timer.cancel();
              });
            }
          }

          // if (expandHeight >= _height) {
          //   if (_height > expandHeight) {
          //     setState(() {
          //       _height = expandHeight;
          //       timer.cancel();
          //     });
          //   } else {
          //     setState(() {
          //       _height += 4;
          //     });
          //   }
          // } else {
          // if (_height < expandHeight) {
          //   setState(() {
          //     _height = expandHeight;
          //     timer.cancel();
          //   });
          // } else {
          //   setState(() {
          //     _height -= 4;
          //   });
          // }
          // }
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // void _statusToHeight() {
  //   if (widget.controller.status == LhSlidingPanelState.DEFAULT) {
  //     _height = _defaultHeight;
  //   }
  //   if (widget.controller.status == LhSlidingPanelState.CLOSED) {
  //     _height = 0;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return Container(
          child: Column(
            children: [
              GestureDetector(
                onVerticalDragUpdate: (details) {
                  // if (_height <= _maxHeight) {
                  //   _height = _height - details.delta.dy;
                  //   if (_height > _maxHeight) _height = _maxHeight;
                  //   setState(() {});
                  // }
                },
                onVerticalDragEnd: (details) {
                  // if (_height < _defaultHeight - 30 &&
                  //     widget.controller.status != LhSlidingPanelState.CLOSED) {
                  //   widget.controller.status = LhSlidingPanelState.CLOSED;
                  //   Get.back();
                  // } else if (_height > _defaultHeight + 30 &&
                  //     widget.controller.status !=
                  //         LhSlidingPanelState.MAXIMIZE) {
                  //   expandHeightSize(_maxHeight);
                  //   widget.controller.status = LhSlidingPanelState.MAXIMIZE;
                  // } else if (_height < _maxHeight - 30 &&
                  //     widget.controller.status !=
                  //         LhSlidingPanelState.MINIMIZE) {
                  //   expandHeightSize(_defaultHeight);
                  //   widget.controller.status = LhSlidingPanelState.MINIMIZE;
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
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.0))),
                          child: Column(
                            children: [
                              Container(
                                  color: null,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 25),
                                  child: Text(
                                    'ahahaha',
                                    style: LhStyle.DEFAULT_18
                                        .copyWith(fontWeight: FontWeight.w600),
                                  )),
                              Container(
                                height: 2,
                                color: Color(0xFFF0F2F5),
                              ),
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
