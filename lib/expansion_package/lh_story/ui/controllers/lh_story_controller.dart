import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:lhbase_v1/expansion_package/lh_story/models/stories.dart';
import 'package:lhbase_v1/lhbase.dart';

enum StoryPlayBack { play, pause, next, previous, returned, completed }
enum PlaybackState { pause, play, completed }

class LhStoryController extends GetxController {
  List<Stories> storiesList;

  int get size => storiesList.length;

  Stories get currentStories => storiesList[page];

  PageController pageController = LhStoryPageController();

  RxInt _page = RxInt(0);

  int get page => _page.value;

  set page(int currentIndex) {
    _page.value = currentIndex;
  }

  PlaybackState state = PlaybackState.play;

  Timer? _parentTimer;
  Timer? _childTimer;
  final VoidCallback? onPageCompleted;
  final VoidCallback? onCompleted;
  final VoidCallback? onPageBack;
  final VoidCallback? onBack;
  // int totalProgress = 0;

  LhStoryController({
    required this.storiesList,
    this.onPageCompleted,
    this.onCompleted,
    this.onPageBack,
    this.onBack,
  }) {
    init();
  }

  init() {
    pageController.addListener(() {
      if (pageController.page! % 1 == 0 &&
          page != pageController.page!.toInt()) {
        print('pageController.page ${pageController.page}');
        page = pageController.page!.toInt();
        currentStories.reset();
        play();
      } else {
        // pause();
      }
    });
  }

  void pause() {
    state = PlaybackState.pause;
  }

  void play() {
    if (state != PlaybackState.completed) {
      state = PlaybackState.play;
      // update();
      startTimer();
    }
    // state = PlaybackState.play;
    // startTimer();
    // print('play');
  }

  void next() {
    var expectedpage = storiesList[page].currentStory + 1;
    // print('next + expectedpage $expectedpage');
    readyFor(expectedpage);
    update();
  }

  void previous() {
    var expectedpage = storiesList[page].currentStory - 1;
    readyFor(expectedpage);
    update();
  }

  @override
  void onClose() {
    clearTimer();

    super.onClose();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void readyFor(int index) {
    if (index < 0) {
      if (previousPage()) {
        if (this.onPageBack != null) this.onPageBack!();
      } else {
        if (this.onBack != null) this.onBack!();
      }
    } else if (index > storiesList[page].stories.length - 1) {
      if (nextPage()) {
        if (this.onPageCompleted != null) this.onPageCompleted!();
      } else {
        if (this.onCompleted != null) this.onCompleted!();
      }
    } else {
      if (index >= storiesList[page].currentStory) {
        storiesList[page].getCurrentStory().toCompleted();
      } else {
        storiesList[page].getCurrentStory().toReset();
      }
      storiesList[page].currentStory = index;
      storiesList[page].getCurrentStory().currentDuration = Duration.zero;
    }
    play();
  }

  void startTimer() async {
    clearTimer();
    await storiesList[page].getCurrentStory().loadContent();
    // update();
    int maxMilliseconds =
        storiesList[page].getCurrentStory().duration!.inMilliseconds;
    int onMilliseconds = maxMilliseconds ~/ 100;
    var oneSec = Duration(milliseconds: onMilliseconds);
    _parentTimer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        _childTimer = timer;
        if (state != PlaybackState.pause) {
          storiesList[page].getCurrentStory().step();
          if (storiesList[page]
                  .getCurrentStory()
                  .currentDuration
                  .inMilliseconds >=
              storiesList[page].getCurrentStory().duration!.inMilliseconds) {
            if (storiesList[page].canNext()) {
              _parentTimer!.cancel();
              next();
            } else {
              clearTimer();
              if (!nextPage()) {
                if (this.onCompleted != null) {
                  this.onCompleted!();
                  this.state = PlaybackState.completed;
                }
              } else {
                if (this.onPageCompleted != null) {
                  this.onPageCompleted!();
                }
              }
            }
            clearTimer();
          }
        } else {
          clearTimer();
        }
        update();
      },
    );
  }

  clearTimer() {
    if (_parentTimer != null) {
      _parentTimer!.cancel();
      _parentTimer = null;
    }
    if (_childTimer != null) {
      _childTimer!.cancel();
      _childTimer = null;
    }
  }

  bool nextPage() {
    if (page + 1 < size) {
      currentStories.reset();
      pageController.nextPage(
          duration: Duration(seconds: 2), curve: Curves.ease);
      return true;
    }
    return false;
  }

  bool previousPage() {
    if (page - 1 >= 0) {
      pageController.previousPage(
          duration: Duration(seconds: 2), curve: Curves.ease);
      return true;
    }
    return false;
  }
}
