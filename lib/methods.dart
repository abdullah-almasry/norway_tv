import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class MyGlobalMethods {
  ProgressDialog progressDialog;
  BuildContext context;
  MyGlobalMethods(this.context) {
    progressDialog = ProgressDialog(
      context,
      isDismissible: false,
    );
    progressDialog.style(
        message: 'انتظر جاري التحميل',
        progressWidget: Center(
            child: SizedBox(
          child: CircularProgressIndicator(),
          width: 40.w,
          height: 40.h,
        )),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 50.h));
  }

  static void showSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String text) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
    ));
  }

  static Widget dioErrorToWidgetHandler(
    DioError error, {
    Widget defaultE,
    Widget response,
    Widget timeOut,
  }) {
    if (error.type == DioErrorType.DEFAULT) {
      return defaultE;
    } else if (error.type == DioErrorType.RESPONSE) {
      return response;
    } else {
      return timeOut;
    }
  }

  static Future<void> launchUrl(String url) async {
    if (await UrlLauncher.canLaunch(url)) {
      UrlLauncher.launch(
        url,
      );
    } else {}
  }
}
