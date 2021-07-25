import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/screens/intro/components/body.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

class IntroScreen extends StatelessWidget {
  static String routeName = "/intro";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Body(),
    );
  }
}
