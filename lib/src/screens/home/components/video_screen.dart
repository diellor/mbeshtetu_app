import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbeshtetu_app/src/commons.dart';
import 'package:mbeshtetu_app/src/size_config.dart';
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
      appBar: MediaQuery.of(context).orientation == Orientation.portrait? AppBar(
        backgroundColor: primary_blue,
        title: Text('Kthehu'),
        centerTitle: false,
      ): null,
      backgroundColor: primary_blue,
      body: youtubeHierarchy(),
    );
  }

  youtubeHierarchy() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    _controller.updateValue(_controller.value.copyWith(isFullScreen: true));

    return WillPopScope(
      onWillPop: () {
        if (_controller.value.isPlaying) {
          _controller.pause();
        }
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

        return new Future.value(true);
      },
      child: Container(
        color: primary_blue,
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
          ),
          builder: (context, player) {
            return Column(
              children: [
                // some widgets
                Flexible(
                  flex: 1,
                    fit: FlexFit.loose,
                    child: player
                ),
                Flexible(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical: 2.5 * SizeConfig.heightMultiplier, horizontal: 3 * SizeConfig.widthMultiplier),
                            child: AutoSizeText("Ushtrimi i menaxhimit te simptomave iuhuhuhuhuhu",
                              minFontSize: 10,
                              style: TextStyle(fontSize: 3 * SizeConfig.textMultiplier),),
                          ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
