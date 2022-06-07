// ignore: import_of_legacy_library_into_null_safe
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lhbase_v1/expansion_package/chat_kit/ui/widgets/controls_overlay_screen.dart';
import 'package:lhbase_v1/lhbase.dart';
import 'package:lhbase_v1/ui/widgets/widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class PlayVideoOnlineBackScreen extends StatefulWidget {
  final String videoUrl;
  PlayVideoOnlineBackScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _PlayVideoOnlineBackScreenState createState() => _PlayVideoOnlineBackScreenState();
}

class _PlayVideoOnlineBackScreenState extends State<PlayVideoOnlineBackScreen> {

  late VideoPlayerController _controller;

  int index = 0;

  @override
  void initState() {
    print('dkm: ${widget.videoUrl}');

    if(widget.videoUrl != null){
      _controller = VideoPlayerController.network(widget.videoUrl)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {
            print('dsfw');
            _controller.setLooping(false);
            _controller.pause();
          });
        });
    }

    Wakelock.enable();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LhBasePage(
      statusBarBrightness: Brightness.dark,
      appBarTop: LhAppBar.top(
        backgroundColor: Colors.black,
        leadingColor: Colors.white,
        leadingOnTap: _onWillPop,
      ),
      onWillPop: _onWillPop,
      appBarBottom: LhAppBar.bottomEmpty(
        backgroundColor: Colors.black,
      ),
      child: Container(
        color: Colors.black,
        height: Get.height,
        width: Get.width,
        child: _controller.value.isInitialized
            ? Stack(
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        VideoPlayer(_controller),
                        ControlsOverlay(controller: _controller, fullScreen: false, videoUrl: widget.videoUrl),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                        playedColor: Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            )
            : Container(),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    print('nhấn vào đây');
    Get.back();
    // Future.delayed(Duration(seconds: 0), () {
    //   _homeController.listPost.value=null;
    //   _homeController.getHome();
    // });
    return  false;
    //return Future.value(false);
  }
}
