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
  @override
  void initState() {
    super.initState();
    _storyController.storys = [
      Story(
          image:
              'https://baoquocte.vn/stores/news_dataimages/dieulinh/012020/29/15/nhung-buc-anh-dep-tuyet-voi-ve-tinh-ban.jpg'),
      Story(
          image:
              'https://www.wallpaperup.com/uploads/wallpapers/2015/03/06/633166/e8d825bde9f2127330224dbd1570e457.jpg'),
      Story(
          widget: Container(
        color: Colors.red,
        child: Text('co gi do sai sai'),
      )),
    ];
    // _storyController.play();
  }

  StoryController _storyController = StoryController(
      storys: [],
      onCompleted: () {
        print('onCompleted');
      });

  @override
  Widget build(BuildContext context) {
    return LhBasePage(
        appBarTop: LhAppBar.topEmpty(
          backgroundColor: Colors.black,
        ),
        child: Container(
          child: LhStoryView(
            controller: _storyController,
          ),
        ));
  }

  @override
  void dispose() {
    _storyController.dispose();
    super.dispose();
  }
}
