import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StoryData {
  Duration? duration;
  Duration currentDuration = Duration.zero;

  final Widget? widget;

  final String? image;
  Uint8List? imageBytes;

  int get stepInMilliseconds => duration!.inMilliseconds ~/ 100;
  bool isReady = false;

  StoryData({
    this.duration,
    this.widget,
    this.image,
  }) {
    if (this.duration == null) this.duration = Duration(seconds: 2);
  }

  Future<bool> loadContent() async {
    if (widget != null) {
      isReady = true;
      return true;
    }
    if (image != null) {
      if (imageBytes == null) {
        imageBytes = (await NetworkAssetBundle(Uri.parse(image!)).load(image!))
            .buffer
            .asUint8List();
        return true;
      }
    }
    return true;
  }

  step() {
    if (currentDuration.inMilliseconds <=
        duration!.inMilliseconds - stepInMilliseconds) {
      currentDuration = Duration(
          milliseconds: currentDuration.inMilliseconds + stepInMilliseconds);
    }
  }

  toCompleted() {
    if (duration != null) currentDuration = duration!;
  }

  toReset() {
    currentDuration = Duration.zero;
  }
}
