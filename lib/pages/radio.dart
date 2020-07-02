import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';

import 'package:flutter/rendering.dart';
import 'package:tv/key_code.dart';

class RadioStream extends StatefulWidget {
  var playerState = FlutterRadioPlayer.flutter_radio_paused;

  var volume = 0.8;

  @override
  _RadioStreamState createState() => _RadioStreamState();
}

class _RadioStreamState extends State<RadioStream> {
  FlutterRadioPlayer _flutterRadioPlayer = new FlutterRadioPlayer();

  @override
  void initState() {
    super.initState();
    initRadioService();
  }

  Future<void> initRadioService() async {
    try {
      await _flutterRadioPlayer.init("Flutter Radio Example", "Live",
          "http://104.194.9.150:9302/;", "true");
    } on PlatformException {
      print("Exception occured while trying to register the services.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Radio Player Example'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            StreamBuilder(
                stream: _flutterRadioPlayer.isPlayingStream,
                initialData: widget.playerState,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  String returnData = snapshot.data;
                  print("object data: " + returnData);
                  switch (returnData) {
                    case FlutterRadioPlayer.flutter_radio_stopped:
                      return RaisedButton(
                          child: Text("Start listening now"),
                          onPressed: () async {
                            await initRadioService();
                          });
                      break;
                    case FlutterRadioPlayer.flutter_radio_loading:
                      return Text("Loading stream...");
                    case FlutterRadioPlayer.flutter_radio_error:
                      return RaisedButton(
                          child: Text("Retry ?"),
                          onPressed: () async {
                            await initRadioService();
                          });
                      break;
                    default:
                      return Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(5.0),
                        child: new RawKeyboardListener(
                          focusNode: FocusNode(),
                          onKey: (RawKeyEvent event) {
                            if (event is RawKeyDownEvent &&
                                event.data is RawKeyEventDataAndroid) {
                              RawKeyDownEvent rawKeyDownEvent = event;
                              RawKeyEventDataAndroid rawKeyEventDataAndroid =
                                  rawKeyDownEvent.data;
                              print(
                                  "Focus Node 1 ${rawKeyEventDataAndroid.keyCode}");
                              switch (rawKeyEventDataAndroid.keyCode) {
                                case KEY_CENTER:
                                  snapshot.data ==
                                          FlutterRadioPlayer
                                              .flutter_radio_playing
                                      ? Icon(Icons.pause)
                                      : Icon(Icons.play_arrow);
                                  break;
//                                  case KEY_RIGHT:
//                                    FocusScope.of(context).requestFocus(focusNodes[0]);
//                                    break;
                                default:
                                  break;
                              }
                              setState(() {});
                            }
                          },
                          child: RaisedButton.icon(
                              label: Text(""),
                              onPressed: () async {
                                print("button press data: " +
                                    snapshot.data.toString());
                                await _flutterRadioPlayer.playOrPause();
                              },
                              icon: snapshot.data ==
                                      FlutterRadioPlayer.flutter_radio_playing
                                  ? Icon(Icons.pause)
                                  : Icon(Icons.play_arrow)),
                        ),
                      );
//                          Row(
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              RawKeyboardListener(
//                                focusNode: FocusNode(
//                                ),

//
//                            ]);
                      break;
                  }
                }),
            Slider(
                value: widget.volume,
                min: 0,
                max: 1.0,
                onChanged: (value) => setState(() {
                      widget.volume = value;
                      _flutterRadioPlayer.setVolume(widget.volume);
                    })),
            Text("Volume: " + (widget.volume * 100).toStringAsFixed(0)),
          ],
        ),
      ),
    );
  }
}
