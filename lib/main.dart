


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tv/home.dart';
import 'package:tv/logic.dart';
import 'package:tv/pages/facebook.dart';
import 'package:tv/pages/logic.dart';
import 'package:tv/pages/radio.dart';
import 'package:tv/pages/youtube.dart';


//SharedPreferences sharedPreferences;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


 // await AudioService.connect();
  runApp(ChangeNotifierProvider(
      create: (BuildContext context)=> StreamBarLogic(),
      child: MyApp()));
}


class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return ChangeNotifierProvider(
        create: (BuildContext context) => HomeLogic(context),
    child: MaterialApp(
      routes: {
        '/radio': (context)=> RadioStream(),
        '/youtube': (context) => Youtube(),
       // '/facebook': (context) => FaceBook(),//,
         '/home': (context) => Home(),
        FaceBook.route: (_) => FaceBook(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Norway Voice',
      builder: (BuildContext context, Widget widget) {
        ScreenUtil.init(context,
            width: 360, height: 756, allowFontScaling: true);
        return Directionality(
            child: ScrollConfiguration(
              child: SafeArea(child: widget),
              behavior: MyBehavior(),
            ),
            textDirection: TextDirection.rtl);
      },
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: GoogleFonts.cairo().fontFamily,
        iconTheme: IconThemeData(color: Colors.black),
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}




