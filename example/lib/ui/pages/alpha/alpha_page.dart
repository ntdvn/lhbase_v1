import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  // LhStoryController _storyController1 = LhStoryController(
  //     stories: [],
  //     onCompleted: () {
  //       print('onCompleted');
  //     });
  // LhStoryController _storyController2 = LhStoryController(
  //     stories: [],
  //     onCompleted: () {
  //       print('onCompleted');
  //     });

  // @override
  // void initState() {
  //   Get.put(MediaPickerController());
  //   _mediaPickerController = Get.find<MediaPickerController>();
  //   _storyController1.stories = [
  //     Story(
  //         widget: Container(
  //       color: Colors.blue,
  //       child: Text('1'),
  //     )),
  //     Story(
  //         widget: Container(
  //       color: Colors.green,
  //       child: Text('2'),
  //     )),
  //     Story(
  //         widget: Container(
  //       color: Colors.red,
  //       child: Text('3'),
  //     )),
  //     // Story(
  //     //     image:
  //     //         'https://i.pinimg.com/originals/58/bd/4f/58bd4fc9ebfccc1f2de419529bbf1a12.jpg'),
  //     // Story(
  //     //     image:
  //     //         'https://www.wallpaperup.com/uploads/wallpapers/2015/03/06/633166/e8d825bde9f2127330224dbd1570e457.jpg'),
  //     Story(
  //         widget: Container(
  //       color: Colors.red,
  //       child: Text('co gi do sai sai'),
  //     )),
  //   ];
  //   _storyController2.stories = [
  //     // Story(
  //     //     image:
  //     //         'https://i.pinimg.com/originals/58/bd/4f/58bd4fc9ebfccc1f2de419529bbf1a12.jpg'),
  //     // Story(
  //     //     image:
  //     //         'https://www.wallpaperup.com/uploads/wallpapers/2015/03/06/633166/e8d825bde9f2127330224dbd1570e457.jpg'),
  //     Story(
  //         widget: Container(
  //       color: Colors.red,
  //       child: Text('co gi do sai sai'),
  //     )),
  //   ];
  //   super.initState();
  // }

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

  // @override
  // Widget build(BuildContext context) {
  //   return LhBasePage(
  //       appBarTop: LhAppBar.top(
  //         actions: [
  //               LhAppBarAction.icon(
  //                   onTap: () {},
  //                   iconFactor: .4,
  //                   // sizeFactor: 0.75,
  //                   icon: Image.asset('./assets/images/camera.png',  package: 'lhbase_v1' ,)),
  //               LhAppBarAction.icon(
  //                   onTap: () {
  //                     // AppNavigator.navigateProductStatistical();
  //                   },
  //                   iconFactor: .4,
  //                   icon: Icon(Icons.ac_unit)),
  //             ],
  //       ),
  //       child: Column(
  //         children: [
  //           Container(
  //             width: 200,
  //             color: Colors.green,
  //             child: LhInkwell(
  //               padding: EdgeInsets.zero,
  //               decoration: BoxDecoration(
  //                   color: Colors.red,
  //                   borderRadius: BorderRadius.circular(6.0)),
  //               onTap: () {},
  //               child: Text(
  //                 'title',
  //                 style: LhStyle.DEFAULT_16,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ));
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return LhBasePage(
  //     appBarTop: LhAppBar.top(
  //       leadingColor: Colors.black,
  //       // decoration: BoxDecoration(color: Colors.yellow),
  //       behavior: LhAppBarBehavior.STACKED,
  //       actions: [
  //         LhAppBarAction.icon(onTap: () {}, icon: Icon(Icons.g_mobiledata)),
  //         LhAppBarAction.icon(onTap: () {}, icon: Icon(Icons.g_mobiledata)),
  //         LhAppBarAction.icon(onTap: () {}, icon: Icon(Icons.g_mobiledata))
  //       ],
  //     ),
  //     child: SingleChildScrollView(
  //       child: Container(
  //         height: 1000,
  //         width: double.infinity,
  //         // color: Colors.red,
  //         padding: EdgeInsets.only(top: 80),
  //         child: Column(
  //           children: [
  //             Container(
  //               width: 300,
  //               child: LhInkwell(
  //                   // borderRadius: BorderRadius.zero,
  //                   onTap: () {},
  //                   decoration: BoxDecoration(
  //                       color: Colors.transparent,
  //                       border: Border.all(color: Colors.green, width: 1)),
  //                   child: Container(
  //                     child: Text('haha'),
  //                   )),
  //             ),
  //             LhInkwell(
  //                 // borderRadius: BorderRadius.zero,
  //                 onTap: () {},
  //                 decoration: BoxDecoration(
  //                   color: Colors.green,
  //                   // border: Border.all(color: Colors.green, width: 1)
  //                 ),
  //                 child: Container(
  //                   child: Text('haha'),
  //                 )),
  //             ListView.builder(
  //               physics: NeverScrollableScrollPhysics(),
  //               shrinkWrap: true,
  //               itemCount: 10,
  //               itemBuilder: (context, index) {
  //                 return LhInkwell(
  //                   onTap: () {
  //                     print('father');
  //                   },
  //                   child: Container(

  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       crossAxisAlignment: CrossAxisAlignment.center,
  //                       children: [
  //                         Container(
  //                           child: LhAvatar(
  //                               width: 46,
  //                               height: 46,
  //                               imageUrl:
  //                                   'https://toigingiuvedep.vn/wp-content/uploads/2021/05/hinh-anh-avatar-de-thuong.jpg'),
  //                         ),
  //                         Expanded(
  //                             child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               'Trần Hà',
  //                               style: LhStyle.DEFAULT_16
  //                                   .copyWith(fontWeight: FontWeight.w500),
  //                             ),
  //                             Text(
  //                               'Bạn có bức ảnh rất đẹp',
  //                               style: LhStyle.DEFAULT_14.copyWith(
  //                                   color: Colors.grey,
  //                                   fontWeight: FontWeight.w400),
  //                             ),
  //                           ],
  //                         )),
  //                         Column(
  //                           children: [
  //                             LhInkwell(
  //                               borderRadius: BorderRadius.circular(10.0),
  //                               // padding: EdgeInsets.all(5.0),
  //                               onTap: () {
  //                                 print('abc');
  //                               },
  //                               margin: EdgeInsets.only(bottom: 10),
  //                               child: Container(
  //                                   // color: Colors.red,
  //                                   width: 20,
  //                                   child: Icon(Icons.ac_unit_outlined)),
  //                             ),
  //                             LhText(
  //                               'abc',
  //                               style: LhStyle.DEFAULT_10.copyWith(
  //                                   color: Colors.grey,
  //                                   fontWeight: FontWeight.w400),
  //                             ),
  //                           ],
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 );
  //               },
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  late MediaPickerController _mediaPickerController;

  @override
  Widget build(BuildContext context) {
    return LhBasePage(
        child: MediaResourceView(
      mediaController: _mediaPickerController,
      // physics: const NeverScrollableScrollPhysics(),
      // shrinkWrap: true,
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
