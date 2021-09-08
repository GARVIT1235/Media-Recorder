import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'videoView.dart';
import 'cameraView.dart';

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
  Future<void> initState() async {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
    _cameraController = CameraController(cameras[1], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
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
}
