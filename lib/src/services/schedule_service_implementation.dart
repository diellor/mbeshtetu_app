import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:mbeshtetu_app/src/models/create_schedule_model.dart';
import 'package:mbeshtetu_app/src/services/schedule_service.dart';

class ScheduleServiceImplementation extends ScheduleService {
  @override
  Future<void> scheduleAudio() {
    // TODO: implement scheduleAudio
    throw UnimplementedError();
  }

  @override
  Future<void> scheduleVideo(CreateSchedule request) async {
    // TODO: implement scheduleVideo
    Uri uri = Uri.http(
      '192.168.0.101:3000', '/schedule',
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    await Firebase.initializeApp();
    String deviceId = await FirebaseMessaging.instance.getToken();
    deviceId = deviceId.replaceAll(":", "");
    print("NANA JOTE " + deviceId);
    FirebaseMessaging.instance.subscribeToTopic(deviceId);
    var response = await http.post(uri,
        headers: headers,
        body: jsonEncode(<String, dynamic>{
          'deviceId': deviceId,
          'timestamp': request.timestamp,
          'eventId': request.videoId
        }));
    if (response.statusCode != 201) {
      throw json.decode(response.body)['error']['message'];
    }
  }

  @override
  Future<bool> getSubscription() async {
    String deviceId = await FirebaseMessaging.instance.getToken();
    deviceId = deviceId.replaceAll(":", "");
    print("NANA JOTE " + deviceId);
    FirebaseMessaging.instance.subscribeToTopic(deviceId);
  }

  @override
  Future<String> getRandomQuote() async {
    Uri uri = Uri.http(
      '192.168.0.101:3000', '/schedule',
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      String randomQuote = response.body;
      return randomQuote;
    }
  }

}
