import 'package:mbeshtetu_app/src/models/video_model.dart';

class Category {
  final int id;
  final String category;
  final String subCategory;
  List<Video> videos;

  Category({
    this.id,
    this.category,
    this.subCategory,
    this.videos
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    Iterable list = json['videos'];
    List<Video> videos = list.map((i)=> Video.fromJson(i)).toList();

    return Category(
      id: json['id'],
      category: json['category'],
      subCategory: json['sub_category'],
      videos: videos,
    );
  }
}