import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => ChatScreen(),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Chat Page"),
      ),
    );
  }
}
