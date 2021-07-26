import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mbeshtetu_app/src/business_logic/category_screen_viewmodel.dart';
import 'package:mbeshtetu_app/src/commons.dart';
import 'package:mbeshtetu_app/src/controllers/category_contorller.dart';
import 'package:mbeshtetu_app/src/models/category_model.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';
import 'package:mbeshtetu_app/src/screens/navigation/navigation_screen.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';
import 'package:mbeshtetu_app/src/size_config.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class CatetegoriesScreenSecond extends StatefulWidget {
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
      print("WHAT: $selectedPage");
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
    return Scaffold(
      bottomSheet: NavigationScreen(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(SizeConfig.heightMultiplier * 13),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: new AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                          indicatorWeight: 0.01,
                          labelColor: Color(0xff2D2727),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                          unselectedLabelStyle: TextStyle(),
                          tabs:
                              model.getCategoryTabList.map((Category category) {
                            return Tab(
                              child: Column(
                                children: [
                                  Text(category.category,
                                      style: TextStyle(
                                        fontSize: SizeConfig.textMultiplier * 3.2,
                                      )),
                                  Text(category.subCategory,
                                      style: TextStyle(
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
              crossAxisCount: 2,
              itemCount: snapshot.data.videos.length,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              itemBuilder: (context, index) {
                return CategoryTile(snapshot.data.videos[index]);
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
  final Video video;

  const CategoryTile(this.video);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  child: Image.network(
                    video.thumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              video.title,
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
    );
  }
}
