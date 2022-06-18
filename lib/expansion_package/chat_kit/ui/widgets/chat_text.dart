import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lhbase_v1/lhbase.dart';

class ChatText extends StatefulWidget {
  final ChatMessage message;
  final DateTime time;
  const ChatText({Key? key, required this.message, required this.time}) : super(key: key);

  @override
  State<ChatText> createState() => _ChatTextState();
}

class _ChatTextState extends State<ChatText> {

  bool seeTime = true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatKitController>(
      builder: (controller) {
        return Container(
          color: Colors.transparent,
          key: UniqueKey(),
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: controller.user == widget.message.user ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                widget.message.is_hidden == false ? widget.message.text ?? '' : 'Tin nhắn đã được thu hồi',
                style: controller.user == widget.message.user
                    ? controller.themeData.textMessageThemeData.textStyle
                    : controller.themeData.mTextMessageThemeData.textStyle,
                textAlign: TextAlign.start,
                softWrap: true,
                maxLines: null,
                textWidthBasis: TextWidthBasis.longestLine,
              ),
              seeTime ? Container(
                padding: EdgeInsets.only(top: 8),
                child: LhText(LhValue.dateTimeToTime(widget.time), style: LhStyle.DEFAULT_12.copyWith(color: Colors.grey[100]),),
              ) : SizedBox()
            ],
          ),
        );
      },
    );
  }
}
