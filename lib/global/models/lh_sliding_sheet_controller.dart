import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

abstract class SlidingListener {
  VoidCallback onStatusChanged(VoidCallback func);
}

class LhSlidingSheetController extends ChangeNotifier
    implements SlidingListener {
  final double minimizeHeight;
  final double? maximizeHeight;

  double currentHeight = 0;

  final VoidCallback? onAnimatedEnded;
  LhSlidingPanelState status = LhSlidingPanelState.CLOSED;

  Timer? _timer;

  static final _maxHeight =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.height;

  static final offsetHeight = 70;

  LhSlidingSheetController(
      {required this.minimizeHeight,
      this.maximizeHeight,
      this.onAnimatedEnded}) {}

  void changeStatus(LhSlidingPanelState changeStatus) {
    print('changeStatus');
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
        if (maximizeHeight != null) {
          status = LhSlidingPanelState.MAXIMIZE;
          animatedTo(maximizeHeight!);
        }
        break;
    }
    onStatusChanged(() {});
    // notify();
  }

  void onChangedEnd() {
    print('onChangedEnd $status');
    switch (status) {
      case LhSlidingPanelState.MINIMIZE:
        if (currentHeight > minimizeHeight + offsetHeight) {
          changeStatus(LhSlidingPanelState.MAXIMIZE);
        } else if (currentHeight < minimizeHeight - offsetHeight) {
          changeStatus(LhSlidingPanelState.CLOSED);
        } else {
          changeStatus(LhSlidingPanelState.MINIMIZE);
        }

        break;
      case LhSlidingPanelState.MAXIMIZE:
        if (maximizeHeight != null) {
          if (currentHeight < maximizeHeight! - offsetHeight) {
            changeStatus(LhSlidingPanelState.MINIMIZE);
          } else {
            changeStatus(LhSlidingPanelState.MAXIMIZE);
          }
        }

        break;
      case LhSlidingPanelState.CLOSED:
        break;
    }

    // if (currentHeight < minimizeHeight - offsetHeight &&
    //     status != LhSlidingPanelState.CLOSED) {
    //   changeStatus(LhSlidingPanelState.CLOSED);
    // } else if (currentHeight > minimizeHeight + offsetHeight &&
    //     status != LhSlidingPanelState.MAXIMIZE) {
    //   changeStatus(LhSlidingPanelState.MAXIMIZE);
    // } else if (currentHeight < maximizeHeight - offsetHeight &&
    //     status != LhSlidingPanelState.MINIMIZE) {
    //   changeStatus(LhSlidingPanelState.MINIMIZE);
    // }
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

  void setHeightDelta(double delta) {
    print('setHeightDelta ${delta}');

    if (maximizeHeight == null && delta > 0) {
      return;
    } else if (maximizeHeight != null) {
      if (currentHeight + delta > maximizeHeight!) {
        currentHeight = maximizeHeight!;
        return;
      }
    }

    currentHeight += delta;
    notifyListeners();
  }

  void animatedTo(double expandHeight) {
    if (expandHeight > _maxHeight) return;

    var originHeight = currentHeight;
    var mode = 0;

    if (originHeight < expandHeight) {
      mode = 1;
    } else {
      mode = 2; 
    }
    const double stepValue = 4;
    const oneSec = const Duration(microseconds: 1000);
    // print('minimizeHeight ${minimizeHeight}');
    // print('expandHeight ${expandHeight}');
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        print('mode $mode');
        // print('timer ${timer.tick}');
        // print('currentHeight ${currentHeight}');
        if (currentHeight == expandHeight) {
          // print('currentHeight == expandHeight');
          timer.cancel();
        } else {
          // print('currentHeight $currentHeight');
          // print('expandHeight $expandHeight');
          if (mode == 1) {
            print('cong');
            currentHeight += stepValue;
            if (currentHeight > expandHeight) {
              currentHeight = expandHeight;
              timer.cancel();
            }
          } else if (mode == 2) {
            print('tru');
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

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
    super.addListener(listener);
  }

  @override
  VoidCallback onStatusChanged(VoidCallback func) {
    return func;
  }
}
