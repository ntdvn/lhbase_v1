import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';


class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  FocusNode _inputFocusNode = FocusNode();
  TextEditingController _inputEditController = TextEditingController();
  ScrollController _messageListController = ScrollController();
  String _inputText = '';

  LhExpanableController _mediaExpanableController =
      LhExpanableController(minimizeHeight: 300);
  late MediaPickerController _mediaPickerController;


  late ChatKitController _chatKitController;
  late ChatToolbarController _chatToolbarController;

  // <RECODER>


  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;

  var dat = LhChatUser(
      username: "Tiot-1",
      imageUrl:
          'https://i.pinimg.com/736x/70/ed/da/70edda522b0e5673b231dad1b425b904.jpg',
      id: 1);
  var nam = LhChatUser(
      username: "Tiot-2",
      imageUrl:
          'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      id: 2);
  var viet = LhChatUser(
      username: "Tiot-3",
      imageUrl:
          'https://topshare.vn/wp-content/uploads/2021/01/Hinh-nen-dien-thoai-dep-va-doc-dao-1.jpg',
      id: 3);

  // </RECODER>

  @override
  void initState() {
    _mediaPickerController = Get.put(MediaPickerController(number: 10));


    Get.put(ChatKitController(LhChatUser(
        username: "Tiot-1",
        imageUrl:
            'https://i.pinimg.com/736x/70/ed/da/70edda522b0e5673b231dad1b425b904.jpg',
        id: 1)));
    _chatToolbarController = Get.put(ChatToolbarController());
    _chatToolbarController.themeData.toolbarThemeData.inputBackgroundColor =
        Color(0xFFF0F2F5);
    _chatKitController = Get.find<ChatKitController>();
    _chatKitController.themeData.roomThemeData.backgroundColor = Colors.white;
    _chatKitController.themeData.bubbleThemeData.backgroundColor =
        Colors.grey;
    _chatKitController.themeData.mBubbleThemeData.backgroundColor = Colors.green;

    _chatKitController.messages = [
      ChatMessage(
          user: nam,
          id: 1,
          time: DateTime.parse('2022-06-10T03:21:08.000000Z'),
          is_hidden: false,
          recoderUrl:
              'https://vichatcrm.vn/storage/uploads/22/pOitUUljiX1xwI384NnZ7zP5pFjLCBekrD9J6Zvd.mp4'),
      ChatMessage(user: dat, id: 1, time: DateTime.parse('2022-06-09T03:44:08.000000Z'),is_hidden: false,text: 'tin nhắn âm thanh bị thu hồi'),
      ChatMessage(
          user: nam,
          id: 1,
          time: DateTime.parse('2022-06-10T03:21:08.000000Z'),
          is_hidden: true,
          recoderUrl:
              'https://vichatcrm.vn/storage/uploads/22/pOitUUljiX1xwI384NnZ7zP5pFjLCBekrD9J6Zvd.mp4'),
      ChatMessage(user: dat, id: 1,time: DateTime.parse('2022-06-10T03:22:08.000000Z'),is_hidden: false, imageUrls: [
        'https://topshare.vn/wp-content/uploads/2021/01/Hinh-nen-dien-thoai-dep-va-doc-dao-1.jpg'
      ]),
      ChatMessage(user: dat, id: 1,time: DateTime.parse('2022-06-10T03:23:08.000000Z'),is_hidden: false, video: 'https://vichatcrm.vn/storage/uploads/22/JzAYB6vp4VFQbEAEwSrd3eSisJQ14FO4GfajDqqv.mp4'),
      ChatMessage(user: dat, id: 1, time: DateTime.parse('2022-06-09T03:44:08.000000Z'),is_hidden: false,text: 'tin nhắn video bị thu hồi'),
      ChatMessage(user: nam, id: 2, time: DateTime.parse('2022-06-10T03:25:08.000000Z'),is_hidden: true,video: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'),
      ChatMessage(user: dat, id: 2, time: DateTime.parse('2022-06-10T03:44:08.000000Z'),is_hidden: false,imageUrls: [
        'https://topshare.vn/wp-content/uploads/2021/01/Hinh-nen-dien-thoai-dep-va-doc-dao-1.jpg'
      ]),
      ChatMessage(user: dat, id: 1, time: DateTime.parse('2022-06-10T03:44:08.000000Z'),is_hidden: false,imageUrls: [
        'https://topshare.vn/wp-content/uploads/2021/01/Hinh-nen-dien-thoai-dep-va-doc-dao-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      ]),
      ChatMessage(user: dat, id: 1, time: DateTime.parse('2022-06-10T03:44:08.000000Z'),is_hidden: false,imageUrls: [
        'https://topshare.vn/wp-content/uploads/2021/01/Hinh-nen-dien-thoai-dep-va-doc-dao-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      ]),
      ChatMessage(user: dat, id: 1, time: DateTime.parse('2022-06-10T03:44:08.000000Z'),is_hidden: false,imageUrls: [
        'https://topshare.vn/wp-content/uploads/2021/01/Hinh-nen-dien-thoai-dep-va-doc-dao-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      ]),
      ChatMessage(user: dat, id: 1, time: DateTime.parse('2022-06-10T03:44:08.000000Z'),is_hidden: false,imageUrls: [
        'https://topshare.vn/wp-content/uploads/2021/01/Hinh-nen-dien-thoai-dep-va-doc-dao-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      ]),
      ChatMessage(user: dat, id: 1, time: DateTime.parse('2022-06-10T03:44:08.000000Z'),is_hidden: false,text: 'alo alo'),
      ChatMessage(user: nam, id: 1, time: DateTime.parse('2022-06-10T03:44:08.000000Z'),is_hidden: false,text: 'alo alo trên là tin nhắn ảnh bị thu hồi'),
      ChatMessage(user: dat, id: 1, time: DateTime.parse('2022-06-09T03:44:08.000000Z'),is_hidden: true,imageUrls: [
        'https://topshare.vn/wp-content/uploads/2021/01/Hinh-nen-dien-thoai-dep-va-doc-dao-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      ]),
      ChatMessage(user: dat, id: 1, time: DateTime.parse('2022-06-09T03:44:08.000000Z'),is_hidden: false,text: 'alkjhfalksfjklasfjlka', status: 0),
      ChatMessage(user: dat, id: 1, time: DateTime.parse('2022-06-09T03:44:08.000000Z'),is_hidden: false,text: 'abc'),
      ChatMessage(user: viet, id: 1, time: DateTime.parse('2022-06-09T03:44:08.000000Z'),is_hidden: false,text: 'alo alo'),
      ChatMessage(user: dat, id: 1, time: DateTime.parse('2022-06-09T03:44:08.000000Z'),is_hidden: false,text: 'Xin chào'),
      ChatMessage(user: dat, id: 1, time: DateTime.parse('2022-06-09T03:44:08.000000Z'),is_hidden: false,text: 'Ừm'),
      ChatMessage(user: nam, id: 1, time: DateTime.parse('2022-06-09T03:44:08.000000Z'),is_hidden: true,text: 'alo alo'),
      ChatMessage(user: dat, id: 1, time: DateTime.parse('2022-06-09T03:44:08.000000Z'),is_hidden: true,text: 'alo alo'),
      ChatMessage(user: nam, id: 1, time: DateTime.parse('2022-06-09T03:44:08.000000Z'),is_hidden: false,text: 'alo alo'),
      ChatMessage(user: dat, id: 1, time: DateTime.parse('2022-06-09T03:44:08.000000Z'),is_hidden: false,text: 'alo alo'),
      ChatMessage(user: nam, id: 1, time: DateTime.parse('2022-06-09T03:44:08.000000Z'),is_hidden: false,text: 'alo alo'),
      ChatMessage(user: nam, id: 1, time: DateTime.parse('2022-06-09T03:44:08.000000Z'),is_hidden: false,text: 'alo alo'),
      ChatMessage(user: nam, id: 1, time: DateTime.parse('2022-06-09T03:44:08.000000Z'),is_hidden: false,text: 'alo alo'),
      ChatMessage(user: dat, id: 1, time: DateTime.parse('2022-06-09T03:44:08.000000Z'),is_hidden: false,text: 'alo alo2222'),
      ChatMessage(user: dat, id: 1, time: DateTime.parse('2022-06-08T03:44:08.000000Z'),is_hidden: false,text: 'alo alo'),
      ChatMessage(user: nam, id: 1, time: DateTime.parse('2022-06-08T03:44:08.000000Z'),is_hidden: false,text: 'alo alo'),
      ChatMessage(user: nam, id: 1, time: DateTime.parse('2022-06-08T03:44:08.000000Z'),is_hidden: false,text: 'alo alo'),
      ChatMessage(user: nam, id: 1, time: DateTime.parse('2022-06-08T03:44:08.000000Z'),is_hidden: false,text: 'alo alo'),
      ChatMessage(user: nam, id: 1, time: DateTime.parse('2022-06-08T03:44:08.000000Z'),is_hidden: false,text: 'alo alo'),
      ChatMessage(user: viet, id: 1, time: DateTime.parse('2022-06-08T03:44:08.000000Z'),is_hidden: false,text: 'alo alo'),
      ChatMessage(user: viet, id: 1, time: DateTime.parse('2022-06-08T03:44:08.000000Z'),is_hidden: false,text: 'alo alo'),
      ChatMessage(user: viet, id: 1, time: DateTime.parse('2022-06-08T03:44:08.000000Z'),is_hidden: false,text: 'alo alo'),
      ChatMessage(user: nam, id: 1, time: DateTime.parse('2022-06-08T03:44:08.000000Z'),is_hidden: false,text: '123'),
      ChatMessage(
          user: nam,
          id: 1,
          time: DateTime.parse('2022-06-08T03:44:08.000000Z'),
          is_hidden: false,
          text:
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum'),
      ChatMessage(user: nam, id: 1, time: DateTime.parse('2022-06-08T03:44:08.000000Z'),
          is_hidden: false,
          imageUrls: [
        'https://baoninhbinh.org.vn//DATA/ARTICLES/2021/5/17/cuoc-dua-lot-vao-top-100-anh-dep-di-san-van-hoa-va-thien-7edf3.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://sites.google.com/site/hinhanhdep24h/_/rsrc/1436687439788/home/hinh%20anh%20thien%20nhien%20dep%202015%20%281%29.jpeg',
        'https://baoninhbinh.org.vn//DATA/ARTICLES/2021/5/17/cuoc-dua-lot-vao-top-100-anh-dep-di-san-van-hoa-va-thien-7edf3.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://sites.google.com/site/hinhanhdep24h/_/rsrc/1436687439788/home/hinh%20anh%20thien%20nhien%20dep%202015%20%281%29.jpeg',
        'https://sites.google.com/site/hinhanhdep24h/_/rsrc/1436687439788/home/hinh%20anh%20thien%20nhien%20dep%202015%20%281%29.jpeg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      ]),
    ];
    super.initState();
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LhBasePage(
            appBarTop: LhAppBar.top(
              leadingColor: Colors.black,
              backgroundColor: Colors.white,
              titles: GestureDetector(
                onTap: () {
                  //AppNavigator.navigateChatConfig();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'chat_room_avatar',
                      child: LhAvatar(
                          height: 36,
                          width: 36,
                          isOnline: true,
                          imageUrl: 'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg'),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Tiot',
                            style: LhStyle.DEFAULT_16
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Online',
                            style: LhStyle.DEFAULT_12.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF6F6F6F)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                LhAppBarAction.icon(
                  icon: Icon(Icons.more_horiz),
                  onTap: () {
                    //AppNavigator.navigateChatConfigGroup();
                    // AppNavigator.navigateChatConfigGroup();
                  },
                )
              ],
            ),
            appBarBottom: LhAppBar.bottomEmpty(),
            child: LhChatView(
              controller: _chatKitController,
              onLoadMore: () {
                _chatKitController.isLoading = true;
                Future.delayed(Duration(seconds: 2), () {
                  _chatKitController.isLoading = false;
                });
              },
              onMessagedClicked: (message) {},
              onMessagedLongClicked: (mess){
                print('delete message ${mess.id}');
              },
              onAvatarClicked: (message){
                print('avatar');
              },
              toolBar: ChatToolbar(
                controller: _chatToolbarController,

                rightActionsBuilder: (state, output) {
                  return [
                    if (output.text.isNotEmpty)
                      ChatKitAction(
                          widget: LhAppBarAction.icon(
                              onTap: () {},
                              iconFactor: 0.7,
                              icon: Icon(Icons.send)),
                          onTap: () {

                          }),
                  ];
                },
                leftActionsBuilder: (state, output) {
                  print('leftActionsBuilder ${state.toolbarRightFlag}');
                  return state.toolbarRightFlag
                      ? [
                          ChatKitAction(
                              widget: const Icon(
                                Icons.add_circle,
                                color: Colors.green,
                              ),
                              onTap: () {
                                _chatToolbarController
                                    .changeToolbarRightFlag(false);
                              }),
                          ChatKitAction(
                              widget: Icon(
                                Icons.camera_alt,
                                color: Colors.green,
                              ),
                              onTap: () {}),
                          ChatKitAction(
                              widget: Icon(
                                Icons.image,
                                color: Colors.green,
                              ),
                              onTap: () {}),
                          ChatKitAction(
                              widget: Icon(
                                Icons.mic,
                                color: Colors.green,
                              ),
                              onTap: () {}),
                        ]
                      : [
                          ChatKitAction(
                              widget: Icon(
                                Icons.chevron_right,
                                color: Colors.green,
                              ),
                              onTap: () {
                                _chatToolbarController
                                    .changeToolbarRightFlag(true);
                                // print(
                                //     "chatkit ${_chatKitController.state.toolbarRightFlag}");
                              }),
                        ];
                },
                // controller: TextEditingController(),
                focusNode: FocusNode(),
              ),
            )),
        MediaPickerView(
          viewController: _mediaExpanableController,
          mediaManagerController: _mediaPickerController,
          onSubmitted: (value) {
            _mediaExpanableController.closed();
          },
        )
      ],
    );
  }

  Widget _buildRecodingInput() {
    return Container(
      color: Colors.white,
      child: Row(
        children: [LhAppBarAction.icon(onTap: () {}, icon: Icon(Icons.delete))],
      ),
    );
  }



  @override
  void dispose() {
    super.dispose();
  }
}
