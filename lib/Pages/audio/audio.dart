import 'package:flutter/material.dart';
import 'audioController.dart';

class Audio extends StatefulWidget {
  @override
  _AudioState createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
        child: Opacity(
          opacity: 0.9,
          child: Image.asset('assets/images/audio.png', fit: BoxFit.cover),
        ),
      ),
      Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: FloatingActionButton(
          child: Icon(Icons.play_arrow,color: Colors.white),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AudioController()));
          },
        ),
      )
    ]);
  }
}
