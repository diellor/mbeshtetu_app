import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/commons.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

class GreenButton extends StatelessWidget {
  const GreenButton({Key key, this.text, this.press}) : super(key: key);

  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: getProportionateScreenHeight(56),
        child: FlatButton(

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: green,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
                fontSize: getProportionateScreenWidth(18), color: Colors.black),
          ),
        ),
      ),
    );
  }
}
