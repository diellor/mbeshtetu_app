import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/commons.dart';
import 'package:mbeshtetu_app/src/screens/meditations/components/body.dart';

class MeditationScreen extends StatelessWidget {
  MeditationScreen(this.id);
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: primary_blue, body: Body(categoryId: id));
  }
}
