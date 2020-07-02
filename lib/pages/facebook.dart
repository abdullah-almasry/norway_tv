import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class FaceBook extends StatefulWidget {
  static const route = '/facebook';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<FaceBook> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: AwsomeVideoPlayer(

              ModalRoute.of(context).settings.arguments,
              playOptions: VideoPlayOptions(
                  seekSeconds: 30,
                  aspectRatio: VideoPlayer(VideoPlayerController.network(
                      ModalRoute.of(context).settings.arguments))
                      .controller
                      .value
                      .aspectRatio,
                  loop: true,
                  autoplay: true,
                  allowScrubbing: true,
                  startPosition: Duration(seconds: 0)),
              videoStyle: VideoStyle(
                videoTopBarStyle: VideoTopBarStyle(
                  show: false,
                ),
                playIcon: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: ScreenUtil.pixelRatio * 30,
                    ),
                  ),
                ),
                videoControlBarStyle: VideoControlBarStyle(
                  bufferedColor: Colors.white,
                  padding: EdgeInsets.zero,
                  progressStyle: VideoProgressStyle(
                    height: 20,
                    padding: EdgeInsets.zero,
                  ),
                  timePadding: EdgeInsets.zero,
                  timeFontSize: 10,
                  playIcon: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: ScreenUtil.pixelRatio * 15,
                  ),
                  pauseIcon: Icon(
                    Icons.pause,
                    color: Colors.red,
                    size: ScreenUtil.pixelRatio * 15,
                  ),
                  rewindIcon: Icon(
                    Icons.replay_30,
                    size: ScreenUtil.pixelRatio * 15,
                    color: Colors.white,
                  ),
                  forwardIcon: Icon(
                    Icons.forward_30,
                    size: ScreenUtil.pixelRatio * 15,
                    color: Colors.white,
                  ),
                  fullscreenIcon: Icon(
                    Icons.fullscreen,
                    size: ScreenUtil.pixelRatio * 15,
                    color: Colors.white,
                  ),
                  fullscreenExitIcon: Icon(
                    Icons.fullscreen_exit,
                    size: ScreenUtil.pixelRatio * 15,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(1, -1),
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () => Navigator.pop(context)),
          )
        ],
      ),
    );
  }
}