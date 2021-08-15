import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/models/categoryMetadata_model.dart';
import 'package:mbeshtetu_app/src/models/category_model.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';
import 'package:mbeshtetu_app/src/services/youtube_service.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final YoutubeService _youtubeService = serviceLocator<YoutubeService>();

  CategoryMetadata _categories = defaultCategories;

  static final CategoryMetadata defaultCategories = CategoryMetadata(
    categories: [],
  );

  Future<CategoryMetadata> loadCategoriesData() async {
    _categories = await _youtubeService.fetchCategoriesWithVideos();
    return _categories;
  }

  CategoryMetadata get getCategories {
    return _categories;
  }


  T getRandomElement<T>(List<T> list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  Video get getMainVideo {
    Category category  = getRandomElement(_categories.categories.where((element) => element.category != "Meditimi" && element.category != "Gjumi").toList());
    Video video = getRandomElement(category.videos);
    return video;
  }

  List<Video> filteredVideosByCategory(Category category) {
    List<Category> filteredCategories = _categories.categories
        .where((item) =>
            item.category == category.category &&
            item.subCategory == category.subCategory)
        .toList();
    List<Video> filteredVideos = [];
    filteredCategories.forEach((element) {
      filteredVideos.addAll(element.videos);
    });
    return filteredVideos;
  }

  String getTitleRecomended(Category category) {
    if (category.category == "Ankthi" && category.subCategory == "MËSO") {
      return "Mëso për ankthin";
    } else if (category.category == "Ankthi" &&
        category.subCategory == "LEHTËSO") {
      return "Lehtëso simptomet e ankthit";
    } else if (category.category == "Stresi" &&
        category.subCategory == "MËSO") {
      return "Mëso për stresin";
    } else if (category.category == "Stresi" &&
        category.subCategory == "LEHTËSO") {
      return "Lehtëso simptomet e stresit";
    } else if (category.category == "Depresioni" &&
        category.subCategory == "MËSO") {
      return "Mëso për depresionin";
    } else if (category.category == "Recent" && category.videos.length > 0) {
      return "Shikuar së fundmi";
    } else if (category.category == "Depresioni" &&
        category.subCategory == "LEHTËSO") {
      return "Lehtëso simptomet e depresionit";
    } else if (category.videos.length > 0){
      return "Të tjera";
    } else {
      return "";
    }
  }
}
