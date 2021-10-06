import 'package:flutter/material.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:video_player/video_player.dart';

class LhVideoPlayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  const LhVideoPlayer({Key? key, required this.videoPlayerController})
      : super(key: key);

  @override
  _LhVideoPlayerState createState() => _LhVideoPlayerState();
}

class _LhVideoPlayerState extends State<LhVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  int currentPosition = 0;

  @override
  void initState() {
    _videoPlayerController = widget.videoPlayerController;

    _videoPlayerController.addListener(() async {
      var _position =
          _videoPlayerController.value.position.inMilliseconds / 1000;
      if (currentPosition != _position) {
        setState(() {
          currentPosition = _position.toInt();
        });
        print('currentPosition ${currentPosition}');
      }

      // if (_positionTime != _videoPlayerController.value.position.inSeconds &&
      //     _isDotControlled == false) {
      //   setState(() {
      //     _positionTime = _videoPlayerController.value.position.inSeconds;
      //   });
      //   Overlay.of(context)!.setState(() {
      //     _progressWidth = _distancePerStep *
      //         _videoPlayerController.value.position.inSeconds;
      //   });
      // }
    });
    super.initState();
  }

  String toMinutesString(int input) {
    // 100 -> 01:40
    int seconds, minutes;
    seconds = (input % 60).toInt();
    minutes = (input - seconds) ~/ 60;

    String secondsStr, minutesStr;
    if (seconds < 10) {
      secondsStr = '0$seconds';
    } else {
      secondsStr = '$seconds';
    }

    if (minutes < 10) {
      minutesStr = '0$minutes';
    } else {
      minutesStr = '$minutes';
    }
    return "$minutesStr:$secondsStr";
    // if()
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Container(
        child: Stack(
          children: [
            Container(
              color: Colors.black,
              alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              ),
            ),
            _buildPlayback(),
            LinearProgressIndicator(
              value: 50,
              semanticsLabel: 'Linear progress indicator',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayback() {
    var playbackTextStyle = LhStyle.DEFAULT_12.copyWith(color: Colors.white);
    return Positioned.fill(
        child: Stack(
      children: [
        // Positioned.fill(
        //   child: Container(
        //     color: Colors.black.withOpacity(0.5),
        //   ),
        // ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: Wrap(
              children: [
                LinearProgressIndicator(
                  value: currentPosition /
                      _videoPlayerController.value.duration.inSeconds,
                  semanticsLabel: 'Linear progress indicator',
                  minHeight: 5,
                  backgroundColor: Colors.black,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                Container(
                  color: Colors.black.withOpacity(0.7),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (_videoPlayerController.value.isPlaying) {
                            _videoPlayerController.pause();
                          } else {
                            _videoPlayerController.play();
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Icon(
                            _videoPlayerController.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      Text(
                        '${toMinutesString(currentPosition)} / ${toMinutesString(_videoPlayerController.value.duration.inSeconds)}',
                        style: playbackTextStyle,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

//  AspectRatio(
//             aspectRatio: _videoPlayerController.value.aspectRatio,
//             child: VideoPlayer(_videoPlayerController),
//           ),
