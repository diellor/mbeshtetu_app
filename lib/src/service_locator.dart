import 'package:get_it/get_it.dart';
import 'package:mbeshtetu_app/src/business_logic/category_screen_viewmodel.dart';
import 'package:mbeshtetu_app/src/business_logic/home_screen_viewmodel.dart';
import 'package:mbeshtetu_app/src/business_logic/meditation_screen_viewmodel.dart';
import 'package:mbeshtetu_app/src/business_logic/page_manager.dart';
import 'package:mbeshtetu_app/src/business_logic/postVideo_screen_viewmodel.dart';
import 'package:mbeshtetu_app/src/services/schedule_service.dart';
import 'package:mbeshtetu_app/src/services/schedule_service_implementation.dart';
import 'package:mbeshtetu_app/src/services/user_service.dart';
import 'package:mbeshtetu_app/src/services/user_service_implementation.dart';
import 'package:mbeshtetu_app/src/services/youtube_service.dart';
import 'package:mbeshtetu_app/src/services/youtube_service_implementation.dart';
GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {

  serviceLocator.registerLazySingleton<YoutubeService>(() => YoutubeServiceImpl());
  serviceLocator.registerLazySingleton<UserService>(() => UserServiceImplementation());
  serviceLocator.registerLazySingleton<ScheduleService>(() => ScheduleServiceImplementation());
  serviceLocator.registerFactory<PageManager>(() => PageManager());
  serviceLocator.registerFactory<HomeScreenViewModel>(() => HomeScreenViewModel());
  serviceLocator.registerFactory<CategoryScreenViewModel>(() => CategoryScreenViewModel());
  serviceLocator.registerFactory<PostVideoScreenViewModel>(() => PostVideoScreenViewModel());
  serviceLocator.registerFactory<MeditationScreenViewModel>(() => MeditationScreenViewModel());

}