import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbeshtetu_app/src/commons.dart';
import 'package:mbeshtetu_app/src/models/audio_model.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';
import 'package:mbeshtetu_app/src/models/video_model_arg.dart';
import 'package:mbeshtetu_app/src/screens/home/components/video_screen.dart';
import 'package:mbeshtetu_app/src/screens/music/music_screen.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

class HeaderWithVideoDetails extends StatelessWidget {
  const HeaderWithVideoDetails({Key key, @required this.video})
      : super(key: key);
  final Video video;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // TODO: implement build
    return InkWell(
      onTap: () => video.isAudio ?  Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MusicScreen(video: this.video),
          ))
    :Navigator.of(context)
          .pushNamed(VideoScreen.routeName, arguments: VideoArgs(video: video)),
      child: Container(
        height: size.height * 0.35,
        child: Stack(
          children: <Widget>[
            Container(
              height: size.height * 0.35,
              decoration: BoxDecoration(
                  color: primary_blue,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36)),
                  image: DecorationImage(
                    fit: BoxFit.contain,
                      colorFilter: ColorFilter.mode(primary_blue.withOpacity(0.7), BlendMode.dstATop),
                      image: AssetImage(video.thumbnail))),
            ),
            Positioned(
              bottom: 15,
              left: 0,
              right: 0,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 5),
                        child: AutoSizeText(
                          video.title,
                          style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          child: SvgPicture.asset("images/ballina_play_3.svg"),
                          ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
