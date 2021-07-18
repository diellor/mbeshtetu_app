import 'package:mbeshtetu_app/src/models/started_watching_videos_model.dart';

abstract class UserService {
  Future<void> createUser();
  Future<void> startedWatchingVideo(StartedWatchingVideosRequest request);
}
