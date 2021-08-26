import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';
import 'package:mbeshtetu_app/src/models/video_model_arg.dart';

import 'package:mbeshtetu_app/src/screens/home/components/video_screen_body.dart';

class VideoScreen extends StatelessWidget {
  static String routeName = "/videoScreen";

  const VideoScreen({Key key, this.video}): super(key: key);
  final Video video;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as VideoArgs;
    if(args == null){
      return Scaffold(body: VideoScreenBody(video: this.video));
    }else {
      return Scaffold(body: VideoScreenBody(video: args.video
      ));
    }
  }
}


