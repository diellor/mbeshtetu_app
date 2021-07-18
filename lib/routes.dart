import 'package:flutter/widgets.dart';
import 'package:mbeshtetu_app/src/screens/intro/intro_screen.dart';
import 'package:mbeshtetu_app/src/screens/music/music_screen.dart';
import 'package:mbeshtetu_app/src/screens/splash/spash_screen.dart';
import 'package:mbeshtetu_app/src/screens/tabs/tabs_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  IntroScreen.routeName: (context) => IntroScreen(),
  TabsScreen.routeName: (context) => TabsScreen(),
  MusicScreen.routeName: (context) => MusicScreen(),
};
