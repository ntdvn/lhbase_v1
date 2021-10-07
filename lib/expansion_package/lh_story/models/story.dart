import 'package:flutter/material.dart';

class Story {
  Duration? duration;
  Duration currentDuration = Duration.zero;
  int stepInMilliseconds = 0;
  final Widget? widget;
  final String? image;

  Story({this.duration, this.widget, this.image}) {
    this.duration = Duration(seconds: 2);
    stepInMilliseconds = duration!.inMilliseconds ~/ 100;
  }

  toCompleted() {
    if (duration != null) currentDuration = duration!;
  }

  toReset() {
    currentDuration = Duration.zero;
  }
}
