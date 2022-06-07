import 'package:flutter/cupertino.dart';
import 'package:lhbase_v1/lhbase.dart';

enum MessageType {
  TEXT,
  IMAGE,
  VIDEO,
  AUDIO,
  PRODUCT,
  ORDER
}

class ChatMessage {
  final LhChatUser user;
  final int id;
  final int status;
  String? text;
  final List<String>? imageUrls;
  final String? video;
  final String? recoderUrl;
  final Widget? product, order;
  ChatBubblePosition position = ChatBubblePosition.MIDDLE;

  ChatMessage({
    required this.user,
    required this.id,
    this.status = 1,
    this.text,
    this.imageUrls,
    this.video,
    this.recoderUrl,
    this.product,
    this.order,
  });

  MessageType get type {
    if (text != null)
      return MessageType.TEXT;
    else if (imageUrls != null)
      return MessageType.IMAGE;
    else if (video != null)
      return MessageType.VIDEO;
    else if (product != null)
      return MessageType.PRODUCT;
    else if (order != null)
      return MessageType.ORDER;
    else if (recoderUrl != null) return MessageType.AUDIO;
    return MessageType.TEXT;
  }
}
