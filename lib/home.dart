
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tv/key_code.dart';
import 'package:tv/methods.dart';
import 'package:tv/pages/facebook.dart';
import 'logic.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey _globalKey = GlobalKey();

  final List<FocusNode> focusNodes = List();
  bool isFirstIn = true;

  @override
  void initState() {
    print('initState called.');
    super.initState();
    for (int i = 0; i < 3; i++) {
      FocusNode focus = FocusNode();
      focusNodes.add(focus);
    }
  }

  @override
  void dispose() {
    print('dispose called.');
    for (int i = 0; i < 3; i++) {
      focusNodes[i].dispose();
    }
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    Size size = MediaQuery.of(context).size;
    var logic = Provider.of<StreamBarLogic>(context, listen: false);
//    var logic = Provider.of<StreamBarLogic>(context, listen: false);
    logic.context = context;
    logic.myGlobalMethods = MyGlobalMethods(context);


    if (isFirstIn) {
      FocusScope.of(context).requestFocus(focusNodes[0]);
      isFirstIn = false;
    }

    return Scaffold(
        key: _globalKey,
        appBar: AppBar(),
        body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5.0),
                child: new RawKeyboardListener(
                  focusNode: focusNodes[0],
                  onKey: (RawKeyEvent event) {
                    if (event is RawKeyDownEvent &&
                        event.data is RawKeyEventDataAndroid) {
                      RawKeyDownEvent rawKeyDownEvent = event;
                      RawKeyEventDataAndroid rawKeyEventDataAndroid =
                          rawKeyDownEvent.data;
                      print("Focus Node 0 ${rawKeyEventDataAndroid.keyCode}");
                      switch (rawKeyEventDataAndroid.keyCode) {
                        case KEY_CENTER:
                          Navigator.of(context).pushNamed('/radio',);

                          // Navigator.pushNamed(context, FaceBook.route, arguments: videoUrl);
                          break;
                        case KEY_LEFT:
                          FocusScope.of(context).requestFocus(focusNodes[1]);
                          break;

                        default:
                          break;
                      }
                      setState(() {});
                    }
                  },
                  child: new RaisedButton(
                    child: new Container(
                        alignment: Alignment.center,
                        width: 160.0,
                        height: 100,
                        child: Icon(Icons.radio)),
                    color: focusNodes[0].hasFocus ? Colors.red : Colors.grey,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/radio',);
                    },
                  ),
                ),
              ),
               Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5.0),
                child: new RawKeyboardListener(
                  focusNode: focusNodes[1],
                  onKey: (RawKeyEvent event) {
                    if (event is RawKeyDownEvent &&
                        event.data is RawKeyEventDataAndroid) {
                      RawKeyDownEvent rawKeyDownEvent = event;
                      RawKeyEventDataAndroid rawKeyEventDataAndroid =
                          rawKeyDownEvent.data;
                      print("Focus Node 1 ${rawKeyEventDataAndroid.keyCode}");
                      switch (rawKeyEventDataAndroid.keyCode) {
                        case KEY_CENTER:
                          logic.playFaceBookVideo();
                          break;
                        case KEY_LEFT:
                          FocusScope.of(context).requestFocus(focusNodes[2]);
                          break;
                        case KEY_RIGHT:
                          FocusScope.of(context).requestFocus(focusNodes[0]);
                          break;
                        default:
                          break;
                      }
                      setState(() {});
                    }
                  },
                  child: new RaisedButton(
                    child: new Container(
                        alignment: Alignment.center,
                        width: 160.0,
                        height: 100,
                        child: Expanded(
                            child: MyFlatButton(FontAwesomeIcons.facebookSquare, Colors.black,
                                logic.playFaceBookVideo)),),
                    color: focusNodes[1].hasFocus ? Colors.red : Colors.grey,
                    onPressed: ()=> logic.playFaceBookVideo()
    //{
                      //Navigator.pushNamed(context, FaceBook.route,);

                      // Navigator.of(context).pushNamed('/facebook',arguments: logic.playFaceBookVideo());


                 //   },
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(5.0),
                child: new RawKeyboardListener(

                  focusNode: focusNodes[2],
                  onKey: (RawKeyEvent event) {
                    if (event is RawKeyDownEvent &&
                        event.data is RawKeyEventDataAndroid) {
                      RawKeyDownEvent rawKeyDownEvent = event;
                      RawKeyEventDataAndroid rawKeyEventDataAndroid =
                          rawKeyDownEvent.data;
                      print("Focus Node 2 ${rawKeyEventDataAndroid.keyCode}");
                      switch (rawKeyEventDataAndroid.keyCode) {
                        case KEY_CENTER:
                            logic.playYoutubeVideo();
                          break;

                        case KEY_LEFT:
                          FocusScope.of(context).requestFocus(focusNodes[0]);
                          break;
                        case KEY_RIGHT:
                          FocusScope.of(context).requestFocus(focusNodes[1]);
                          break;
                        default:
                          break;
                      }
                      setState(() {});
                    }
                  },
                  child: RaisedButton(
                    child: Container(
                        alignment: Alignment.center,
                        width: 160.0,
                        height: 100,
                        child: Icon(
                          FontAwesomeIcons.youtubeSquare,
                          color: Colors.red,
                        )),
                    color: focusNodes[2].hasFocus
                        ? Colors.red
                        : Colors.transparent,
                    onPressed: () => logic.playYoutubeVideo()
                    //{
                     // Navigator.of(context).pushNamed('/youtube');
                 //   },
                  ),
                ),
              ),
            ]));
  }
}
/*class MyStreamBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var logic = Provider.of<StreamBarLogic>(context, listen: false);
    logic.context = context;
    logic.myGlobalMethods = MyGlobalMethods(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[

        Container(
            width: size.width*0.34,
            child: MyFlatButton(
                FontAwesomeIcons.youtube, Colors.red, logic.playYoutubeVideo,)),
        Container(
          width: size.width*0.33,

          child: Container(
            color: Colors.green,
            child: Consumer<StreamBarLogic>(
              builder:
                  (BuildContext context, StreamBarLogic value, Widget child) =>
                      StreamBuilder<PlaybackState>(
                          stream: AudioService.playbackStateStream,
                          builder: logic.stramBuildAudioStream
                      ),
            ),
          ),
        ),
        Container(
            width: size.width*0.33,

            child: MyFlatButton(FontAwesomeIcons.facebookSquare, Colors.black,
                logic.playFaceBookVideo)),
      ],
    );
  }
}

class MyFlatButton extends StatelessWidget {
  VoidCallback onPressed;
  Color color;
  IconData icon;
  MyFlatButton(this.icon, this.color, this.onPressed);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      //colorBrightness: Brightness.dark,
      color: this.color,
      onPressed: this.onPressed,
      icon: Icon(
        this.icon,
        size: ScreenUtil.pixelRatio * 80,
      ),
    );
  }
}*/
class MyFlatButton extends StatelessWidget {
  VoidCallback onPressed;
  Color color;
  IconData icon;
  MyFlatButton(this.icon, this.color, this.onPressed);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      colorBrightness: Brightness.dark,
      color: this.color,
      onPressed: this.onPressed,
      child: Icon(
        this.icon,
        size: ScreenUtil.pixelRatio * 15,
      ),
    );
  }
}