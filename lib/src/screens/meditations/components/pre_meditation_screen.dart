import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/business_logic/meditation_screen_viewmodel.dart';
import 'package:mbeshtetu_app/src/commons.dart';
import 'package:mbeshtetu_app/src/models/category_model.dart';
import 'package:mbeshtetu_app/src/screens/meditations/meditation_screen.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

class PreMeditationScreen extends StatefulWidget {
  static String routeName = "/selectMeditation";

  @override
  _PreMeditationScreenState createState() => _PreMeditationScreenState();
}

class _PreMeditationScreenState extends State<PreMeditationScreen> {
  Future categoriesWithVideos;
  MeditationScreenViewModel model = serviceLocator<MeditationScreenViewModel>();
  int _currentPage = 1, _limit = 10;

  Future categoryTabs;
  @override
  initState() {
    //get list of Tabs that will be displayed (categories)
    super.initState();
    categoryTabs = _loadCategoryTabs();
  }

  _loadCategoryTabs() async {
    var result = await model.loadCategoryTabs();
    return result;
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 18 * SizeConfig.heightMultiplier, bottom: 1 * SizeConfig.heightMultiplier),
            child: AutoSizeText("Meditimi", style: TextStyle(fontSize: 2.5 * SizeConfig.textMultiplier, fontWeight: FontWeight.bold),),
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
              ),
              child: Column(children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MeditationScreen(model.getCategoryTabList[0].id),
                  ),
                ),
                child: Container(
                margin: EdgeInsets.symmetric(vertical: 4 * SizeConfig.heightMultiplier, horizontal: 6 * SizeConfig.widthMultiplier),
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
              ),
                AutoSizeText("Meditimet 1", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 2.3 * SizeConfig.textMultiplier),),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MeditationScreen(model.getCategoryTabList[1].id),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 4 * SizeConfig.heightMultiplier, horizontal: 6 * SizeConfig.widthMultiplier),
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
                ),
                AutoSizeText("Meditimet 2", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 2.3 * SizeConfig.textMultiplier),),
              ],
            ),),
          ),
        ],
      ),
    );
  }
}
