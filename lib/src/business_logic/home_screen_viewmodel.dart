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
    print("erdh QITU");
    if (category.category == "Ankthi" && category.subCategory == "MESO") {
      return "Meso per ankthin";
    } else if (category.category == "Ankthi" &&
        category.subCategory == "LEHTESO") {
      return "Lehteso simptomet e ankthit";
    } else if (category.category == "Stresi" &&
        category.subCategory == "MESO") {
      return "Meso per stresin";
    } else if (category.category == "Stresi" &&
        category.subCategory == "LEHTESO") {
      return "Lehteso simptomet e stresit";
    } else if (category.category == "Depresioni" &&
        category.subCategory == "MESO") {
      return "Meso per depresionin";
    } else if (category.category == "Recent") {
      return "Shikuar së fundmi";
    } else if (category.category == "Depresioni" &&
        category.subCategory == "LEHTESO") {
      return "Lehteso simptomet e depresionit";
    } else {
      return "Te tjera";
    }
  }
}
