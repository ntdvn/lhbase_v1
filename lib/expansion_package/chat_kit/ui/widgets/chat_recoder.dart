import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lhbase_v1/expansion_package/chat_kit/chat_kit.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1/ui/ui.dart';

class ChatRecoder extends StatefulWidget {
  final ChatMessage message;
  final DateTime time;
  const ChatRecoder({Key? key, required this.message, required this.time}) : super(key: key);

  @override
  _ChatRecoderState createState() => _ChatRecoderState();
}

class _ChatRecoderState extends State<ChatRecoder>
    with AutomaticKeepAliveClientMixin {
  final player = AudioPlayer(
    userAgent: 'myradioapp/1.0 (Linux;Android 11) https://myradioapp.com',
  );

  Duration? _duration;
  Duration? _position;
  bool _playing = false;

  Size? _widgetSize;
  double widthPerSecond = 0;

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  init() async {
    var a = await player.setUrl(widget.message.recoderUrl!);
    await player.setSpeed(1.0);
    setState(() {
      _duration = a;
    });

    // player.durationStream.listen((duration) {
    //   // print('duration: ${duration!.inMilliseconds}');
    //   setState(() {
    //     _duration = duration;
    //   });
    // });
    player.positionStream.listen((duration) {
      // print('positionStream ${duration.inSeconds} ');
      setState(() {
        // widthPerSecond = _widgetSize!.width / duration.inSeconds;
        _position = duration;
      });

      if (_position!.inSeconds == _duration!.inSeconds) {
        player.seek(Duration.zero);
        player.pause();
      }
    });

    player.playingStream.listen((playing) {
      setState(() {
        _playing = playing;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.message.is_hidden == false ?
      Container(
        // key: UniqueKey(),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 15),
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      print("dlkkjl");
                      if (player.playing) {
                        player.stop();
                      } else {
                        player.play();
                      }
                    },
                    child: Container(
                      child: Icon(_playing ? Icons.pause_circle_filled : Icons.play_circle, color: Colors.white,),
                      margin: EdgeInsets.only(right: 10),
                    ),
                  ),

                  Text(
                      '${_position != null ? DataUtils.durationToTime(_duration!-_position!) : ''}',
                  style: TextStyle(color: Colors.white,),)
                ],
              ),
            ),
            // Positioned.fill(
            //   child: Container(
            //     alignment: Alignment.centerLeft,
            //     child: FractionallySizedBox(
            //       widthFactor: _position != null && _duration != null
            //           ? _position!.inSeconds / _duration!.inSeconds
            //           : 0,
            //       // width:
            //       //     _position != null ? widthPerSecond * _position!.inSeconds : 0,
            //       child: Container(
            //         color: Colors.amber.withOpacity(0.2),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ) :
      GetBuilder<ChatKitController>(
        builder: (controller) {
          return Container(
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
      )
    ;
  }

  @override
  bool get wantKeepAlive => true;
}
