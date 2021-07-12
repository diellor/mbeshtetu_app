import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/screens/home/components/body.dart';

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
    return Scaffold(body: Body());
  }
}
