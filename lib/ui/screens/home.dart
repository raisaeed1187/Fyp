import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutterfirebase/PageSearch.dart';
import 'package:flutterfirebase/ProductDetails.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/modal/mobile.dart';
import 'package:flutterfirebase/modal/user.dart';
import 'package:flutterfirebase/pages/comparison.dart';
import 'package:flutterfirebase/provider/comparisonProvider.dart';
import 'package:flutterfirebase/services/auth.dart';
import 'package:flutterfirebase/services/database.dart';
import 'package:flutterfirebase/services/favorite_services.dart';
// import 'package:flutterfirebase/services/favorite_services.dart';
import 'package:flutterfirebase/services/search_service.dart';
import 'package:flutterfirebase/ui/models/product.dart';
import 'package:flutterfirebase/ui/painters/circlepainters.dart';
import 'package:flutterfirebase/ui/screens/favorites_list.dart';
import 'package:flutterfirebase/ui/screens/products_list.dart';
import 'package:flutterfirebase/ui/screens/profile.dart';
// import 'package:flutterfirebase/ui/screens/search.dart';
import 'package:flutterfirebase/ui/screens/shoppingcart.dart';
import 'package:flutterfirebase/ui/screens/usersettings.dart';
// import 'package:flutterfirebase/ui/screens/whell.dart';
// import 'package:flutterfirebase/ui/utils/constant.dart';
import 'package:flutterfirebase/ui/widgets/bannerWidget.dart';
// import 'package:flutterfirebase/ui/widgets/favorite_compare_widget.dart';
import 'package:flutterfirebase/ui/widgets/item_product.dart';
import 'package:flutterfirebase/ui/widgets/leftDrawer.dart';
import 'package:flutterfirebase/ui/widgets/compareCard.dart';
// import 'package:flutterfirebase/ui/utils/navigator.dart';
// import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirebase/widgets/compareAdvantages.dart';
import 'package:provider/provider.dart';
// import 'checkout.dart';
import 'products_list.dart';
import 'usersettings.dart';
// import 'dart:async';
import 'package:flutterfirebase/ui/screens/favorite_compares.dart';
import 'package:delayed_display/delayed_display.dart';

class Home extends StatefulWidget {
  final String uid;
  Home({this.uid});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  GlobalKey key = new GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void fetchData() {
    Firestore.instance
        .collection("mobiles")
        .snapshots()
        .listen((querySnapshot) {
      AppData.mobilesList = querySnapshot.documents;
      print(AppData.mobilesList.length);
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    fetchData();
    // print('favorite in home:${AppData.favoriteMobiles.length}');
    // DatabaseService().giveScore();
    super.initState();
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    // final userData = Provider.of<UserData>(context);
    // print('total mobiles: ${AppData.mobilesList.length}');
    print('previous list: ${AppData.previousComparisonsList.length}');
    if (AppData.compareList.length == 0) {
      final comparisonProvider = context.watch<ComparisonProvider>();
      if (comparisonProvider.compareList.length != 0) {
        comparisonProvider.clearCompareList();
      }
    }
    return StreamProvider<UserData>.value(
      value: DatabaseService(uid: AppData.activeUserId).getUserData,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          drawer: Drawer(child: leftDrawerMenu()),
          appBar: buildAppBar(context),
          bottomNavigationBar: new TabBar(
            tabs: [
              Tab(
                icon: new Icon(Icons.home),
              ),
              Tab(
                icon: new Icon(Icons.search),
              ),
              Tab(
                child: StreamProvider<QuerySnapshot>.value(
                  value: allFavoriteCompareQuery(AppData.activeUserId),
                  child: Container(
                    child: ComparisonTab(),
                  ),
                ),
                // icon: new Icon(Icons.compare_arrows),
              ),
              Tab(
                icon: new Icon(Icons.account_circle),
              )
            ],
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.blueGrey,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(8.0),
            indicatorColor: Colors.red,
          ),
          body: TabBarView(
            children: [
              DelayedDisplay(
                delay: Duration(milliseconds: 500),
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CategoriesListView(
                          title: "YOUR TITLES",
                          categories: [
                            'menu.png',
                            'iphone_logo-2.png',
                            'samsung_logo.jpg',
                            'oppo_logo-2.png',
                            'telephone.png',
                            'telephone.png',
                            'telephone.png',
                            'telephone.png',
                            'telephone.png',
                            'telephone.png'
                          ],
                          categoryTitle: [
                            'All',
                            'Apple',
                            'Samsung',
                            'Oppo',
                            'Infinix',
                            'Realme',
                            'Tecno',
                            'Vivo',
                            'Huawei',
                            'Xiaomi'
                          ],
                        ),
                        StreamProvider<QuerySnapshot>.value(
                            value: banners, child: buildCarouselSlider()),
                        SizedBox(
                          height: 5.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Latest",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ProductList(
                                                  mobilesList:
                                                      AppData.mobilesList,
                                                  checkHomePage: true,
                                                )));
                                    // Navigator.push(
                                    //   context,
                                    //   PageTransition(
                                    //     type: PageTransitionType.fade,
                                    //     child: ProductList(
                                    //       mobilesList: AppData.mobilesList,
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  child: Text(
                                    "View All",
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.blue),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        buildLatest(),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Papular ",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    // print("Clicked");
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ProductList(
                                                  mobilesList:
                                                      AppData.mobilesList,
                                                  checkHomePage: true,
                                                )));
                                  },
                                  child: Text(
                                    "View All",
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.blue),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        buildPapular(),
                        // CompareMobile(),
                        // Occasions(),
                      ],
                    ),
                  ),
                ),
              ),
              // PageSearch(),
              DelayedDisplay(
                delay: Duration(milliseconds: 300),
                child: ProductList(
                  mobilesList: AppData.mobilesList,
                  checkHomePage: false,
                ),
              ),
              DelayedDisplay(
                  delay: Duration(milliseconds: 300),
                  child: FavoriteComparesList(
                    checkHomePage: false,
                  )),
              DelayedDisplay(
                  delay: Duration(milliseconds: 300), child: ProfilePage()),
            ],
          ),
        ),
      ),
    );
  }

  Column buildLatest() {
    return Column(
      children: <Widget>[
        Container(
          height: 242,
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection('mobiles')
                  .orderBy('released_date', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text('no data');
                }
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      DocumentSnapshot mobile = snapshot.data.documents[index];
                      return TrendingItem(
                        product: Product(
                            company: mobile['brand'],
                            name: mobile['product_name'],
                            productId: mobile.documentID,
                            icon: mobile['product_image'],
                            rating: 3.5,
                            remainingQuantity: 5,
                            price: 'Rs ${mobile['price']}',
                            mobile: mobile),
                        gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
                      );
                    });
              }),
        )
      ],
    );
  }

  Column buildPapular() {
    return Column(
      children: <Widget>[
        Container(
          height: 242,
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection('mobiles')
                  .orderBy('released_date', descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text('no data');
                }
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      DocumentSnapshot mobile = snapshot.data.documents[index];
                      return TrendingItem(
                        product: Product(
                            company: mobile['brand'],
                            name: mobile['product_name'],
                            productId: mobile.documentID,
                            icon: mobile['product_image'],
                            rating: 3.5,
                            remainingQuantity: 5,
                            price: 'Rs ${mobile['price']}',
                            mobile: mobile),
                        gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
                      );
                    });
              }),
        )
      ],
    );
  }

  // CarouselSlider buildCarouselSlider() {
  //   return CarouselSlider(
  //     height: 150,
  //     viewportFraction: 0.9,
  //     aspectRatio: 16 / 9,
  //     autoPlay: true,
  //     enlargeCenterPage: true,
  //     items: StreamBuilder()
  //   );
  // }

  BottomNavyBar buildBottomNavyBar(BuildContext context) {
    return BottomNavyBar(
      selectedIndex: currentIndex,
      showElevation: true,
      onItemSelected: (index) => setState(() {
        currentIndex = index;
      }),
      items: [
        BottomNavyBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
          activeColor: Theme.of(context).primaryColor,
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Categories'),
            activeColor: Theme.of(context).primaryColor),
        BottomNavyBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Shopping Cart'),
            activeColor: Theme.of(context).primaryColor),
        BottomNavyBarItem(
            icon: Icon(Icons.shopping_basket),
            title: Text('Orders'),
            activeColor: Theme.of(context).primaryColor),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    final comparisonProvider = context.watch<ComparisonProvider>();

    return AppBar(
      title: Text(
        "MobHub",
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
      leading: new IconButton(
          icon: new Icon(MaterialCommunityIcons.getIconData("menu"),
              color: Colors.black),
          onPressed: () => _scaffoldKey.currentState.openDrawer()),
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            if (AppData.compareList.length >= 2) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Comparison(
                        compareList: AppData.compareList,
                      )));
            } else {
              // infoToast("Select minimam two mobiles");
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Select minimam two mobiles',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      content: Text(''),
                    );
                  });
            }
          },
          child: Container(
            width: 35,
            margin: EdgeInsets.only(top: 15),
            child: Stack(
              // overflow: Overflow.visible,
              children: <Widget>[
                Icon(
                  Icons.compare_arrows,
                  color: Colors.black,
                  key: key,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      // Icon(
                      //   Icons.favorite,
                      //   color: Colors.red,
                      //   size: 20,
                      // ),
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      Text(comparisonProvider.compareList.length.toString(),
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),

        Text(' '),
        // IconButton(
        //   icon: Icon(
        //     // MaterialCommunityIcons.getIconData("cart-outline"),
        //     Icons.compare_arrows,
        //   ),
        //   color: Colors.black,
        //   onPressed: () {
        //     Navigator.of(context).push(MaterialPageRoute(
        //         builder: (context) => Comparison(
        //               compareList: AppData.compareList,
        //             )));

        //   },
        // ),
      ],
      backgroundColor: Colors.white,
    );
  }

  buildViewCard(
      DocumentSnapshot mobile, String name, String price, String image) {
    return Container(
//      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey[200], blurRadius: 1, spreadRadius: 1)
          ]),
      width: (MediaQuery.of(context).size.width - 20) / 3,
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductDetails(mobile: mobile))),
            child: Container(
              height: 140,
              width: 70,
              child: Image.network(image),
            ),
          ),

          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductDetails(mobile: mobile)));
            },
            // onTap: () => Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => ProductDetails(mobile: mobile))),
            child: Text(
              name,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'NeusaNextPro',
                fontSize: 14,
              ),
            ),
          ),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Text(
//                price,
//                style: TextStyle(
//                  fontFamily: 'NeusaNextPro',
//                  fontWeight: FontWeight.w600,
//                  color: Color(0xFF515C6F),
//                ),
//              ),
//              Container(
//                  decoration: BoxDecoration(
//                    color: Color(0xFFFF6969),
//                    borderRadius: BorderRadius.circular(100),
//                  ),
//                  padding: EdgeInsets.only(top: 4, bottom: 4, left: 5),
//                  child: Row(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Text('Compare',
//                          style: TextStyle(
//                              fontFamily: 'NeusaNextPro', color: Colors.white)),
//                    ],
//                  )),
//            ],
//          )
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Rs ',
                  style: TextStyle(
//                color: Color(0xFF727C8E),
                    fontFamily: 'NeusaNextPro',
//                fontWeight: FontWeight.bold,
                  )),
              Text(
                price,
                style: TextStyle(
//                color: Color(0xFF727C8E),
                  fontFamily: 'NeusaNextPro',
//                fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              print("total compare ${AppData.compareList.length.toString()}");
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    if (AppData.compareList.length <= 4) {
                      AppData.compareList.add(mobile);
                      return AlertDialog(
                        title: Row(
                          children: <Widget>[
                            Text('Mobiles in Compare list '),
                            Text(AppData.compareList.length.toString()),
                          ],
                        ),
                        content: FlatButton(
                          onPressed: () async {
                            List<DocumentSnapshot> list = AppData.compareList;
                            AppData.compareList.clear();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Comparison(
                                  compareList: list,
                                ),
                              ),
                            );
                          },
                          child: Text('Compare Now'),
                          color: Colors.green,
                        ),
                      );
                    } else {
                      return AlertDialog(
                        title: Row(
                          children: <Widget>[
                            Text('you Compare more then 4 mobiles '),
                          ],
                        ),
                        content: FlatButton(
                          onPressed: () {
                            // List<DocumentSnapshot> list = AppData.compareList;

                            Navigator.of(context).pop();
                          },
                          child: Text('Go back'),
                          color: Colors.green,
                        ),
                      );
                    }
                  });
            },
            child: Container(
              height: 30,
              width: 70,
              decoration: BoxDecoration(
                color: Color(0xFFFF6969),
                borderRadius: BorderRadius.circular(100),
              ),
              padding: EdgeInsets.only(top: 4, bottom: 4, left: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Compare',
                    style: TextStyle(
                      fontFamily: 'NeusaNextPro',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoriesListView extends StatelessWidget {
  final String title;
  final List<String> categories;
  final List<String> categoryTitle;
  CategoriesListView(
      {Key key,
      @required this.title,
      @required this.categories,
      @required this.categoryTitle})
      : super(key: key);
  QuerySnapshot document;
  List<DocumentSnapshot> doc;

  @override
  Widget build(BuildContext context) {
    print(categoryTitle[1]);

    return CustomPaint(
      painter: LinePainter(),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 12),
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () async {
                    if (categoryTitle[index] == 'All') {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductList(
                                mobilesList: AppData.mobilesList,
                                checkHomePage: true,
                              )));
                    } else {
                      document = await SearchService()
                          .searchBrand(categoryTitle[index]);
                      doc = document.documents;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductList(
                                mobilesList: doc,
                                checkHomePage: true,
                              )));
                    }
                    // Navigator.push(
                    //   context,
                    //   PageTransition(
                    //     type: PageTransitionType.fade,
                    //     child: ProductList(
                    //       mobilesList: AppData.mobilesList,
                    //     ),
                    //   ),
                    // );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: 55,
                          height: 55,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.blueGrey,
                              width: 1,
                            ),
                          ),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/" + categories[index],
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            categoryTitle[index],
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Regular',
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

//---------------favorite mobiles

class AllFavoritesWidget extends StatefulWidget {
  @override
  _AllFavoritesWidgetState createState() => _AllFavoritesWidgetState();
}

class _AllFavoritesWidgetState extends State<AllFavoritesWidget> {
  @override
  Widget build(BuildContext context) {
    final queryFavorites = Provider.of<QuerySnapshot>(context);

    print('total favorites: ${AppData.favoriteMobiles.length}');
    return ListTile(
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xFFFB7C7A),
        ),
        child: TotalFavoritesWidget(),
      ),
      // Icon(
      //   Ionicons.getIconData('ios-radio-button-on'),
      //   color: Color(0xFFFB7C7A),
      //   size: 18,
      // ),
      leading: Icon(Icons.favorite_border, color: Colors.black54),
      title: Text('Favorite Mobiles',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black54)),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FavoriteList(
                  mobilesList: queryFavorites.documents,
                )));
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.fade,
        //     child: FavoriteList(
        //       mobilesList: AppData.favoriteMobiles,
        //     ),
        //   ),
        // );
      },
    );
  }
}

class TotalFavoritesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<QuerySnapshot>(context);
    return Text(
      favorites.documents.length.toString() ?? "0",
      style: TextStyle(
          color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
    );
  }
}

// compare tab item
class ComparisonTab extends StatefulWidget {
  @override
  _ComparisonTabState createState() => _ComparisonTabState();
}

class _ComparisonTabState extends State<ComparisonTab> {
  @override
  Widget build(BuildContext context) {
    final queryFavorites = Provider.of<QuerySnapshot>(context);

    return Container(
      width: 40,
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Icon(Icons.compare_arrows),
          Positioned(
            top: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 20,
                ),
                TotalFavoriteComparesWidget()
              ],
            ),
            // child: Container(
            //   padding: EdgeInsets.symmetric(horizontal: 5),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(5),
            //     color: Color(0xFFFB7C7A),
            //   ),
            //   child: TotalFavoriteComparesWidget(),
            // ),
          )
        ],
      ),
    );
  }
}

//--------end compare tab item
//---------------all favorite compares
class AllFavoriteComparesWidget extends StatefulWidget {
  @override
  _AllFavoriteComparesWidgetState createState() =>
      _AllFavoriteComparesWidgetState();
}

class _AllFavoriteComparesWidgetState extends State<AllFavoriteComparesWidget> {
  @override
  Widget build(BuildContext context) {
    final queryFavorites = Provider.of<QuerySnapshot>(context);

    print('total favorites: ${AppData.favoriteMobiles.length}');
    return ListTile(
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xFFFB7C7A),
        ),
        child: TotalFavoriteComparesWidget(),
      ),
      leading: Icon(Icons.favorite_border, color: Colors.black54),
      title: Text('Favorite Compares',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black54)),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FavoriteComparesList(
                  compareList: queryFavorites.documents,
                  checkHomePage: true,
                )));
      },
    );
  }
}

class TotalFavoriteComparesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<QuerySnapshot>(context);
    return Text(
      favorites.documents.length.toString() ?? "0",
      style: TextStyle(
          color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
    );
  }
}
