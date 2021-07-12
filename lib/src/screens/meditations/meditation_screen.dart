import 'package:flutter/material.dart';

class MeditationScreen extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => MeditationScreen(),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Meditation Screen"),
      ),
    );
  }
}
