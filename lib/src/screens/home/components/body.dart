import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/business_logic/home_screen_viewmodel.dart';
import 'package:mbeshtetu_app/src/models/category_model.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';
import 'package:mbeshtetu_app/src/screens/categories/categories_screen_second.dart';
import 'package:mbeshtetu_app/src/screens/home/components/ballina_video_card.dart';
import 'package:mbeshtetu_app/src/screens/home/components/header_video_details.dart';
import 'package:mbeshtetu_app/src/screens/home/components/title_recomended.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future categoriesWithVideos;

  bool isOnline = false;
  var listener;
  HomeScreenViewModel model = serviceLocator<HomeScreenViewModel>();
  @override
  void initState() {
    super.initState();
    categoriesWithVideos = _loadCategoriesWithVideos();
  }

  _loadCategoriesWithVideos() async {
    return await model.loadCategoriesData();
  }

  List<Widget> getVideoCardsBasedOnCategory(Category category) {
    List<Video> filteredVideos = model.filteredVideosByCategory(category);
    List<Widget> columns = <Widget>[];
    if(model.getTitleRecomended(category) != ""){
      if(category.category != "Meditimi" && category.category != "Gjumi" )
      columns.add(TitleRecommended(
          text: model.getTitleRecomended(category),
          press: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CatetegoriesScreenSecond(category: category)));
          },isTeFundit: category.category == "Recent"? true: false)
      );
    }
    if(category.category != "Meditimi" && category.category != "Gjumi")
    columns.add(SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: new Row(
          children: filteredVideos
              .map((item) => new BallinaVideoCard(
                  image:
                      item.thumbnail,
                  title: item.title,
                  press: () {},
                  videoId: item.videoId,
                  isAudio: item.isAudio,
                  category: item.category,
video: item,
          ))
              .toList()),
    ));
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: categoriesWithVideos,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData || model.getCategories.categories.length == 0)
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor, // Red
                  ),
                ),
              ); //CIRCULAR INDICATOR
            else
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    HeaderWithVideoDetails(video: model.getMainVideo),
                    //titleRecommended gets the text based on category
                    for (int i = 0; i < model.getCategories.categories.length;
                        i++)
                      //Container will cover 40% of our page width
                      ...getVideoCardsBasedOnCategory(
                          model.getCategories.categories[i]),
                    SizedBox(
                      height: SizeConfig.heightMultiplier *7.5,
                    )
                  ],
                ),
              ).build(context);
          })
    );
  }
}
