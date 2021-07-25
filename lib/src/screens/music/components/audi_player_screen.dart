import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mbeshtetu_app/src/commons.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';

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
    ], playing: true,
        processingState: AudioProcessingState.connecting);
    // Connect to the URL
    await _audioPlayer.setUrl(params["url"]);

    _audioPlayer.play();

    AudioServiceBackground.setState(controls: [
      MediaControl.pause,
      MediaControl.stop,
    ], playing: true, processingState: AudioProcessingState.ready);

    return super.onStart(params);
  }

  @override
  Future<void> onStop() async {
    AudioServiceBackground.setState(
        controls: [],
        playing: false,
        processingState: AudioProcessingState.ready);
    await _audioPlayer.stop();
    await super.onStop();
  }

  @override
  Future<void> onPause() async {
    AudioServiceBackground.setState(controls: [
      MediaControl.play,
      MediaControl.stop,
    ], playing: false, processingState: AudioProcessingState.ready);
    await _audioPlayer.pause();
    return super.onPause();
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
}


class AudioPlayerScreen extends StatefulWidget {

  final Video video;
  const AudioPlayerScreen({Key key, this.video}) : super(key: key);

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  Duration _durationPlayer = new Duration();
  Duration _postitionPlayer = new Duration();

  bool isPlaying = false;
  bool isPause = false;
  bool isRepeating = false;
  Color color = Colors.black;



  @override
  void initState() {
    initAudioService();
    super.initState();



    // //this changes all the time as audio plays
    // this.widget.advancedPlayer.onAudioPositionChanged.listen((event) {
    //   setState(() {
    //     _postitionPlayer = event;
    //   });
    // });
    // //this is duration of the audio
    // this.widget.advancedPlayer.onDurationChanged.listen((event) {
    //   setState(() {
    //     _durationPlayer = event;
    //   });
    // });

    // this.widget.advancedPlayer.setUrl(this.widget.video.videoId);
    //
    // this.widget.advancedPlayer.onPlayerCompletion.listen((event) {
    //   setState(() {
    //     _postitionPlayer = Duration(seconds: 0);
    //     if (isRepeating == true) {
    //       isPlaying = true;
    //     } else {
    //       isPlaying = false;
    //       isRepeating = false;
    //     }
    //   });
    // });
  }

  @override
  void dispose(){
    AudioService.disconnect();
    super.dispose();
  }

  initAudioService() async {
    await AudioService.connect();
  }

  Widget slider() {
    return Slider(
      activeColor: bold_blue,
      inactiveColor: Colors.grey,
      value: _postitionPlayer.inSeconds.toDouble(),
      min: 0.0,
      max: _durationPlayer.inSeconds.toDouble(),
      onChanged: (double value) {
        setState(() {
          changeToSeconds(value.toInt());
          value = value;
        });
      },
    );
  }

  void changeToSeconds(int second) {
    Duration newDuration = Duration(seconds: second);
   // this.widget.advancedPlayer.seek(newDuration);
  }

  Widget startButton() {
    return StreamBuilder<PlaybackState>(
        stream: AudioService.playbackStateStream,
      builder: (context,snapshot){
          final isPlaying = snapshot.data?.playing ?? false;
          if(isPlaying){
            return IconButton(icon: Image.asset("images/audio_pause.png"), onPressed: (){
              AudioService.pause();
            });
          } else {
            return IconButton(icon: Image.asset("images/audio_play.png"), onPressed: (){
              if(AudioService.running){
                AudioService.play();
              }else {
                AudioService.start(backgroundTaskEntrypoint: _backgroundTaskEntrypoint, params: {"url": "https://mbeshtetu.fra1.digitaloceanspaces.com/1.Njohja%20e%20Simptomave%20te%20Ankthit%20-%20Simptomat%20Mendore%20%28Final%29.mp3"});
              }
            });
          }
      },
    );
    // return IconButton(
    //     icon: isPlaying == false
    //         ? Image.asset("images/audio_play.png")
    //         : Image.asset("images/audio_pause.png"),
    //     onPressed: () {
    //       if (isPlaying == false) {
    //         this.widget.advancedPlayer.play(this.widget.video.videoId);
    //         setState(() {
    //           isPlaying = true;
    //         });
    //       } else {
    //         setState(() {
    //           this.widget.advancedPlayer.pause();
    //           isPlaying = false;
    //         });
    //       }
    //     });
  }

  Widget loadButtonAssets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 48,
        ),
        IconButton(
            icon: Image.asset("images/audio_left.png"),
            onPressed: () {
             // this.widget.advancedPlayer.setPlaybackRate(playbackRate: 0.5);
            }),
        startButton(),
        IconButton(
            icon: Image.asset("images/audio_right.png"),
            onPressed: () {
             // this.widget.advancedPlayer.setPlaybackRate(playbackRate: 1.5);
            }),
        IconButton(
            color: color,
            icon: Icon(Icons.loop_outlined),
            onPressed: () {
              if (isRepeating == false) {
               // this.widget.advancedPlayer.setReleaseMode(ReleaseMode.LOOP);
                setState(() {
                  isRepeating = true;
                  color = bold_blue;
                });
              } else if (isRepeating == true) {
              //  this.widget.advancedPlayer.setReleaseMode(ReleaseMode.RELEASE);
                color = Colors.black;
                isRepeating = false;
              }
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Expanded(
        child: Column(
          children: [
            Text(_postitionPlayer.toString().split(".")[0] +
                " / " +
                _durationPlayer.toString().split(".")[0]),
            slider(),
            loadButtonAssets(),
          ],
        ),
      ),
    );
  }
}
