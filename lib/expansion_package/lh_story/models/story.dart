import 'package:flutter/material.dart';

class Story {
  final Duration duration;
  Duration currentDuration = Duration.zero;
  final Widget widget;

  Story(this.duration, this.widget);
}
