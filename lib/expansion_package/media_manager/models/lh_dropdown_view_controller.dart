import 'package:flutter/material.dart';

class LhDropdownViewController extends ChangeNotifier {
  bool isPanelShow = false;

  togglePanel() {
    isPanelShow = !isPanelShow;
    notifyListeners();
  }
}
