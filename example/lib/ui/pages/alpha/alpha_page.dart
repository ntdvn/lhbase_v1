import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';

class AlphaPage extends StatefulWidget {
  const AlphaPage({Key? key}) : super(key: key);

  @override
  _AlphaPageState createState() => _AlphaPageState();
}

class _AlphaPageState extends State<AlphaPage> {
  final PageController controller = LhStoryPageController();
  int currentIndex = 0;

  StoryControllerProvider _storyController1 = StoryControllerProvider(
      stories: [],
      onCompleted: () {
        print('onCompleted');
      });
  StoryControllerProvider _storyController2 = StoryControllerProvider(
      stories: [],
      onCompleted: () {
        print('onCompleted');
      });

  @override
  void initState() {
    _storyController1.stories = [
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
    _storyController2.stories = [
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
  // @override
  // Widget build(BuildContext context) {
  //   return LhBasePage(
  //       statusBarBrightness: Brightness.dark,
  //       appBarTop: LhAppBar.top(),
  //       child: Container(
  //         child: CubePageView(
  //           controller: controller,
  //           onTapLeft: () {
  //             // _storyController.previous();
  //           },
  //           onTapRight: () {
  //             // _storyController.next();
  //           },
  //           children: [
  //             LhStoryViewProvider(
  //               controller: _storyController1,
  //             ),
  //             LhStoryViewProvider(
  //               controller: _storyController2,
  //             ),
  //           ],
  //           onPageChanged: (value) {
  //             currentIndex = value;
  //           },
  //         ),
  //       ));
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return LhBasePage(
  //       statusBarBrightness: Brightness.dark,
  //       appBarTop: LhAppBar.top(),
  //       child: Container(
  //         padding: EdgeInsets.all(10.0),
  //         child: Column(
  //           children: [
  //             LhAdvancedInput(
  //               inputPadding:
  //                   EdgeInsets.symmetric(vertical: 12, horizontal: 18),
  //               controller: ab,
  //               focusNode: a,
  //               builderContainer: (lhInputBuilder) {
  //                 return BoxDecoration(
  //                     color: lhInputBuilder.isFocused
  //                         ? Colors.yellow
  //                         : Colors.blue,
  //                     borderRadius: BorderRadius.circular(
  //                         lhInputBuilder.isFocused ? 8.0 : 0),
  //                     border: Border.all(
  //                         width: 1,
  //                         color: lhInputBuilder.isFocused
  //                             ? Colors.green
  //                             : Colors.black));
  //               },
  //               builderTop: (lhInputBuilder) {
  //                 return Text(
  //                   'avb',
  //                   style: TextStyle(
  //                       color: lhInputBuilder.isFocused
  //                           ? Colors.green
  //                           : Colors.black),
  //                 );
  //               },
  //             )
  //           ],
  //         ),
  //       ));
  // }

  int _currentCustomer = 0;
  List<String> customerSupport = [
    'Tất cả',
    'Dành cho thành viên',
    'Công khai',
    'Tất cả',
    'Dành cho thành viên',
    'Công khai'
  ];

  @override
  Widget build(BuildContext context) {
    return LhBasePage(
        statusBarBrightness: Brightness.dark,
        appBarTop: LhAppBar.top(),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              LhRadiosWidget<String>(
                initialIndex: 0,
                items: customerSupport,
                // scrollDirection: Axis.horizontal,
                containerBuilder: () {
                  return Row();
                },
                radioBuilder: (p0, p1, p2) {
                  return Container(
                      margin: EdgeInsets.only(right: 25),
                      child: Text(
                        '${p1}',
                        style: LhStyle.DEFAULT_16.copyWith(
                            color: p0 == _currentCustomer
                                ? Colors.green
                                : Colors.black,
                            fontWeight: FontWeight.w400),
                      ));
                },
                onSelectedChanged: (p0, p1) {
                  _currentCustomer = p0;
                },
              )
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
