import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mbeshtetu_app/src/screens/categories/categories_screen.dart';
import 'package:mbeshtetu_app/src/screens/chat/chat_screen.dart';
import 'package:mbeshtetu_app/src/screens/home/home.dart';
import 'package:mbeshtetu_app/src/screens/tabs/bnb_custom_painter.dart';

import '../../../commons.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          color: Colors.white,
          width: size.width,
          height: 80,
          child: Stack(
            overflow: Overflow.visible,
            children: [
              CustomPaint(
                size: Size(size.width, 80),
                painter: BNBCustomPainter(),
              ),
              Center(
                heightFactor: 0.5,
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: FloatingActionButton(
                      child: Image.asset("images/tab_chat.png"),
                      elevation: 0.1,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatScreen(),
                          ),
                        );
                      }),
                ),
              ),
              Container(
                width: size.width,
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Image.asset("images/tab_ballina.png"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Home(),
                              ),
                            );
                          },
                          splashColor: Colors.white,
                        ),
                        Text(
                          "Ballina",
                          style: TextStyle(
                              color: bold_blue, fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        IconButton(
                            icon: SvgPicture.asset("images/tab_seancat.svg"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CatetegoriesScreen(1),
                                ),
                              );
                            }),
                        Text(
                          "Seancat",
                          style: TextStyle(
                              color: bold_blue, fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                    Container(
                      width: size.width * 0.20,
                    ),
                    Column(
                      children: <Widget>[
                        IconButton(
                            icon: SvgPicture.asset("images/tab_meditimi.svg"),
                            onPressed: () {}),
                        Text(
                          "Meditimi",
                          style: TextStyle(
                              color: bold_blue, fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        IconButton(
                            icon: SvgPicture.asset("images/tab_gjumi.svg"),
                            onPressed: () {}),
                        Text(
                          "Gjumi",
                          style: TextStyle(
                              color: bold_blue, fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
