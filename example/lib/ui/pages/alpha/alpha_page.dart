import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1/ui/widgets/lh_cached_image.dart';

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

  List<String> images = [
    'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
    'https://www.elle.vn/wp-content/uploads/2017/07/25/hinh-anh-dep-1.jpg',
    'https://farm3.staticflickr.com/2919/32726853103_ac1707e094_z.jpg',
    'https://tackexinh.com/wp-content/uploads/2021/01/hinh-anh-dep-chat-luong-001.jpg',
    'https://dbk.vn/uploads/ckfinder/images/1-content/anh-dep-1.jpg',
    'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
    'https://www.elle.vn/wp-content/uploads/2017/07/25/hinh-anh-dep-1.jpg',
    'https://farm3.staticflickr.com/2919/32726853103_ac1707e094_z.jpg',
    'https://tackexinh.com/wp-content/uploads/2021/01/hinh-anh-dep-chat-luong-001.jpg',
    'https://dbk.vn/uploads/ckfinder/images/1-content/anh-dep-1.jpg',
    'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
    'https://www.elle.vn/wp-content/uploads/2017/07/25/hinh-anh-dep-1.jpg',
    'https://farm3.staticflickr.com/2919/32726853103_ac1707e094_z.jpg',
    'https://tackexinh.com/wp-content/uploads/2021/01/hinh-anh-dep-chat-luong-001.jpg',
    'https://dbk.vn/uploads/ckfinder/images/1-content/anh-dep-1.jpg',
    'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
    'https://www.elle.vn/wp-content/uploads/2017/07/25/hinh-anh-dep-1.jpg',
    'https://farm3.staticflickr.com/2919/32726853103_ac1707e094_z.jpg',
    'https://tackexinh.com/wp-content/uploads/2021/01/hinh-anh-dep-chat-luong-001.jpg',
    'https://dbk.vn/uploads/ckfinder/images/1-content/anh-dep-1.jpg',
    'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
    'https://www.elle.vn/wp-content/uploads/2017/07/25/hinh-anh-dep-1.jpg',
    'https://farm3.staticflickr.com/2919/32726853103_ac1707e094_z.jpg',
    'https://tackexinh.com/wp-content/uploads/2021/01/hinh-anh-dep-chat-luong-001.jpg',
    'https://dbk.vn/uploads/ckfinder/images/1-content/anh-dep-1.jpg',
    'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
    'https://www.elle.vn/wp-content/uploads/2017/07/25/hinh-anh-dep-1.jpg',
    'https://farm3.staticflickr.com/2919/32726853103_ac1707e094_z.jpg',
    'https://tackexinh.com/wp-content/uploads/2021/01/hinh-anh-dep-chat-luong-001.jpg',
    'https://dbk.vn/uploads/ckfinder/images/1-content/anh-dep-1.jpg',
  ];

  // @override
  // Widget build(BuildContext context) {
  //   return LhBasePage(
  //       statusBarBrightness: Brightness.dark,
  //       appBarTop: LhAppBar.top(),
  //       child: SingleChildScrollView(
  //         child: Column(
  //           children: [
  //             LhSelecteds<String>(
  //               initialValue: images,
  //               containerBuilder: () {
  //                 return GridView(
  //                   scrollDirection: Axis.vertical,
  //                   physics: NeverScrollableScrollPhysics(),
  //                   shrinkWrap: true,
  //                   gridDelegate:
  //                       const SliverGridDelegateWithFixedCrossAxisCount(
  //                           crossAxisCount: 3, mainAxisExtent: 150),
  //                 );
  //               },
  //               addPosition: LhAddPosition.FIRST,
  //               addBuilder: () {
  //                 return GestureDetector(
  //                   onTap: () {
  //                     print('abc');
  //                   },
  //                   child: Container(
  //                     width: 100,
  //                     height: 100,
  //                     color: Colors.green,
  //                   ),
  //                 );
  //               },
  //               // containerBuilder: () {
  //               //   return ListView(
  //               //     scrollDirection: Axis.vertical,
  //               //   );
  //               // },
  //               builder: (index, item) {
  //                 return Container(
  //                   padding: EdgeInsets.all(10),
  //                   width: 100,
  //                   height: 100,
  //                   child: ClipRRect(
  //                       borderRadius: BorderRadius.circular(8.0),
  //                       child: LhCachedImageWidget(
  //                         imageUrl: images[index],
  //                       )),
  //                 );
  //               },
  //               removeBuilder: (index, item) {
  //                 return Align(
  //                     alignment: Alignment.topRight,
  //                     child: GestureDetector(
  //                       onTap: () {
  //                         setState(() {
  //                           images.removeAt(index);
  //                         });
  //                       },
  //                       child: Container(
  //                           decoration: BoxDecoration(
  //                               color: Colors.black.withOpacity(0.8),
  //                               borderRadius: BorderRadius.circular(500.0)),
  //                           child: Icon(Icons.close, color: Colors.white)),
  //                     ));
  //               },
  //             ),
  //           ],
  //         ),
  //       ));
  // }
  // LhExpanableController _lhExpanableController =
  //     LhExpanableController(minimizeHeight: 300);

  // @override
  // Widget build(BuildContext context) {
  //   return Stack(
  //     children: [
  //       LhBasePage(
  //           statusBarBrightness: Brightness.dark,
  //           appBarTop: LhAppBar.top(),
  //           child: TextButton(
  //             child: Text('abc'),
  //             onPressed: () {
  //               _lhExpanableController.minimize();
  //             },
  //           )),
  //       LhExpanableView(
  //           controller: _lhExpanableController,
  //           child: LhBottomSheetUi(
  //             child: Container(),
  //           ),)
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return LhBasePage(
        appBarTop: LhAppBar.top(
          actions: [
                LhAppBarAction.icon(
                    onTap: () {},
                    iconFactor: .4,
                    // sizeFactor: 0.75,
                    icon: Image.asset('./assets/images/camera.png',  package: 'lhbase_v1' ,)),
                LhAppBarAction.icon(
                    onTap: () {
                      // AppNavigator.navigateProductStatistical();
                    },
                    iconFactor: .4,
                    icon: Icon(Icons.ac_unit)),
              ],
        ),
        child: Column(
          children: [
            Container(
              width: 200,
              color: Colors.green,
              child: LhInkwell(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6.0)),
                onTap: () {},
                child: Text(
                  'title',
                  style: LhStyle.DEFAULT_16,
                ),
              ),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
