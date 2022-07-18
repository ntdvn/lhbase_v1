import 'package:flutter/material.dart';
import 'package:lhbase_v1/expansion_package/chat_kit/models/themes/bubble_theme_data.dart';
import 'package:lhbase_v1/expansion_package/chat_kit/models/themes/room_theme_data.dart';
import 'package:lhbase_v1/expansion_package/chat_kit/models/themes/text_message_theme_data.dart';

class ChatViewThemeData {
  RoomThemeData roomThemeData = RoomThemeData();
  BubbleThemeData bubbleThemeData = BubbleThemeData();
  BubbleThemeData mBubbleThemeData = BubbleThemeData();
  TextMessageThemeData textMessageThemeData =
      TextMessageThemeData(textStyle: TextStyle(color: Colors.white, fontSize: 16));
  TextMessageThemeData mTextMessageThemeData =
      TextMessageThemeData(textStyle: TextStyle(color: Colors.white, fontSize: 16));

  ChatViewThemeData() {}
}
