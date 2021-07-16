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
import 'package:mbeshtetu_app/src/service_locator.dart';

class CatetegoriesScreen extends StatefulWidget {
  @override
  _CatetegoriesScreenState createState() => _CatetegoriesScreenState();
}

class _CatetegoriesScreenState extends State<CatetegoriesScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  CategoryScreenViewModel model = serviceLocator<CategoryScreenViewModel>();
  Future categoryTabs;

  @override
  initState() {
    //get list of Tabs that will be displayed (categories)
    super.initState();
    categoryTabs = _loadCategoryTabs();
  }

  _loadCategoryTabs() async {
    var result = await model.loadCategoryTabs();
    _tabController = TabController(length: model.getCategoryTabList.length, vsync: this);
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder(
                future: categoryTabs,
                builder: (context, snapshot){
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
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 9.0),
              child: Container(
                height: MediaQuery.of(context).size.height - 50.0,
                width: double.infinity,
                child: TabBarView(controller: _tabController, children: [
                  //foreach _categorylist, display it's grid values.
                  //Go to db display circle when loading
                  //Make categoriesGridItem stateful
                  CategoriesGridItem(),
                  CategoriesGridItem(),
                  CategoriesGridItem(),
                  CategoriesGridItem(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesGridItem extends StatefulWidget {
  @override
  _CategoriesGridItemState createState() => _CategoriesGridItemState();
}

class _CategoriesGridItemState extends State<CategoriesGridItem> {

  @override
  void initState() {
    //get videos by tab-category
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //use FutureBuilder to get videos by category
    //display circle or grid
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
              padding: EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height - 50.0,
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.8,
                children: <Widget>[
                  _buildCard('Cookie mint test test test test ',
                      'images/ballina_main.png', false, false, context),
                  _buildCard('Cookie cream', 'images/green_shadow.png', true,
                      false, context),
                  _buildCard('Cookie classic', 'images/intro_bg_2.png', false,
                      true, context),
                  _buildCard('Cookie choco', 'images/intro_bg.png', false,
                      false, context),
                ],
              )),
        ),
      ),
    );
  }
}

Widget _buildCard(
    String name, String imgPath, bool added, bool isFavorite, context) {
  return Padding(
    padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
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