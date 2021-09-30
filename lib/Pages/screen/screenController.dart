import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ScreenController extends StatefulWidget {
  @override
  _ScreenControllerState createState() => _ScreenControllerState();
}

class _ScreenControllerState extends State<ScreenController> {
  @override
  initState() {
    super.initState();
    createAndUploadFile();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "Comming Soon",
      style: TextStyle(color: Colors.white, fontSize: 10),
    ));
  }

  Future<void> createAndUploadFile() async {
    // Create a dummy file
    final exampleString = 'Example file contents';
    final tempDir = await getTemporaryDirectory();
    final exampleFile = File('example.txt')
      ..createSync()
      ..writeAsStringSync(exampleString);

    // Upload the file to S3
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
        local: exampleFile,
        key: 'ExampleKey',
      );
      print('Successfully uploaded file: ${result.key}');
    } on StorageException catch (e) {
      print('Error uploading file: $e');
    }
  }
}
