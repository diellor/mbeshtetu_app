import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mbeshtetu_app/src/models/selected_category.dart';
import 'package:mbeshtetu_app/src/screens/categories/categories_screen.dart';
import 'package:mbeshtetu_app/src/screens/categories/categories_screen_second.dart';
import 'package:mbeshtetu_app/src/screens/chat/chat_screen.dart';
import 'package:mbeshtetu_app/src/screens/home/home.dart';
import 'package:mbeshtetu_app/src/screens/meditations/components/pre_meditation_screen.dart';
import 'package:mbeshtetu_app/src/screens/sleep/sleep_screen.dart';
import 'package:mbeshtetu_app/src/screens/tabs/bnb_custom_painter.dart';

import '../../../commons.dart';

class Body extends StatefulWidget {
  final SelectedCat categorySelected;
  const Body({this.categorySelected});

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
                        Navigator.of(context)
                            .pushReplacementNamed('/chatScreen');
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
                          icon: widget.categorySelected.ballina == 1? Image.asset("images/tab_ballina.png"):Image.asset("images/ballina_tab_0.png") ,
                          onPressed: () {
                            Navigator.of(context).
                            pushReplacementNamed('/homeScreen');
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
                            icon: widget.categorySelected.seancat == 1? SvgPicture.asset("images/seanca_tab_1.svg"):SvgPicture.asset("images/seanca_tab_0.svg") ,
                            onPressed: () {
                              Navigator.of(context).
                              pushReplacementNamed('/categoriesScreen');
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
                            icon: widget.categorySelected.meditimi == 1? SvgPicture.asset("images/meditimi_tab_1.svg"):SvgPicture.asset("images/meditimi_tab_0.svg") ,
                            onPressed: () {    Navigator.of(context)
                                .pushReplacementNamed('/selectMeditation');}),
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
                            icon: widget.categorySelected.gjumi == 1? SvgPicture.asset("images/gjumi_tab_1.svg"):SvgPicture.asset("images/gjumi_tab_0.svg") ,
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/sleepScreen');
                            }),
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
