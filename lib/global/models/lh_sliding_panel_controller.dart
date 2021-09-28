import 'package:flutter/foundation.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhSlidingPanelController extends ChangeNotifier {
  final double minimizeHeight;
  final double maximizeHeight;
  double currentHeight = 0;
  LhSlidingPanelState status = LhSlidingPanelState.CLOSED;

  LhSlidingPanelController({
    required this.minimizeHeight,
    required this.maximizeHeight,
  });

  void open() {
    status = LhSlidingPanelState.DEFAULT;
    notify();
  }

  void toggle() {
    if (status == LhSlidingPanelState.CLOSED) {
      status = LhSlidingPanelState.DEFAULT;
    } else {
      status = LhSlidingPanelState.CLOSED;
    }

    notify();
  }

  void notify() {
    notifyListeners();
  }
}
