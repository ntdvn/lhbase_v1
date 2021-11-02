import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lhbase_v1/lhbase.dart';

typedef Widget LhStoryCustomViewBuilder(StoryData story);

class LhStoryView extends StatefulWidget {
  final Stories stories;
  final LhStoryCustomViewBuilder? customViewBuilder;
  final VoidCallback? onTapLeft;
  final VoidCallback? onTapRight;
  const LhStoryView(
      {Key? key,
      required this.stories,
      this.customViewBuilder,
      this.onTapLeft,
      this.onTapRight})
      : super(key: key);

  @override
  _LhStoryViewState createState() => _LhStoryViewState();
}

class _LhStoryViewState extends State<LhStoryView> {
  late LhStoryController _controller;
  @override
  void initState() {
    _controller = Get.find<LhStoryController>();
    // Future.delayed(Duration(seconds: 0), () {
    //   _controller = Get.find<LhStoryController>();

    //   setState(() {});
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        if (details.globalPosition.dx > MediaQuery.of(context).size.width / 2) {
          _controller.next();
          if (widget.onTapRight != null) {
            widget.onTapRight!();
          }
        } else {
          _controller.previous();
          if (widget.onTapRight != null) {
            widget.onTapLeft!();
          }
        }
      },
      onLongPressDown: (details) {
        // widget.controller.pause();
      },
      onLongPressUp: () {
        // widget.controller.play();
      },
      onLongPressEnd: (details) {},
      child: Stack(
        children: [
          _renderStoryLayer(),
          _renderProgressLayer(),
        ],
      ),
    );
  }

  Widget _renderProgressLayer() {
    return Positioned.fill(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Container(
                  color: Colors.black.withOpacity(0.3),
                ),
                GetBuilder<LhStoryController>(
                  builder: (controller) {
                    return GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: widget.stories.stories.length,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            mainAxisExtent: 3),
                        itemCount: widget.stories.stories.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return LhStoryProgressBar(
                            progress: (widget.stories.stories[index]
                                        .currentDuration.inMilliseconds /
                                    widget.stories.stories[index].duration!
                                        .inMilliseconds)
                                .toDouble(),
                          );
                        });
                  },
                )
              ],
            ),
          ),
          if (widget.customViewBuilder != null)
            Expanded(child: Container(
              // color: Colors.transparent,
              child: GetBuilder<LhStoryController>(
                builder: (controller) {
                  if (widget.customViewBuilder != null)
                    return widget.customViewBuilder!(
                        controller.currentStories.getCurrentStory());
                  else
                    return Container();
                },
              ),
            ))
        ],
      ),
    );
  }

  Widget _renderStoryLayer() {
    return Positioned.fill(
      child: GetBuilder<LhStoryController>(
        builder: (controller) {
          // print('_renderStoryLayer');
          return LhStoryContent(
            key: ObjectKey(0),
            data: widget.stories.getCurrentStory(),
            onReady: () {
              print('onReady');
              controller.play();
            },
          );
        },
      ),
    );
  }
}
