import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbeshtetu_app/src/commons.dart';
import 'package:mbeshtetu_app/src/screens/splash/components/default_button.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

class PreMeditationScreen extends StatelessWidget {
  static String routeName = "/selectMeditation";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Image.asset(
            "images/ballina_main.png",
            height: 25 * SizeConfig.heightMultiplier,
            width: double.infinity,
            // it cover the 25% of total height
            fit: BoxFit.contain,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: preMeditation_bg,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),child: Column(
              children: <Widget>[
            Container(
            margin: EdgeInsets.symmetric(vertical: 4 * SizeConfig.heightMultiplier, horizontal: 12 * SizeConfig.widthMultiplier),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0) //                 <--- border radius here
                  ),
                  border: Border.all(color: Colors.greenAccent.withOpacity(0.2))
              ),
              child: Center(
                child: SizedBox(
                  width: 50 * SizeConfig.widthMultiplier,
                  height: 50 * SizeConfig.heightMultiplier,
                  child: Image.asset("images/postVideo_box.png"),
                ),
              ),
            )
              ],
            ),),
          ),
        ],
      ),
    );
  }
}
