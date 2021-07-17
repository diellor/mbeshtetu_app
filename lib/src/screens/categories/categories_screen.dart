// import 'package:flutter/material.dart';
//
// class CatetegoriesScreen extends StatelessWidget {
//   static Route<dynamic> route() => MaterialPageRoute(
//     builder: (context) => CatetegoriesScreen(),
//   );
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Text("CategoryPage"),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/business_logic/category_screen_viewmodel.dart';
import 'package:mbeshtetu_app/src/models/category_model.dart';
import 'package:mbeshtetu_app/src/models/videoMetadata_model.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

class CatetegoriesScreen extends StatefulWidget {
  @override
  _CatetegoriesScreenState createState() => _CatetegoriesScreenState();
}

class _CatetegoriesScreenState extends State<CatetegoriesScreen>
    with TickerProviderStateMixin {
  TabController _tabController;
  CategoryScreenViewModel model = serviceLocator<CategoryScreenViewModel>();
  Future categoryTabs;

  @override
  initState() {
    //get list of Tabs that will be displayed (categories)
    super.initState();
    categoryTabs = _loadCategoryTabs();
    setState(() {
      _tabController = TabController(vsync: this, length: 4);
    });
  }

  _loadCategoryTabs() async {
    var result = await model.loadCategoryTabs();
    return result;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: 6 * SizeConfig.heightMultiplier,
              left: 6 * SizeConfig.widthMultiplier,
              right: 6 * SizeConfig.widthMultiplier),
          child: Column(
            children: [
              FutureBuilder(
                  future: categoryTabs,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return TabBar(
                        controller: _tabController,
                        indicatorColor: Colors.transparent,
                        labelColor: Color(0xFFC88D67),
                        isScrollable: true,
                        labelPadding: EdgeInsets.only(right: 45.0),
                        unselectedLabelColor: Color(0xFFCDCDCD),
                        tabs: model.getCategoryTabList.map((Category category) {
                          return Tab(
                            child: Text(category.category,
                                style: TextStyle(
                                  fontFamily: 'Wow',
                                  fontSize: 21.0,
                                )),
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
              Padding(
                padding: const EdgeInsets.only(top: 9.0),
                child: Container(
                  height: MediaQuery.of(context).size.height - 50.0,
                  width: double.infinity,
                  child: FutureBuilder(
                      future: categoryTabs,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor, // Red
                              ),
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          return TabBarView(
                              controller: _tabController,
                              children: [
                                ...model.getCategoryTabList
                                    .map((e) => new CategoriesGridItem(e.id))
                                    .toList()
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesGridItem extends StatefulWidget {
  final int id;
  CategoriesGridItem(this.id);

  @override
  _CategoriesGridItemState createState() => _CategoriesGridItemState();
}

class _CategoriesGridItemState extends State<CategoriesGridItem> {
  CategoryScreenViewModel model = serviceLocator<CategoryScreenViewModel>();
  Future future;
  List<Video> gridList;

  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  int _currentPage = 1, _limit = 10;

  bool shouldLoadMore = true;
  bool isLoading = true;
  @override
  void initState() {
    //get videos by tab-category

    super.initState();
    bool shouldLoadMore = true;
    gridList = [];
    future = _loadVideosByCategoryId(_currentPage); //load data for first time

    _scrollController.addListener(() {
      _scrollController.addListener(() {
        var isEnd = _scrollController.offset ==
            _scrollController.position.maxScrollExtent;
        if (isEnd) if (shouldLoadMore) {
          setState(() {
            isLoading = true;
            future = _loadVideosByCategoryId(++_currentPage);
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _loadVideosByCategoryId(int page) async {
    return await model.loadVideosByCategoryId(_currentPage, widget.id);
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      final before = notification.metrics.extentBefore;
      final max = notification.metrics.maxScrollExtent;

      if (before == max) {
        // load next page
        // code here will be called only if scrolled to the very bottom
        print("END Without items HERE");
        if (shouldLoadMore) {
          isLoading = true;
          setState(() {
            future = _loadVideosByCategoryId(++_currentPage);
          });
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    //use FutureBuilder to get videos by category
    //display circle or grid
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              padding: EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height -
                  30 * SizeConfig.heightMultiplier, //200.0,
              child: FutureBuilder(
                  future: future,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      isLoading = false;
                      if (gridList.length == snapshot.data.total)
                        shouldLoadMore = false;
                      // snapshot.data.videos?.foreach((video){
                      //   if(!gridList.contains(video)) gridList.add(video);
                      // });
                      VideoMetadata videoMetadata =
                          snapshot.data as VideoMetadata;
                      videoMetadata.videos.forEach((element) {
                        if (!gridList.contains(element)) gridList.add(element);
                      });

                      return NotificationListener<ScrollNotification>(
                        onNotification: _onScrollNotification,
                        child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 5.0,
                              childAspectRatio: 0.8,
                            ),
                            itemCount: gridList.length,
                            itemBuilder: (context, index) {
                              if (snapshot.connectionState ==
                                      ConnectionState.waiting ||
                                  !snapshot.hasData) {
                                isLoading = true;
                                // return Center(
                                //   child: CircularProgressIndicator(),
                                // );
                              }
                              if (isLoading) {
                                print(isLoading);
                                return CircularProgressIndicator();
                              } else {
                                print(isLoading);
                                return _buildCard(
                                    gridList[index].title,
                                    'images/ballina_main.png',
                                    false,
                                    false,
                                    context);
                              }
                            }),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor, // Red
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildCard(
    String name, String imgPath, bool added, bool isFavorite, context) {
  return Padding(
    padding: EdgeInsets.only(top: 5.0, bottom: 8.0, left: 5.0, right: 5.0),
    child: InkWell(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) =>
        //         CategoriesDetailPage(assetPath: imgPath, cookiename: name)));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3.0,
                  blurRadius: 5.0)
            ],
            color: Colors.white),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  isFavorite
                      ? Icon(Icons.favorite, color: Color(0xFFEF7532))
                      : Icon(Icons.favorite_border, color: Color(0xFFEF7532))
                ])),
            Hero(
                tag: imgPath,
                child: Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(imgPath), fit: BoxFit.contain)))),
            SizedBox(height: 7.0),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(name,
                  style: TextStyle(
                      color: Color(0xFF575E67),
                      fontFamily: 'Varela',
                      fontSize: 14.0)),
            ),
          ],
        ),
      ),
    ),
  );
}
