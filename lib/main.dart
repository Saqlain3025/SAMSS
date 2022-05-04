import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samss/screen/splash.dart';
import 'package:samss/screen/splash_screen.dart';
import 'package:samss/services/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  runApp(
    //MyApp()
    ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: MyApp(),
          );
        }),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  String value = '';

  Future<bool> checkedLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    value = prefs.getString('email')!;
    if (value == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Something went wrongs");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ScreenUtilInit(
              designSize: Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (child) {
                return FutureBuilder(
                    future: checkedLoginStatus(),
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.hasData == false) {
                        return SplashScreen();
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return SplashScreen1();
                    });
              });
        });
  }
}
