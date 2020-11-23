import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/ionicons.dart';
import 'package:flutterfirebase/ProductDetails.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/pages/comparison.dart';
import 'package:flutterfirebase/ui/models/product.dart';
import 'package:flutterfirebase/ui/screens/product.dart';
import 'package:flutterfirebase/ui/widgets/star_rating.dart';

class TrendingItem extends StatelessWidget {
  final Product product;
  final List<Color> gradientColors;

  TrendingItem({this.product, this.gradientColors});

  @override
  Widget build(BuildContext context) {
    double trendCardWidth = 140;

    return GestureDetector(
      child: Stack(
        children: <Widget>[
          Container(
            width: trendCardWidth,
            child: Card(
              elevation: 4,
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Spacer(),
                        Icon(
                          Ionicons.getIconData("ios-heart-empty"),
                          color: Colors.black54,
                        )
                      ],
                    ),
                    _productImage(),
                    _productDetails(),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              AppData.compareList.add(product.mobile);
                              return AlertDialog(
                                title: Row(
                                  children: <Widget>[
                                    Text(
                                      'Mobiles in Compare list ',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(AppData.compareList.length.toString(),
                                        style: TextStyle(fontSize: 15)),
                                  ],
                                ),
                                content: FlatButton(
                                  onPressed: () {
                                    List<DocumentSnapshot> list =
                                        AppData.compareList;

                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetails(mobile: product.mobile),
          ),
        );
      },
    );
  }

  _productImage() {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            width: 100,
            height: 100,
            child: Image.network(product.icon, fit: BoxFit.contain),
            // decoration: BoxDecoration(
            //   // image: DecorationImage(
            //   //     image: AssetImage(product.icon), fit: BoxFit.contain),
            // ),
          ),
        )
      ],
    );
  }

  _productDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          product.company,
          style: TextStyle(fontSize: 12, color: Color(0XFFb1bdef)),
        ),
        Text(
          product.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        ),
        StarRating(rating: product.rating, size: 10),
        Row(
          children: <Widget>[
            Text(product.price,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
          ],
        )
      ],
    );
  }
}
