import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbeshtetu_app/src/commons.dart';
import 'package:mbeshtetu_app/src/models/selected_category.dart';
import 'package:mbeshtetu_app/src/screens/meditations/components/body.dart';
import 'package:mbeshtetu_app/src/screens/navigation/navigation_screen.dart';

class MeditationScreen extends StatelessWidget {

  MeditationScreen(this.id, this.title, this.thumbnail);
  final int id;
  final String title;
  final String thumbnail;


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    SelectedCat selectedCat = SelectedCat(ballina: 0,gjumi: 0,meditimi: 1,seancat: 0);
    return Scaffold(backgroundColor: primary_blue, body: Body(categoryId: id, title: title, thumbnail: thumbnail,), bottomSheet: NavigationScreen(selectedCat: selectedCat),);
  }
}
