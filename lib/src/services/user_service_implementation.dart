import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mbeshtetu_app/src/models/create_user_model.dart';
import 'package:mbeshtetu_app/src/models/started_watching_videos_model.dart';
import 'package:mbeshtetu_app/src/models/user_model.dart';
import 'package:mbeshtetu_app/src/services/user_service.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class UserServiceImplementation extends UserService {
  @override
  Future<void> createUser() async {
    Uri uri = getApiUri('users');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    await Firebase.initializeApp();
    String deviceId = await FirebaseMessaging.instance.getToken();
    deviceId = deviceId.replaceAll(":", "");
    print("NANA JOTE " + deviceId);
    FirebaseMessaging.instance.subscribeToTopic(deviceId);
    var response = await http.post(uri, headers: headers, body: jsonEncode(<String, String>{
      'deviceId': deviceId,
    }));
    var userData = json.decode(response.body);
    User user = User.fromJson(userData);
    if (user.isSubscribedToQuotes) {
      FirebaseMessaging.instance.subscribeToTopic("epic");
    }
    // if (response.statusCode != 201) {
    //   throw json.decode(response.body)['error']['message'];
    // }
  }

  @override
  Future<void> startedWatchingVideo(StartedWatchingVideosRequest request) async {
    Uri uri = getApiUri('users/started-video');
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    await Firebase.initializeApp();
    String deviceId = await FirebaseMessaging.instance.getToken();
    deviceId = deviceId.replaceAll(":", "");
    print("NANA JOTE " + deviceId);
    var response = await http.post(uri, headers: headers, body: jsonEncode(<String, dynamic>{
      'deviceId': deviceId,
      'videoId': request.videoId,
      'timestamp': request.timestamp,
    }));
    print(response.body);
  }
}
