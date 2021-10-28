import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1/ui/ui.dart';

class StoryViewPage extends StatefulWidget {
  const StoryViewPage({Key? key}) : super(key: key);

  @override
  _StoryViewPageState createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  final PageController controller = LhStoryPageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return LhBasePage(
      appBarTop: LhAppBar.topEmpty(
        backgroundColor: Colors.black,
      ),
      appBarBottom: LhAppBar.bottomEmpty(),
      child: Container(),
      // child: LhStory(
      //   customViewBuilder: (story) {
      //     return Container(
      //       alignment: Alignment.center,
      //       // color: Colors.yellow,
      //       child: Text('${story.currentDuration.inMilliseconds}'),
      //     );
      //   },
      // ),
    );
  }
}
