import 'dart:io';
import 'dart:convert';
import 'package:mbeshtetu_app/src/models/categoryMetadata_model.dart';
import 'package:mbeshtetu_app/src/models/category_model.dart';
import 'package:mbeshtetu_app/src/services/youtube_service.dart';
import 'package:http/http.dart' as http;

class YoutubeServiceImpl implements YoutubeService{
  @override
  Future<CategoryMetadata> fetchCategoriesWithVideos() async {
    Uri uri = Uri.http(
      '192.168.0.101:3000', '/category',
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var categorydata = json.decode(response.body);
      CategoryMetadata categoryMetadata = CategoryMetadata.fromJson(categorydata);
      return categoryMetadata;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  @override
  Future<List<Category>> fetchCategoriesNoVideos() async {
    Uri uri = Uri.http(
      '192.168.0.163:3000', '/category/videosByCategory',
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Iterable categorydata = json.decode(response.body);
      List<Category> categories = categorydata.map((i)=> Category.fromJson(i)).toList();
      return categories;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}