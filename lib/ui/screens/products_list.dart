import 'dart:collection';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_icons/ionicons.dart';
import 'package:flutter_icons/material_community_icons.dart';
import 'package:flutterfirebase/ProductDetails.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/pages/comparison.dart';
import 'package:flutterfirebase/provider/comparisonProvider.dart';
import 'package:flutterfirebase/ui/models/product.dart';
import 'package:flutterfirebase/ui/screens/home.dart';
import 'package:flutterfirebase/ui/widgets/filter.dart';
import 'package:flutterfirebase/ui/widgets/item_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterfirebase/ui/widgets/product_card.dart';
import 'package:getflutter/components/search_bar/gf_search_bar.dart';
// import 'package:page_transition/page_transition.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  List<DocumentSnapshot> mobilesList;

  ProductList({this.mobilesList});

  @override
  _ProductListState createState() => _ProductListState(mobilesList);
}

class _ProductListState extends State<ProductList> {
  List<DocumentSnapshot> mobilesList;
  _ProductListState(this.mobilesList);
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  PanelController slidingUpController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> widgetList = [
    'A',
    'B',
    'C',
    'A',
    'B',
    'C',
    'A',
    'B',
    'C',
    'A',
    'B',
    'C',
    'A',
    'B',
    'C'
  ];
  GlobalKey key = new GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // setState(() {
    //   AppData.filterMobiles = mobilesList;
    // });
    // final comparisonProvider = context.watch<ComparisonProvider>();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final comparisonProvider = context.watch<ComparisonProvider>();
    // if (AppData.compareList.length == 0) {
    //   comparisonProvider.clearCompareList();
    // }
    // Future.delayed(Duration(seconds: 5))
    //     .then((value) => AppData.filterMobiles.clear());
    print("length in product page: ${mobilesList.length}");
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        title: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 5),
              child: GFSearchBar(
                searchBoxInputDecoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(top: 0, bottom: 0, right: 30),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      ),
                    ),
                    fillColor: Color(0x20727C8E),
                    filled: true,
                    prefixIcon: Icon(Icons.search, color: Color(0x40515C6F)),
                    hintStyle: TextStyle(
                        color: Color(0x40515C6F), fontFamily: 'NeusaNextPro'),
                    hintText: "Search Mobiles"),
                searchList: mobilesList,
                searchQueryBuilder: (query, list) {
                  return list
                      .where((item) => item['product_name']
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                },
                noItemsFoundWidget: Text('No record found s'),
                hideSearchBoxWhenItemSelected: false,
                overlaySearchListItemBuilder: (item) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      item['product_name'],
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                },
                onItemSelected: (item) {
                  if (item != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductDetails(mobile: item)));
                  }
                },
              ),
            ),
          ],
          overflow: Overflow.visible,
          fit: StackFit.loose,
        ),
        // title: Text(
        //   "MobHub",
        //   style: TextStyle(color: Colors.black, fontSize: 16),
        // ),
        leading: IconButton(
          icon:
              Icon(Ionicons.getIconData("ios-arrow-back"), color: Colors.black),
          onPressed: () {
            AppData.brands.clear();
            AppData.rams.clear();
            AppData.battries.clear();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Home()));
          },
        ),
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
          AppData.brands.isNotEmpty ||
                  AppData.rams.isNotEmpty ||
                  AppData.battries.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 20,
                  ),
                  onPressed: () {
                    AppData.brands.clear();
                    AppData.rams.clear();
                    AppData.battries.clear();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductList(
                              mobilesList: AppData.mobilesList,
                            )));
                  },
                )
              : Text(''),
          // Stack(
          //   children: <Widget>[Positioned(top: 30, child: Text('filter'))],
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 24.0),
          //   child: SizedBox(
          //     height: 18.0,
          //     width: 18.0,
          //     child: IconButton(
          //       icon: Icon(
          //         // MaterialCommunityIcons.getIconData("cart-outline"),
          //         Icons.notifications,
          //       ),
          //       color: Colors.black,
          //       onPressed: () {
          //         // Navigator.push(
          //         //   context,
          //         //   PageTransition(
          //         //     type: PageTransitionType.fade,
          //         //     child: ProductList(),
          //         //   ),
          //         // );
          //       },
          //     ),
          //   ),
          // ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SlidingUpPanel(
        controller: slidingUpController,
        minHeight: 42,
        maxHeight: MediaQuery.of(context).size.height / 1,
        color: Colors.blueAccent,
        panel: Filtre(),
        collapsed: Container(
          decoration:
              BoxDecoration(color: Colors.blueGrey, borderRadius: radius),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              Text(
                "Filter",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        borderRadius: radius,
        body: Container(
          // padding: EdgeInsets.only(top: 18),
          // color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              AppData.brands.isNotEmpty ||
                      AppData.rams.isNotEmpty ||
                      AppData.battries.isNotEmpty
                  ? Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Container(
                          color: Color(0xFFFF6969),
                          height: 35,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: ListView(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: <Widget>[
                              AppData.brands.isNotEmpty
                                  ? Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            'Brand:',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: List.generate(
                                                AppData.brands.length, (index) {
                                              return Container(
                                                margin:
                                                    EdgeInsets.only(left: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.amberAccent),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5, vertical: 3),
                                                // height: 20,
                                                child: Center(
                                                  child: Text(
                                                    AppData.brands[index],
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Text(''), //end brands filters
                              AppData.rams.isNotEmpty
                                  ? Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            'Ram: ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: List.generate(
                                                AppData.rams.length, (index) {
                                              return Container(
                                                margin:
                                                    EdgeInsets.only(left: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.amberAccent),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5, vertical: 3),
                                                // height: 20,
                                                child: Center(
                                                  child: Text(
                                                    AppData.rams[index],
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Text(''),
                              AppData.battries.isNotEmpty
                                  ? Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            'Battery: ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: List.generate(
                                                AppData.battries.length,
                                                (index) {
                                              return Container(
                                                margin:
                                                    EdgeInsets.only(left: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.amberAccent),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5, vertical: 3),
                                                // height: 20,
                                                child: Center(
                                                  child: Text(
                                                    AppData.battries[index]
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Text(''),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Text(''),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    buildTrending(),
                  ],
                ),
              ),
            ],
          ),
          // child: StreamBuilder(
          //     stream: Firestore.instance.collection('mobiles').snapshots(),
          //     builder: (BuildContext context,
          //         AsyncSnapshot<QuerySnapshot> snapshot) {
          //       return GridView.count(
          //         crossAxisCount: 2,
          //         childAspectRatio: (itemWidth / itemHeight) * 1.1,
          //         controller: ScrollController(keepScrollOffset: false),
          //         shrinkWrap: true,
          //         scrollDirection: Axis.vertical,
          //         children:
          //             List.generate(snapshot.data.documents.length, (index) {
          //           DocumentSnapshot mobile = snapshot.data.documents[index];
          //           return Center(
          //             child: TrendingItem(
          //               product: Product(
          //                   company: mobile['brand'],
          //                   name: mobile['product_name'],
          //                   icon: mobile['product_image'],
          //                   rating: 4.5,
          //                   remainingQuantity: 5,
          //                   price: 'Rs ${mobile['price']}',
          //                   mobile: mobile),
          //               gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
          //             ),
          //           );
          //         }),
          //       );
          //     }),
        ),
      ),
    );
  }

  Column buildTrending() {
    // print('favorite in list:${AppData.favoriteMobiles.length}');

    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder(
              stream: Firestore.instance.collection('mobiles').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text('no data');
                }
                return ListView.builder(
                    itemCount: AppData.brands.isNotEmpty ||
                            AppData.rams.isNotEmpty ||
                            AppData.battries.isNotEmpty
                        ? snapshot.data.documents.length
                        : mobilesList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      DocumentSnapshot mobile = AppData.brands.isNotEmpty ||
                              AppData.rams.isNotEmpty ||
                              AppData.battries.isNotEmpty
                          ? snapshot.data.documents?.elementAt(index)
                          : mobilesList?.elementAt(index);
                      if (AppData.brands.isNotEmpty ||
                          AppData.rams.isNotEmpty ||
                          AppData.battries.isNotEmpty) {
                        //check brands, batties, rams length
                        if ((AppData.brands.isNotEmpty &&
                                AppData.brands.contains(mobile['brand'])) &&
                            (mobile['price'] >= AppData.minPrice &&
                                mobile['price'] <= AppData.maxPrice) &&
                            (AppData.rams.isEmpty) &&
                            (AppData.battries.isEmpty)) {
                          //brand filter
                          return ProductCard(
                            product: Product(
                              company: mobile['brand'] ?? "",
                              name: mobile['product_name'] ?? "",
                              icon: mobile['product_image'] ?? "",
                              rating: 4.5,
                              price: 'Rs ${mobile['price']}' ?? "",
                              mobile: mobile ?? "",
                            ),
                            gradientColors: [
                              Color(0XFFa466ec),
                              Colors.purple[400]
                            ],
                          );
                        } //end brand filter
                        if ((AppData.brands.isEmpty) &&
                            (mobile['price'] >= AppData.minPrice &&
                                mobile['price'] <= AppData.maxPrice) &&
                            (AppData.rams.isNotEmpty &&
                                AppData.rams.contains(mobile['ram'])) &&
                            (AppData.battries.isEmpty)) {
                          //check ram filter
                          return ProductCard(
                            product: Product(
                              company: mobile['brand'] ?? "",
                              name: mobile['product_name'] ?? "",
                              icon: mobile['product_image'] ?? "",
                              rating: 4.5,
                              price: 'Rs ${mobile['price']}' ?? "",
                              mobile: mobile ?? "",
                            ),
                            gradientColors: [
                              Color(0XFFa466ec),
                              Colors.purple[400]
                            ],
                          );
                        } //end rams filter
                        if ((AppData.brands.isEmpty) &&
                            (mobile['price'] >= AppData.minPrice &&
                                mobile['price'] <= AppData.maxPrice) &&
                            (AppData.rams.isEmpty) &&
                            (AppData.battries.isNotEmpty &&
                                AppData.battries
                                    .contains(mobile['battery_size']))) {
                          //check battery filter
                          return ProductCard(
                            product: Product(
                              company: mobile['brand'] ?? "",
                              name: mobile['product_name'] ?? "",
                              icon: mobile['product_image'] ?? "",
                              rating: 4.5,
                              price: 'Rs ${mobile['price']}' ?? "",
                              mobile: mobile ?? "",
                            ),
                            gradientColors: [
                              Color(0XFFa466ec),
                              Colors.purple[400]
                            ],
                          );
                        } //end battery filter
                        if ((AppData.brands.isEmpty) &&
                            (mobile['price'] >= AppData.minPrice &&
                                mobile['price'] <= AppData.maxPrice) &&
                            (AppData.rams.isNotEmpty &&
                                AppData.rams.contains(mobile['ram'])) &&
                            (AppData.battries.isNotEmpty &&
                                AppData.battries
                                    .contains(mobile['battery_size']))) {
                          //check battery and ram filter
                          return ProductCard(
                            product: Product(
                              company: mobile['brand'] ?? "",
                              name: mobile['product_name'] ?? "",
                              icon: mobile['product_image'] ?? "",
                              rating: 4.5,
                              price: 'Rs ${mobile['price']}' ?? "",
                              mobile: mobile ?? "",
                            ),
                            gradientColors: [
                              Color(0XFFa466ec),
                              Colors.purple[400]
                            ],
                          );
                        } //end battery and ram filter
                        if ((AppData.brands.isNotEmpty &&
                                AppData.brands.contains(mobile['brand'])) &&
                            (mobile['price'] >= AppData.minPrice &&
                                mobile['price'] <= AppData.maxPrice) &&
                            (AppData.rams.isEmpty) &&
                            (AppData.battries.isNotEmpty &&
                                AppData.battries
                                    .contains(mobile['battery_size']))) {
                          //check battery and brand filter
                          return ProductCard(
                            product: Product(
                              company: mobile['brand'] ?? "",
                              name: mobile['product_name'] ?? "",
                              icon: mobile['product_image'] ?? "",
                              rating: 4.5,
                              price: 'Rs ${mobile['price']}' ?? "",
                              mobile: mobile ?? "",
                            ),
                            gradientColors: [
                              Color(0XFFa466ec),
                              Colors.purple[400]
                            ],
                          );
                        } //end battery and brand filter
                        if ((AppData.brands.isNotEmpty &&
                                AppData.brands.contains(mobile['brand'])) &&
                            (mobile['price'] >= AppData.minPrice &&
                                mobile['price'] <= AppData.maxPrice) &&
                            (AppData.rams.isNotEmpty &&
                                AppData.rams.contains(mobile['ram'])) &&
                            (AppData.battries.isNotEmpty &&
                                AppData.battries
                                    .contains(mobile['battery_size']))) {
                          //check brand, brand and battery filter
                          return ProductCard(
                            product: Product(
                              company: mobile['brand'] ?? "",
                              name: mobile['product_name'] ?? "",
                              icon: mobile['product_image'] ?? "",
                              rating: 4.5,
                              price: 'Rs ${mobile['price']}' ?? "",
                              mobile: mobile ?? "",
                            ),
                            gradientColors: [
                              Color(0XFFa466ec),
                              Colors.purple[400]
                            ],
                          );
                        } //end brand, ram and battery filter
                        if ((AppData.brands.isNotEmpty &&
                                AppData.brands.contains(mobile['brand'])) &&
                            (AppData.rams.isNotEmpty &&
                                AppData.rams.contains(mobile['ram'])) &&
                            (mobile['price'] >= AppData.minPrice &&
                                mobile['price'] <= AppData.maxPrice)) {
                          //check brand and rams
                          return ProductCard(
                            product: Product(
                              company: mobile['brand'] ?? "",
                              name: mobile['product_name'] ?? "",
                              icon: mobile['product_image'] ?? "",
                              rating: 4.5,
                              price: 'Rs ${mobile['price']}' ?? "",
                              mobile: mobile ?? "",
                            ),
                            gradientColors: [
                              Color(0XFFa466ec),
                              Colors.purple[400]
                            ],
                          );
                        } else {
                          return SizedBox(
                            height: 1,
                          );
                        } //end brand, ram filter
                      } else {
                        return ProductCard(
                          product: Product(
                            company: mobile['brand'] ?? "",
                            name: mobile['product_name'] ?? "",
                            icon: mobile['product_image'] ?? "",
                            rating: 4.5,
                            remainingQuantity: 5,
                            price: 'Rs ${mobile['price']}' ?? "",
                            mobile: mobile ?? "",
                          ),
                          gradientColors: [
                            Color(0XFFa466ec),
                            Colors.purple[400]
                          ],
                        );
                      }
                      // return AppData.rams.isNotEmpty &&
                      //         AppData.rams.contains(mobile['ram'])
                      //     // ? AppData.minPrice >= mobile['price'] &&
                      //     //         AppData.maxPrice <= mobile['price']
                      // return ProductCard(
                      //   product: Product(
                      //     company: mobile['brand'] ?? "",
                      //     name: mobile['product_name'] ?? "",
                      //     icon: mobile['product_image'] ?? "",
                      //     rating: 4.5,
                      //     remainingQuantity: 5,
                      //     price: 'Rs ${mobile['price']}' ?? "",
                      //     mobile: mobile ?? "",
                      //   ),
                      //   gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
                      // );

                      // : SizedBox(
                      //     height: 1,
                      //   )
                      // : SizedBox(
                      //     height: 1,
                      //   )
                      // : SizedBox(
                      //     height: 1,
                      //   );
                    });
              }),
        )
      ],
    );
  }
}
