import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lhbase_v1/expansion_package/lh_story/models/stories.dart';
import 'package:lhbase_v1/lhbase.dart';

enum StoryPlayBack { play, pause, next, previous, returned, completed }
enum PlaybackState { pause, play, completed }

class LhStoryController extends GetxController {
  List<Stories> storiesList;

  PageController pageController = LhStoryPageController();

  int currentIndex = 0;

  Stories get currentStories => storiesList[currentIndex];

  PlaybackState state = PlaybackState.play;

  Timer? _timer;
  final VoidCallback? onCompleted;
  final VoidCallback? onReturned;
  int totalProgress = 0;

  LhStoryController({
    required this.storiesList,
    this.onCompleted,
    this.onReturned,
  }) {}

  void pause() {
    state = PlaybackState.pause;
    update();
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
    var expectedpage = storiesList[currentIndex].currentStory + 1;
    print('next + expectedpage $expectedpage');
    readyFor(expectedpage);
    update();
  }

  void previous() {
    var expectedpage = storiesList[currentIndex].currentStory -1;
    readyFor(expectedpage);
    update();
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
    } else if (index > storiesList[currentIndex].stories.length - 1) {
      if (this.onCompleted != null) this.onCompleted!();
    } else {
      if (index >= storiesList[currentIndex].currentStory) {
        storiesList[currentIndex].getCurrentStory().toCompleted();
      } else {
        storiesList[currentIndex].getCurrentStory().toReset();
      }
      storiesList[currentIndex].currentStory = index;
      storiesList[currentIndex].getCurrentStory().currentDuration =
          Duration.zero;
    }
    print('currentIndex $currentIndex');
    update();

    //   // if (index >= 0 && index < stories.length) {}
    //   // if (index == stories.length) {
    //   //   stories[currentIndex].currentDuration =
    //   //       stories[currentIndex].duration! - Duration(milliseconds: 1);
    //   // }
  }

  void startTimer() {
    clearTimer();
    int maxMilliseconds =
        storiesList[currentIndex].getCurrentStory().duration!.inMilliseconds;
    int onMilliseconds = maxMilliseconds ~/ 100;
    var oneSec = Duration(milliseconds: onMilliseconds);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (state != PlaybackState.pause) {
          storiesList[currentIndex].getCurrentStory().currentDuration =
              Duration(
                  milliseconds: storiesList[currentIndex]
                          .getCurrentStory()
                          .currentDuration
                          .inMilliseconds +
                      onMilliseconds);
          print(storiesList[currentIndex]
              .getCurrentStory()
              .currentDuration
              .inMilliseconds);
          if (storiesList[currentIndex]
                  .getCurrentStory()
                  .currentDuration
                  .inMilliseconds >=
              storiesList[currentIndex]
                  .getCurrentStory()
                  .duration!
                  .inMilliseconds) {
            if (currentIndex < storiesList[currentIndex].stories.length - 1) {
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
        update();
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
