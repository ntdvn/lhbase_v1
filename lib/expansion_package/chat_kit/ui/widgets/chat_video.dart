import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lhbase_v1/expansion_package/chat_kit/ui/widgets/controls_overlay_screen.dart';
import 'package:lhbase_v1/lhbase.dart';
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

  @override
  void initState() {
    if(widget.message.video != null)
    _controller = VideoPlayerController.network(widget.message.video!)
      ..initialize().then((_) {
        setState(() {

        });
      });

    _controller!.pause();
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
        return widget.message.is_hidden == false ? Container(
          key: UniqueKey(),
          child: AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                VideoPlayer(_controller!),
                ControlsOverlay(controller: _controller!, fullScreen: true, videoUrl: widget.message.video!, time: widget.time,),
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
            ),
          )
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
