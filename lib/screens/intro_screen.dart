import 'dart:async';
import 'package:finniu/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:finniu/screens/login/start_screen.dart';
// import 'package:teve_empresa_app/src/pages/home.dart';
// import 'package:teve_empresa_app/src/providers/home_video.dart';

Color black = Colors.white;

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  // String videoUrl = '';

  _IntroScreenState() {
    // print('entre al intro');
    // HomeVideoProvider().getHomeVideo().then((val) => setState(() {
    //       videoUrl = val;
    //     }));
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => StartLoginScreen(
                // videoUrl: videoUrl,
                ))));

    return Scaffold(
      backgroundColor: Color(primary_light),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  image: AssetImage(
                "assets/images/logo_finniu_light.png",
              )),
              Text('Vive el #ModoFinniu',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(primary_dark),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(width: 20.0, height: 20.0),
              CircularProgressIndicator(color: black),
            ],
          )),
    );
  }
}
