import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/expansion_package/chat_toolbar/ui/ui.dart';
import 'package:lhbase_v1/expansion_package/expansion_package.dart';
import 'package:lhbase_v1/ui/ui.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatKitController _chatKitController;
  late ChatToolbarController _chatToolbarController;

  var dat = ChatUser(
      username: "Tiot-1",
      imageUrl:
          'https://i.pinimg.com/736x/70/ed/da/70edda522b0e5673b231dad1b425b904.jpg',
      id: 1);
  var nam = ChatUser(
      username: "Tiot-2",
      imageUrl:
          'https://i.pinimg.com/736x/70/ed/da/70edda522b0e5673b231dad1b425b904.jpg',
      id: 2);

  @override
  void initState() {
    var dat = ChatUser(
        username: "Tiot-1",
        imageUrl:
            'https://i.pinimg.com/736x/70/ed/da/70edda522b0e5673b231dad1b425b904.jpg',
        id: 1);
    Get.put(ChatKitController(dat));
    _chatToolbarController = Get.put(ChatToolbarController());
    _chatKitController = Get.find<ChatKitController>();

    _chatKitController.messages = [
      ChatMessage(
          user: nam,
          id: 1,
          recoderUrl:
              'https://tainhac123.com/listen/em-cua-ngay-hom-qua-son-tung-m-tp.9Fd4zVvPMIbf.html'),
      // ChatMessage(user: dat, id: 1, recoderUrl: 'dat day'),
      // ChatMessage(user: dat, id: 1, imageUrls: [
      //   'https://topshare.vn/wp-content/uploads/2021/01/Hinh-nen-dien-thoai-dep-va-doc-dao-1.jpg'
      // ]),
      // ChatMessage(user: dat, id: 1, imageUrls: [
      //   'https://topshare.vn/wp-content/uploads/2021/01/Hinh-nen-dien-thoai-dep-va-doc-dao-1.jpg',
      //   'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      // ]),
      // ChatMessage(user: dat, id: 1, imageUrls: [
      //   'https://topshare.vn/wp-content/uploads/2021/01/Hinh-nen-dien-thoai-dep-va-doc-dao-1.jpg',
      //   'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      //   'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      // ]),
      // ChatMessage(user: dat, id: 1, imageUrls: [
      //   'https://topshare.vn/wp-content/uploads/2021/01/Hinh-nen-dien-thoai-dep-va-doc-dao-1.jpg',
      //   'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      //   'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      //   'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      // ]),
      // ChatMessage(user: dat, id: 1, imageUrls: [
      //   'https://topshare.vn/wp-content/uploads/2021/01/Hinh-nen-dien-thoai-dep-va-doc-dao-1.jpg',
      //   'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      //   'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      //   'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      //   'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      // ]),
      // ChatMessage(user: dat, id: 1, imageUrls: [
      //   'https://topshare.vn/wp-content/uploads/2021/01/Hinh-nen-dien-thoai-dep-va-doc-dao-1.jpg',
      //   'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      //   'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      //   'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      //   'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      //   'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      // ]),
      ChatMessage(user: dat, id: 1, text: 'alkjhfalksfjklasfjlka', status: 0),
      ChatMessage(user: dat, id: 1, text: 'abc'),
      ChatMessage(user: dat, id: 1, text: 'alo alo'),
      ChatMessage(user: dat, id: 1, text: 'Xin chào'),
      ChatMessage(user: dat, id: 1, text: 'Ừm'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: dat, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: dat, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: dat, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: '123'),
      ChatMessage(
          user: nam,
          id: 1,
          text:
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum'),
      // ChatMessage(user: nam, id: 1, imageUrls: [
      //   'https://baoninhbinh.org.vn//DATA/ARTICLES/2021/5/17/cuoc-dua-lot-vao-top-100-anh-dep-di-san-van-hoa-va-thien-7edf3.jpg',
      //   'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      //   'https://sites.google.com/site/hinhanhdep24h/_/rsrc/1436687439788/home/hinh%20anh%20thien%20nhien%20dep%202015%20%281%29.jpeg',
      //   'https://baoninhbinh.org.vn//DATA/ARTICLES/2021/5/17/cuoc-dua-lot-vao-top-100-anh-dep-di-san-van-hoa-va-thien-7edf3.jpg',
      //   'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      //   'https://sites.google.com/site/hinhanhdep24h/_/rsrc/1436687439788/home/hinh%20anh%20thien%20nhien%20dep%202015%20%281%29.jpeg',
      //   'https://sites.google.com/site/hinhanhdep24h/_/rsrc/1436687439788/home/hinh%20anh%20thien%20nhien%20dep%202015%20%281%29.jpeg',
      //   'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      // ]),
    ];
    super.initState();
  }

  List<Color> backgroundColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.redAccent
  ];

  List<String> backgroundImages = [
    'https://truongquochoc.com/wp-content/uploads/2020/10/40-hinh-nen-powerpoint-dep-nhieu-chu-de-2.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQu-OTJ2tFV6MBvpGMe35GaLoMoprOrNN3uIQ&usqp=CAU',
    'https://toigingiuvedep.vn/wp-content/uploads/2021/04/hinh-nen-powerpoint-3d-hoa-tiet-cute-de-thuong.jpg',
    'https://phunugioi.com/wp-content/uploads/2020/09/hinh-nen-slide-dep.jpg',
    'https://hedieuhanh.com/wp-content/uploads/2018/11/hinh-nen-dep-powerpoint-1_082903321.jpeg'
  ];

  List<MapEntry<Color, Color>> bubbleColors = [
    MapEntry(Colors.grey, Colors.blueAccent),
    MapEntry(Colors.blue, Colors.green),
    MapEntry(Colors.pink, Colors.amber),
    MapEntry(Colors.black, Colors.cyan),
  ];

  @override
  Widget build(BuildContext context) {
    return LhBasePage(
        appBarTop: LhAppBar.top(
          actions: [
            LhAppBarAction.icon(
                onTap: () {
                  Get.bottomSheet(Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitle('Background colors'),
                        Row(
                          children: [
                            ...List.generate(
                                backgroundColors.length,
                                (index) => LhInkwell(
                                      onTap: () {
                                        _chatKitController.themeData
                                                .roomThemeData.backgroundColor =
                                            backgroundColors[index];
                                        _chatKitController.update();
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        color: backgroundColors[index],
                                      ),
                                    ))
                          ],
                        ),
                        _buildTitle('Background images'),
                        Row(
                          children: [
                            ...List.generate(
                                backgroundImages.length,
                                (index) => LhInkwell(
                                      onTap: () {
                                        _chatKitController.themeData
                                                .roomThemeData.backgroundImage =
                                            backgroundImages[index];
                                        _chatKitController.update();
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        child: Image.network(
                                            backgroundImages[index]),
                                      ),
                                    ))
                          ],
                        ),
                        _buildTitle('Bubble colors'),
                        Row(
                          children: [
                            ...List.generate(
                              bubbleColors.length,
                              (index) => LhInkwell(
                                onTap: () {
                                  _chatKitController.themeData.mBubbleThemeData
                                          .backgroundColor =
                                      bubbleColors[index].key;
                                  _chatKitController.themeData.bubbleThemeData
                                          .backgroundColor =
                                      bubbleColors[index].value;
                                  _chatKitController.update();
                                },
                                child: Container(
                                    width: 40,
                                    height: 40,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 40,
                                          color: bubbleColors[index].key,
                                        ),
                                        Container(
                                          width: 20,
                                          height: 40,
                                          color: bubbleColors[index].value,
                                        )
                                      ],
                                    )),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ));
                },
                icon: Icon(Icons.settings))
          ],
        ),
        appBarBottom: LhAppBar.bottomEmpty(),
        child: ChatView(
          controller: _chatKitController,
          onLoadMore: () {
            _chatKitController.isLoading = true;
            Future.delayed(Duration(seconds: 2), () {
              _chatKitController.isLoading = false;
            });
          },
          onMessagedClicked: (message) {},
          toolBar: ChatToolbar(
            controller: _chatToolbarController,
            rightActionsBuilder: (state, output) {
              return [
                if (output.text.isNotEmpty)
                  ChatKitAction(widget: Icon(Icons.send), onTap: () {}),
              ];
            },
            leftActionsBuilder: (state, output) {
              return state.toolbarRightFlag
                  ? [
                      ChatKitAction(
                          widget: Icon(Icons.add_circle), onTap: () {}),
                      ChatKitAction(widget: Icon(Icons.mic), onTap: () {}),
                      ChatKitAction(
                          widget: Icon(Icons.camera_alt), onTap: () {}),
                      ChatKitAction(widget: Icon(Icons.image), onTap: () {}),
                    ]
                  : [
                      ChatKitAction(
                          widget: Icon(Icons.chevron_right),
                          onTap: () {
                            // _chatKitController.changeToolbarRightFlag(true);
                            // print(
                            //     "chatkit ${_chatKitController.state.toolbarRightFlag}");
                          }),
                    ];
            },
            // controller: TextEditingController(),
            focusNode: FocusNode(),
          ),
        ));
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }
}
