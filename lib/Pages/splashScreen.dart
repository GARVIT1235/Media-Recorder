import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () async {
      // ToDo:
      Navigator.of(context).pushReplacementNamed('/home');
    });

    final X = MediaQuery.of(context).size.width;
    final Y = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: Y / 3 + 30),
        height: Y,
        width: X,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Colors.deepPurple, Colors.deepPurpleAccent],
        )),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 90,
              child: Image.asset("assets/images/media_icon.png"),
            ),
            SizedBox(
              height: Y * .06,
            ),
            AnimatedTextKit(animatedTexts: [
              TyperAnimatedText('WELCOME',
                  textStyle: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                  speed: Duration(milliseconds: 200))
            ]),
          ],
        ),
      ),
    );
  }
}
