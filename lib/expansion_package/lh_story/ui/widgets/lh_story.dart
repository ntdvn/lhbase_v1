import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lhbase_v1/lhbase.dart';

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
    // Get.put(LhStoryController(storiesList: [
    //   Stories(
    //     [
    //       Story(
    //           image:
    //               'https://file.vfo.vn/hinh/2018/03/hinh-nen-dien-thoai-dep-nhat-full-hd-cho-dien-thoai-iphone-android-2.jpg'),
    //       Story(widget: Container(color: Colors.red))
    //     ],
    //   ),
    //   Stories([Story(widget: Container(color: Colors.red))]),
    //   Stories([
    //     Story(
    //         image:
    //             'https://thuthuatnhanh.com/wp-content/uploads/2019/11/hinh-nen-dien-thoai-dep.jpg')
    //   ])
    // ]));
    _lhStoryController = Get.find<LhStoryController>();
    // _lhStoryController.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
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
}
