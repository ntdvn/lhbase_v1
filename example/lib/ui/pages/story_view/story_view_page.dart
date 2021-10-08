import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lhbase_v1/global/global.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1/res/res.dart';
import 'package:lhbase_v1/ui/widgets/lh_cached_image.dart';

class StoryViewPage extends StatefulWidget {
  const StoryViewPage({Key? key}) : super(key: key);

  @override
  _StoryViewPageState createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  final PageController controller = LhStoryPageController();
  int currentIndex = 0;

  StoryController _storyController1 = StoryController(
      storys: [],
      onCompleted: () {
        print('onCompleted');
      });
  StoryController _storyController2 = StoryController(
      storys: [],
      onCompleted: () {
        print('onCompleted');
      });

  @override
  void initState() {
    _storyController1.storys = [
      Story(
          widget: Container(
        color: Colors.blue,
        child: Text('1'),
      )),
      Story(
          widget: Container(
        color: Colors.green,
        child: Text('2'),
      )),
      Story(
          widget: Container(
        color: Colors.red,
        child: Text('3'),
      )),
      // Story(
      //     image:
      //         'https://i.pinimg.com/originals/58/bd/4f/58bd4fc9ebfccc1f2de419529bbf1a12.jpg'),
      // Story(
      //     image:
      //         'https://www.wallpaperup.com/uploads/wallpapers/2015/03/06/633166/e8d825bde9f2127330224dbd1570e457.jpg'),
      Story(
          widget: Container(
        color: Colors.red,
        child: Text('co gi do sai sai'),
      )),
    ];
    _storyController2.storys = [
      // Story(
      //     image:
      //         'https://i.pinimg.com/originals/58/bd/4f/58bd4fc9ebfccc1f2de419529bbf1a12.jpg'),
      // Story(
      //     image:
      //         'https://www.wallpaperup.com/uploads/wallpapers/2015/03/06/633166/e8d825bde9f2127330224dbd1570e457.jpg'),
      Story(
          widget: Container(
        color: Colors.red,
        child: Text('co gi do sai sai'),
      )),
    ];
    super.initState();
  }

  var a = FocusNode();
  var b = FocusNode();
  var ab = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return LhBasePage(
        statusBarBrightness: Brightness.dark,
        appBarTop: LhAppBar.top(),
        child: Container(
          child: CubePageView(
            controller: controller,
            onTapLeft: () {
              // _storyController.previous();
            },
            onTapRight: () {
              // _storyController.next();
            },
            children: [
              LhStoryView(
                controller: _storyController1,
              ),
              LhStoryView(
                controller: _storyController2,
              ),
            ],
            onPageChanged: (value) {
              currentIndex = value;
            },
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
