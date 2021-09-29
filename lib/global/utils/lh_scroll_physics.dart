import 'package:flutter/material.dart';

class LhScrollPhysics {
  static _NoBouncingScrollPhysics noBouncingScrollPhysics =
      _NoBouncingScrollPhysics();
}

class _NoBouncingScrollPhysics extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      ClampingScrollPhysics();
}
