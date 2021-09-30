//import 'package:amazon_s3_cognito/amazon_s3_cognito.dart';
//import 'package:amazon_s3_cognito/aws_region.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'videoView.dart';
import 'cameraView.dart';
import 'dart:io';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:path_provider/path_provider.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import '../../amplifyconfiguration.dart';

class VideoController extends StatefulWidget {
  @override
  _VideoControllerState createState() => _VideoControllerState();
}

List<CameraDescription> cameras;

class _VideoControllerState extends State<VideoController> {
  CameraController _cameraController;
  Future<dynamic> cameraValue;
  bool VideoOn = false;
  bool flash = false;
  bool CameraFront = true;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    Camera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: CameraPreview(_cameraController));
                } else {
                  return Center(
                    child: Image.asset('assets/images/video.jpg',
                        fit: BoxFit.cover),
                  );
                }
              }),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: Icon(
                            flash ? Icons.flash_on : Icons.flash_off,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () {
                            setState(() {
                              flash = !flash;
                            });
                            flash
                                ? _cameraController
                                    .setFlashMode(FlashMode.torch)
                                : _cameraController.setFlashMode(FlashMode.off);
                          }),
                      GestureDetector(
                        onLongPress: () async {
                          await _cameraController.startVideoRecording();
                          setState(() {
                            VideoOn = true;
                          });
                        },
                        onDoubleTap: () async {
                          XFile videopath =
                              await _cameraController.stopVideoRecording();
                          setState(() {
                            VideoOn = false;
                          });
                          createAndUploadFile();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => VideoViewPage(
                                        path: videopath.path,
                                      )));
                        },
                        onTap: () async {
                          if (!VideoOn) {
                            XFile file = await _cameraController.takePicture();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => CameraViewPage(
                                          path: file.path,
                                        )));
                          }
                        },
                        child: VideoOn
                            ? Icon(
                                Icons.radio_button_checked,
                                color: Colors.red,
                                size: 80,
                              )
                            : Icon(
                                Icons.radio_button_off,
                                color: Colors.white,
                                size: 70,
                              ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.flip_camera_android_sharp,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () async {
                            setState(() {
                              CameraFront = !CameraFront;
                            });
                            int cameraPos = CameraFront ? 0 : 1;
                            _cameraController = CameraController(
                                cameras[cameraPos], ResolutionPreset.high);
                            cameraValue = _cameraController.initialize();
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Tap for photo,Hold for Video,",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> Camera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras[1], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  Future<void> createAndUploadFile() async {
    // Create a dummy file
    final exampleString = 'Example file contents';
    final tempDir = await getTemporaryDirectory();
    final exampleFile = File(tempDir.path + '/example.txt')
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
/*Future<void> sendFile(XFile path) async {
    String uploadedImageUrl = await AmazonS3Cognito.upload(
        path.path,
        "video-storage-demo",
        "ap-south-1:1d50d6a9-bf31-4b90-bb94-6f2ee1ef5f4b",
        "image",
        AwsRegion.US_EAST_1,
        AwsRegion.AP_SOUTHEAST_1);
  }*/
}
