import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mbeshtetu_app/src/screens/categories/categories_screen.dart';
import 'package:mbeshtetu_app/src/screens/chat/chat_screen.dart';
import 'package:mbeshtetu_app/src/screens/home/home.dart';
import 'package:mbeshtetu_app/src/screens/meditations/meditation_screen.dart';
import 'package:mbeshtetu_app/src/screens/music/music_screen.dart';


class TabNavigationItem {
  final Widget page;
  final String title;
  final Icon icon;

  TabNavigationItem(
      {@required this.page, @required this.title, @required this.icon});

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: Home(),
          icon: Icon(Icons.home),
          title: "Home",
        ),
        TabNavigationItem(
          page: ChatScreen(),
          icon: Icon(Icons.shopping_basket),
          title: "Shop",
        ),
        TabNavigationItem(
          page: CatetegoriesScreen(),
          icon: Icon(Icons.shopping_basket),
          title: "Chati",
        ),
        TabNavigationItem(
          page: MusicScreen(),
          icon: Icon(Icons.shopping_basket),
          title: "Music",
        ),
        TabNavigationItem(
          page: MeditationScreen(),
          icon: Icon(Icons.shopping_basket),
          title: "Meditation",
        ),
      ];
}
