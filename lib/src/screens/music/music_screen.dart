import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/models/audio_model.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';
import 'package:mbeshtetu_app/src/screens/music/components/body2.dart';

import 'components/body.dart';

class MusicScreen extends StatelessWidget {
  static String routeName = "/musicScreen";

  const MusicScreen({Key key, this.video, this.index, this.videos}): super(key: key);
  final Video video;
  final int index;
  final List<Video> videos;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Audio;
    return Scaffold(body: AudioServiceWidget(child: Body2(video: args.video, index: args.index, videos: args.videos)));
  }
}
