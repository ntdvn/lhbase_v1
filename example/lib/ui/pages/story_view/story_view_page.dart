import 'package:flutter/material.dart';
import 'package:lhbase_v1/global/global.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1/res/res.dart';

class StoryViewPage extends StatefulWidget {
  const StoryViewPage({Key? key}) : super(key: key);

  @override
  _StoryViewPageState createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LhBasePage(
        appBarTop: LhAppBar.topEmpty(
          backgroundColor: Colors.black,
        ),
        child: Container(
          child: LhStoryView(
            controller: StoryController(storys: [
              Story(
                  Duration(seconds: 3),
                  Container(
                    color: Colors.red,
                    child: Text(
                      'Story 1',
                      style: LhStyle.DEFAULT_24.copyWith(color: Colors.white),
                    ),
                  )),
              Story(
                  Duration(seconds: 3),
                  Text(
                    'Story 2',
                    style: LhStyle.DEFAULT_24.copyWith(color: Colors.white),
                  )),
              Story(
                  Duration(seconds: 5),
                  Text(
                    'Story 3',
                    style: LhStyle.DEFAULT_24.copyWith(color: Colors.white),
                  )),
            ]),
          ),
        ));
  }
}
