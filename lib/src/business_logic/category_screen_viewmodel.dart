import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/models/category_model.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';
import 'package:mbeshtetu_app/src/services/youtube_service.dart';

class CategoryScreenViewModel extends ChangeNotifier {
  final YoutubeService _youtubeService = serviceLocator<YoutubeService>();

  List<Category> _categories = [];

  Future<List<Category>> loadCategoryTabs() async {
    _categories = await _youtubeService.fetchCategoriesNoVideos();
    return _categories;
  }

  List<Category> get getCategoryTabList {
    return _categories;
  }
}