import 'package:flutter/material.dart';
import 'package:media_recorder/Pages/video/videoController.dart';

class Video extends StatefulWidget {
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
        child: Opacity(
          opacity: 0.9,
          child: Image.asset('assets/images/video.jpg', fit: BoxFit.cover),
        ),
      ),
      Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: FloatingActionButton(
          child: Icon(Icons.play_arrow, color: Colors.white),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => VideoController()));
          },
        ),
      )
    ]);
  }
}
