import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';

Future<AudioHandler> initAudioService() async {
  return await AudioService.init(
    builder: () => MyAudioHandler(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.mycompany.myapp.audio',
      androidNotificationChannelName: 'Audio Service Demo',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
    ),
  );
}

class MyAudioHandler extends BaseAudioHandler {
  final player = AudioPlayer();
  var _playlist = ConcatenatingAudioSource(children: []);

  MyAudioHandler() {
    loadEmptyPlaylist();
    _notifyAudioHandlerAboutPlaybackEvents();
    _listenForDurationChanges();
    _listenForCurrentSongIndexChanges();
    _listenForSequenceStateChanges();
  }

  Future<void> loadEmptyPlaylist() async {
    try {
      await player.setAudioSource(_playlist);
    } catch (e) {
      print("Error: $e");
    }
  }

  void _notifyAudioHandlerAboutPlaybackEvents() {
    player.playbackEventStream.listen((PlaybackEvent event) {
      final playing = player.playing;
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.stop,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
        },
        androidCompactActionIndices: const [0, 1, 3],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[player.processingState],
        repeatMode: const {
          LoopMode.off: AudioServiceRepeatMode.none,
          LoopMode.one: AudioServiceRepeatMode.one,
          LoopMode.all: AudioServiceRepeatMode.all,
        }[player.loopMode],
        shuffleMode: (player.shuffleModeEnabled)
            ? AudioServiceShuffleMode.all
            : AudioServiceShuffleMode.none,
        playing: playing,
        updatePosition: player.position,
        bufferedPosition: player.bufferedPosition,
        speed: player.speed,
        queueIndex: event.currentIndex,
      ));
    });
  }

  void _listenForDurationChanges() {
    player.durationStream.listen((duration) {
      final index = player.currentIndex;
      final newQueue = queue.value;
      if (index == null || newQueue.isEmpty) return;
      final oldMediaItem = newQueue[index];
      final newMediaItem = oldMediaItem.copyWith(duration: duration);
      newQueue[index] = newMediaItem;
      queue.add(newQueue);
      mediaItem.add(newMediaItem);
    });
  }
  void _listenForCurrentSongIndexChanges() {
    player.currentIndexStream.listen((index) {
      var playlist = queue.value;
      if (index == null || playlist.isEmpty) return;
      mediaItem.add(playlist[index]);
    });
  }

  void _listenForSequenceStateChanges() {
    player.sequenceStateStream.listen((SequenceState sequenceState) {
      final sequence = sequenceState?.effectiveSequence;
      if (sequence == null || sequence.isEmpty) return;
      final items = sequence.map((source) => source.tag as MediaItem);
      queue.add(items.toList());
    });
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    // manage Just Audio
    final audioSource = mediaItems.map(_createAudioSource);
    _playlist = ConcatenatingAudioSource(children: []);
    await player.setAudioSource(_playlist);
   // _playlist.clear();
    _playlist.addAll(audioSource.toList());
    // notify system
    final newQueue = queue.value..addAll(mediaItems);
    queue.add(newQueue);
  }

  // @override
  // Future<void> onUpdateQueue(List<MediaItem> mediaItems) async {
  //   player = new AudioPlayer();
  // }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    // manage Just Audio
    final audioSource = _createAudioSource(mediaItem);
    _playlist = ConcatenatingAudioSource(children: []);
    await player.setAudioSource(_playlist);
    _playlist.add(audioSource);
    // notify system
    var newQueue = queue.value..add(mediaItem);
    queue.add(newQueue);
  }

  UriAudioSource _createAudioSource(MediaItem mediaItem) {
    return AudioSource.uri(
      Uri.parse(mediaItem.extras['url']),
      tag: mediaItem,
    );
  }

  @override
  Future<void> removeQueueItemAt(int index) async {
    // manage Just Audio
    _playlist.removeAt(index);

    // notify system
    final newQueue = queue.value..removeAt(index);
    queue.add(newQueue);
  }

  @override
  Future<void> play() => player.play();

  @override
  Future<void> pause() => player.pause();

  @override
  Future<void> seek(Duration position) => player.seek(position);

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= queue.value.length) return;
    player.seek(Duration.zero, index: index);
  }

  @override
  Future<void> skipToNext() async {
    await _skip(1);
  }

  @override
  Future<void> skipToPrevious() async {
    await _skip(-1);
  }

  Future<void> _skip(int offset) async {
    final queue = this.queue.value;
    final index = playbackState.value.queueIndex ?? -1;
    if (index < 0 || index >= queue.length) return;
    return skipToQueueItem(index + offset);
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    switch (repeatMode) {
      case AudioServiceRepeatMode.none:
        player.setLoopMode(LoopMode.off);
        break;
      case AudioServiceRepeatMode.one:
        player.setLoopMode(LoopMode.one);
        break;
      case AudioServiceRepeatMode.group:
      case AudioServiceRepeatMode.all:
        player.setLoopMode(LoopMode.all);
        break;
    }
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    if (shuffleMode == AudioServiceShuffleMode.none) {
      player.setShuffleModeEnabled(false);
    } else {
      player.setShuffleModeEnabled(true);
      player.shuffle();
    }
  }

  @override
  Future customAction(
      String name, [
        Map<String, dynamic> extras,
      ]) async {
    if (name == 'dispose') {
      //await player.dispose();
      super.stop();
    }
  }

  @override
  Future<void> stop() async {
    await player.stop();
    return super.stop();
  }
}