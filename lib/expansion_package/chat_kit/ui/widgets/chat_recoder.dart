import 'package:flutter/material.dart';
import 'package:lhbase_v1/expansion_package/chat_kit/chat_kit.dart';
import 'package:lhbase_v1/ui/ui.dart';

class ChatRecoder extends StatefulWidget {
  final ChatMessage message;
  const ChatRecoder({Key? key, required this.message}) : super(key: key);

  @override
  _ChatRecoderState createState() => _ChatRecoderState();
}

class _ChatRecoderState extends State<ChatRecoder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LhInkwell(
      onTap: () {},
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 15),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
            child: Icon(Icons.play_circle),
            margin: EdgeInsets.only(right: 10),
          ),
          Text('0:02')
        ],
      ),
    );
  }
}
