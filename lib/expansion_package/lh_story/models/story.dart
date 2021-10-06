import 'package:flutter/material.dart';

class Story {
  Duration? duration;
  Duration currentDuration = Duration.zero;
  final Widget? widget;
  final String? image;

  Story({this.duration, this.widget, this.image}) {
    this.duration = Duration(seconds: 5);
  }
}
