import 'package:flutter/material.dart';
import 'package:samss/screen/main_screen/Home_screen.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({Key? key}) : super(key: key);

  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    super.initState();
    _nagivateState();
  }

  void _nagivateState() async {
    try {
      await Future.delayed(const Duration(milliseconds: 1000), () {});
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset(
            "assets/image/logo3.png",
            height: 300,
            width: 300,
          ),
        ),
      ),
    );
  }
}
