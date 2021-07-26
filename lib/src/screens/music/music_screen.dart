import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/models/audio_model.dart';

import 'components/body.dart';

class MusicScreen extends StatelessWidget {
  static String routeName = "/musicScreen";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Audio;
    return Scaffold(body: Body(video: args.video, index: args.index,));
  }
}
