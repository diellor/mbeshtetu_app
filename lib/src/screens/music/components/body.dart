import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mbeshtetu_app/src/screens/music/components/audi_player_screen.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  AudioPlayer advancedPlayer;

  @override
  void initState() {
    super.initState();
    advancedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Image.asset(
          "images/audio_bg.png",
          width: SizeConfig.screenWidth,
          fit: BoxFit.fitWidth,
          repeat: ImageRepeat.repeatX,
          alignment: Alignment.bottomCenter,
        )),
        Column(
          children: [
            Expanded(
                flex: 1,
                child: Row(
                  children: [
                    IconButton(
                        icon: SvgPicture.asset("images/audio_back_btn.svg"),
                        onPressed: () {})
                  ],
                )),
            Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 2 * SizeConfig.heightMultiplier),
                      child: Container(
                        width: 70 * SizeConfig.heightMultiplier,
                        height: 70 * SizeConfig.widthMultiplier,
                        child: Image.asset(
                          "images/audio_player_img.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Text(
                      "Category",
                      style: TextStyle(fontSize: 2 * SizeConfig.textMultiplier),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 2 * SizeConfig.heightMultiplier),
                      child: Text(
                        "Audio title",
                        style: TextStyle(
                            fontSize: 3 * SizeConfig.textMultiplier,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    AudioPlayerScreen(advancedPlayer: advancedPlayer),
                  ],
                )),
          ],
        )
      ],
    );
  }
}
