import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mbeshtetu_app/src/models/create_schedule_model.dart';
import 'package:mbeshtetu_app/src/services/schedule_service.dart';
import 'package:http/http.dart' as http;

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
      '192.168.0.226:3000', '/schedule',
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    await Firebase.initializeApp();
    String deviceId = await FirebaseMessaging.instance.getToken();
    print("NANA JOTE " + deviceId.replaceAll(":", ""));
    FirebaseMessaging.instance.subscribeToTopic(deviceId.replaceAll(":", ""));
    var response = await http.post(uri, headers: headers, body: jsonEncode(<String, dynamic>{
      'deviceId': deviceId,
      'timestamp': request.timestamp,
      'eventId': request.videoId
    }));
    if (response.statusCode != 201) {
      throw json.decode(response.body)['error']['message'];
    }
  }

}