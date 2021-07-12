import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/commons.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

class GridContent extends StatelessWidget {
  const GridContent({Key key, this.gridImag, this.text}) : super(key: key);

  final String gridImag, text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(100),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: secondary_blue,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                    image: AssetImage(gridImag), fit: BoxFit.cover)),
          ),
          Center(
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 2.2 * SizeConfig.textMultiplier),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
