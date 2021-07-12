class Video {
  final String id;
  final String title;
  final String videoId;

  Video({
    this.id,
    this.title,
    this.videoId,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      videoId: json['videoId'],
      title: json['title'],
    );
  }
}