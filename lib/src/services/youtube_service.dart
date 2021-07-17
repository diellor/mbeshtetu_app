import 'package:mbeshtetu_app/src/models/categoryMetadata_model.dart';
import 'package:mbeshtetu_app/src/models/category_model.dart';
import 'package:mbeshtetu_app/src/models/videoMetadata_model.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';

abstract class YoutubeService {
  Future<CategoryMetadata> fetchCategoriesWithVideos();
  Future<List<Category>> fetchCategoriesNoVideos();
  Future<VideoMetadata> loadVideosByCategoryId(int categoryId, int pageNumber, int limitPerPage);
}