// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1/res/lh_styles.dart';
import 'package:lhbase_v1/ui/widgets/lh_text.dart';
import 'package:video_player/video_player.dart';

import 'widget_play_video_back.dart';

class ControlsOverlay extends StatefulWidget {
  final String videoUrl;
  final DateTime? time;
  final bool fullScreen;
  const ControlsOverlay({Key? key, required this.controller, required this.fullScreen, required this.videoUrl, this.time})
      : super(key: key);

  final VideoPlayerController controller;

  @override
  State<ControlsOverlay> createState() => ControlsOverlayState();
}

class ControlsOverlayState extends State<ControlsOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: widget.controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
            color: Colors.black26,
            child: Center(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 50.0,
                semanticLabel: 'Play',
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            widget.controller.value.isPlaying ? widget.controller.pause() : widget.controller.play();
            setState(() {

            });
          },
        ),
        widget.time != null ? Positioned(
          bottom: 8,
          left: 8,
          child: Container(
            padding: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: LhText(LhValue.dateTimeToTime(widget.time!), style: LhStyle.DEFAULT_12.copyWith(color: Colors.black),),
          ),
        ) : Container(),
        widget.fullScreen == true ? Positioned(
          bottom: 4,
          right: 4,
          child: GestureDetector(
            onTap: () {
              widget.controller.pause();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PlayVideoOnlineBackScreen(videoUrl: widget.videoUrl,)),
              );
            },
            child: Icon(Icons.fullscreen, color: Colors.white, size: 25,),
          ),
        ) : SizedBox(),
        // Align(
        //   alignment: Alignment.topRight,
        //   child: PopupMenuButton<double>(
        //     initialValue: widget.controller.value.playbackSpeed,
        //     tooltip: 'Playback speed',
        //     onSelected: (speed) {
        //       widget.controller.setPlaybackSpeed(speed);
        //       setState(() {
        //
        //       });
        //     },
        //     itemBuilder: (context) {
        //       return [
        //         for (final speed in ControlsOverlay._examplePlaybackRates)
        //           PopupMenuItem(
        //             value: speed,
        //             child: Text('${speed}x'),
        //           )
        //       ];
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(
        //         // Using less vertical padding as the text is also longer
        //         // horizontally, so it feels like it would need more spacing
        //         // horizontally (matching the aspect ratio of the video).
        //         vertical: 12,
        //         horizontal: 16,
        //       ),
        //       child: Text('${widget.controller.value.playbackSpeed}x'),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}