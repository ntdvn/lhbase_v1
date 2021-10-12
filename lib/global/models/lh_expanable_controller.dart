import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

enum LhExpanableState {
  SCROLLING,
  MINIMIZE,
  MAXIMIZE,
  CLOSED,
}

class LhExpanableValue {
  final LhExpanableState state;
  final double height;

  LhExpanableValue({required this.state, required this.height});

  static final CLOSED =
      LhExpanableValue(height: 0, state: LhExpanableState.CLOSED);
  @override
  String toString() {
    return 'LhExpanableState: state: $state, height: $height';
  }
}

class LhExpanableController extends ChangeNotifier {
  final double minimizeHeight;
  final double? maximizeHeight;

  LhExpanableValue value = LhExpanableValue.CLOSED;
  LhExpanableValue targetValue = LhExpanableValue.CLOSED;

  double height = 0;

  static const double closedHeight = 0;

  late LhExpanableValue valueMinimize, valueMaximize;

  LhExpanableController({required this.minimizeHeight, this.maximizeHeight}) {
    valueMinimize = LhExpanableValue(
      state: LhExpanableState.MINIMIZE,
      height: minimizeHeight,
    );

    if(maximizeHeight!=null) {
      valueMaximize = LhExpanableValue(
        state: LhExpanableState.MAXIMIZE,
        height: maximizeHeight!,
      );
    }


    
    this.addListener(() {
      // print('height $height targetHeight ${targetValue.height}');
      if (height <= closedHeight)
        value = LhExpanableValue.CLOSED;
      else if (height >= minimizeHeight &&
          maximizeHeight != null &&
          height < maximizeHeight!) {
        value = LhExpanableValue(
          state: LhExpanableState.MINIMIZE,
          height: minimizeHeight,
        );
        print('LhExpanableState.MINIMIZE');
      } else if (maximizeHeight != null && height >= maximizeHeight!) {
        value = LhExpanableValue(
          state: LhExpanableState.MAXIMIZE,
          height: maximizeHeight!,
        );
        print('LhExpanableState.MAXIMIZE');
      } else {
        value = LhExpanableValue(
          state: LhExpanableState.SCROLLING,
          height: height,
        );
        print('LhExpanableState.SCROLLING');
      }
    });
  }

  bool get isShow => value.state != LhExpanableState.CLOSED;

  static final screenWidth =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.width;
  static final screenHeight =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.height;

  void delta(double delta) {
    // if (maximizeHeight == null && delta > 0) {
    //   return;
    // } else if (maximizeHeight != null) {
    //   if (currentHeight + delta > maximizeHeight!) {
    //     currentHeight = maximizeHeight!;
    //     return;
    //   }
    // }
    if (height < screenHeight - delta)
      height += delta;
    else
      height = screenHeight;
    notifyListeners();
  }

  Timer? _timer;

  void animatedToTarget(LhExpanableValue tValue) {
    targetValue = tValue;
    var mValue = 0;

    if (targetValue.height > value.height) {
      mValue = 1;
    } else {
      mValue = -1;
    }

    double stepValue = (3 * mValue).toDouble();
    const oneSec = const Duration(milliseconds: 1);
    // print('minimizeHeight ${minimizeHeight}');
    // print('expandHeight ${expandHeight}');
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        delta(stepValue);
        if (targetValue.state == value.state) {
          timer.cancel();
          notifyListeners();
        }
      },
    );
    _timer = null;
  }

  void minimize() {
    animatedToTarget(LhExpanableValue(
        height: minimizeHeight, state: LhExpanableState.MINIMIZE));
  }

  void maximize() {
    animatedToTarget(LhExpanableValue(
        height: maximizeHeight!, state: LhExpanableState.MAXIMIZE));
  }

  void closed() {
    animatedToTarget(LhExpanableValue.CLOSED);
  }

  @override
  void dispose() {
    if (_timer != null) _timer!.cancel();
    super.dispose();
  }
}
