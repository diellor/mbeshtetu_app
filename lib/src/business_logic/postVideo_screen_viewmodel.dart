import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/models/create_rate_model.dart';
import 'package:mbeshtetu_app/src/models/create_schedule_model.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';
import 'package:mbeshtetu_app/src/services/schedule_service.dart';

class PostVideoScreenViewModel extends ChangeNotifier {
  final ScheduleService _service = serviceLocator<ScheduleService>();
  String randQuote;

  Future<String> loadRandomQuote() async {
    randQuote =  await _service.getRandomQuote();
    return randQuote;
  }

  Future<void> scheduleVideo(DateTime dateTime, String videoId) async {
    await _service.scheduleVideo(CreateSchedule(timestamp: dateTime.millisecondsSinceEpoch, videoId: videoId));
  }


  Future<void> rateVideo(CreateRate request) async {
    await _service.rateVideo(request);
  }

  String get getRandomQuote {
    return randQuote;
  }
}
