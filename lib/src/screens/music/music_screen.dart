import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/models/audio_model.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';
import 'package:mbeshtetu_app/src/screens/music/components/body3.dart';

import 'components/body.dart';

class MusicScreen extends StatefulWidget {
  static String routeName = "/musicScreen";

  final Video video;
  final int index;
  final List<Video> videos;
  const MusicScreen({Key key, this.video, this.index, this.videos}): super(key: key);

  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context).settings.arguments as Audio;
    return Scaffold(body: Body3(video: this.widget.video, index: this.widget.index, videos: this.widget.videos,));
  }
}
