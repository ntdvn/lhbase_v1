import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1/ui/ui.dart';

class StoryViewPage extends StatefulWidget {
  const StoryViewPage({Key? key}) : super(key: key);

  @override
  _StoryViewPageState createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  final PageController controller = LhStoryPageController();
  late LhStoryController _lhStoryController;
  int currentIndex = 0;

  @override
  void initState() {
    Get.put(LhStoryController(
        storiesList: [
          Stories([
            StoryData(
                image:
                    'https://thuthuatnhanh.com/wp-content/uploads/2018/07/hinh-nen-khong-gian-vu-tru-cho-dien-thoai.jpg',
                duration: Duration(seconds: 15)),
            StoryData(
                widget: Container(child: Text('Page 2'), color: Colors.blue)),
            StoryData(
                widget: Container(child: Text('Page 3'), color: Colors.amber)),
          ]),
          Stories([
            StoryData(
                widget:
                    Container(child: Text('Page 1'), color: Colors.cyanAccent)),
            StoryData(
                widget: Container(child: Text('Page 2'), color: Colors.red)),
          ]),
        ],
        onPageBack: () {
          print('page <-');
        },
        onBack: () {
          Get.back();
        },
        onPageCompleted: () {
          print('page ->');
        },
        onCompleted: () {
          Get.back();
        }));
    _lhStoryController = Get.find<LhStoryController>();
    _lhStoryController.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LhBasePage(
      appBarTop: LhAppBar.topEmpty(
        backgroundColor: Colors.black,
      ),
      // appBarBottom: LhAppBar.bottomEmpty(),
      child: LhStory(
        customViewBuilder: (story) {
          return Container(
            alignment: Alignment.center,
            // color: Colors.yellow,
            child: Text('${story.currentDuration.inMilliseconds}'),
          );
        },
        controller: _lhStoryController,
      ),
    );
  }
}
