import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/models/selected_category.dart';
import 'package:mbeshtetu_app/src/screens/home/components/body.dart';
import 'package:mbeshtetu_app/src/screens/navigation/navigation_screen.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

final _navigatorKey = GlobalKey();

class Home extends StatefulWidget {
  static String routeName = "/homeScreen";

  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => Home(),
  );
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SelectedCat selectedCat = SelectedCat(ballina: 1,gjumi: 0,meditimi: 0,seancat: 0);
    SizeConfig().init(context);
    return Scaffold(body: Body(), bottomSheet: NavigationScreen(selectedCat: selectedCat,),);
  }
}
