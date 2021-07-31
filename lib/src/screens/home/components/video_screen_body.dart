import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbeshtetu_app/src/models/started_watching_videos_model.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';
import 'package:mbeshtetu_app/src/screens/splash/components/default_button.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';
import 'package:mbeshtetu_app/src/services/user_service.dart';
import 'package:mbeshtetu_app/src/size_config.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreenBody extends StatefulWidget {
  final Video video;
  VideoScreenBody({this.video});

  @override
  _VideoScreenBodyState createState() => _VideoScreenBodyState();
}

class _VideoScreenBodyState extends State<VideoScreenBody> {
  YoutubePlayerController _controller;
  final UserService _userService = serviceLocator<UserService>();

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.videoId,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
    _userService.startedWatchingVideo(StartedWatchingVideosRequest(
        _controller.initialVideoId,
        DateTime.now().millisecondsSinceEpoch ~/ 1000));
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("ne build");
    return  youtubeHierarchy();
  }

  _scheduleVideo(DateTime dateTime, String videoId) {
    print('qitu');
    final timestamp = dateTime.millisecondsSinceEpoch;
    // this._scheduleService.scheduleVideo(CreateSchedule(timestamp, videoId));
  }

  _pushToNextScreen() {
    String omg = this._controller.initialVideoId;
    print("hini ne push $omg");
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Navigator.of(context)
        .pushNamed("/postVideo", arguments: this._controller.initialVideoId);
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
        color: Colors.white,
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
                Flexible(flex: 1, fit: FlexFit.loose, child: player),
                Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.5 * SizeConfig.heightMultiplier,
                            horizontal: 3 * SizeConfig.widthMultiplier),
                        child: Text(
                          widget.video.title,
                          style: TextStyle(
                              fontSize: 3 * SizeConfig.textMultiplier),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 13 * SizeConfig.widthMultiplier,
                        vertical: 13 * SizeConfig.heightMultiplier),
                    child: DefaultButton(
                      text: "Kthehu",
                      press: () {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        }
                        //_controller.dispose();
                        Navigator.pop(context);
                      },
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
