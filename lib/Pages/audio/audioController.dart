import 'package:flutter/material.dart';

class AudioController extends StatefulWidget {
  @override
  _AudioControllerState createState() => _AudioControllerState();
}

class _AudioControllerState extends State<AudioController> {
  bool isRecording = false;
  final path = 'audio.mp3';
  String time = " 00:00 ";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff172133),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff172133),
          leading: IconButton(
              icon: Icon(
                Icons.backspace_outlined,
                size: 27,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Column(children: [
              Text(
                time,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 30,
                  child: IconButton(
                    icon: isRecording
                        ? Icon(
                            Icons.stop,
                            color: Colors.white,
                            size: 30,
                          )
                        : Icon(
                            Icons.mic,
                            color: Colors.white,
                            size: 30,
                          ),
                    onPressed: () {
                      setState(() {
                        isRecording = !isRecording;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              isRecording
                  ? Text(
                      "STOP Recording",
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      "START Recording",
                      style: TextStyle(color: Colors.white),
                    )
            ])));
  }
}
