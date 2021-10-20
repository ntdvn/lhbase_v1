import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class KeyBoarDismisserWidget extends StatelessWidget {
  final Widget child;
  final bool keyboardDimissable;

  const KeyBoarDismisserWidget({Key? key, required this.child, this.keyboardDimissable = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: keyboardDimissable ? []  : [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: child,
    );
  }
}
