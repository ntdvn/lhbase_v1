import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lhbase_v1/expansion_package/chat_kit/models/chat_message.dart';
import 'package:lhbase_v1/expansion_package/chat_kit/ui/controllers/audio_model.dart';
import 'package:lhbase_v1/expansion_package/chat_kit/ui/controllers/chat_kit_controller.dart';
import 'package:lhbase_v1/global/routes/lh_pages.dart';
import 'package:lhbase_v1/res/lh_styles.dart';
import 'package:lhbase_v1/res/lh_values.dart';
import 'package:lhbase_v1/ui/widgets/lh_text.dart';
import 'package:video_player/video_player.dart';

class ChatVideo extends StatefulWidget {
  final ChatMessage message;
  final DateTime time;
  const ChatVideo({Key? key, required this.message, required this.time}) : super(key: key);

  @override
  State<ChatVideo> createState() => _ChatVideoState();
}

class _ChatVideoState extends State<ChatVideo> {

  VideoPlayerController? _controller;
  ChatKitController chatKitController = Get.find<ChatKitController>();

  @override
  void initState() {
    if(widget.message.video != null)
    _controller = VideoPlayerController.network(widget.message.video!)
      ..initialize().then((_) {
        setState(() {

        });
      });

    _controller!.pause();
    AudioModel data = AudioModel(widget.message.id, null, _controller, ()=>setState(() {

    }));
    if(chatKitController.audioController.value.contains(data) == false)
      chatKitController.audioController.value.add(data);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatKitController>(
      builder: (controller) {
        return widget.message.is_hidden == false ? GestureDetector(
          onTap: ()=> Get.toNamed(LhPages.play_video_online_screen, arguments: widget.message.video),
          child: Container(
            height: Get.width/2,
            key: UniqueKey(),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Center(
                  child: VideoPlayer(_controller!),
                ),

                Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 50.0,
                      semanticLabel: 'Play',
                    ),
                  )
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: VideoProgressIndicator(
                    _controller!,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                        playedColor: Colors.white
                    ),
                  ),
                ),

              ],
            )
          ),
        ) : Container(
          color: Colors.transparent,
          key: UniqueKey(),
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: controller.user == widget.message.user ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                'Tin nhắn đã được thu hồi',
                style: controller.user == widget.message.user
                    ? controller.themeData.textMessageThemeData.textStyle
                    : controller.themeData.mTextMessageThemeData.textStyle,
                textAlign: TextAlign.start,
                softWrap: true,
                maxLines: null,
                textWidthBasis: TextWidthBasis.longestLine,
              ),
              Container(
                padding: EdgeInsets.only(top: 8),
                child: LhText(LhValue.dateTimeToTime(widget.time), style: LhStyle.DEFAULT_12.copyWith(color: Colors.grey[100]),),
              )
            ],
          ),
        );
      },
    );
  }
}
