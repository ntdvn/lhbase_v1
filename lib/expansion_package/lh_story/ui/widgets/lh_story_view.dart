import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhStoryView extends StatefulWidget {
  final StoryController controller;
  final VoidCallback? onTapLeft;
  final VoidCallback? onTapRight;
  const LhStoryView(
      {Key? key, required this.controller, this.onTapLeft, this.onTapRight})
      : super(key: key);

  @override
  _LhStoryViewState createState() => _LhStoryViewState();
}

class _LhStoryViewState extends State<LhStoryView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        if (details.globalPosition.dx > MediaQuery.of(context).size.width / 2) {
          widget.controller.next();
          if (widget.onTapRight != null) {
            widget.onTapRight!();
          }
        } else {
          widget.controller.previous();
          if (widget.onTapRight != null) {
            widget.onTapLeft!();
          }
        }
      },
      onLongPressDown: (details) {
        widget.controller.pause();
      },
      onLongPressUp: () {
        widget.controller.play();
      },
      onLongPressEnd: (details) {},
      child: Container(
        width: double.infinity,
        color: Colors.black,
        child: Stack(
          children: [
            _renderStoryLayer(),
            _renderProgressLayer(),
          ],
        ),
      ),
    );
  }

  int _currentStory = 0;

  Timer? _timer;
  @override
  void initState() {
    super.initState();
    // Stream numbers = initTimer();
    // numbers.listen((event) {
    //   print('ok');
    // });
  }

  // void startTimer() {
  //   int MaxMilliseconds = _storys[_currentStory].duration.inMilliseconds;
  //   int onMilliseconds = MaxMilliseconds ~/ 100;
  //   int count = 0;
  //   var oneSec = Duration(milliseconds: onMilliseconds);
  //   _timer = new Timer.periodic(
  //     oneSec,
  //     (Timer timer) {
  //       count++;
  //       setState(() {
  //         _storys[_currentStory].currentDuration =
  //             Duration(milliseconds: onMilliseconds * count);
  //       });
  //       if (count == 100) {
  //         setState(() {
  //           _timer!.cancel();
  //         });
  //         if (_currentStory < _storys.length - 1) {
  //           setState(() {
  //             _currentStory++;
  //           });
  //           startTimer();
  //         }
  //       }
  //       print('hehe $onMilliseconds');
  //     },
  //   );
  // }

  Widget _renderProgressLayer() {
    return Positioned.fill(
      child: Stack(
        children: [
          Container(
            height: 10,
            color: Colors.black.withOpacity(0.3),
          ),
          AnimatedBuilder(
            animation: widget.controller,
            builder: (context, child) {
              print('_renderProgressLayer');
              return GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.controller.storys.length,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      mainAxisExtent: 3),
                  itemCount: widget.controller.storys.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return LhStoryProgressBar(
                      progress: (widget.controller.storys[index].currentDuration
                                  .inMilliseconds /
                              widget.controller.storys[index].duration!
                                  .inMilliseconds)
                          .toDouble(),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }

  Widget _renderStoryLayer() {
    return Positioned.fill(
        child: AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        print('_renderStoryLayer');
        return LhStoryContent(
          story: widget.controller.storys[widget.controller.currentStory],
          onReady: () {
            print('ready');

            SchedulerBinding.instance!.addPostFrameCallback((_) {
              // add your code here.

              widget.controller.play();
            });
          },
        );
      },
    ));
  }
  // Widget _renderStoryLayer() {
  //   return Container(
  //     child: LhStoryContent(
  //       story: widget.controller.storys[widget.controller.currentStory],
  //       storyController: widget.controller,
  //       onReady: () {
  //         print('ready');
  //         widget.controller.play();
  //       },
  //     ),
  //   );
  // }
}
