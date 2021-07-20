import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mbeshtetu_app/src/commons.dart';
import 'package:mbeshtetu_app/src/models/create_schedule_model.dart';
import 'package:mbeshtetu_app/src/models/started_watching_videos_model.dart';
import 'package:mbeshtetu_app/src/services/schedule_service.dart';
import 'package:mbeshtetu_app/src/services/user_service.dart';
import 'package:mbeshtetu_app/src/size_config.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../service_locator.dart';

class VideoScreen extends StatefulWidget {
  final String id;

  VideoScreen({this.id});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  YoutubePlayerController _controller;
  final ScheduleService _scheduleService = serviceLocator<ScheduleService>();
  final UserService _userService = serviceLocator<UserService>();
  @override
  void initState() {
    super.initState();
    print("te nana jote");
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
    _userService.startedWatchingVideo(StartedWatchingVideosRequest(_controller.initialVideoId, DateTime.now().millisecondsSinceEpoch ~/ 1000));
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
    print("ne build");
    return Scaffold(
      // appBar: MediaQuery.of(context).orientation == Orientation.portrait? AppBar(
      //   backgroundColor: primary_blue,
      //   title: Text('Kthehu'),
      //   centerTitle: false,
      // ): null,
      backgroundColor: primary_blue,
      body: youtubeHierarchy(),
    );
  }
  _scheduleVideo(DateTime dateTime, String videoId) {
    print('qitu');
    final timestamp = dateTime.millisecondsSinceEpoch;
    this._scheduleService.scheduleVideo(CreateSchedule(timestamp, videoId));
  }

  _pushToNextScreen() {
    print("hini ne push");
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Navigator.of(context).pushNamed("/intro");
  }
  youtubeHierarchy() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    _controller.updateValue(_controller.value.copyWith(isFullScreen: true));
    print("ne hierarchy");
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
            onEnded: (data) {
              print("edhe qitu");
              _pushToNextScreen();
            },
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
