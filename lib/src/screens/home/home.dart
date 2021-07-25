import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/screens/home/components/body.dart';
import 'package:mbeshtetu_app/src/screens/navigation/navigation_screen.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

final _navigatorKey = GlobalKey();

class Home extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => Home(),
  );
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(body: Body(), bottomSheet: NavigationScreen(),);

  }
}
