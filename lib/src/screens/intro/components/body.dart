import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/screens/categories/categories_screen.dart';
import 'package:mbeshtetu_app/src/screens/chat/chat_screen.dart';
import 'package:mbeshtetu_app/src/screens/intro/components/grid_content.dart';
import 'package:mbeshtetu_app/src/screens/meditations/meditation_screen.dart';
import 'package:mbeshtetu_app/src/screens/music/music_screen.dart';
import 'package:mbeshtetu_app/src/screens/splash/components/default_button.dart';
import 'package:mbeshtetu_app/src/screens/tabs/tabs_screen.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var gridImages = [
      "images/question_1.png",
      "images/question_2.png",
      "images/question_3.png",
      "images/question_4.png",
      "images/question_5.png",
      "images/question_6.png",
    ];
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            "images/intro_bg_2.png",
            fit: BoxFit.contain,
            alignment: Alignment.bottomRight,
          )),
          Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Cka ju sjell te",
                          style: TextStyle(
                              fontSize: 3.2 * SizeConfig.textMultiplier,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "mbështetu?",
                          style: TextStyle(
                              fontSize: 3.2 * SizeConfig.textMultiplier,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.5 * SizeConfig.widthMultiplier),
                  child: Container(
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 15.0,
                      childAspectRatio:
                          MediaQuery.of(context).size.aspectRatio * 3 / 1.6,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CatetegoriesScreen(1)));
                          },
                          child: GridContent(
                              gridImag: gridImages[0], text: "Stresi"),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CatetegoriesScreen(0)));
                          },
                          child: GridContent(
                              gridImag: gridImages[1], text: "Ankthi"),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CatetegoriesScreen(2)));
                          },
                          child: GridContent(
                              gridImag: gridImages[2], text: "Depresioni"),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MeditationScreen()));
                          },
                          child: GridContent(
                              gridImag: gridImages[0], text: "Meditimi"),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MusicScreen()));
                          },
                          child: GridContent(
                              gridImag: gridImages[0],
                              text: "Problemet me gjumë"),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatScreen()));
                          },
                          child: GridContent(
                              gridImag: gridImages[0],
                              text: "Bisedoj me dikënd"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10 * SizeConfig.widthMultiplier,
                      vertical: 7 * SizeConfig.heightMultiplier),
                  child: DefaultButton(
                    text: "Vazhdo",
                    press: () {
                      Navigator.pushNamed(context, TabsScreen.routeName);
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
