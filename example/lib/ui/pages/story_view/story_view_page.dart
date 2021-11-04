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
                    'https://cdn.tgdd.vn/2020/05/content/bo-hinh-nen-valorant-dep-mat-cho-may-tinh-dien-thoai-game-thu-khong-nen-bo-qua-11-573x1020-1.jpg'),
            StoryData(
                image:
                    'https://i.vietgiaitri.com/2016/11/19/top-20-hinh-nen-chu-de-game-cuc-dep-danh-cho-dien-thoai-6abd00.jpg'),
            StoryData(
                image:
                    'https://dean2020.edu.vn/wp-content/uploads/2021/04/anh-nen-game-2.jpg'),
          ]),
          Stories([
            StoryData(
                image:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpIPymvX4j2f65KxaG-Dskg96FNNi1vefPjg&usqp=CAU'),
            StoryData(
                image:
                    'https://1.bp.blogspot.com/-Fq8DR08GXMU/Xrpxg2ukuPI/AAAAAAAAk_0/qwbWHTcLrTkoiPg0QLoxXwhdjSuGvfeGACLcBGAsYHQ/s1600/Hinh-Nen-Game-Thu-Dep%2B%25283%2529.jpg'),
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
            child: GestureDetector(
                onTap: () {
                  Get.bottomSheet(Container(height: 100, color: Colors.red));
                },
                child: Text('${story.currentDuration.inMilliseconds}')),
          );
        },
        controller: _lhStoryController,
      ),
    );
  }
}
