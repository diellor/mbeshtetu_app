import 'package:get/state_manager.dart';
import 'package:mbeshtetu_app/src/models/videoMetadata_model.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';
import 'package:mbeshtetu_app/src/services/youtube_service.dart';

class CategoryController extends GetxController {
  var isLoading = true.obs;
  var categoryList = VideoMetadata().obs;
  final YoutubeService _youtubeService = serviceLocator<YoutubeService>();

  @override
  void onInit() {
    super.onInit();
  }


  void fetchCategory(int category) async {
    try {
      isLoading(true);
      var categories = await _youtubeService.loadVideosByCategoryId(category, 1, 222);
      if (categories != null) {
        categoryList.value = categories;
      }
    } finally {
      isLoading(false);
    }
  }
}