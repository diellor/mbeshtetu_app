class Video {
  final String id;
  final String title;
  final String videoId;
  final String thumbnail;
  final bool isAudio;

  Video({
    this.id,
    this.title,
    this.videoId,
    this.thumbnail,
    this.isAudio
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      videoId: json['videoId'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      isAudio: json['isAudio'],
    );
  }
}