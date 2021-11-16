import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lhbase_v1/expansion_package/chat_kit/chat_kit.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1/ui/ui.dart';

class ChatRecoder extends StatefulWidget {
  final ChatMessage message;
  const ChatRecoder({Key? key, required this.message}) : super(key: key);

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
    if (_position != null && _duration != null) {
      // print('_position!.inSeconds: ${_position!.inSeconds}');
      // print('_duration!.inSeconds: ${_duration!.inSeconds}');
      print(
          'hee is ok ${_position != null && _duration != null ? _position!.inSeconds / _duration!.inSeconds : 0}');
    }

    return LhInkwell(
      padding: EdgeInsets.zero,
      onTap: () {
        if (player.playing) {
          player.stop();
        } else {
          player.play();
        }
      },
      // padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 15),
      child: LhMeasureSize(
        onChange: (Size size) {},
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 15),
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    child: Icon(_playing ? Icons.pause : Icons.play_circle),
                    margin: EdgeInsets.only(right: 10),
                  ),
                  Text(
                      '${_duration != null ? DataUtils.durationToTime(_duration!) : ''}')
                ],
              ),
            ),
            Positioned.fill(
              child: Container(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: _position != null && _duration != null
                      ? _position!.inSeconds / _duration!.inSeconds
                      : 0,
                  // width:
                  //     _position != null ? widthPerSecond * _position!.inSeconds : 0,
                  child: Container(
                    color: Colors.amber.withOpacity(0.2),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
