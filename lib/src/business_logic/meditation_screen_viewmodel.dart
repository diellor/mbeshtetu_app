import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/models/category_model.dart';
import 'package:mbeshtetu_app/src/models/videoMetadata_model.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';
import 'package:mbeshtetu_app/src/services/youtube_service.dart';

class MeditationScreenViewModel extends ChangeNotifier {
  final YoutubeService _youtubeService = serviceLocator<YoutubeService>();

  List<Category> _categories = [];
  VideoMetadata videoMetadata;
  Category categorySleep;
  Future<List<Category>> loadCategoryTabs() async {
    _categories = await _youtubeService.fetchCategoriesNoVideos();
    _categories = _categories.where((element) => element.category == "Meditimi").toList();
    return _categories;
  }

  Future<Category> loadSleepCategory() async {
    _categories = await _youtubeService.fetchCategoriesNoVideos();
    categorySleep = _categories.firstWhere((element) => element.category == "Gjumi");
    return categorySleep;
  }

  List<Category> get getCategoryTabList {
    return _categories;
  }

  VideoMetadata get getVideoMetadata {
    return videoMetadata;
  }

  Future<VideoMetadata> loadVideosByCategoryId(int page, int categoryId) async {
    videoMetadata = await _youtubeService.loadVideosByCategoryId(categoryId, page, 500);
    return videoMetadata;
  }
}
