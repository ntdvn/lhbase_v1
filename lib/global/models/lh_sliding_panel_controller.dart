import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhSlidingPanelController extends ChangeNotifier {
  final double minimizeHeight;
  final double maximizeHeight;
  double currentHeight = 0;

  final VoidCallback? onAnimatedEnded;
  LhSlidingPanelState status = LhSlidingPanelState.CLOSED;

  Timer? _timer;

  LhSlidingPanelController(
      {required this.minimizeHeight,
      required this.maximizeHeight,
      this.onAnimatedEnded});

  void changeStatus(LhSlidingPanelState changeStatus) {
    switch (changeStatus) {
      case LhSlidingPanelState.CLOSED:
        status = LhSlidingPanelState.CLOSED;
        animatedTo(0);
        break;
      case LhSlidingPanelState.MINIMIZE:
        status = LhSlidingPanelState.MINIMIZE;
        animatedTo(minimizeHeight);
        break;
      case LhSlidingPanelState.MAXIMIZE:
        status = LhSlidingPanelState.MAXIMIZE;
        animatedTo(maximizeHeight);
        break;
    }

    // notify();
  }

  void close() {
    changeStatus(LhSlidingPanelState.CLOSED);
  }

  void minimize() {
    changeStatus(LhSlidingPanelState.MINIMIZE);
  }

  void maximize() {
    changeStatus(LhSlidingPanelState.MAXIMIZE);
  }

  void toggleMinimize() {
    if (status == LhSlidingPanelState.CLOSED) {
      minimize();
    } else {
      close();
    }
  }

  void toggleMaximize() {
    if (status == LhSlidingPanelState.CLOSED) {
      maximize();
    } else {
      close();
    }
  }

  void notify() {
    notifyListeners();
  }

  animatedTo(double expandHeight) {
    var originHeight = currentHeight;
    const double stepValue = 4;
    const oneSec = const Duration(microseconds: 1000);
    // print('minimizeHeight ${minimizeHeight}');
    // print('expandHeight ${expandHeight}');
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        // print('timer ${timer.tick}');
        // print('currentHeight ${currentHeight}');
        if (currentHeight == expandHeight) {
          // print('currentHeight == expandHeight');
          timer.cancel();
        } else {
          print('currentHeight $currentHeight');
          print('expandHeight $expandHeight');
          if (originHeight < expandHeight) {
            currentHeight += stepValue;
            if (currentHeight > expandHeight) {
              currentHeight = expandHeight;
              timer.cancel();
            }
          } else if (originHeight > expandHeight) {
            currentHeight -= stepValue;
            if (currentHeight < expandHeight) {
              currentHeight = expandHeight;
              timer.cancel();
            }
          }
        }
        notifyListeners();
        if (onAnimatedEnded != null) {
          this.onAnimatedEnded!();
        }
      },
    );
    _timer = null;
  }

  @override
  void dispose() {
    if (_timer != null) _timer!.cancel();
    super.dispose();
  }
}
