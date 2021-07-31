import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbeshtetu_app/src/business_logic/meditation_screen_viewmodel.dart';
import 'package:mbeshtetu_app/src/commons.dart';
import 'package:mbeshtetu_app/src/models/category_model.dart';
import 'package:mbeshtetu_app/src/models/selected_category.dart';
import 'package:mbeshtetu_app/src/screens/navigation/navigation_screen.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';

import 'components/body.dart';
class SleepScreen extends StatefulWidget {
  static String routeName = "/sleepScreen";

  @override
  _SleepScreenState createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  Future sleepCategory;
  MeditationScreenViewModel model = serviceLocator<MeditationScreenViewModel>();

  @override
  void initState() {
    super.initState();
    sleepCategory = _loadSleepCategory();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _loadSleepCategory() async {
    var result = await model.loadSleepCategory();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    SelectedCat selectedCat = SelectedCat(ballina: 0,gjumi: 1,meditimi: 0,seancat: 0);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: green));
    return Scaffold(backgroundColor: green, bottomSheet: NavigationScreen(selectedCat: selectedCat,),
        body: FutureBuilder(
      future: sleepCategory,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor, // Red
              ),
            ),
          );
        else
          return Body(category: snapshot.data as Category,);
      },
    ));
  }
}
