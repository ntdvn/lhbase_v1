import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:rxdart/rxdart.dart';

enum PlaybackState { pause, play, completed }

class StoryController extends ChangeNotifier {
  List<Story> storys;
  int currentStory = 0;
  Timer? _timer;
  final VoidCallback? onCompleted;

  StoryController({
    required this.storys,
    this.onCompleted,
  }) {}

  PlaybackState state = PlaybackState.play;

  void pause() {
    state = PlaybackState.pause;
    notifyListeners();
  }

  void play() {
    // if (state != PlaybackState.play) {
    //   state = PlaybackState.play;
    //   notifyListeners();
    //   startTimer();
    // }
    state = PlaybackState.play;
    notifyListeners();
    startTimer();
    print('play');
  }

  void next() {
    var expectedpage = currentStory + 1;
    goTo(expectedpage);
    notifyListeners();
  }

  void previous() {
    var expectedpage = currentStory - 1 < 0 ? 0 : currentStory - 1;
    print('expectedpage ${currentStory - 1}');
    goTo(expectedpage);
    play();
    notifyListeners();
  }

  @override
  void dispose() {
    print('dispose');
    clearTimer();
    super.dispose();
  }

  void goTo(int index) {
    if (index >= 0 && index < storys.length) {
      if (currentStory >= index) {
        storys[currentStory].currentDuration = Duration.zero;
      } else {
        storys[currentStory].currentDuration = storys[currentStory].duration!;
      }
      currentStory = index;
      storys[currentStory].currentDuration = Duration.zero;
    }
    if (index == storys.length) {
      storys[currentStory].currentDuration =
          storys[currentStory].duration! - Duration(milliseconds: 1);
    }
    play();
  }

  void startTimer() {
    clearTimer();
    int maxMilliseconds = storys[currentStory].duration!.inMilliseconds;
    int onMilliseconds = maxMilliseconds ~/ 100;
    var oneSec = Duration(milliseconds: onMilliseconds);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        // print('state $state');
        if (state != PlaybackState.pause) {
          storys[currentStory].currentDuration = Duration(
              milliseconds:
                  storys[currentStory].currentDuration.inMilliseconds +
                      onMilliseconds);
          if (storys[currentStory].currentDuration.inMilliseconds >=
              storys[currentStory].duration!.inMilliseconds) {
            _timer!.cancel();
            if (currentStory < storys.length - 1) {
              next();
              pause();
            } else {
              if (this.onCompleted != null) {
                this.onCompleted!();
                this.state = PlaybackState.completed;
              }
            }
          }
        } else {
          clearTimer();
        }
        notifyListeners();
      },
    );
  }

  clearTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }
}
