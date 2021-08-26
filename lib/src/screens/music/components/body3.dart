import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbeshtetu_app/src/business_logic/notifiers/play_button_notifier.dart';
import 'package:mbeshtetu_app/src/business_logic/notifiers/progress_notifier.dart';
import 'package:mbeshtetu_app/src/business_logic/notifiers/repeat_button_notifier.dart';
import 'package:mbeshtetu_app/src/business_logic/page_manager.dart';
import 'package:mbeshtetu_app/src/commons.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

class Body3 extends StatefulWidget {

  final Video video;
  final int index;
  final List<Video> videos;
  const Body3({Key key, this.video, this.index, this.videos}): super(key: key);

  //const Body3({Key key}) : super(key: key);

  @override
  _Body3State createState() => _Body3State();
}

class _Body3State extends State<Body3> {

  @override
  void initState() {
    super.initState();
   // serviceLocator<PageManager>().removeItems();
    setPlayList();
  }

  Future<void> removeItems() async {
    await serviceLocator<PageManager>().remove();
  }

  Future<void> setPlayList () async {
    if(this.widget.video != null && this.widget.index == null || this.widget.index == -1){
      await serviceLocator<PageManager>().setPlayList(this.widget.video);
    } else
    if (this.widget.videos != null && this.widget.index != null || this.widget.index != -1 ){
      print(this.widget.videos);
      await serviceLocator<PageManager>().setPlayList(this.widget.video, this.widget.index, this.widget.videos);
     // await skipToNext();
    }
  }

  Future<void> skipToNext () async {
    if (this.widget.videos != null && this.widget.index != null || this.widget.index != -1 ){
       await serviceLocator<PageManager>().skipToNextItemInQueue(this.widget.index);
    }
  }

  @override
  void dispose() {
    serviceLocator<PageManager>().dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    serviceLocator<PageManager>().dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
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
                            "images/audio_bg_2.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 4,
                      ),
                      CurrentSongTitle(),
                      Container(
                        child: Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AudioProgressBar(videoId: this.widget.video?.videoId != null?this.widget.video.videoId: this.widget.videos[this.widget.index].videoId ,),
                              AudioControlButtons(),
                              RepeatButton(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ],
        )
      ],
    );
  }
}



class CurrentSongTitle extends StatelessWidget {
  const CurrentSongTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = serviceLocator<PageManager>();
    return ValueListenableBuilder<String>(
      valueListenable: pageManager.currentSongTitleNotifier,
      builder: (_, title, __) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: 2 * SizeConfig.heightMultiplier),
          child: FittedBox(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 3 * SizeConfig.textMultiplier,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}

class Playlist extends StatelessWidget {
  const Playlist({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = serviceLocator<PageManager>();
    return Expanded(
      child: ValueListenableBuilder<List<String>>(
        valueListenable: pageManager.playlistNotifier,
        builder: (context, playlistTitles, _) {
          return ListView.builder(
            itemCount: playlistTitles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${playlistTitles[index]}'),
              );
            },
          );
        },
      ),
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  final String videoId;
  AudioProgressBar({Key key, this.videoId}) : super(key: key);

  var flag = false;
  @override
  Widget build(BuildContext context) {
    final pageManager = serviceLocator<PageManager>();
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: pageManager.progressNotifier,
      builder: (_, value, __) {
        print("CURRENT"+value.current.toString());
        print("TOTAL"+value.total.toString());
        if(value.current.compareTo(value.total) > 0 && flag == false){
          WidgetsBinding.instance.addPostFrameCallback((_){
            flag = true;
            print("VIDEOID"+videoId);
            Navigator.of(context)
                .pushNamed("/postVideo", arguments: videoId );
          });
        }
        return ProgressBar(
          baseBarColor: secondary_blue,
          bufferedBarColor: secondary_blue,
          progressBarColor: preMeditation_bg,
          thumbColor: preMeditation_bg ,
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: pageManager.seek,
        );
      },
    );
  }
}

class AudioControlButtons extends StatelessWidget {
  const AudioControlButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PreviousSongButton(),
        PlayButton(),
        NextSongButton(),
      ],
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = serviceLocator<PageManager>();

    return ValueListenableBuilder<RepeatState>(
      valueListenable: pageManager.repeatButtonNotifier,
      builder: (context, value, child) {
        Icon icon;
        switch (value) {
          case RepeatState.off:
            icon = Icon(Icons.repeat, color: Colors.grey);
            break;
          case RepeatState.repeatSong:
            icon = Icon(Icons.repeat_one);
            break;
          case RepeatState.repeatPlaylist:
            icon = Icon(Icons.repeat);
            break;
        }
        return IconButton(
          icon: icon,
          onPressed: pageManager.repeat,
        );
      },
    );
  }
}

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = serviceLocator<PageManager>();

    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          icon: Image.asset("images/audio_left.png"),
          onPressed: (isFirst) ? null : pageManager.previous,        );
      },
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = serviceLocator<PageManager>();

    return ValueListenableBuilder<ButtonState>(
      valueListenable: pageManager.playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: EdgeInsets.all(8.0),
              width: 32.0,
              height: 32.0,
              child: CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return IconButton(
              icon: Image.asset("images/audio_play.png"),
              iconSize: 32.0,
              onPressed: pageManager.play,
            );
          case ButtonState.playing:
            return IconButton(
              icon: Image.asset("images/audio_pause.png"),
              iconSize: 32.0,
              onPressed: pageManager.pause,
            );
        }
      },
    );
  }
}

class NextSongButton extends StatelessWidget {
  const NextSongButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = serviceLocator<PageManager>();

    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          icon: Image.asset("images/audio_right.png"),
          onPressed: (isLast) ? null : pageManager.next,
        );
      },
    );
  }
}
