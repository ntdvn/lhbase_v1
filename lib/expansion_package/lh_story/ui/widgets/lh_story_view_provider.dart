import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:provider/provider.dart';

class LhStoryViewProvider extends StatefulWidget {
  final StoryControllerProvider controller;
  final VoidCallback? onTapLeft;
  final VoidCallback? onTapRight;
  const LhStoryViewProvider(
      {Key? key, required this.controller, this.onTapLeft, this.onTapRight})
      : super(key: key);

  @override
  _LhStoryViewProviderState createState() => _LhStoryViewProviderState();
}

class _LhStoryViewProviderState extends State<LhStoryViewProvider> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => widget.controller,
        child: GestureDetector(
          onTapUp: (details) {
            if (details.globalPosition.dx >
                MediaQuery.of(context).size.width / 2) {
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
          child: Stack(
            children: [
              _renderStoryLayer(),
              _renderProgressLayer(),
            ],
          ),
        ));
  }

  Widget _renderProgressLayer() {
    return Positioned.fill(
      child: Stack(
        children: [
          Container(
            height: 10,
            color: Colors.black.withOpacity(0.3),
          ),
          Selector<StoryControllerProvider, int>(
            builder: (context, value, child) {
              print('_renderProgressLayer');
              return GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.controller.stories.length,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      mainAxisExtent: 3),
                  itemCount: widget.controller.stories.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return LhStoryProgressBar(
                      progress: (widget.controller.stories[index]
                                  .currentDuration.inMilliseconds /
                              widget.controller.stories[index].duration!
                                  .inMilliseconds)
                          .toDouble(),
                    );
                  });
            },
            selector: (buildContext, provider) {
              return provider.totalProgress;
            },
          ),
        ],
      ),
    );
  }

  Widget _renderStoryLayer() {
    return Positioned.fill(
      child: Selector<StoryControllerProvider, int>(
        builder: (context, value, child) {
          print('_renderStoryLayer ${widget.controller.currentIndex}');
          return LhStoryContent(
            key: ObjectKey(widget.controller.currentIndex),
            story: widget.controller.stories[widget.controller.currentIndex],
            onReady: () {
              print('ready ${widget.controller.currentIndex}');
              widget.controller.play();
              // SchedulerBinding.instance!.addPostFrameCallback((_) {
              //   // add your code here.

              //   widget.controller.play();
              // });
            },
          );
        },
        selector: (buildContext, provider) {
          return provider.currentIndex;
        },
      ),
    );
  }
}
