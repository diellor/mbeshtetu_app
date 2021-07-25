import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

import 'components/body.dart';

class PostVideoScreen extends StatelessWidget {
  static String routeName = "/postVideo";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    SizeConfig().init(context);
    print(args);
    return Scaffold(
      body: Body(id: args),
    );
  }
}
