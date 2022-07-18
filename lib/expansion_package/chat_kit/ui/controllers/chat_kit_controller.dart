import 'package:get/get.dart';
import 'package:lhbase_v1/expansion_package/chat_kit/models/chat_message.dart';
import 'package:lhbase_v1/expansion_package/chat_kit/models/chat_user.dart';
import 'package:lhbase_v1/expansion_package/chat_kit/models/themes/chat_view_theme_data.dart';
import 'audio_model.dart';

enum ChatBubblePosition {
  FIRST,
  MIDDLE,
  LAST,
  SINGLE,
  FIRST_MINE,
  MIDDLE_MINE,
  LAST_MINE,
  SINGLE_MINE
}

class ChatKitController extends GetxController {
  final LhChatUser user;
  Rx<ChatViewThemeData> _themeData = Rx(ChatViewThemeData());

  ChatViewThemeData get themeData => _themeData.value;

  set themeData(ChatViewThemeData themeData) {
    _themeData.value = themeData;
  }

 
  ChatKitController(
    this.user,
  ) {}

  init() {
    bubbleCount();
  }

  Rx<List<ChatMessage>> _messages = Rx([]);

  Rx<List<AudioModel>> audioController = Rx([]);


  List<ChatMessage> get messages => _messages.value;

  set messages(List<ChatMessage> message) {
    _messages.value = message;
    init();
  }

  Rx<bool> _isLoading = Rx<bool>(false);

  bool get isLoading => _isLoading.value;

  set isLoading(bool isLoading) {
    _isLoading.value = isLoading;
  }

  bubbleCount() {
    messages.asMap().forEach((index, message) {
      var isMine = user == messages[index].user;
      var bubbleType;

      ChatMessage? newerMessage, olderMessage;

      if (checkValidIndex(index - 1)) {
        olderMessage = messages[index - 1].user.id == message.user.id
            ? messages[index - 1]
            : null;
      }
      if (checkValidIndex(index + 1)) {
        newerMessage = messages[index + 1].user.id == message.user.id
            ? messages[index + 1]
            : null;
      }
      if (isMine) {
        if (olderMessage != null && newerMessage != null) {
          bubbleType = ChatBubblePosition.MIDDLE_MINE;
        } else if (olderMessage == null && newerMessage == null) {
          bubbleType = ChatBubblePosition.SINGLE_MINE;
        } else if (olderMessage == null) {
          bubbleType = ChatBubblePosition.LAST_MINE;
        } else if (newerMessage == null) {
          bubbleType = ChatBubblePosition.FIRST_MINE;
        }
      } else {
        if (olderMessage != null && newerMessage != null) {
          bubbleType = ChatBubblePosition.MIDDLE;
        } else if (olderMessage == null && newerMessage == null) {
          bubbleType = ChatBubblePosition.SINGLE;
        } else if (olderMessage == null) {
          bubbleType = ChatBubblePosition.LAST;
        } else if (newerMessage == null) {
          bubbleType = ChatBubblePosition.FIRST;
        }
      }
      message.position = bubbleType;
    });
    update();
  }

  bool checkValidIndex(int index) {
    return index >= 0 && index <= messages.length - 1;
  }

  playAudio(int idMess){
    audioController.value.forEach((element) {
      if(element.id == idMess){
        if(element.controller != null){
          if (element.controller!.playing) {
            element.controller!.stop();
          } else {
            element.controller!.play();
          }
        } else {
          if (element.controllerVideo!.value.isPlaying) {
            element.controllerVideo!.pause();
          } else {
            element.controllerVideo!.play();
          }
        }

      } else {
        if(element.controller != null)
          element.controller!.stop();
        else
          element.controllerVideo!.pause();
      }
    });
  }
}