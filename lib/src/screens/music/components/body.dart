// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:mbeshtetu_app/src/models/video_model.dart';
// import 'package:mbeshtetu_app/src/screens/music/components/audi_player_screen.dart';
// import 'package:mbeshtetu_app/src/size_config.dart';
//
// class Body extends StatefulWidget {
//    List<Video> videos = [];
//    int index = 0;
//
//    Body({Key key, this.videos,this.index}) : super(key: key);
//
//   @override
//   _BodyState createState() => _BodyState();
// }
//
// class _BodyState extends State<Body> {
//   AudioPlayer advancedPlayer;
//
//   @override
//   void initState() {
//     super.initState();
//     advancedPlayer = AudioPlayer();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned.fill(
//             child: Image.asset(
//           "images/audio_bg.png",
//           width: SizeConfig.screenWidth,
//           fit: BoxFit.fitWidth,
//           repeat: ImageRepeat.repeatX,
//           alignment: Alignment.bottomCenter,
//         )),
//         Column(
//           children: [
//             Expanded(
//                 flex: 1,
//                 child: Row(
//                   children: [
//                     IconButton(
//                         icon: SvgPicture.asset("images/audio_back_btn.svg"),
//                         onPressed: () {})
//                   ],
//                 )),
//             Expanded(
//                 flex: 4,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(
//                           bottom: 2 * SizeConfig.heightMultiplier),
//                       child: Container(
//                         width: 70 * SizeConfig.heightMultiplier,
//                         height: 70 * SizeConfig.widthMultiplier,
//                         child: Image.asset(
//                           "images/audio_player_img.png",
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                     Text(
//                       "Category",
//                       style: TextStyle(fontSize: 2 * SizeConfig.textMultiplier),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(
//                           bottom: 2 * SizeConfig.heightMultiplier),
//                       child: Text(
//                         this.widget?.videos[this.widget.index]?.title,
//                         style: TextStyle(
//                             fontSize: 3 * SizeConfig.textMultiplier,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     AudioPlayerScreen(video: this.widget?.videos[this.widget.index]),
//                   ],
//                 )),
//           ],
//         )
//       ],
//     );
//   }
// }


import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/business_logic/notifiers/play_button_notifier.dart';
import 'package:mbeshtetu_app/src/business_logic/notifiers/progress_notifier.dart';
import 'package:mbeshtetu_app/src/business_logic/notifiers/repeat_button_notifier.dart';
import 'package:mbeshtetu_app/src/business_logic/page_manager.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';

class Body extends StatefulWidget {
  List<Video> videos = [];
  Video video;
  int index = -1;

  Body({Key key, this.video, this.index,this.videos}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => Body(),
  );

  @override
  _BodyState createState() => _BodyState();
}

PageManager _pageManager;

class _BodyState extends State<Body> {

  @override
  void initState() {
    super.initState();

    _pageManager = serviceLocator<PageManager>();
    _pageManager.setPlayList(this.widget.video, this.widget.index, this.widget.videos);
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _pageManager.dispose();
    super.deactivate();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CurrentSongTitle(),
              Playlist(),
              AudioProgressBar(),
              AudioControlButtons(),
            ],
          ),
    );
  }
}

class CurrentSongTitle extends StatelessWidget {
  const CurrentSongTitle({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: _pageManager.currentSongTitleNotifier,
      builder: (_, title, __) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(title, style: TextStyle(fontSize: 40)),
        );
      },
    );
  }
}

class Playlist extends StatelessWidget {
  const Playlist({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<String>>(
        valueListenable: _pageManager.playlistNotifier,
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
  const AudioProgressBar({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: _pageManager.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: _pageManager.seek,
        );
      },
    );
  }
}

class AudioControlButtons extends StatelessWidget {
  const AudioControlButtons({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RepeatButton(),
          PreviousSongButton(),
          PlayButton(),
          NextSongButton(),
        ],
      ),
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<RepeatState>(
      valueListenable: _pageManager.repeatButtonNotifier,
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
          onPressed: _pageManager.onRepeatButtonPressed,
        );
      },
    );
  }
}

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _pageManager.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          icon: Icon(Icons.skip_previous),
          onPressed:
          (isFirst) ? null : _pageManager.onPreviousSongButtonPressed,
        );
      },
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ButtonState>(
      valueListenable: _pageManager.playButtonNotifier,
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
              icon: Icon(Icons.play_arrow),
              iconSize: 32.0,
              onPressed: _pageManager.play,
            );
          case ButtonState.playing:
            return IconButton(
              icon: Icon(Icons.pause),
              iconSize: 32.0,
              onPressed: _pageManager.pause,
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
    return ValueListenableBuilder<bool>(
      valueListenable: _pageManager.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          icon: Icon(Icons.skip_next),
          onPressed: (isLast) ? null : _pageManager.onNextSongButtonPressed,
        );
      },
    );
  }
}