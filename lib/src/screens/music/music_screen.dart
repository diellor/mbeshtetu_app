import 'package:flutter/material.dart';

class MusicScreen extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => MusicScreen(),
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
