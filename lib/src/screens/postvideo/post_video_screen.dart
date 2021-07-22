import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

import 'components/body.dart';

class PostVideoScreen extends StatelessWidget {
  static String routeName = "/postVideo";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Body(),
    );
  }
}
