import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/commons.dart';

class AudioPlayerScreen extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  const AudioPlayerScreen({Key key, this.advancedPlayer}) : super(key: key);

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  Duration _durationPlayer = new Duration();
  Duration _postitionPlayer = new Duration();

  final String pathUrl =
      "https://mbeshtetu.fra1.digitaloceanspaces.com/DJ%20ARNE%20L%20II%20-%20Grave%20Diggers%20%28Original%20Mix%29.mp3";
  bool isPlaying = false;
  bool isPause = false;
  bool isRepeating = false;
  Color color = Colors.black;
  @override
  void initState() {
    super.initState();

    //this changes all the time as audio plays
    this.widget.advancedPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        _postitionPlayer = event;
      });
    });
    //this is duration of the audio
    this.widget.advancedPlayer.onDurationChanged.listen((event) {
      setState(() {
        _durationPlayer = event;
      });
    });

    this.widget.advancedPlayer.setUrl(pathUrl);

    this.widget.advancedPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _postitionPlayer = Duration(seconds: 0);
        if (isRepeating == true) {
          isPlaying = true;
        } else {
          isPlaying = false;
          isRepeating = false;
        }
      });
    });
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
    this.widget.advancedPlayer.seek(newDuration);
  }

  Widget startButton() {
    return IconButton(
        icon: isPlaying == false
            ? Image.asset("images/audio_play.png")
            : Image.asset("images/audio_pause.png"),
        onPressed: () {
          if (isPlaying == false) {
            this.widget.advancedPlayer.play(pathUrl);
            setState(() {
              isPlaying = true;
            });
          } else {
            setState(() {
              this.widget.advancedPlayer.pause();
              isPlaying = false;
            });
          }
        });
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
              this.widget.advancedPlayer.setPlaybackRate(playbackRate: 0.5);
            }),
        startButton(),
        IconButton(
            icon: Image.asset("images/audio_right.png"),
            onPressed: () {
              this.widget.advancedPlayer.setPlaybackRate(playbackRate: 1.5);
            }),
        IconButton(
            color: color,
            icon: Icon(Icons.loop_outlined),
            onPressed: () {
              if (isRepeating == false) {
                this.widget.advancedPlayer.setReleaseMode(ReleaseMode.LOOP);
                setState(() {
                  isRepeating = true;
                  color = bold_blue;
                });
              } else if (isRepeating == true) {
                this.widget.advancedPlayer.setReleaseMode(ReleaseMode.RELEASE);
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
