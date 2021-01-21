import 'dart:collection';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_icons/ionicons.dart';
import 'package:flutter_icons/material_community_icons.dart';
import 'package:flutterfirebase/ProductDetails.dart';
import 'package:flutterfirebase/modal/data.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // setState(() {
    //   AppData.filterMobiles = mobilesList;
    // });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Future.delayed(Duration(seconds: 5))
        .then((value) => AppData.filterMobiles.clear());
    print("length in product page: ${mobilesList.length}");
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 5),
          child: GFSearchBar(
            searchBoxInputDecoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 30),
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
        // title: Text(
        //   "MobHub",
        //   style: TextStyle(color: Colors.black, fontSize: 16),
        // ),
        leading: IconButton(
          icon:
              Icon(Ionicons.getIconData("ios-arrow-back"), color: Colors.black),
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Home())),
        ),
        actions: <Widget>[
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
          //         Navigator.push(
          //           context,
          //           PageTransition(
          //             type: PageTransitionType.fade,
          //             child: ProductList(),
          //           ),
          //         );
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
        color: Colors.blueGrey,
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
          padding: EdgeInsets.only(top: 18),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                buildTrending(),
              ],
            ),
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
                    itemCount: mobilesList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      DocumentSnapshot mobile = mobilesList?.elementAt(index);
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
                        gradientColors: [Color(0XFFa466ec), Colors.purple[400]],
                      );
                    });
              }),
        )
      ],
    );
  }
}
