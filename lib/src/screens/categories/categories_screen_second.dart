import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mbeshtetu_app/src/business_logic/category_screen_viewmodel.dart';
import 'package:mbeshtetu_app/src/commons.dart';
import 'package:mbeshtetu_app/src/controllers/category_contorller.dart';
import 'package:mbeshtetu_app/src/models/audio_model.dart';
import 'package:mbeshtetu_app/src/models/category_model.dart';
import 'package:mbeshtetu_app/src/models/selected_category.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';
import 'package:mbeshtetu_app/src/models/video_model_arg.dart';
import 'package:mbeshtetu_app/src/screens/home/components/video_screen.dart';
import 'package:mbeshtetu_app/src/screens/music/music_screen.dart';
import 'package:mbeshtetu_app/src/screens/navigation/navigation_screen.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';
import 'package:mbeshtetu_app/src/size_config.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class CatetegoriesScreenSecond extends StatefulWidget {
  static String routeName = "/categoriesScreen";

  Category category;

  CatetegoriesScreenSecond({this.category});

  @override
  _CatetegoriesScreenSecondState createState() =>
      _CatetegoriesScreenSecondState();
}

class _CatetegoriesScreenSecondState extends State<CatetegoriesScreenSecond>
    with TickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 0;
  CategoryScreenViewModel model = serviceLocator<CategoryScreenViewModel>();
  Future categoryTabs;

  Future future;
  List<Video> gridList;

  int _currentPage = 1, _limit = 10;
  bool shouldLoadMore = true;
  bool isLoading = true;

  @override
  initState() {
    //get list of Tabs that will be displayed (categories)
    super.initState();
    categoryTabs = _loadCategoryTabs();
    // gridList = [];
  }

  _loadCategoryTabs() async {
    var result = await model.loadCategoryTabs();
    int selectedPage = 0;
    if (this.widget.category != null) {
      Category ohno = model.getCategoryTabList.where((element) => element.id == this.widget.category.id).first;
      selectedPage = model.getCategoryTabList.indexOf(ohno);
    }
    _controller = TabController(
        vsync: this,
        length: result.length,
        initialIndex: selectedPage);
    return result;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final CategoryController productController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    SelectedCat selectedCat = SelectedCat(ballina: 0,gjumi: 0,meditimi: 0,seancat: 1);
    return Scaffold(
      backgroundColor: primary_blue,
      bottomSheet: NavigationScreen(selectedCat: selectedCat),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(SizeConfig.heightMultiplier * 16),
        child: Padding(
          padding: EdgeInsets.only(top: 4 * SizeConfig.heightMultiplier),
          child: new AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: primary_blue,
            elevation: 0,
            flexibleSpace: new Column(
              children: [
                new SizedBox(
                  height: 30,
                ),
                FutureBuilder(
                    future: categoryTabs,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return TabBar(
                          controller: _controller,
                          isScrollable: true,
                          indicatorWeight: 0.5,
                          indicatorColor: Color(0xff2D2727),
                          labelColor: Color(0xff2D2727),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: SizeConfig.textMultiplier * 4),
                          unselectedLabelStyle: TextStyle(),
                          tabs:
                              model.getCategoryTabList.map((Category category) {
                            return Tab(
                              child: Column(
                                children: [
                                  Text(category.category,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: SizeConfig.textMultiplier * 3.0,
                                      )),
                                  Text(category.subCategory,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: SizeConfig.textMultiplier * 1.2,
                                      )),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor, // Red
                            ),
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder(
          future: categoryTabs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor, // Red
                  ),
                ),
              );
            }
            if (snapshot.hasData) {
              List<Category> list = snapshot.data as List<Category>;
              return TabBarView(controller: _controller, children: [
                ...list.map((e) => new CategoryGridView(e.id)).toList()
              ]);
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor, // Red
                  ),
                ),
              );
            }
          }),
    );
  }
}

class CategoryGridView extends StatefulWidget {
  final int id;

  CategoryGridView(this.id);

  @override
  _CategoryGridViewState createState() => _CategoryGridViewState();
}

class _CategoryGridViewState extends State<CategoryGridView> {
  CategoryScreenViewModel model = serviceLocator<CategoryScreenViewModel>();
  Future future;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    future = _loadVideosByCategoryId(_currentPage); //load data for first time
  }

  _loadVideosByCategoryId(int page) async {
    return await model.loadVideosByCategoryId(_currentPage, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return StaggeredGridView.countBuilder(
              padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 3, right: SizeConfig.widthMultiplier * 3, bottom: SizeConfig.heightMultiplier * 10),
              crossAxisCount: 2,
              itemCount: snapshot.data.videos.length,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              itemBuilder: (context, index) {
                return CategoryTile(videos: snapshot.data.videos, index: index,);
              },
              staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor, // Red
                ),
              ),
            );
          }
        }
    );
  }
}

class CategoryTile extends StatelessWidget {
  final List<Video> videos;
  final int index;

  const CategoryTile({this.videos, this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        this.videos[index].isAudio
            ?  Navigator.of(context)
          .pushNamed(MusicScreen.routeName, arguments: Audio(index: index, videos: videos))
            : Navigator.of(context)
          .pushNamed(VideoScreen.routeName, arguments: VideoArgs(video: videos[index])),
      },
      child: Card(
        shadowColor: bold_blue.withOpacity(0.3),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        videos[index].thumbnail,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                videos[index].title,
                maxLines: 2,
                style:
                    TextStyle(fontFamily: 'avenir', fontWeight: FontWeight.w800),
                overflow: TextOverflow.ellipsis,
              ),
              // Text('\$${product.price}',
              //     style: TextStyle(fontSize: 32, fontFamily: 'avenir')),
            ],
          ),
        ),
      ),
    );
  }
}
