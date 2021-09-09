import 'package:flutter/material.dart';

class ScreenController extends StatefulWidget {
  @override
  _ScreenControllerState createState() => _ScreenControllerState();
}

class _ScreenControllerState extends State<ScreenController> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "Comming Soon",
      style: TextStyle(color: Colors.white, fontSize: 10),
    ));
  }
}
