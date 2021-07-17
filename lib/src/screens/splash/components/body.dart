import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/models/create_user_model.dart';
import 'package:mbeshtetu_app/src/screens/intro/intro_screen.dart';
import 'package:mbeshtetu_app/src/services/user_service.dart';
import 'package:mbeshtetu_app/src/size_config.dart';
import 'package:mbeshtetu_app/src/screens/splash/components/default_button.dart';
import 'package:mbeshtetu_app/src/screens/splash/components/splash_content.dart';

import '../../../../main.dart';
import '../../../service_locator.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final UserService _userService = serviceLocator<UserService>();

  PageController _pageController;
  List<Map<String, String>> splashData = [
    {
      "text": "Mëso",
      "mainImage": "images/splash_1.png",
      "secondaryText": "për stresin, ankthin dhe depresionin"
    },
    {
      "text": "Lehtëso",
      "mainImage": "images/splash_2.png",
      "secondaryText": "simptomet e ankthit, stresit dhe depresionit"
    },
    {
      "text": "Bisedo",
      "mainImage": "images/splash_3.png",
      "secondaryText": "bisedo me njërin nga vullnetarët tanë"
    },
  ];

  @override
  void initState() {
    super.initState();
    _userService.createUser();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      bottom: false,
      left: false,
      right: false,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Image.asset(
                    "images/green_shadow.png",
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomCenter,
                  )),
                  Positioned.fill(
                      child: Image.asset(
                    "images/green_shadow.png",
                    fit: BoxFit.fill,
                    repeat: ImageRepeat.repeat,
                  )),
                  Positioned.fill(
                      child: Image.asset(
                    "images/green_shadow.png",
                    fit: BoxFit.fill,
                    repeat: ImageRepeat.repeatX,
                  )),
                  Positioned.fill(
                      child: Image.asset(
                    "images/green_shadow.png",
                    fit: BoxFit.fill,
                    repeat: ImageRepeat.repeatY,
                  )),
                  PageView.builder(
                    itemCount: splashData.length,
                    controller: _pageController,
                    itemBuilder: (context, index) => AnimatedBuilder(
                      animation: _pageController,
                      builder: (BuildContext context, Widget widget) {
                        double value = 1;
                        if (_pageController.position.haveDimensions) {
                          value = _pageController.page - 1;
                          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                        }
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: widget,
                            ),
                          ),
                        );
                      },
                      child: SplashContent(
                          mainImage: splashData[index]["mainImage"],
                          text: splashData[index]['text'],
                          secondaryText: splashData[index]['secondaryText'],
                          size: size),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 13 * SizeConfig.widthMultiplier,
                    vertical: 6.3 * SizeConfig.heightMultiplier),
                child: DefaultButton(
                  text: "Vazhdo",
                  press: () {
                    Navigator.pushNamed(context, IntroScreen.routeName);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
