import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:mbeshtetu_app/src/models/user_model.dart';
import 'package:mbeshtetu_app/src/screens/intro/intro_screen.dart';
import 'package:mbeshtetu_app/src/screens/splash/components/default_button.dart';
import 'package:mbeshtetu_app/src/screens/tabs/bnb_custom_painter.dart';
import 'package:mbeshtetu_app/src/services/user_service.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

import '../../../service_locator.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isSubscribed;
  final UserService _userService = serviceLocator<UserService>();

  @override
  void initState() {
    super.initState();
    _fetchSubscription();
  }

  _fetchSubscription() async {
    User user = await _userService.getUser();
    print(user.isSubscribedToQuotes);
    setState(() {
      _isSubscribed = user.isSubscribedToQuotes;
    });
  }

  _changeSubscription(bool subscribe) async {
    await _userService.changeSubscription(subscribe);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            "images/quotes_bg.png",
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter,
          )),
          Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Center(
                    child: SizedBox(
                      width: 50 * SizeConfig.widthMultiplier,
                      height: 50 * SizeConfig.heightMultiplier,
                       child: Image.asset("images/logo.png"),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(child: AutoSizeText("Miresevini!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 3 * SizeConfig.textMultiplier), minFontSize: 4,)),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Container(child: AutoSizeText("Ky aplikacion nuk merr asnje te dhene personale, ju jeni plotesisht anoninm gjate perdorimit te aplikacionit!", style:
                            TextStyle(fontSize: 2 * SizeConfig.textMultiplier),textAlign: TextAlign.center,)),
                        ),
                      ),
                     Expanded(
                       flex: 1,
                       child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Switch(
                              value: _isSubscribed != null ? _isSubscribed: false,
                              onChanged: (value) {
                                setState(() {
                                  _isSubscribed = value;
                                  print(_isSubscribed);
                                });
                                _changeSubscription(value);
                              },
                              activeTrackColor: Colors.green[50],
                              activeColor: Colors.green[200],
                            ),
                          ),
                          Flexible(flex:4,child: AutoSizeText(
                            "Thënje të përditshme",
                            style: TextStyle(
                                fontSize: 2.3 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.bold),
                            minFontSize: 4,
                          ))
                        ],
                    ),
                     ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 13 * SizeConfig.widthMultiplier,
                      vertical: 6.3 * SizeConfig.heightMultiplier),
                  child: DefaultButton(
                    text: "Vazhdo",
                    press: () {
                      Navigator.pushNamed(context, IntroScreen.routeName);
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
