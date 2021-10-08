import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

class AlphaPage extends StatefulWidget {
  const AlphaPage({Key? key}) : super(key: key);

  @override
  _AlphaPageState createState() => _AlphaPageState();
}

class _AlphaPageState extends State<AlphaPage> {
  StoryControllerProvider _storyController = StoryControllerProvider(
      stories: [],
      onCompleted: () {
        print('onCompleted');
      });

  @override
  void initState() {
    _storyController.stories = [
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
      Story(
          image:
              'https://i.pinimg.com/originals/58/bd/4f/58bd4fc9ebfccc1f2de419529bbf1a12.jpg'),
      Story(
          image:
              'https://www.wallpaperup.com/uploads/wallpapers/2015/03/06/633166/e8d825bde9f2127330224dbd1570e457.jpg'),
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
        child: Column(
          children: [LhInputSearch(controller: ab)],
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
