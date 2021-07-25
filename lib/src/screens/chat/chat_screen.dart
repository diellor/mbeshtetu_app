import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:mbeshtetu_app/src/screens/navigation/navigation_screen.dart';
import 'package:mbeshtetu_app/src/screens/tabs/bnb_custom_painter.dart';

import '../../commons.dart';

class ChatScreen extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => ChatScreen(),
      );

  @override
  Widget build(BuildContext context) {
    //return Container();
    return Scaffold(
        bottomSheet: NavigationScreen(),
        body: Tawk(
          directChatLink:
              'https://tawk.to/chat/5eb4764681d25c0e5849d53a/default',
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
        ));
  }
}
