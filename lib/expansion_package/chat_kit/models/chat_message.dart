import 'package:lhbase_v1/lhbase.dart';

enum MessageType {
  TEXT,
  IMAGE,
  AUDIO,
}

class ChatMessage {
  final LhChatUser user;
  final int id;
  final int status;
  String? text;
  final List<String>? imageUrls;
  final String? recoderUrl;
  ChatBubblePosition position = ChatBubblePosition.MIDDLE;

  ChatMessage({
    required this.user,
    required this.id,
    this.status = 1,
    this.text,
    this.imageUrls,
    this.recoderUrl,
  });

  MessageType get type {
    if (text != null)
      return MessageType.TEXT;
    else if (imageUrls != null)
      return MessageType.IMAGE;
    else if (recoderUrl != null) return MessageType.AUDIO;
    return MessageType.TEXT;
  }
}
