import 'package:flutter/material.dart';

class CatetegoriesScreen extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => CatetegoriesScreen(),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("CategoryPage"),
      ),
    );
  }
}
