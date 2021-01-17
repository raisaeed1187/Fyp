import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutterfirebase/ui/utils/navigator.dart';
import 'package:flutterfirebase/ui/widgets/item_product.dart';
import 'package:flutterfirebase/ui/widgets/star_rating.dart';
import 'package:flutterfirebase/ui/screens/product.dart';

import '../models/product.dart';

class Occasions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Nav.route(
            context,
            ProductPage(
              product: Product(
                  company: 'Apple',
                  name: 'iPhone 7 plus (128GB)',
                  icon: 'assets/iphone_7.png',
                  rating: 4.5,
                  remainingQuantity: 5,
                  price: '\$2,000'),
            ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 320,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Popular Comparison",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.start,
                      ),
                      Icon(
                        SimpleLineIcons.getIconData("screen-smartphone"),
                        color: Colors.black54,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Divider(
                      color: Colors.black12,
                      height: 1,
                    ),
                  ),
                  Container(
                    height: 240,
                    child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('mobiles')
                            .orderBy('released_date', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text('no data');
                          }
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot mobile =
                                  snapshot.data.documents[index];

                              return Card(
                                child: Container(
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
                                      TrendingItem(
                                        product: Product(
                                            company: 'Apple',
                                            name: "iphone 11 pro",
                                            productId: '115c0xoyPbkXU49tSro2',
                                            icon:
                                                'https://www.bestmobile.pk/mobile_images/Original_1601501407Xiaomi-Mi-10T-5G-price-pakistan.jpg',
                                            rating: 4.5,
                                            remainingQuantity: 5,
                                            price: 'Rs 43245',
                                            mobile: mobile),
                                        gradientColors: [
                                          Color(0XFFa466ec),
                                          Colors.purple[400]
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  )
                ],
              ),
            ),
            elevation: 5,
          ),
        ),
      ),
    );
  }
}
