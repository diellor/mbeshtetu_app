import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/business_logic/notifiers/play_button_notifier.dart';
import 'package:mbeshtetu_app/src/business_logic/notifiers/progress_notifier.dart';
import 'package:mbeshtetu_app/src/business_logic/notifiers/repeat_button_notifier.dart';
import 'package:mbeshtetu_app/src/business_logic/page_manager.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';

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

  // Future<void> removeItems () async {
  //   serviceLocator<PageManager>().removeItems();
  // }
  Future<void> removeItems() async {
    await serviceLocator<PageManager>().remove();
  }
  Future<void> setPlayList () async {
    if(this.widget.video != null && this.widget.index == null || this.widget.index == -1){
      await serviceLocator<PageManager>().setPlayList(this.widget.video);
    } else
    if (this.widget.videos != null && this.widget.index != null || this.widget.index != -1 ){
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          CurrentSongTitle(),
          Playlist(),
          AddRemoveSongButtons(),
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
    final pageManager = serviceLocator<PageManager>();
    return ValueListenableBuilder<String>(
      valueListenable: pageManager.currentSongTitleNotifier,
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

class AddRemoveSongButtons extends StatelessWidget {
  const AddRemoveSongButtons({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = serviceLocator<PageManager>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: pageManager.add,
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: pageManager.remove,
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = serviceLocator<PageManager>();
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: pageManager.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
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
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RepeatButton(),
          PreviousSongButton(),
          PlayButton(),
          NextSongButton(),
          ShuffleButton(),
        ],
      ),
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
          icon: Icon(Icons.skip_previous),
          onPressed: (isFirst) ? null : pageManager.previous,
        );
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
              icon: Icon(Icons.play_arrow),
              iconSize: 32.0,
              onPressed: pageManager.play,
            );
          case ButtonState.playing:
            return IconButton(
              icon: Icon(Icons.pause),
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
          icon: Icon(Icons.skip_next),
          onPressed: (isLast) ? null : pageManager.next,
        );
      },
    );
  }
}

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = serviceLocator<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isShuffleModeEnabledNotifier,
      builder: (context, isEnabled, child) {
        return IconButton(
          icon: (isEnabled)
              ? Icon(Icons.shuffle)
              : Icon(Icons.shuffle, color: Colors.grey),
          onPressed: pageManager.shuffle,
        );
      },
    );
  }
}
