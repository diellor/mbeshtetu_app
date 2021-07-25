import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';
import 'package:mbeshtetu_app/src/screens/music/components/body.dart';

class MusicScreen extends StatelessWidget {
  static String routeName = "/musicScreen";
   List<Video> videos = [];
   int index = 0;

   MusicScreen({Key key, this.videos, this.index}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => MusicScreen(),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AudioServiceWidget(child: Body(videos: videos, index: index)),
    );
  }
}
