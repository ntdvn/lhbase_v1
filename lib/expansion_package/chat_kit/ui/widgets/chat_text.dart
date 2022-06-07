import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lhbase_v1/lhbase.dart';

class ChatText extends StatelessWidget {
  final ChatMessage message;
  const ChatText({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatKitController>(
      builder: (controller) {
        return Container(
          key: UniqueKey(),
          padding: EdgeInsets.all(10.0),
          child: Text(
            message.text ?? '',
            style: controller.user == message.user
                ? controller.themeData.textMessageThemeData.textStyle
                : controller.themeData.mTextMessageThemeData.textStyle,
            textAlign: TextAlign.start,
            softWrap: true,
            maxLines: null,
            textWidthBasis: TextWidthBasis.longestLine,
          ),
        );
      },
    );
  }
}
