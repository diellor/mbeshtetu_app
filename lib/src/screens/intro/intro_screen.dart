import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/screens/intro/components/body.dart';

class IntroScreen extends StatelessWidget {
  static String routeName = "/intro";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
