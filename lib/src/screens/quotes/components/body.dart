import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/models/user_model.dart';
import 'package:mbeshtetu_app/src/screens/splash/components/default_button.dart';
import 'package:mbeshtetu_app/src/screens/tabs/tabs_screen.dart';
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
            "images/intro_bg_2.png",
            fit: BoxFit.contain,
            alignment: Alignment.bottomRight,
          )),
          Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Switch(
                          value: _isSubscribed,
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
                        Text(
                          "Thënje të përditshme",
                          style: TextStyle(
                              fontSize: 2.6 * SizeConfig.textMultiplier,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10 * SizeConfig.widthMultiplier,
                      vertical: 22 * SizeConfig.heightMultiplier),
                  child: DefaultButton(
                    text: "Vazhdo",
                    press: () {
                      Navigator.pushNamed(context, TabsScreen.routeName);
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
