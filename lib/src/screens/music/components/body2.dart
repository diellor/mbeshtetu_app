import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';
import 'package:mbeshtetu_app/src/size_config.dart';


_backgroundTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

class AudioPlayerTask extends BackgroundAudioTask {
  final _audioPlayer = AudioPlayer();

  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    AudioServiceBackground.setState(controls: [
      MediaControl.pause,
      MediaControl.stop,
    ], playing: true, processingState: AudioProcessingState.connecting);
    // Connect to the URL
    await _audioPlayer.setUrl(params["url"]);
    // Now we're ready to play
    _audioPlayer.play();
    // Broadcast that we're playing, and what controls are available.
    AudioServiceBackground.setState(controls: [
      MediaControl.pause,
      MediaControl.stop,
    ], playing: true, processingState: AudioProcessingState.ready);
  }

  @override
  Future<void> onStop() async {
    AudioServiceBackground.setState(
        controls: [],
        playing: false,
        processingState: AudioProcessingState.stopped);
    await _audioPlayer.stop();
    await super.onStop();
  }

  @override
  Future<void> onPlay() async {
    AudioServiceBackground.setState(controls: [
      MediaControl.pause,
      MediaControl.stop,
    ], playing: true, processingState: AudioProcessingState.ready);
    await _audioPlayer.play();
    return super.onPlay();
  }

  @override
  Future<void> onPause() async {
    AudioServiceBackground.setState(controls: [
      MediaControl.play,
      MediaControl.stop,
    ],playing: false, processingState: AudioProcessingState.ready); //change to true
    await _audioPlayer.pause();
    return super.onPause();
  }
}


class Body2 extends StatefulWidget {
  List<Video> videos = [];
  Video video;
  int index = -1;

  Body2({Key key, this.video, this.index, this.videos}) : super(key: key);

  static Route<dynamic> route() =>
      MaterialPageRoute(
        builder: (context) => Body2(),
      );

  @override
  _Body2State createState() => _Body2State();
}


class _Body2State extends State<Body2> {
  @override
  void initState() {
    initAudioService();
    super.initState();
  }
  initAudioService() async {
    await AudioService.connect();
  }

  @override
  void dispose() {
    AudioService.disconnect();
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    String url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";
    return Stack(
      children: [
        Positioned.fill(
            child: Image.asset(
              "images/audio_bg.png",
              width: SizeConfig.screenWidth,
              fit: BoxFit.fitWidth,
              repeat: ImageRepeat.repeatX,
              alignment: Alignment.bottomCenter,
            )),
        Column(
          children: [
            Expanded(
                flex: 1,
                child: Row(
                  children: [
                    IconButton(
                        icon: SvgPicture.asset("images/audio_back_btn.svg"),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                )),
            Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 2 * SizeConfig.heightMultiplier),
                        child: Container(
                          width: 70 * SizeConfig.heightMultiplier,
                          height: 70 * SizeConfig.widthMultiplier,
                          child: Image.asset(
                            "images/audio_player_img.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 4,
                      ),
                      Text("WOW"),
                      Container(
                        child: Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: StreamBuilder<PlaybackState>(
                                  stream: AudioService.playbackStateStream,
                                  builder: (context,snapshot){
                                    final playing = snapshot.data?.playing ?? false;
                                    if(playing){
                                      return ElevatedButton(onPressed: (){
                                        AudioService.pause();
                                      }, child: Text("PAUZE BITCH"));
                                    } else {
                                      return ElevatedButton(onPressed: (){
                                        if(AudioService.running){
                                          AudioService.play();
                                        }else{
                                          AudioService.start(backgroundTaskEntrypoint: _backgroundTaskEntrypoint, params: {"url":url});
                                        }
                                      }, child: Text("Play"));
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        )
      ],
    );
  }
}
//
// class CurrentSongTitle extends StatelessWidget {
//   const CurrentSongTitle({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // final pageManager = serviceLocator<PageManager>();
//     return ValueListenableBuilder<String>(
//       valueListenable: pageManager.currentSongTitleNotifier,
//       builder: (_, title, __) {
//         return Padding(
//           padding: EdgeInsets.only(
//               bottom: 2 * SizeConfig.heightMultiplier),
//           child: Text(
//             title,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 fontSize: 3 * SizeConfig.textMultiplier,
//                 fontWeight: FontWeight.bold),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class Playlist extends StatelessWidget {
//   const Playlist({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // final pageManager = serviceLocator<PageManager>();
//     return Expanded(
//       child: ValueListenableBuilder<List<String>>(
//         valueListenable: pageManager.playlistNotifier,
//         builder: (context, playlistTitles, _) {
//           return ListView.builder(
//             itemCount: playlistTitles.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text('${playlistTitles[index]}'),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class AudioProgressBar extends StatelessWidget {
//   final String videoId;
//   AudioProgressBar({Key key, this.videoId}) : super(key: key);
//
//   var flag = false;
//   @override
//   Widget build(BuildContext context) {
//     // final pageManager = serviceLocator<PageManager>();
//     return ValueListenableBuilder<ProgressBarState>(
//       valueListenable: pageManager.progressNotifier,
//       builder: (_, value, __) {
//         print("CURRENT"+value.current.toString());
//         print("TOTAL"+value.total.toString());
//         if(value.current.compareTo(value.total) > 0 && flag == false){
//           WidgetsBinding.instance.addPostFrameCallback((_){
//             flag = true;
//             print("VIDEOID"+videoId);
//             Navigator.of(context)
//                 .pushNamed("/postVideo", arguments: videoId );
//           });
//         }
//         return ProgressBar(
//           baseBarColor: secondary_blue,
//           bufferedBarColor: secondary_blue,
//           progressBarColor: preMeditation_bg,
//           thumbColor: preMeditation_bg ,
//           progress: value.current,
//           buffered: value.buffered,
//           total: value.total,
//           onSeek: pageManager.seek,
//         );
//       },
//     );
//   }
// }
//
// class AudioControlButtons extends StatelessWidget {
//   const AudioControlButtons({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         PreviousSongButton(),
//         PlayButton(),
//         NextSongButton(),
//       ],
//     );
//   }
// }
//
// class RepeatButton extends StatelessWidget {
//   const RepeatButton({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // final pageManager = serviceLocator<PageManager>();
//
//     return ValueListenableBuilder<RepeatState>(
//       valueListenable: pageManager.repeatButtonNotifier,
//       builder: (context, value, child) {
//         Icon icon;
//         switch (value) {
//           case RepeatState.off:
//             icon = Icon(Icons.repeat, color: Colors.grey);
//             break;
//           case RepeatState.repeatSong:
//             icon = Icon(Icons.repeat_one);
//             break;
//           case RepeatState.repeatPlaylist:
//             icon = Icon(Icons.repeat);
//             break;
//         }
//         return IconButton(
//           icon: icon,
//           onPressed: pageManager.repeat,
//         );
//       },
//     );
//   }
// }
//
// class PreviousSongButton extends StatelessWidget {
//   const PreviousSongButton({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // final pageManager = serviceLocator<PageManager>();
//
//     return ValueListenableBuilder<bool>(
//       valueListenable: pageManager.isFirstSongNotifier,
//       builder: (_, isFirst, __) {
//         return IconButton(
//           icon: Image.asset("images/audio_left.png"),
//           onPressed: (isFirst) ? null : pageManager.previous,        );
//       },
//     );
//   }
// }
//
// class PlayButton extends StatelessWidget {
//   const PlayButton({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // final pageManager = serviceLocator<PageManager>();
//
//     return ValueListenableBuilder<ButtonState>(
//       valueListenable: pageManager.playButtonNotifier,
//       builder: (_, value, __) {
//         switch (value) {
//           case ButtonState.loading:
//             return Container(
//               margin: EdgeInsets.all(8.0),
//               width: 32.0,
//               height: 32.0,
//               child: CircularProgressIndicator(),
//             );
//           case ButtonState.paused:
//             return IconButton(
//               icon: Image.asset("images/audio_play.png"),
//               iconSize: 32.0,
//               onPressed: pageManager.play,
//             );
//           case ButtonState.playing:
//             return IconButton(
//               icon: Image.asset("images/audio_pause.png"),
//               iconSize: 32.0,
//               onPressed: pageManager.pause,
//             );
//         }
//       },
//     );
//   }
// }
//
// class NextSongButton extends StatelessWidget {
//   const NextSongButton({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // final pageManager = serviceLocator<PageManager>();
//
//     return ValueListenableBuilder<bool>(
//       valueListenable: pageManager.isLastSongNotifier,
//       builder: (_, isLast, __) {
//         return IconButton(
//           icon: Image.asset("images/audio_right.png"),
//           onPressed: (isLast) ? null : pageManager.next,
//         );
//       },
//     );
//   }
// }
