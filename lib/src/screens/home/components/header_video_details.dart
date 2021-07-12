import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbeshtetu_app/src/commons.dart';

class HeaderWithVideoDetails extends StatelessWidget {
  const HeaderWithVideoDetails({Key key, @required this.text, @required this.imageUrl})
      : super(key: key);
  final String text;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // TODO: implement build
    return Container(
      height: size.height * 0.35,
      child: Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.35,
            decoration: BoxDecoration(
                color: primary_blue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36)),
                image: DecorationImage(
                    image: AssetImage(imageUrl))),
          ),
          Positioned(
            bottom: 15,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "Menaxhimi i ankthit ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                        child: SvgPicture.asset("images/ballina_play_3.svg"),
                        ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
