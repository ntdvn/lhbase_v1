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
  final bool is_hidden;
  String? text;
  final List<String>? imageUrls;
  final String? video;
  final String? recoderUrl;
  final Widget? product, order;
  final DateTime time;
  ChatBubblePosition position = ChatBubblePosition.MIDDLE;

  ChatMessage({
    required this.user,
    required this.id,
    required this.is_hidden,
    this.status = 1,
    this.text,
    this.imageUrls,
    this.video,
    this.recoderUrl,
    this.product,
    this.order,
    required this.time,
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
