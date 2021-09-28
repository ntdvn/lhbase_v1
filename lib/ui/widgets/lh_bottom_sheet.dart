import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

enum LhBottomSheetState { DEFAULT, MINIMIZE, MAXIMIZE, CLOSED }

class LhBottomSheet extends StatefulWidget {
  final String title;
  final TextStyle? titleStyle;

  final Color? titleBackground;

  final Color? draggerColor;
  final EdgeInsets? titlePadding;
  final EdgeInsets? bottomSheetPadding;

  final BorderRadius? bottomSheetRadius;
  final EdgeInsets? contentPadding;
  final Widget child;
  final double height;

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
      required this.height})
      : super(key: key);

  @override
  _LhBottomSheetState createState() => _LhBottomSheetState();
}

class _LhBottomSheetState extends State<LhBottomSheet> {
  late double _height;
  late double _defaultHeight;
  LhBottomSheetState _status = LhBottomSheetState.DEFAULT;

  static final _maxHeight = Get.height;

  @override
  void initState() {
    _defaultHeight = widget.height;
    _height = _defaultHeight;
    super.initState();
  }

  late Timer _timer;

  void expandHeightSize(double expandHeight) {
    var originHeight = _height;
    const double stepValue = 4;
    const oneSec = const Duration(microseconds: 1000);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_height == expandHeight) {
          setState(() {
            timer.cancel();
          });
        } else {
          if (originHeight < expandHeight) {
            setState(() {
              _height += stepValue;
            });
            if (_height > expandHeight) {
              setState(() {
                _height = expandHeight;
                timer.cancel();
              });
            }
          } else if (originHeight > expandHeight) {
            setState(() {
              _height -= stepValue;
            });
            if (_height < expandHeight) {
              setState(() {
                _height = expandHeight;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
              child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              color: Colors.transparent,
            ),
          )),
          GestureDetector(
            onVerticalDragUpdate: (details) {
              if (_height <= _maxHeight) {
                _height = _height - details.delta.dy;
                if (_height > _maxHeight) _height = _maxHeight;
                setState(() {});
              }

              // else if (_height == _maxHeight - 1) {
              //   setState(() {
              //     _height = _height - details.delta.dy;
              //   });
              // }
            },
            onVerticalDragEnd: (details) {
              print('onVerticalDragEnd ${details.velocity}');
              if (_height < _defaultHeight - 30 &&
                  _status != LhBottomSheetState.CLOSED) {
                // expandHeightSize(_maxHeight);
                _status = LhBottomSheetState.CLOSED;
                // setState(() {
                //   _status = LhBottomSheetState.CLOSED;
                // });
                Get.back();
              } else if (_height > _defaultHeight + 30 &&
                  _status != LhBottomSheetState.MAXIMIZE) {
                expandHeightSize(_maxHeight);
                _status = LhBottomSheetState.MAXIMIZE;
                // setState(() {
                //   _height = _maxHeight;
                //   _status = LhBottomSheetState.MAXIMIZE;
                // });
              } else if (_height < _maxHeight - 30 &&
                  _status != LhBottomSheetState.MINIMIZE) {
                expandHeightSize(_defaultHeight);
                _status = LhBottomSheetState.MINIMIZE;
                // setState(() {
                //   _height = _defaultHeight;
                //   _status = LhBottomSheetState.MINIMIZE;
                // });
              }
            },
            child: Container(
              height: _height,
              padding: widget.bottomSheetPadding ??
                  EdgeInsets.only(
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
                          borderRadius: widget.bottomSheetRadius ??
                              BorderRadius.vertical(
                                  top: Radius.circular(16.0))),
                      child: Column(
                        children: [
                          Container(
                              color: widget.titleBackground,
                              padding: widget.titlePadding ??
                                  EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 25),
                              child: Text(
                                widget.title,
                                style: widget.titleStyle ??
                                    LhStyle.DEFAULT_18
                                        .copyWith(fontWeight: FontWeight.w600),
                              )),
                          Container(
                            height: 2,
                            color: Color(0xFFF0F2F5),
                          ),
                          Expanded(
                            child: Container(
                              padding: widget.contentPadding ??
                                  EdgeInsets.only(
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
  }
}
