
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:async/async.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:tv/methods.dart';
import 'package:tv/pages/facebook.dart';
import 'package:tv/pages/logic.dart';

class StreamBarLogic extends ChangeNotifier {
  BuildContext context;
  bool isPlayButtonVisible = true;
  Future<void> play() async {
    isPlayButtonVisible = false;

    notifyListeners();
  }

  MyGlobalMethods myGlobalMethods;
  void showSnackBar(String content) {
    MyGlobalMethods.showSnackBar(
        Provider.of<HomeLogic>(context, listen: false).scaffoldKey, content);
  }
//  FlutterYoutubeView(
//
//  scaleMode: YoutubeScaleMode.none, // <option> fitWidth, fitHeight
//  params: YoutubeParam(
//  showFullScreen: true,
//  showYoutube: true,
//  videoId: url,
//  showUI: false,
//  startSeconds: 0.0, // <option>
//  autoPlay: true)
  Future<void> playYoutubeVideo() async {
    playVideo('youtube', (url) async {
      await myGlobalMethods.progressDialog.hide();
      FlutterYoutube.playYoutubeVideoByUrl(
          apiKey: "<API_KEY>", videoUrl: url, autoPlay: true, fullScreen: true);
    });
  }

  Future<void> playFaceBookVideo() async {
    playVideo('facebook', (url) async {
      var response = await Dio().get<String>(url);
      var data = response.data;
      var metas = parse(data).head.querySelectorAll('meta');
      String videoUrl;
      for (var element in metas) {
        if (element.attributes['property'] == 'og:video') {
          videoUrl = element.attributes['content'];
          break;
        }
      }
      await myGlobalMethods.progressDialog.hide();
      if (videoUrl == null) {
        showSnackBar('هناك مشكله سوف نعمل على حلها');
      } else {
        Navigator.pushNamed(context, FaceBook.route, arguments: videoUrl);
      }
    });
  }

  Future<void> playVideo(String child, Function(String url) playVideo) async {
    bool isTimeOut = false;
    await myGlobalMethods.progressDialog.show();
    CancelableOperation<DataSnapshot> opearation =
    CancelableOperation<DataSnapshot>.fromFuture(
        FirebaseDatabase.instance.reference().child(child).once());

    opearation.then((url) async {
      print('then');
      if (!isTimeOut) {
        await myGlobalMethods.progressDialog.hide();
        playVideo(url.value);
      }
    });
    opearation.value.timeout(Duration(seconds: 10), onTimeout: () async {
      print('iam called');
      isTimeOut = true;
      opearation.cancel();
      await myGlobalMethods.progressDialog.hide();
      showSnackBar('هناك مشكله فى الاتصال بخوادمنا');

      return null;
    });
  }


}
