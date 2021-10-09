import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

enum StoryPlayBack { play, pause, next, previous, returned, completed }

class StoryControllerProvider with ChangeNotifier {
  List<Story> stories;
  PlaybackState state = PlaybackState.play;
  int currentIndex = 0;
  Timer? _timer;
  final VoidCallback? onCompleted;
  final VoidCallback? onReturned;
  int totalProgress = 0;

  StoryControllerProvider({
    required this.stories,
    this.onCompleted,
    this.onReturned,
  }) {}

  void pause() {
    state = PlaybackState.pause;
    notifyListeners();
  }

  void play() {
    print('play');
    if (state != PlaybackState.completed) {
      state = PlaybackState.play;
      startTimer();
    }
    // state = PlaybackState.play;
    // startTimer();
    // print('play');
  }

  void next() {
    var expectedpage = currentIndex;
    readyFor(++expectedpage);
    notifyListeners();
  }

  void previous() {
    var expectedpage = currentIndex;
    readyFor(--expectedpage);
    notifyListeners();
  }

  @override
  void dispose() {
    print('--------> dispose <----------');
    clearTimer();
    super.dispose();
  }

  void readyFor(int index) {
    if (index < 0) {
      if (this.onReturned != null) this.onReturned!();
    } else if (index > stories.length - 1) {
      if (this.onCompleted != null) this.onCompleted!();
    } else {
      if (index >= currentIndex) {
        stories[currentIndex].toCompleted();
      } else {
        stories[currentIndex].toReset();
      }
      currentIndex = index;
      stories[currentIndex].currentDuration = Duration.zero;
    }
    notifyListeners();

    // if (index >= 0 && index < stories.length) {}
    // if (index == stories.length) {
    //   stories[currentIndex].currentDuration =
    //       stories[currentIndex].duration! - Duration(milliseconds: 1);
    // }
  }

  void startTimer() {
    clearTimer();
    int maxMilliseconds = stories[currentIndex].duration!.inMilliseconds;
    int onMilliseconds = maxMilliseconds ~/ 100;
    var oneSec = Duration(milliseconds: onMilliseconds);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (state != PlaybackState.pause) {
          stories[currentIndex].currentDuration = Duration(
              milliseconds:
                  stories[currentIndex].currentDuration.inMilliseconds +
                      onMilliseconds);
          print(stories[currentIndex].currentDuration.inMilliseconds);
          if (stories[currentIndex].currentDuration.inMilliseconds >=
              stories[currentIndex].duration!.inMilliseconds) {
            if (currentIndex < stories.length - 1) {
              next();
              pause();
            } else {
              if (this.onCompleted != null) {
                this.onCompleted!();
                this.state = PlaybackState.completed;
              }
            }
            clearTimer();
          }
        } else {
          clearTimer();
        }
        totalProgress += onMilliseconds;
        notifyListeners();
      },
    );
  }

  clearTimer() {
    print('clearTimer');
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }
}
