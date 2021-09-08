import 'package:flutter/material.dart';
import 'screen/screenRecording.dart';
import 'video/videoPage.dart';
import 'audio/audio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final List<Widget> list = [Video(), Audio(), Screen()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.video_call, color: Colors.grey),
                label: 'Video',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.multitrack_audio, color: Colors.grey),
                label: 'Audio',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.screen_share, color: Colors.grey),
                label: 'Screen',
              )
            ],
            currentIndex: selectedIndex,
            selectedItemColor: Colors.white,
            backgroundColor: Colors.black,
            onTap: _onItemTapped,
            elevation: 10,
          ),
          appBar: AppBar(
            title: Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
          ),
          body: list[selectedIndex]),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
