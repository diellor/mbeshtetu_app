import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbeshtetu_app/src/business_logic/postVideo_screen_viewmodel.dart';
import 'package:mbeshtetu_app/src/commons.dart';
import 'package:mbeshtetu_app/src/models/create_rate_model.dart';
import 'package:mbeshtetu_app/src/screens/postvideo/components/green_button.dart';
import 'package:mbeshtetu_app/src/screens/splash/components/default_button.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

class Body extends StatefulWidget {
  final String id;

  Body({this.id});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PostVideoScreenViewModel model = serviceLocator<PostVideoScreenViewModel>();

  Future quote;
  String videoId;
  dynamic rate;

  @override
  void initState() {
    super.initState();
    String id = widget.id;
    print( "$id omg");
    videoId = widget.id;
    quote = _loadRandomQuote();
  }

  _loadRandomQuote() async {
    return await model.loadRandomQuote();
  }

  _confirmSchedule(DateTime date) async {
    print("ohno: $videoId");
    await model.scheduleVideo(date, videoId);
    Navigator.of(context).pushNamed("/intro");
  }

  _handleRate(double rate) async {
    print("TU RAtE");
    await model.rateVideo(CreateRate(rate: rate, videoId: videoId));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "images/audio_bg.png",
            fit: BoxFit.fitWidth,
            height: 20,
            alignment: Alignment.bottomCenter,
              // color: Color.fromRGBO(255, 255, 255, 0.7),
              // colorBlendMode: BlendMode.modulates
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
            Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Text(
                      "Vlerëso",
                      style: TextStyle(
                          fontSize: 2.6 * SizeConfig.textMultiplier,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 4 * SizeConfig.heightMultiplier,
                            horizontal: 12 * SizeConfig.widthMultiplier),
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(
                                    10.0) //                 <--- border radius here
                                ),
                            border: Border.all(
                                color: Colors.greenAccent.withOpacity(0.2))),
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
                          color: dark_green,
                        ),
                        onRatingUpdate: (double rating) {
                          _handleRate(rating);
                          print(rating);
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Expanded(
                            flex:1,
                           child: Padding(
                              padding: EdgeInsets.only(
                                  top: 1 * SizeConfig.heightMultiplier),
                              child: FutureBuilder(
                                  future: quote,
                                  builder:
                                      (BuildContext context, AsyncSnapshot snapshot) {
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                            6 * SizeConfig.widthMultiplier),
                                        child: AutoSizeText(
                                          snapshot.data,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                              2 * SizeConfig.textMultiplier),
                                        ),
                                      );
                                  }),
                            ),
                          ),
                          Expanded(
    flex:1,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20 * SizeConfig.widthMultiplier,
                                  vertical: 2 * SizeConfig.heightMultiplier),
                              child: GreenButton(
                                text: "Cakto perkujtues",
                                press: () {
                                  DatePicker.showDateTimePicker(context,
                                      showTitleActions: true, onChanged: (DateTime date) {
                                        print('change $date');
                                      }, onConfirm: (DateTime date) {
                                        _confirmSchedule(date);
                                      }, currentTime: DateTime.now(), locale: LocaleType.sq);
                                  // Navigator.pushNamed(context, SubscribeToQuotesScreen.routeName);
                                },
                              ),
                            ),
                          ),
                        ],

                      ),
                    ),

                  ],
                )),
            Expanded(
              flex: 1,
              child: SizedBox()
            ),
          ],
        ),
      ],
    );
  }
}
