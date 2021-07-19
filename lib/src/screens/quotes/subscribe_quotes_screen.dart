import 'package:flutter/material.dart';

import 'components/body.dart';

class SubscribeToQuotesScreen extends StatelessWidget {
  static String routeName = "/quotes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}