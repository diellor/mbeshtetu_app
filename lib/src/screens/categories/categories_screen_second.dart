import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/business_logic/category_screen_viewmodel.dart';
import 'package:mbeshtetu_app/src/models/category_model.dart';
import 'package:mbeshtetu_app/src/models/videoMetadata_model.dart';
import 'package:mbeshtetu_app/src/models/video_model.dart';
import 'package:mbeshtetu_app/src/screens/navigation/navigation_screen.dart';
import 'package:mbeshtetu_app/src/service_locator.dart';
import 'package:mbeshtetu_app/src/size_config.dart';

class CatetegoriesScreenSecond extends StatefulWidget {
  int selectedPage;

  CatetegoriesScreenSecond(this.selectedPage);

  @override
  _CatetegoriesScreenSecondState createState() =>
      _CatetegoriesScreenSecondState();
}

class _CatetegoriesScreenSecondState extends State<CatetegoriesScreenSecond> {
  // TabController _tabController;
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
    bool shouldLoadMore = true;
    gridList = [];
    future = _loadVideosByCategoryId(_currentPage); //load data for first time
  }

  _loadVideosByCategoryId(int page) async {
    return await model.loadVideosByCategoryId(_currentPage, widget.selectedPage);
  }

  _loadCategoryTabs() async {
    var result = await model.loadCategoryTabs();
    // _tabController = TabController(
    //     vsync: this, length: result.length, initialIndex: widget.selectedPage - 1);
    return result;
  }

  @override
  void dispose() {
    // _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: NavigationScreen(),
        body: SliverGrid(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return FutureBuilder(
                  future: future,
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.done
                        ? snapshot.hasData
                            ? Text(snapshot.data.toString())
                            : Text('Retry')
                        : Text('progress');
                  },
                );
              },
            ),
        ),
    );
  }
}

// class CategoriesGridItem extends StatefulWidget {
//   final int id;
//
//   CategoriesGridItem(this.id);
//
//   @override
//   _CategoriesGridItemState createState() => _CategoriesGridItemState();
// }
//
// class _CategoriesGridItemState extends State<CategoriesGridItem> {
//   CategoryScreenViewModel model = serviceLocator<CategoryScreenViewModel>();
//   Future future;
//   List<Video> gridList;
//
//   ScrollController _scrollController =
//       ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
//   int _currentPage = 1, _limit = 10;
//
//   bool shouldLoadMore = true;
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     //get videos by tab-category
//
//     super.initState();
//     bool shouldLoadMore = true;
//     gridList = [];
//     future = _loadVideosByCategoryId(_currentPage); //load data for first time
//
//     _scrollController.addListener(() {
//       _scrollController.addListener(() {
//         var isEnd = _scrollController.offset ==
//             _scrollController.position.maxScrollExtent;
//         if (isEnd) if (shouldLoadMore) {
//           setState(() {
//             isLoading = true;
//             future = _loadVideosByCategoryId(++_currentPage);
//           });
//         }
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   _loadVideosByCategoryId(int page) async {
//     return await model.loadVideosByCategoryId(_currentPage, widget.id);
//   }
//
//   bool _onScrollNotification(ScrollNotification notification) {
//     if (notification is ScrollEndNotification) {
//       final before = notification.metrics.extentBefore;
//       final max = notification.metrics.maxScrollExtent;
//
//       if (before == max) {
//         // load next page
//         // code here will be called only if scrolled to the very bottom
//         print("END Without items HERE");
//         if (shouldLoadMore) {
//           isLoading = true;
//           setState(() {
//             future = _loadVideosByCategoryId(++_currentPage);
//           });
//         }
//       }
//     }
//     return false;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //use FutureBuilder to get videos by category
//     //display circle or grid
//     return Scaffold(
//         body: SafeArea(
//       child: SingleChildScrollView(
//         child: Center(
//           child: Container(
//             padding: EdgeInsets.only(right: 15.0),
//             width: MediaQuery.of(context).size.width - 30.0,
//             height: MediaQuery.of(context).size.height -
//                 30 * SizeConfig.heightMultiplier, //200.0,
//             child: SliverGrid(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10.0,
//                   mainAxisSpacing: 5.0,
//                   childAspectRatio: 0.8,
//                 ),
//                 delegate: SliverChildBuilderDelegate(
//                   (BuildContext context, int index) {
//                     return FutureBuilder(
//                       future: future,
//                       builder: (context, snapshot) {
//                         if (snapshot.hasData) {
//                           isLoading = false;
//                           if (gridList.length == snapshot.data.total) {
//                             shouldLoadMore = false;
//                           }
//                           VideoMetadata videoMetadata =
//                               snapshot.data as VideoMetadata;
//                           videoMetadata.videos.forEach((element) {
//                             if (!gridList.contains(element))
//                               gridList.add(element);
//                           });
//                         }
//                         return snapshot.connectionState == ConnectionState.done
//                             ? snapshot.hasData
//                                 ? _buildCard(
//                                     index,
//                                     gridList[index].title,
//                                     'images/question_3.png',
//                                     false,
//                                     false,
//                                     context)
//                                 : Text('Retry')
//                             : Text('progress');
//                       },
//                     );
//                   },
//                 )),
//           ),
//         ),
//       ),
//     ));
//   }
// }
//
