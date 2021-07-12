import 'package:mbeshtetu_app/src/models/categoryMetadata_model.dart';

abstract class YoutubeService {
  Future<CategoryMetadata> fetchCategoriesWithVideos();
}