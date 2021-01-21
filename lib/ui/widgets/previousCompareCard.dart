import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutterfirebase/modal/comparisonMobileModal.dart';
import 'package:flutterfirebase/pages/comparison.dart';
import 'package:flutterfirebase/ui/utils/navigator.dart';
import 'package:flutterfirebase/ui/widgets/item_product.dart';
import 'package:flutterfirebase/ui/widgets/star_rating.dart';
import 'package:flutterfirebase/ui/screens/product.dart';

import '../models/product.dart';

class PreviousCompareCard extends StatefulWidget {
  final ComparisonMobileModal mobilesCompare;
  PreviousCompareCard({this.mobilesCompare});
  @override
  _CompareMobileState createState() => _CompareMobileState();
}

class _CompareMobileState extends State<PreviousCompareCard> {
  List<DocumentSnapshot> compareList = [];

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
        height: 270,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Container(
                  height: 230,
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: <Widget>[
                      StreamBuilder(
                          stream: Firestore.instance
                              .collection('mobiles')
                              .where('product_name',
                                  isEqualTo: widget.mobilesCompare.mobileName1)
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
                                  isEqualTo: widget.mobilesCompare.mobileName2)
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
                              .contains(widget.mobilesCompare.mobileName3)
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
                                            isEqualTo: widget
                                                .mobilesCompare.mobileName3)
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
                              .contains(widget.mobilesCompare.mobileName4)
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
                                            isEqualTo: widget
                                                .mobilesCompare.mobileName4)
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
                )
              ],
            ),
            elevation: 5,
          ),
        ),
      ),
    );
  }
}
