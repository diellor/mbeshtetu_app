import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbeshtetu_app/src/commons.dart';
import 'package:mbeshtetu_app/src/models/tab_navigation_item.dart';

class TabsScreen extends StatefulWidget {
  static String routeName = "/tabsScreen";

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int currentIndex = 0;

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: currentIndex == 1
          ? AppBar(
        title: Text('My App'),
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60))),
      )
          : null,
      body: IndexedStack(
        index: currentIndex,
        children: [
          for (final tabItem in TabNavigationItem.items) tabItem.page,
        ],
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
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
                              setBottomBarIndex(0);
                            },
                            splashColor: Colors.white,
                          ),
                          Text("Ballina", style: TextStyle(color: bold_blue,fontWeight: FontWeight.w200),),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                              icon: SvgPicture.asset("images/tab_seancat.svg"),
                              onPressed: () {
                                setBottomBarIndex(1);
                              }),
                          Text("Seancat", style: TextStyle(color: bold_blue,fontWeight: FontWeight.w200),),

                        ],
                      ),
                      Container(
                        width: size.width * 0.20,
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                              icon: SvgPicture.asset("images/tab_meditimi.svg"),
                              onPressed: () {
                                setBottomBarIndex(2);
                              }),
                          Text("Meditimi", style: TextStyle(color: bold_blue,fontWeight: FontWeight.w200),),

                        ],
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                              icon: SvgPicture.asset("images/tab_gjumi.svg"),
                              onPressed: () {
                                setBottomBarIndex(3);
                              }),
                          Text("Gjumi", style: TextStyle(color: bold_blue,fontWeight: FontWeight.w200),),

                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 10); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 10);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
