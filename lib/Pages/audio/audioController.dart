import 'dart:async';
import 'package:flutter/material.dart';

class AudioController extends StatefulWidget {
  @override
  _AudioControllerState createState() => _AudioControllerState();
}

class _AudioControllerState extends State<AudioController> {
  bool isRecording = false;
  final path = 'audio.mp3';
  Duration duration = Duration();
  Timer timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
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
            padding:
                EdgeInsets.only(top: (MediaQuery.of(context).size.height) / 3),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Column(children: [
              Text(
                '$minutes:$seconds',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: CircleAvatar(
                  backgroundColor: isRecording ? Colors.green : Colors.red,
                  radius: 50,
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
                        isRecording ? reset() : startTimer();
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

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTimer());
  }

  addTimer() {
    final aSecond = 1;
    setState(() {
      final second = duration.inSeconds + aSecond;
      duration = Duration(seconds: second);
    });
  }

  reset() {
    setState(() => duration = Duration());
  }
}
