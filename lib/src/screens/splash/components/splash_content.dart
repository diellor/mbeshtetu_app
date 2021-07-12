import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent(
      {Key key,
      this.text,
      this.mainImage,
      this.secondaryText,
      this.size})
      : super(key: key);

  final String text, mainImage, secondaryText;
  final Size size;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 15 * SizeConfig.heightMultiplier , bottom: 5 * SizeConfig.heightMultiplier),
            child: Container(
              // height: size.height / 2.0,
              // width: size.height / 2.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(4, 4), // changes position of shadow
                  ),
                ],
              ),
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 0 * SizeConfig.heightMultiplier),
                          child: Image.asset(
                            mainImage,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              text,
                              style: TextStyle(
                                  fontSize: 3 * SizeConfig.textMultiplier, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 2 * SizeConfig.widthMultiplier),
                              child: AutoSizeText(
                                secondaryText,
                                style: TextStyle(
                                    fontSize: 2.5 * SizeConfig.textMultiplier, fontWeight: FontWeight.normal),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                minFontSize: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
