import 'package:flutter/material.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';

class Youtube extends StatefulWidget {
  @override
  _YoutubeState createState() => _YoutubeState();
}

class _YoutubeState extends State<Youtube> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FlutterYoutubeView(

          //onViewCreated: _onYoutubeCreated,

            scaleMode: YoutubeScaleMode.none, // <option> fitWidth, fitHeight
            params: YoutubeParam(
              showFullScreen: true,
                showYoutube: true,
                videoId: '69mnGsxTtAY',
                showUI: false,
                startSeconds: 0.0, // <option>
                autoPlay: true) // <option>
        )
    );
  }
}
