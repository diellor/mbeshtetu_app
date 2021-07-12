import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {

  final String id;

  VideoScreen({this.id});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {

  YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: youtubeHierarchy(),
    );
  }
  youtubeHierarchy() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    _controller.updateValue(_controller.value.copyWith(isFullScreen: true));
    return WillPopScope(
      onWillPop: (){
        if (_controller.value.isPlaying) {
          _controller.pause();
        }
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

        return new Future.value(true);
      },
      child: Column(
        children: [
          Container(
            child: FittedBox(
              fit: BoxFit.fill,
              child: YoutubePlayer(
                controller: _controller,
              ),
            ),
          ),
          // IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: (){
          //     Navigator.pop(context);
          //   },
          // )
        ],
      ),
    );
  }
}
