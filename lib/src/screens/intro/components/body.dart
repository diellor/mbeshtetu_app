import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbeshtetu_app/src/business_logic/category_screen_viewmodel.dart';
import 'package:mbeshtetu_app/src/models/category_model.dart';
import 'package:mbeshtetu_app/src/screens/categories/categories_screen.dart';
import 'package:mbeshtetu_app/src/screens/categories/categories_screen_second.dart';
import 'package:mbeshtetu_app/src/screens/chat/chat_screen.dart';
import 'package:mbeshtetu_app/src/screens/home/home.dart';
import 'package:mbeshtetu_app/src/screens/intro/components/grid_content.dart';
import 'package:mbeshtetu_app/src/screens/meditations/components/pre_meditation_screen.dart';
import 'package:mbeshtetu_app/src/screens/meditations/meditation_screen.dart';
import 'package:mbeshtetu_app/src/screens/splash/components/default_button.dart';
import 'package:mbeshtetu_app/src/screens/tabs/bnb_custom_painter.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

import '../../../service_locator.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CategoryScreenViewModel model = serviceLocator<CategoryScreenViewModel>();
  Future filteredCategories;

  @override
  void initState() {
    super.initState();
    filteredCategories = _loadCategoryNames();
  }

  _loadCategoryNames() async {
    final categories = await model.loadCategoryTabs();
    return categories
        .where((element) => element.subCategory == "MESO")
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    print("FUKTERERD: $filteredCategories");
    var gridImages = [
      "images/question_1.png",
      "images/question_2.png",
      "images/question_3.png",
      "images/question_4.png",
      "images/question_5.png",
      "images/question_6.png",
      "images/question_6.png",
    ];
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Cka ju sjell te",
                          style: TextStyle(
                              fontSize: 3.2 * SizeConfig.textMultiplier,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "mbështetu?",
                          style: TextStyle(
                              fontSize: 3.2 * SizeConfig.textMultiplier,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.5 * SizeConfig.widthMultiplier),
                  child: Container(
                      child: FutureBuilder(
                          future: filteredCategories,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Category> list =
                                  snapshot.data as List<Category>;
                              return GridView.count(
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  mainAxisSpacing: 15.0,
                                  crossAxisSpacing: 15.0,
                                  childAspectRatio:
                                  MediaQuery.of(context).size.aspectRatio * 3 / 1.6,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    ...list
                                        .map((e) => new GestureDetector(
                                        onTap: () {
                                          int i = e.id;
                                          print("PO PREKEN SENET: $i");
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  CatetegoriesScreenSecond(
                                                      category: e),
                                            ),
                                          );
                                        },
                                        child: GridContent(
                                            gridImag:
                                            gridImages[list.indexOf(e)],
                                            text: e.category)))
                                        .toList(),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.of(context).pushReplacementNamed('/selectMeditation');
                                      },
                                      child: GridContent(
                                          gridImag:
                                          gridImages[3],
                                          text: "Meditimi"),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushReplacementNamed('/sleepScreen');
                                      },
                                      child: GridContent(
                                          gridImag:
                                          gridImages[4],
                                          text: "Problemet me gjumë"),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushReplacementNamed('/chatScreen');

                                      },
                                      child: GridContent(
                                          gridImag:
                                          gridImages[5],
                                          text: "Bisedoj me dikë"),
                                    ),
                                  ]
                              );
                            } else
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor, // Red
                                  ),
                                ),
                              );
                          })),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20 * SizeConfig.widthMultiplier,
                      vertical: 6.5 * SizeConfig.heightMultiplier),
                  child: DefaultButton(
                    text: "Vazhdo",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Home(),
                        ),
                      );
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
