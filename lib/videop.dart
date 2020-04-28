import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:wakelock/wakelock.dart';
import 'package:after_layout/after_layout.dart';
class VideoApp extends StatefulWidget {
  String url;
  VideoApp(this.url);
  @override

  _VideoAppState createState() => _VideoAppState(url);
}

class _VideoAppState extends State<VideoApp> with AfterLayoutMixin<VideoApp>{
  String url;
  _VideoAppState(this.url);
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  static const _rotationChannel = const MethodChannel('zgadula/orientation');

  @override
  void afterFirstLayout(BuildContext context) {
    _chewieController.enterFullScreen();
  }
  @override
  void initState() {
   super.initState();
   Wakelock.enable();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    try {
      _rotationChannel.invokeMethod('setLandscape');
    } catch (error) {}
    _videoPlayerController1 = VideoPlayerController.network(url);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController1,
        aspectRatio: 16 / 9,
        autoPlay: true,
        allowFullScreen: true,
        //fullScreenByDefault: true,
        //looping: false,
      //showControlsOnInitialize: true,

      showControls: true,);
    }
  void dispose()
  {
    Wakelock.disable();
    _videoPlayerController1.dispose();
    super.dispose();
  }
//    materialProgressColors: ChewieProgressColors(
//    playedColor: Colors.blueAccent,
//    handleColor: Colors.blue,
//
//      backgroundColor: Colors.black,
//      bufferedColor: Colors.lightGreen,
//    ),
//    placeholder: Container(
//    color: Colors.black,
//    ),
        //deviceOrientationsAfterFullScreen: [DeviceOrientation.landscapeLeft],
    //autoInitialize: true,
        @override
        Widget build(BuildContext context) {
          return MaterialApp(
                home: Scaffold(
                  resizeToAvoidBottomPadding: false,
                  body: Container(
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                    color: Colors.black,
                    child: Chewie(
                      controller: _chewieController,
                    )),
                  ),
                );

            }
        }
      // Try playing around with some of these other options:







//class VideoScaffold extends StatefulWidget {
//  const VideoScaffold({Key key, this.child}) : super(key: key);
//  final Widget child;
//
//  @override
//  State<StatefulWidget> createState() => _VideoScaffoldState();
//}
//
//class _VideoScaffoldState extends State<VideoScaffold> {
//  static const _rotationChannel = const MethodChannel('zgadula/orientation');
//  @override
//  void initState() {
//    SystemChrome.setPreferredOrientations([
//      DeviceOrientation.landscapeRight,
//      DeviceOrientation.landscapeLeft,
//    ]);
////    AutoOrientation.landscapeLeftMode();
//    super.initState();
//    try {
//      _rotationChannel.invokeMethod('setLandscape');
//    } catch (error) {}
//
//  }
//
//  @override
//  dispose() {
////    SystemChrome.setPreferredOrientations([
////      DeviceOrientation.portraitUp,
////      DeviceOrientation.portraitDown,
////
////    ]);
//    AutoOrientation.portraitUpMode();
//    super.dispose();
//
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return widget.child;
//  }
//}