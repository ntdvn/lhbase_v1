import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';

class AudioModel {
  final int id;
  final AudioPlayer? controller;
  final VideoPlayerController? controllerVideo;
  final VoidCallback onDone;

  AudioModel(this.id, this.controller, this.controllerVideo, this.onDone);

}