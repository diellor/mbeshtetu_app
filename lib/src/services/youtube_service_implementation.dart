import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:mbeshtetu_app/src/models/categoryMetadata_model.dart';
import 'package:mbeshtetu_app/src/models/category_model.dart';
import 'package:mbeshtetu_app/src/models/videoMetadata_model.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';
import 'package:mbeshtetu_app/src/services/youtube_service.dart';

import '../../main.dart';

class YoutubeServiceImpl implements YoutubeService{
  @override
  Future<CategoryMetadata> fetchCategoriesWithVideos() async {
    Uri uri = getApiUri('category');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var categorydata = json.decode(response.body);
      CategoryMetadata categoryMetadata = CategoryMetadata.fromJson(categorydata);
      print("TI QIFSHA MOTRAT NGOJ");
      final recentVideos = await this.fetchRecentVideos();
      print(recentVideos);
      categoryMetadata.categories.add(Category(id: 999, category: "Recent", subCategory: "", videos: recentVideos));
      return categoryMetadata;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Video>> fetchRecentVideos() async {
    print("QKA KARI KI PRA");
    // await Firebase.initializeApp();
    String deviceId = await FirebaseMessaging.instance.getToken();
    deviceId = deviceId.replaceAll(":", "");
    Uri uri = getApiUri('videos/$deviceId/recent');
    print(uri);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    var response = await http.get(uri, headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Iterable videoData = json.decode(response.body);
      List<Video> videos = videoData?.map((i)=> Video.fromJson(i))?.toList();
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  @override
  Future<List<Category>> fetchCategoriesNoVideos() async {
    Uri uri = Uri.http(
      '192.168.0.226:3000', '/category/videosByCategory',
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

  @override
  Future<VideoMetadata> loadVideosByCategoryId(int categoryId, int pageNumber, int limitPerPage) async {
    final queryParameters = {
      'categoryId': categoryId.toString(),
      'limit': limitPerPage.toString(),
      'page': pageNumber.toString(),
    };
    Uri uri = Uri.http('192.168.0.226:3000','/youtube/findByCategory', queryParameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Videos by category and paginate
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var videoData = json.decode(response.body);
      VideoMetadata videoMetadata = VideoMetadata.fromJson(videoData);
      return videoMetadata;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}