import 'dart:io';
import 'package:flutter/material.dart';

class CameraViewPage extends StatelessWidget {
  const CameraViewPage({Key key, this.path}) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                child: Image.file(
                  File(path),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_a_photo,
                        size: 27,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
