import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/expansion_package/expansion_package.dart';
import 'package:lhbase_v1/ui/ui.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatKitController _chatKitController;
  @override
  void initState() {
    var dat = ChatUser(
        username: "Tiot-1",
        imageUrl:
            'https://i.pinimg.com/736x/70/ed/da/70edda522b0e5673b231dad1b425b904.jpg',
        id: 1);
    Get.put(ChatKitController(dat));
    _chatKitController = Get.find<ChatKitController>();
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
          onMessagedClicked: (message) {
            print('message $message');
          },
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
