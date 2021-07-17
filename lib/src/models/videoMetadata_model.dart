import 'package:mbeshtetu_app/src/models/video_model.dart';

class VideoMetadata {
  List<Video> videos;
  int total;
  int page;

  VideoMetadata({
    this.videos,this.total, this.page
  });

  factory VideoMetadata.fromJson(Map<String, dynamic> json) {
    Iterable list = json['videos'];
    List<Video> videos = list.map((i)=> Video.fromJson(i)).toList();

    return VideoMetadata(
      videos: videos,
      total: json['total'],
      page: json['page'],
    );
  }
}