/*
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';

class Audio {
  FlutterSoundRecorder _flutterSoundRecorder;
  var path;

  Future init() async {
    _flutterSoundRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      print("error");
    }
    await _flutterSoundRecorder.openAudioSession();
    var isRecording = true;
  }

  Future _record() async {
    await _flutterSoundRecorder.startRecorder(toFile: path);
  }
*/
/*
  Future _stop() async {
    await _flutterSoundRecorder.stopRecorder();
  }

  FlutterSoundPlayer _flutterSoundPlayer;

  Future _play() async {
    await _flutterSoundPlayer.startPlayer(fromURI: path);
  }

  Future _pstop() async {
    await _flutterSoundPlayer.stopPlayer();
  }
}
*/
