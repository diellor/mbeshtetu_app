import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/commons.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

class TitleRecommended extends StatelessWidget {
  const TitleRecommended({
    Key key,
    this.text,
    this.press,
    this.isTeFundit
  }) : super(key: key);

  final String text;
  final Function press;
  final bool isTeFundit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 2, vertical: kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 24,
              child: Padding(
                padding: const EdgeInsets.only(left: kDefaultPadding),
                child: AutoSizeText(
                  text,
                  maxLines: 1,
                  minFontSize: 1,
                  style: TextStyle(fontSize: 23
                    , fontWeight: FontWeight.bold, ),
                ),
              ),
            ),
          ),
          // Spacer(),
          !isTeFundit?Expanded(
            flex:1,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: press,
              color: primary_blue,
              child: FittedBox(
                child: AutoSizeText(
                  "Më shume",
                  maxLines: 1,
                  style: TextStyle(color: Colors.black.withOpacity(0.60), fontSize:4  * SizeConfig.textMultiplier),
                ),
              ),
            ),
          ): Expanded(
            flex:1,
            child: Container()
          ),
        ],
      ),
    );
  }
}
