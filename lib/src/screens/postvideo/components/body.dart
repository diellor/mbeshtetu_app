import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbeshtetu_app/src/business_logic/postVideo_screen_viewmodel.dart';
import 'package:mbeshtetu_app/src/screens/splash/components/default_button.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PostVideoScreenViewModel model = serviceLocator<PostVideoScreenViewModel>();

  Future quote;
  @override
  void initState() {
    super.initState();
    quote = _loadRandomQuote();
  }

  _loadRandomQuote() async {
    return await model.loadRandomQuote();
  }

  @override
  Widget build(BuildContext context) {
      return Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
                "images/audio_bg.png",
                width: SizeConfig.screenWidth,
                fit: BoxFit.fitWidth,
                repeat: ImageRepeat.repeatX,
                alignment: Alignment.bottomCenter,
              ),
          ),
          Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      IconButton(
                          icon: SvgPicture.asset("images/audio_back_btn.svg"),
                          onPressed: () {})
                    ],
                  )),
              Expanded(flex:3, child: Column(
                children: [
                  Text("Vlereso",style: TextStyle(fontSize: 2.6 * SizeConfig.textMultiplier, fontWeight: FontWeight.bold),),
                  Expanded(
                    flex: 2,
                    child: Container(
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
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(top: 2 * SizeConfig.heightMultiplier),
                      child: FutureBuilder(
                        future: quote,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData)
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor, // Red
                              ),
                            ),
                          );
                        else
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6* SizeConfig.widthMultiplier),
                            child: AutoSizeText(snapshot.data, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 2 * SizeConfig.textMultiplier),),
                          );
                      }
                    ),
                    ),
                  )],
              )),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 13 * SizeConfig.widthMultiplier,
                      vertical: 6.3 * SizeConfig.heightMultiplier),
                  child: DefaultButton(
                    text: "Cakto perkujtues",
                    press: () {
                      // Navigator.pushNamed(context, SubscribeToQuotesScreen.routeName);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      );
  }
}