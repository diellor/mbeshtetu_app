import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';
import 'package:mbeshtetu_app/src/services/schedule_service.dart';

class PostVideoScreenViewModel extends ChangeNotifier {
  final ScheduleService _service = serviceLocator<ScheduleService>();
  String randQuote;

  Future<String> loadRandomQuote() async {
    randQuote =  await _service.getRandomQuote();
    return randQuote;
  }

  String get getRandomQuote {
    return randQuote;
  }
}
