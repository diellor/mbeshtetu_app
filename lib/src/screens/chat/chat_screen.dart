import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:mbeshtetu_app/src/models/selected_category.dart';
import 'package:mbeshtetu_app/src/screens/navigation/navigation_screen.dart';
import 'package:mbeshtetu_app/src/screens/tabs/bnb_custom_painter.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

import '../../commons.dart';

class ChatScreen extends StatefulWidget {
  static String routeName = "/chatScreen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    SelectedCat selectedCat = SelectedCat(ballina: 0,gjumi: 0,meditimi: 0,seancat: 0);
    return Scaffold(
      bottomSheet: NavigationScreen(selectedCat: selectedCat,),
        body: Padding(
          padding: EdgeInsets.only(bottom: SizeConfig.heightMultiplier *12, top: SizeConfig.heightMultiplier * 4),
          child: Tawk(
            directChatLink:
                'https://tawk.to/chat/5ea35c7335bcbb0c9ab46bce/default',
            visitor: TawkVisitor(
              name: 'Ayoub AMINE',
              email: 'ayoubamine2a@gmail.com',
            ), // onLoad: () {
            //   print('Hello Tawk!');
            // },
            // onLinkTap: (String url) {
            //   print(url);
            // },
            // placeholder: Center(
            //   child: Textz('Loading...'),
            // ),     ),
            //       // onLoad: () {
            //       //   print('Hello Tawk!');
            //       // },
            //       // onLinkTap: (String url) {
            //       //   print(url);
            //       // },
            //       // placeholder: Center(
            //       //   child: Text('Loading...'),
            //       // ),
          ),
        ));
  }
}
