import 'package:flutter/widgets.dart';
import 'package:mbeshtetu_app/src/screens/categories/categories_screen_second.dart';
import 'package:mbeshtetu_app/src/screens/chat/chat_screen.dart';
import 'package:mbeshtetu_app/src/screens/home/components/video_screen.dart';
import 'package:mbeshtetu_app/src/screens/home/home.dart';
import 'package:mbeshtetu_app/src/screens/intro/intro_screen.dart';
import 'package:mbeshtetu_app/src/screens/meditations/components/pre_meditation_screen.dart';
import 'package:mbeshtetu_app/src/screens/music/music_screen.dart';
import 'package:mbeshtetu_app/src/screens/postvideo/post_video_screen.dart';
import 'package:mbeshtetu_app/src/screens/quotes/subscribe_quotes_screen.dart';
import 'package:mbeshtetu_app/src/screens/sleep/sleep_screen.dart';
import 'package:mbeshtetu_app/src/screens/splash/spash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  IntroScreen.routeName: (context) => IntroScreen(),
  MusicScreen.routeName: (context) => MusicScreen(),
  SubscribeToQuotesScreen.routeName: (context) => SubscribeToQuotesScreen(),
  PostVideoScreen.routeName: (context) => PostVideoScreen(),
  PreMeditationScreen.routeName: (context) => PreMeditationScreen(),
  ChatScreen.routeName: (context) => ChatScreen(),
  VideoScreen.routeName: (context) => VideoScreen(),
  Home.routeName: (context) => Home(),
  CatetegoriesScreenSecond.routeName: (context) => CatetegoriesScreenSecond(),
  SleepScreen.routeName: (context) => SleepScreen(),
};
