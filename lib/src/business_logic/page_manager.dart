import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mbeshtetu_app/src/business_logic/category_screen_viewmodel.dart';
import 'package:mbeshtetu_app/src/business_logic/notifiers/play_button_notifier.dart';
import 'package:mbeshtetu_app/src/business_logic/notifiers/progress_notifier.dart';
import 'package:mbeshtetu_app/src/business_logic/notifiers/repeat_button_notifier.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';

class PageManager {
  final currentSongTitleNotifier = ValueNotifier<String>('');
  final playlistNotifier = ValueNotifier<List<String>>([]);
  final progressNotifier = ProgressNotifier();
  final repeatButtonNotifier = RepeatButtonNotifier();
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);

  CategoryScreenViewModel model = serviceLocator<CategoryScreenViewModel>();

  AudioPlayer _audioPlayer;
  ConcatenatingAudioSource _playlist;
  PageManager() {
    _init();
  }

  void _init() async {
    _audioPlayer = AudioPlayer();
    _listenForChangesInPlayerState();
    _listenForChangesInPlayerPosition();
    _listenForChangesInBufferedPosition();
    _listenForChangesInTotalDuration();
    _listenForChangesInSequenceState();
  }

  // void _setInitialPlaylist() async {
  //   const prefix = 'https://www.soundhelix.com/examples/mp3';
  //   final song1 = Uri.parse('$prefix/SoundHelix-Song-1.mp3');
  //   final song2 = Uri.parse('$prefix/SoundHelix-Song-2.mp3');
  //   final song3 = Uri.parse('$prefix/SoundHelix-Song-3.mp3');
  //   _playlist = ConcatenatingAudioSource(children: [
  //     AudioSource.uri(song1, tag: 'Song 1'),
  //     AudioSource.uri(song2, tag: 'Song 2'),
  //     AudioSource.uri(song3, tag: 'Song 3'),
  //   ]);
  //   await _audioPlayer.setAudioSource(_playlist);
  // }

  // void loadPlaylistFromDb(int categoryId, [String videoId]) async {
  //   if(videoId != null){
  //     _playlist = ConcatenatingAudioSource(children: [
  //       AudioSource.uri(Uri.parse(videoId), tag: 'Song 1'),
  //     ]);
  //     await _audioPlayer.setAudioSource(_playlist);
  //   } else {
  //     int _currentPage = 1;
  //     VideoMetadata list = await model.loadVideosByCategoryId(1, categoryId); //load data for first time
  //
  //     var audioResult = [];
  //     list.videos.forEach((element) {
  //       audioResult.add(AudioSource.uri(Uri.parse(element.videoId), tag: element.title),);
  //     });
  //     _playlist = ConcatenatingAudioSource(children: [
  //       ...audioResult
  //     ]);
  //     await _audioPlayer.setAudioSource(_playlist);
  //   }
  // }

  void setPlayList(Video video, [int index, List<Video> videos]) async {
    if(index != null && index != -1 && videos != null && videos.length > 0){
      int _currentPage = 1;
      var audioResult = [];
      videos.forEach((element) {
        audioResult.add(AudioSource.uri(Uri.parse(element.videoId), tag: element.title),);
      });
      _playlist = ConcatenatingAudioSource(children: [
        ...audioResult
      ]);
      await _audioPlayer.setAudioSource(_playlist);
      _audioPlayer.seek(Duration.zero,index: index);
    } else {
      _playlist = ConcatenatingAudioSource(children: [
        AudioSource.uri(Uri.parse(video.videoId), tag: video.videoId),
      ]);
      await _audioPlayer.setAudioSource(_playlist);
    }
  }

  void _listenForChangesInPlayerState() {
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });
  }

  void _listenForChangesInPlayerPosition() {
    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenForChangesInBufferedPosition() {
    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenForChangesInTotalDuration() {
    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  void _listenForChangesInSequenceState() {
    _audioPlayer.sequenceStateStream.listen((sequenceState) {
      if (sequenceState == null) return;
      //Song title
      final currentItem = sequenceState.currentSource;
      final title = currentItem?.tag as String;
      currentSongTitleNotifier.value = title ?? '';

      //show playlist
      final playlist = sequenceState.effectiveSequence;
      final titles = playlist.map((item) => item.tag as String).toList();
      playlistNotifier.value = titles;

      //update prev and next button if there are songs available
      if (playlist.isEmpty || currentItem == null) {
        isFirstSongNotifier.value = true;
        isLastSongNotifier.value = true;
      } else {
        isFirstSongNotifier.value = playlist.first == currentItem;
        isLastSongNotifier.value = playlist.last == currentItem;
      }
      // TODO: update shuffle mode
      // TODO: update previous and next buttons
    });
  }

  void play() async {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void dispose() {
    _audioPlayer.dispose();
  }

  void onRepeatButtonPressed() {
    repeatButtonNotifier.nextState();
    switch (repeatButtonNotifier.value) {
      case RepeatState.off:
        _audioPlayer.setLoopMode(LoopMode.off);
        break;
      case RepeatState.repeatSong:
        _audioPlayer.setLoopMode(LoopMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioPlayer.setLoopMode(LoopMode.all);
    }
  }

  void onPreviousSongButtonPressed() {
    _audioPlayer.seekToPrevious();
  }

  void onNextSongButtonPressed() {
    _audioPlayer.seekToNext();
  }
}