import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/commons.dart';
import 'package:mbeshtetu_app/src/models/audio_model.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';
import 'package:mbeshtetu_app/src/models/video_model_arg.dart';
import 'package:mbeshtetu_app/src/screens/home/components/video_screen.dart';
import 'package:mbeshtetu_app/src/screens/music/music_screen.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

class BallinaVideoCard extends StatelessWidget {
  const BallinaVideoCard(
      {Key key, this.image, this.title, this.press, this.videoId, this.isAudio, this.category, this.video})
      : super(key: key);

  final String image, title;
  final String videoId;
  final Function press;
  final bool isAudio;
  final String category;
  final Video video;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
      return InkWell(
        onTap: () => {
          this.isAudio
              ? Navigator.of(context)
                  .pushNamed(MusicScreen.routeName, arguments: Audio(video: video))
              : Navigator.of(context)
              .pushNamed(VideoScreen.routeName, arguments: VideoArgs(video: video))
        },
      child: Container(
        margin: EdgeInsets.only(
            left: kDefaultPadding * 2,
            top: kDefaultPadding,
            bottom: kDefaultPadding * 2),
        width: size.width * 0.4,
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: bold_blue.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: FittedBox(fit:BoxFit.contain,child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(image, width: size.width * 0.4, height: size.width * 0.4),
                  )),
                )),
            GestureDetector(
              onTap: press,
              child: Container(
                height: SizeConfig.heightMultiplier * 9,

                padding: EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: bold_blue.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(4, 8), // changes position of shadow
                      ),
                    ]),
                child: Row(
                  children: [
                    Expanded(
                        child: AutoSizeText(
                      title,
                      maxLines: 2,
                          style: TextStyle(fontWeight: FontWeight.bold),
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
