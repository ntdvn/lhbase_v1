import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:rxdart/rxdart.dart';

enum PlaybackState { pause, play, next, previous }

class StoryController extends ChangeNotifier {
  List<Story> storys;
  int currentStory = 0;
  Timer? _timer;

  StoryController({required this.storys}) {
    startTimer(); 
  }

  final playbackNotifier = BehaviorSubject<PlaybackState>();

  void pause() {
    playbackNotifier.add(PlaybackState.pause);
  }

  void play() {
    playbackNotifier.add(PlaybackState.play);
  }

  void next() {
    playbackNotifier.add(PlaybackState.next);
  }

  void previous() {
    playbackNotifier.add(PlaybackState.previous);
  }

  void dispose() {
    playbackNotifier.close();
  }

  void startTimer() {
    int MaxMilliseconds = storys[currentStory].duration.inMilliseconds;
    int onMilliseconds = MaxMilliseconds ~/ 100;
    int count = 0;
    var oneSec = Duration(milliseconds: onMilliseconds);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        count++;
        storys[currentStory].currentDuration =
            Duration(milliseconds: onMilliseconds * count);
        if (count == 100) {
          _timer!.cancel();
          if (currentStory < storys.length - 1) {
            currentStory++;
            startTimer();
          }
        }
        notifyListeners();
      },
    );
  }
}
