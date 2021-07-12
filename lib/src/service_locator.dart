import 'package:get_it/get_it.dart';
import 'package:mbeshtetu_app/src/business_logic/home_screen_viewmodel.dart';
import 'package:mbeshtetu_app/src/services/youtube_service.dart';
import 'package:mbeshtetu_app/src/services/youtube_service_implementation.dart';
GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {

  serviceLocator.registerLazySingleton<YoutubeService>(() => YoutubeServiceImpl());
  serviceLocator.registerFactory<HomeScreenViewModel>(() => HomeScreenViewModel());

}