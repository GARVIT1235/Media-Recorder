import 'package:flutter/material.dart';
import 'package:media_recorder/Pages/screen/screenController.dart';

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
        child: Opacity(
          opacity: 0.9,
          child: Image.asset('assets/images/screen.jpg', fit: BoxFit.cover),
        ),
      ),
      Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: FloatingActionButton(
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 50,
          ),
          backgroundColor: Colors.transparent,
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ScreenController()));
          },
        ),
      )
    ]);
  }
}
