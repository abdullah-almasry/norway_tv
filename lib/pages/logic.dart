
import 'package:audio_service/audio_service.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv/logic.dart';
import 'package:tv/methods.dart';
import 'package:xml/xml.dart' as xml;

class HomeLogic extends ChangeNotifier {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List<xml.XmlElement> xmlNewsList = [];
  bool show = false;
  List<String> categories = [];
  bool isRefreshing = false;
  Future<ConnectivityResult> getConnectionState;
  Future<Response<String>> getNews;
  List<Map<String, String>> newsList = [];

  void refreshConnectivity() {
    getConnectionState = Connectivity().checkConnectivity();
    notifyListeners();
  }



  String xmlCustomField(xml.XmlElement newsElement, String field) =>
      newsElement.findElements(field).toList()[0].text;
  xml.XmlElement test(xml.XmlElement newsElement, String field) =>
      newsElement.findElements(field).toList()[0];

  HomeLogic(BuildContext context) {
    getConnectionState = Connectivity().checkConnectivity();
    AudioService.customEventStream.listen((event) async {

      if (event == 1) {
        MyGlobalMethods.showSnackBar(scaffoldKey, 'هناك مشكله فى تشغيل البث');
      }  else if (event == 3) {
        MyGlobalMethods.showSnackBar(scaffoldKey, 'تم انقطاع الانترنت عن البث');
      }
      Provider.of<StreamBarLogic>(context, listen: false)
          .isPlayButtonVisible = true;
      Provider.of<StreamBarLogic>(context, listen: false).notifyListeners();

    });
  }
}
