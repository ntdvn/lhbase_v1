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

enum LhExpanableAction {
  SCROLLING,
  IDLE,
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
  LhExpanableAction _action = LhExpanableAction.IDLE;
  set action(LhExpanableAction action) {
    _action = action;
  }

  double height = 0;

  static const double closedHeight = 0;

  late LhExpanableValue valueMinimize, valueMaximize;

  static const double offsetHeight = 50;

  LhExpanableController({required this.minimizeHeight, this.maximizeHeight}) {
    valueMinimize = LhExpanableValue(
      state: LhExpanableState.MINIMIZE,
      height: minimizeHeight,
    );

    if (maximizeHeight != null) {
      valueMaximize = LhExpanableValue(
        state: LhExpanableState.MAXIMIZE,
        height: maximizeHeight!,
      );
    }

    this.addListener(() {
      // print('height $height targetHeight ${targetValue.height}')
      // switch (_action) {
      //   case LhExpanableAction.IDLE:
      //     print('height $height');

      //     if (height <= valueMinimize.height - offsetHeight)
      //       value = LhExpanableValue.CLOSED;
      //     else if (height >= minimizeHeight - offsetHeight &&
      //         height < minimizeHeight + offsetHeight) {
      //       value = LhExpanableValue(
      //         state: LhExpanableState.MINIMIZE,
      //         height: minimizeHeight,
      //       );
      //       print('LhExpanableState.MINIMIZE');
      //     } else if (maximizeHeight != null) {
      //       if (height >= maximizeHeight! - offsetHeight) {
      //         value = LhExpanableValue(
      //           state: LhExpanableState.MAXIMIZE,
      //           height: maximizeHeight!,
      //         );
      //         print('LhExpanableState.MAXIMIZE ${maximizeHeight! - offsetHeight}');
      //       }
      //     } else {
      //       // value = LhExpanableValue(
      //       //   state: LhExpanableState.SCROLLING,
      //       //   height: height,
      //       // );
      //       print('LhExpanableState.SCROLLING');
      //     }
      //     // print('targetValue $targetValue');
      //     // animatedToTarget(targetValue);

      //     break;

      //   case LhExpanableAction.SCROLLING:
      //     break;
      // }
      if (height <= 0)
        value = LhExpanableValue.CLOSED;
      else if (height == valueMinimize.height) {
        value = LhExpanableValue(
          state: LhExpanableState.MINIMIZE,
          height: minimizeHeight,
        );
        // print('LhExpanableState.MINIMIZE');
      } else if (maximizeHeight != null) {
        if (height == valueMaximize.height) {
          value = LhExpanableValue(
            state: LhExpanableState.MAXIMIZE,
            height: maximizeHeight!,
          );
          // print('LhExpanableState.MAXIMIZE ${maximizeHeight! - offsetHeight}');
        }
      } else {
        // value = LhExpanableValue(
        //   state: LhExpanableState.SCROLLING,
        //   height: height,
        // );
        // print('LhExpanableState.SCROLLING');
      }
    });
  }

  bool get isShow => height > 0;

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

    action = LhExpanableAction.SCROLLING;

    notifyListeners();
  }

  Timer? _timer;
  Timer? _tmpTimer;

  void animatedToTarget(LhExpanableValue tValue) {
    targetValue = tValue;
    var mValue = 0;

    if (targetValue.height > height) {
      mValue = 1;
    } else if (targetValue.height < height) {
      mValue = -1;
    }

    double stepValue = (5 * mValue).toDouble();
    const oneSec = const Duration(milliseconds: 1);
    // print('minimizeHeight ${minimizeHeight}');
    // print('expandHeight ${expandHeight}');
    clearTimer();
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        _tmpTimer = timer;
        // print('height $height');
        // print('targetValue $targetValue');
        // print('height $height');
        delta(stepValue);
        if (targetValue.height == height) {
          // Future.delayed(Duration(seconds: 2), () {
          value = targetValue;
          action = LhExpanableAction.IDLE;
          //  notifyListeners();
          // });
          clearTimer();
          notifyListeners();
        } else if (height < 0 || height > screenHeight) {
          clearTimer();
          notifyListeners();
        }
      },
    );
  }

  void minimize() {
    animatedToTarget(LhExpanableValue(
        height: minimizeHeight, state: LhExpanableState.MINIMIZE));
  }

  void maximize() {
    if (maximizeHeight != null) {
      animatedToTarget(LhExpanableValue(
          height: maximizeHeight!, state: LhExpanableState.MAXIMIZE));
    }
  }

  void closed() {
    animatedToTarget(LhExpanableValue.CLOSED);
  }

  clearTimer() {
    if (_timer != null) _timer!.cancel();
    _timer = null;
    if (_tmpTimer != null) _tmpTimer!.cancel();
    _tmpTimer = null;
  }

  @override
  void dispose() {
    clearTimer();
    super.dispose();
  }
}
