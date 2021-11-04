import 'package:get/get.dart';
import 'package:lhbase_v1/lhbase.dart';

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
  final ChatUser user;
  Rx<ChatViewThemeData> _themeData = Rx(ChatViewThemeData());

  ChatViewThemeData get themeData => _themeData.value;

  set themeData(ChatViewThemeData themeData) {
    _themeData.value = themeData;
  }

  ChatKitController(
    this.user,
  ) {
    messages = [
      ChatMessage(user: nam, id: 1, recoderUrl: 'name day'),
      ChatMessage(user: dat, id: 1, recoderUrl: 'dat day'),
      ChatMessage(user: dat, id: 1, imageUrls: [
        'https://topshare.vn/wp-content/uploads/2021/01/Hinh-nen-dien-thoai-dep-va-doc-dao-1.jpg'
      ]),
      ChatMessage(user: dat, id: 1, imageUrls: [
        'https://topshare.vn/wp-content/uploads/2021/01/Hinh-nen-dien-thoai-dep-va-doc-dao-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      ]),
      ChatMessage(user: dat, id: 1, imageUrls: [
        'https://topshare.vn/wp-content/uploads/2021/01/Hinh-nen-dien-thoai-dep-va-doc-dao-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      ]),
      ChatMessage(user: dat, id: 1, imageUrls: [
        'https://topshare.vn/wp-content/uploads/2021/01/Hinh-nen-dien-thoai-dep-va-doc-dao-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      ]),
      ChatMessage(user: dat, id: 1, imageUrls: [
        'https://topshare.vn/wp-content/uploads/2021/01/Hinh-nen-dien-thoai-dep-va-doc-dao-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      ]),
      ChatMessage(user: dat, id: 1, imageUrls: [
        'https://topshare.vn/wp-content/uploads/2021/01/Hinh-nen-dien-thoai-dep-va-doc-dao-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
        'https://nhattientuu.com/wp-content/uploads/2020/08/hinh-anh-dep-1.jpg',
      ]),
      ChatMessage(user: dat, id: 1, text: 'alkjhfalksfjklasfjlka', status: 0),
      ChatMessage(user: dat, id: 1, text: 'abc'),
      ChatMessage(user: dat, id: 1, text: 'alo alo'),
      ChatMessage(user: dat, id: 1, text: 'Xin chào'),
      ChatMessage(user: dat, id: 1, text: 'Ừm'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: dat, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: dat, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: dat, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: 'alo alo'),
      ChatMessage(user: nam, id: 1, text: '123'),
      ChatMessage(
          user: nam,
          id: 1,
          text:
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum'),
      ChatMessage(user: nam, id: 1, imageUrls: [
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
  }

  init() {
    print('init');
    bubbleCount();
  }

  Rx<List<ChatMessage>> _messages = Rx([]);

  List<ChatMessage> get messages => _messages.value;

  set messages(List<ChatMessage> message) {
    _messages.value = message;
    init();
  }

  var dat = ChatUser(
      username: "Tiot-1",
      imageUrl:
          'https://i.pinimg.com/736x/70/ed/da/70edda522b0e5673b231dad1b425b904.jpg',
      id: 1);
  var nam = ChatUser(
      username: "Tiot-2",
      imageUrl:
          'https://i.pinimg.com/736x/70/ed/da/70edda522b0e5673b231dad1b425b904.jpg',
      id: 2);

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
}
