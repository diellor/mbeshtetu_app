import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbeshtetu_app/src/screens/splash/components/default_button.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
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
         color: Colors.white,
         borderRadius: BorderRadius.only(
           topLeft: Radius.circular(30),
           topRight: Radius.circular(30),
            ),
          ),child: Column(
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.only(top: 1 * SizeConfig.heightMultiplier),
            child: Text("Meditimi", style: TextStyle(fontSize: 3 * SizeConfig.textMultiplier, fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2 * SizeConfig.heightMultiplier),
            child: Text("Meditimi Koleksioni 1", style: TextStyle(fontSize: 2.5 * SizeConfig.textMultiplier,),),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1 * SizeConfig.heightMultiplier, horizontal: 18 * SizeConfig.widthMultiplier),
            child: DefaultButton(
              text: "Play",
              press: () {
              //  Navigator.pushNamed(context, TabsScreen.routeName);
              },
            ),
          ),
          Container(
            height: SizeConfig.screenHeight - 60 * SizeConfig.heightMultiplier,
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1 * SizeConfig.heightMultiplier),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //SvgPicture.asset("images/meditimi_play_1.svg"),
                      Text("Mediation audio one",style: TextStyle(fontSize: 2 * SizeConfig.textMultiplier,)),
                      Text("10 mins")
                  ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1 * SizeConfig.heightMultiplier),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //SvgPicture.asset("images/meditimi_play_1.svg"),
                      Text("Mediation audio one",style: TextStyle(fontSize: 2 * SizeConfig.textMultiplier,)),
                      Text("10 mins")
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1 * SizeConfig.heightMultiplier),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //SvgPicture.asset("images/meditimi_play_1.svg"),
                      Text("Mediation audio one",style: TextStyle(fontSize: 2 * SizeConfig.textMultiplier,)),
                      Text("10 mins")
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1 * SizeConfig.heightMultiplier),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //SvgPicture.asset("images/meditimi_play_1.svg"),
                      Text("Mediation audio one",style: TextStyle(fontSize: 2 * SizeConfig.textMultiplier,)),
                      Text("10 mins")
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1 * SizeConfig.heightMultiplier),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //SvgPicture.asset("images/meditimi_play_1.svg"),
                      Text("Mediation audio one",style: TextStyle(fontSize: 2 * SizeConfig.textMultiplier,)),
                      Text("10 mins")
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1 * SizeConfig.heightMultiplier),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //SvgPicture.asset("images/meditimi_play_1.svg"),
                      Text("Mediation audio one",style: TextStyle(fontSize: 2 * SizeConfig.textMultiplier,)),
                      Text("10 mins")
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1 * SizeConfig.heightMultiplier),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //SvgPicture.asset("images/meditimi_play_1.svg"),
                      Text("Mediation audio one",style: TextStyle(fontSize: 2 * SizeConfig.textMultiplier,)),
                      Text("10 mins")
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1 * SizeConfig.heightMultiplier),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //SvgPicture.asset("images/meditimi_play_1.svg"),
                      Text("Mediation audio one",style: TextStyle(fontSize: 2 * SizeConfig.textMultiplier,)),
                      Text("10 mins")
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1 * SizeConfig.heightMultiplier),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //SvgPicture.asset("images/meditimi_play_1.svg"),
                      Text("Mediation audio one",style: TextStyle(fontSize: 2 * SizeConfig.textMultiplier,)),
                      Text("10 mins")
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),),
    ),
      ],
    );
  }
}
