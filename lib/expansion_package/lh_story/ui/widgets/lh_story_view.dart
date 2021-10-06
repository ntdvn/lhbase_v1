import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

class LhStoryView extends StatefulWidget {
  final StoryController controller;
  const LhStoryView({Key? key, required this.controller}) : super(key: key);

  @override
  _LhStoryViewState createState() => _LhStoryViewState();
}

class _LhStoryViewState extends State<LhStoryView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('alolo ${widget.controller.currentStory}');
      },
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
      child: Column(
        children: [
          AnimatedBuilder(
            animation: widget.controller,
            builder: (context, child) {
              return GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.controller.storys.length,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      mainAxisExtent: 4),
                  itemCount: widget.controller.storys.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return LhStoryProgressBar(
                      progress: (widget.controller.storys[index].currentDuration
                                  .inMilliseconds /
                              widget.controller.storys[index].duration
                                  .inMilliseconds)
                          .toDouble(),
                    );
                  });
            },
          )
        ],
      ),
    );
  }

  Widget _renderStoryLayer() {
    return Positioned.fill(
        child: Container(
            child: AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return widget.controller.storys[widget.controller.currentStory].widget;
      },
    )));
  }
}
