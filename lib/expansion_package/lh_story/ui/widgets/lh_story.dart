import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:visibility_detector/visibility_detector.dart';

class LhStory extends StatefulWidget {
  final LhStoryController controller;
  final LhStoryCustomViewBuilder? customViewBuilder;
  const LhStory({Key? key, required this.controller, this.customViewBuilder})
      : super(key: key);

  @override
  _LhStoryState createState() => _LhStoryState();
}

class _LhStoryState extends State<LhStory> {
  final PageController controller = LhStoryPageController();
  late LhStoryController _lhStoryController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<LhStoryController>(
        builder: (controller) {
          // print('builder');
          return CubePageView(
            controller: controller.pageController,
            children: [
              ...List.generate(
                  controller.storiesList.length,
                  (index) => LhStoryView(
                        stories: controller.storiesList[index],
                        customViewBuilder: widget.customViewBuilder,
                      ))
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<LhStoryController>();
    super.dispose();
  }
}
