import 'package:mbeshtetu_app/src/models/create_rate_model.dart';
import 'package:mbeshtetu_app/src/models/create_schedule_model.dart';

abstract class ScheduleService {
  Future<void> scheduleVideo(CreateSchedule request);
  Future<void> scheduleAudio();
  Future<void> rateVideo(CreateRate request);
  Future<bool> getSubscription();
  Future<String> getRandomQuote();
}