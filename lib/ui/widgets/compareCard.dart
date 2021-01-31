import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutterfirebase/pages/comparison.dart';
import 'package:flutterfirebase/services/favorite_services.dart';
import 'package:flutterfirebase/ui/utils/navigator.dart';
import 'package:flutterfirebase/ui/widgets/favorite_compare_widget.dart';
import 'package:flutterfirebase/ui/widgets/item_product.dart';
import 'package:flutterfirebase/ui/widgets/star_rating.dart';
import 'package:flutterfirebase/ui/screens/product.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class CompareMobile extends StatefulWidget {
  final DocumentSnapshot mobilesCompare;
  CompareMobile({this.mobilesCompare});
  @override
  _CompareMobileState createState() => _CompareMobileState();
}

class _CompareMobileState extends State<CompareMobile> {
  List<DocumentSnapshot> compareList = [];
  List<String> mobileNamesList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mobileNamesList.add(widget.mobilesCompare['product_name1']);
    mobileNamesList.add(widget.mobilesCompare['product_name2']);
    if (["", null, false, 0].contains(widget.mobilesCompare['product_name3'])) {
      mobileNamesList.add(widget.mobilesCompare['product_name3']);
    }
    if (["", null, false, 0].contains(widget.mobilesCompare['product_name4'])) {
      mobileNamesList.add(widget.mobilesCompare['product_name4']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Comparison(
                  compareList: compareList,
                )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 295,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     Text(
                //       "Popular Comparison",
                //       style: TextStyle(
                //           fontSize: 18.0, fontWeight: FontWeight.w600),
                //       textAlign: TextAlign.start,
                //     ),
                //     Icon(
                //       SimpleLineIcons.getIconData("screen-smartphone"),
                //       color: Colors.black54,
                //     )
                //   ],
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 6.0),
                //   child: Divider(
                //     color: Colors.black12,
                //     height: 1,
                //   ),
                // ),
                // Text('check it'),
                // StreamBuilder(
                //     stream: Firestore.instance
                //         .collection('mobiles')
                //         .where('product_name', whereIn: [
                //       widget.mobilesCompare['product_name1'],
                //       widget.mobilesCompare['product_name2'],
                //       widget.mobilesCompare['product_name3']
                //     ]).snapshots(),
                //     builder: (context, snapshot) {
                //       if (!snapshot.hasData) {
                //         return Text('no data');
                //       }

                //       List<DocumentSnapshot> compareMobiles =
                //           snapshot.data.documents;
                //       Comparator<DocumentSnapshot> mobileNameSort = (a, b) => a
                //           .data['product_name']
                //           .compareTo(b.data['product_name']);
                //       compareMobiles.sort(mobileNameSort);
                //       return Container(
                //         height: 40,
                //         width: 40,
                //         child: Stack(
                //           alignment: Alignment.center,
                //           children: <Widget>[
                //             StreamProvider<QuerySnapshot>.value(
                //               value: favoriteCompare,
                //               child: DelayedDisplay(
                //                 delay: Duration(milliseconds: 200),
                //                 child: FavoriteCompareWidget(
                //                   compareList: compareMobiles,
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       );
                //     }),

                Container(
                  height: 237,
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: <Widget>[
                      StreamBuilder(
                          stream: Firestore.instance
                              .collection('mobiles')
                              .where('product_name',
                                  isEqualTo:
                                      widget.mobilesCompare['product_name1'])
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text('no data');
                            }
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.documents.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                DocumentSnapshot mobile =
                                    snapshot.data.documents[index];
                                compareList.add(mobile);
                                print('list builder');
                                return Container(
                                  margin: const EdgeInsets.only(right: 8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      TrendingItem(
                                        product: Product(
                                            company: mobile['brand'],
                                            name: mobile['product_name'],
                                            productId: mobile.documentID,
                                            icon: mobile['product_image'],
                                            rating: 4.5,
                                            remainingQuantity: 5,
                                            price: 'Rs ${mobile['price']}',
                                            mobile: mobile),
                                        gradientColors: [
                                          Color(0XFFa466ec),
                                          Colors.purple[400]
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }),
                      Center(
                        child: SizedBox(
                          width: 24,
                          child: Text(
                            'vs',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      StreamBuilder(
                          stream: Firestore.instance
                              .collection('mobiles')
                              .where('product_name',
                                  isEqualTo:
                                      widget.mobilesCompare['product_name2'])
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text('no data');
                            }
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.documents.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                DocumentSnapshot mobile =
                                    snapshot.data.documents[index];
                                compareList.add(mobile);

                                return Container(
                                  margin: const EdgeInsets.only(right: 8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      TrendingItem(
                                        product: Product(
                                            company: mobile['brand'],
                                            name: mobile['product_name'],
                                            productId: mobile.documentID,
                                            icon: mobile['product_image'],
                                            rating: 4.5,
                                            remainingQuantity: 5,
                                            price: 'Rs ${mobile['price']}',
                                            mobile: mobile),
                                        gradientColors: [
                                          Color(0XFFa466ec),
                                          Colors.purple[400]
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }),
                      ["", null, false, 0]
                              .contains(widget.mobilesCompare['product_name3'])
                          ? Text('')
                          : Row(
                              children: <Widget>[
                                Center(
                                  child: SizedBox(
                                    width: 24,
                                    child: Text(
                                      'vs',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                StreamBuilder(
                                    stream: Firestore.instance
                                        .collection('mobiles')
                                        .where('product_name',
                                            isEqualTo: widget.mobilesCompare[
                                                'product_name3'])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Text('no data');
                                      }
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            snapshot.data.documents.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot mobile =
                                              snapshot.data.documents[index];
                                          compareList.add(mobile);

                                          return Container(
                                            margin: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                TrendingItem(
                                                  product: Product(
                                                      company: mobile['brand'],
                                                      name: mobile[
                                                          'product_name'],
                                                      productId:
                                                          mobile.documentID,
                                                      icon: mobile[
                                                          'product_image'],
                                                      rating: 4.5,
                                                      remainingQuantity: 5,
                                                      price:
                                                          'Rs ${mobile['price']}',
                                                      mobile: mobile),
                                                  gradientColors: [
                                                    Color(0XFFa466ec),
                                                    Colors.purple[400]
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }),
                              ],
                            ),
                      ["", null, false, 0]
                              .contains(widget.mobilesCompare['product_name4'])
                          ? Text('')
                          : Row(
                              children: <Widget>[
                                Center(
                                  child: SizedBox(
                                    width: 24,
                                    child: Text(
                                      'vs',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                StreamBuilder(
                                    stream: Firestore.instance
                                        .collection('mobiles')
                                        .where('product_name',
                                            isEqualTo: widget.mobilesCompare[
                                                'product_name4'])
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Text('no data');
                                      }
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            snapshot.data.documents.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot mobile =
                                              snapshot.data.documents[index];
                                          compareList.add(mobile);

                                          return Container(
                                            margin: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                TrendingItem(
                                                  product: Product(
                                                      company: mobile['brand'],
                                                      name: mobile[
                                                          'product_name'],
                                                      productId:
                                                          mobile.documentID,
                                                      icon: mobile[
                                                          'product_image'],
                                                      rating: 4.5,
                                                      remainingQuantity: 5,
                                                      price:
                                                          'Rs ${mobile['price']}',
                                                      mobile: mobile),
                                                  gradientColors: [
                                                    Color(0XFFa466ec),
                                                    Colors.purple[400]
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }),
                              ],
                            )
                    ],
                  ),
                ),
              ],
            ),
            elevation: 5,
          ),
        ),
      ),
    );
  }
}
