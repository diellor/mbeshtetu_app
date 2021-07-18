import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/screens/music/components/body.dart';

class MusicScreen extends StatelessWidget {
  static String routeName = "/musicScreen";

  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => MusicScreen(),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
