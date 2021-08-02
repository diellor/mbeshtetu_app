import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

const primary_blue = Color(0xFFDFE5FF);
const Color secondary_blue = Color(0xFFDFE5FF);
const Color bold_blue = Color(0xFFACA8FC);
const Color preMeditation_bg = Color(0xFFACA8FC);
const Color white = Colors.white;
const Color black = Colors.black;
const Color grey = Colors.grey;
const textColor = Colors.black;
const dark_green =  Color(0xFFa5e6d4);
const green =  Color(0xFFE4F6E0);

const onboarding_animation = Duration(milliseconds: 200);

const double kDefaultPadding = 10.0;

final TextStyle categoryTextStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  color: black,
);

final TextStyle _splashTitle = TextStyle(
  color: black,
  fontSize: 3 * SizeConfig.textMultiplier,
  fontWeight: FontWeight.bold
);

final TextStyle _splashSubtitle = TextStyle(
    color: black,
    fontSize: 2 * SizeConfig.textMultiplier,
    fontWeight: FontWeight.normal
);

final TextStyle _introTitle = TextStyle(
    color: black,
    fontSize: 4 * SizeConfig.textMultiplier,
    fontWeight: FontWeight.bold
);

final TextStyle _introItems = TextStyle(
    color: black,
    fontSize: 2 * SizeConfig.textMultiplier,
    fontWeight: FontWeight.bold
);

//
//
// final TextTheme darkTextTheme = TextTheme(
//   title: bold_blue,
//   subtitle: Colo
// );
