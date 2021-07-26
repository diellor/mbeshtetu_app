import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mbeshtetu_app/src/business_logic/meditation_screen_viewmodel.dart';
import 'package:mbeshtetu_app/src/models/audio_model.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';
import 'package:mbeshtetu_app/src/screens/splash/components/default_button.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

class Body extends StatefulWidget {
  final int categoryId;

  const Body({Key key, this.categoryId}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future categoriesWithVideos;
  MeditationScreenViewModel model = serviceLocator<MeditationScreenViewModel>();
  int _currentPage = 1, _limit = 10;

  @override
  void initState() {
    super.initState();
    print(widget.categoryId);
    categoriesWithVideos = _meditationAudios(_currentPage);
  }

  _meditationAudios(int page) async {
    return await model.loadVideosByCategoryId(_currentPage, widget.categoryId);
  }

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
            child: FutureBuilder(
              future: categoriesWithVideos,
              builder: (context, snapshot) {
                if (!snapshot.hasData || model.getVideoMetadata.videos.length == 0)
                   return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor, // Red
                      ),
                    ),
                  );
                else
                  return ListView.builder(
                    itemCount: snapshot.data.videos.length,
                    itemBuilder: (context, index) {
                      List<Video> videos = snapshot.data.videos;
                      return Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context)
                                  .pushNamed("/musicScreen", arguments: Audio(video: videos[index], index: index));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 1 * SizeConfig.heightMultiplier),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(flex: 1, child: SvgPicture.asset("images/meditimi_play_1.svg")),
                                  Expanded(flex: 3, child:Text(videos[index].title,style: TextStyle(fontSize: 2 * SizeConfig.textMultiplier,)), ),
                                  Expanded(flex: 1, child: Text("10 mins"))
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
              },
            )
          )
        ],
      ),),
    ),
      ],
    );
  }
}
