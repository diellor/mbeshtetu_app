import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/models/category_model.dart';
import 'package:mbeshtetu_app/src/models/videoMetadata_model.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';
import 'package:mbeshtetu_app/src/services/youtube_service.dart';

class CategoryScreenViewModel extends ChangeNotifier {
  final YoutubeService _youtubeService = serviceLocator<YoutubeService>();

  List<Category> _categories = [];
  VideoMetadata videoMetadata;
  Future<List<Category>> loadCategoryTabs() async {
    _categories = await _youtubeService.fetchCategoriesNoVideos();
    _categories = _categories.where((element) => element.category != "Meditimi" && element.category != "Gjumi").toList();
    return _categories;
  }

  List<Category> get getCategoryTabList {
    return _categories;
  }

  VideoMetadata get getVideoMetadata {
    return videoMetadata;
  }


  Future<VideoMetadata> loadVideosByCategoryId(int page, int categoryId) async {
    videoMetadata = await _youtubeService.loadVideosByCategoryId(categoryId, page, 200);
    return videoMetadata;
  }
}
