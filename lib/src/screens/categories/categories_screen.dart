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
class CatetegoriesScreen extends StatefulWidget {
  @override
  _CatetegoriesScreenState createState() => _CatetegoriesScreenState();
}

class _CatetegoriesScreenState extends State<CatetegoriesScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    //get list of Tabs (Only categories in db)
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
              child: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  labelColor: Color(0xFFC88D67),
                  isScrollable: true,
                  labelPadding: EdgeInsets.only(right: 45.0),
                  unselectedLabelColor: Color(0xFFCDCDCD),
                  tabs: [
                    //Display the list that we got above (only categories list)
                    //circle while loading?
                    Tab(
                      child: Text('Cookies',
                          style: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 21.0,
                          )),
                    ),
                    Tab(
                      child: Text('Cookie cake',
                          style: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 21.0,
                          )),
                    ),
                    Tab(
                      child: Text('Ice cream',
                          style: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 21.0,
                          )),
                    )
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 9.0),
              child: Container(
                height: MediaQuery.of(context).size.height - 50.0,
                width: double.infinity,
                child: TabBarView(controller: _tabController, children: [
                  //foreach (categories only list), send category id inside widget below
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
    //get videos by category id that is passed here
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
              //build gridView based on list of videos loaded on initState
              //circle while loading?
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