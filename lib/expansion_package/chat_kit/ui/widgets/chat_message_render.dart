import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lhbase_v1/lhbase.dart';

class MessageRender extends StatelessWidget {
  final ChatMessage message;
  const MessageRender({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var renderMessage;
    switch (message.type) {
      case MessageType.TEXT:
        renderMessage = ChatText(
          message: message,
        );
        break;
      case MessageType.IMAGE:
        renderMessage = ChatImages(imageUrls: message.imageUrls!);
        break;
      case MessageType.AUDIO:
        renderMessage = ChatRecoder(
          message: message,
        );
        break;
      default:
        renderMessage = Container();
        break;
    }
    return GetBuilder<ChatKitController>(
      builder: (controller) {
        // return FractionallySizedBox(widthFactor: 1, child: renderMessage);
        return renderMessage;
      },
    );
  }
}
