import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutterfirebase/ProductDetails.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/pages/comparison.dart';
import 'package:flutterfirebase/ui/models/product.dart';
import 'package:flutterfirebase/ui/painters/circlepainters.dart';
import 'package:flutterfirebase/ui/screens/products_list.dart';
import 'package:flutterfirebase/ui/screens/search.dart';
import 'package:flutterfirebase/ui/screens/shoppingcart.dart';
import 'package:flutterfirebase/ui/screens/usersettings.dart';
import 'package:flutterfirebase/ui/screens/whell.dart';
import 'package:flutterfirebase/ui/utils/constant.dart';
import 'package:flutterfirebase/ui/widgets/item_product.dart';
import 'package:flutterfirebase/ui/widgets/occasions.dart';
import 'package:flutterfirebase/ui/utils/navigator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'checkout.dart';
import 'products_list.dart';
import 'usersettings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

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
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
              icon: new Icon(Icons.shopping_cart),
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
            Container(
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
                        'telephone.png'
                      ],
                      categoryTitle: [
                        'All',
                        'Iphone',
                        'Samsung',
                        'Oppo',
                        'Infinix',
                        'Real Me',
                        'TechNo',
                        'Vivo'
                      ],
                    ),
                    buildCarouselSlider(),
                    SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Popular Trendings",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: ProductList(),
                                  ),
                                );
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
                    buildTrending(),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Best Selling",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                print("Clicked");
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
                    buildTrending(),
                    Occasions(),
                    Occasions(),
                  ],
                ),
              ),
            ),
            WhellFortune(),
            ShoppingCart(false),
            UserSettings(),
          ],
        ),
      ),
    );
  }

  Column buildTrending() {
    return Column(
      children: <Widget>[
        Container(
          height: 242,
          child: StreamBuilder(
              stream: Firestore.instance.collection('mobiles').snapshots(),
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
                            icon: mobile['product_image'],
                            rating: 4.5,
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

  CarouselSlider buildCarouselSlider() {
    return CarouselSlider(
      height: 150,
      viewportFraction: 0.9,
      aspectRatio: 16 / 9,
      autoPlay: true,
      enlargeCenterPage: true,
      items: imgList.map(
        (url) {
          return Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    width: 1000.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Sunny Getaways",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                            "Lorem Ipsım Dolar Lorem Ipsım Dolar Lorem Ipsım Dolar",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ).toList(),
    );
  }

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
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: Search(),
              ),
            );
          },
          child: Icon(
            MaterialCommunityIcons.getIconData("magnify"),
            color: Colors.black,
          ),
        ),
        IconButton(
          icon: Icon(
            // MaterialCommunityIcons.getIconData("cart-outline"),
            Icons.notifications,
          ),
          color: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: ShoppingCart(true),
              ),
            );
          },
        ),
      ],
      backgroundColor: Colors.white,
    );
  }

  leftDrawerMenu() {
    Color blackColor = Colors.black.withOpacity(0.6);
    return Container(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            height: 150,
            child: DrawerHeader(
              child: ListTile(
                trailing: Icon(
                  Icons.chevron_right,
                  size: 28,
                ),
                subtitle: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: UserSettings(),
                      ),
                    );
                  },
                  child: Text(
                    "See Profile",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: blackColor),
                  ),
                ),
                title: Text(
                  "Ali Anıl Koçak",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: blackColor),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://miro.medium.com/fit/c/256/256/1*mZ3xXbns5BiBFxrdEwloKg.jpeg"),
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFFF8FAFB),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Feather.getIconData('home'),
              color: blackColor,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: blackColor),
            ),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: Home(),
                ),
              );
            },
          ),
          ListTile(
            trailing: Icon(
              Ionicons.getIconData('ios-radio-button-on'),
              color: Color(0xFFFB7C7A),
              size: 18,
            ),
            leading: Icon(Feather.getIconData('gift'), color: blackColor),
            title: Text('Wheel Spin(Free)',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: WhellFortune(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Feather.getIconData('search'), color: blackColor),
            title: Text('Search',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: Search(),
                ),
              );
            },
          ),
          ListTile(
            trailing: Icon(
              Ionicons.getIconData('ios-radio-button-on'),
              color: Color(0xFFFB7C7A),
              size: 18,
            ),
            leading: Icon(Feather.getIconData('bell'), color: blackColor),
            title: Text('Notifications',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
              Nav.route(context, Checkout());
            },
          ),
          ListTile(
            trailing: Icon(
              Icons.looks_two,
              color: Color(0xFFFB7C7A),
              size: 18,
            ),
            leading:
                Icon(Feather.getIconData('shopping-cart'), color: blackColor),
            title: Text('Shopping Cart',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: ShoppingCart(true),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Feather.getIconData('list'), color: blackColor),
            title: Text('My Orders',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
              Nav.route(context, ProductList());
            },
          ),
          ListTile(
            leading: Icon(Feather.getIconData('award'), color: blackColor),
            title: Text('Points',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
              Nav.route(context, Checkout());
            },
          ),
          ListTile(
            leading:
                Icon(Feather.getIconData('message-circle'), color: blackColor),
            title: Text('Support',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
              Nav.route(context, ProductList());
            },
          ),
          ListTile(
            leading:
                Icon(Feather.getIconData('help-circle'), color: blackColor),
            title: Text('Help',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
              Nav.route(context, UserSettings());
            },
          ),
          ListTile(
            leading: Icon(Feather.getIconData('settings'), color: blackColor),
            title: Text('Settings',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: UserSettings(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Feather.getIconData('x-circle'), color: blackColor),
            title: Text('Quit',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          ),
        ],
      ),
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
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    AppData.compareList.add(mobile);
                    return AlertDialog(
                      title: Row(
                        children: <Widget>[
                          Text('Mobiles in Compare list '),
                          Text(AppData.compareList.length.toString()),
                        ],
                      ),
                      content: FlatButton(
                        onPressed: () {
                          List<DocumentSnapshot> list = AppData.compareList;

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Comparison(
                                    compareList: list,
                                  )));
                          // AppData.compareList.clear();
                        },
                        child: Text('Compare Now'),
                        color: Colors.green,
                      ),
                    );
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

  const CategoriesListView(
      {Key key,
      @required this.title,
      @required this.categories,
      @required this.categoryTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: ProductList(),
                      ),
                    );
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
