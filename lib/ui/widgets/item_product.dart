import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/ionicons.dart';
import 'package:flutterfirebase/ProductDetails.dart';
import 'package:flutterfirebase/favorite/main.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/modal/favorite.dart';
import 'package:flutterfirebase/pages/comparison.dart';
import 'package:flutterfirebase/ui/models/product.dart';
import 'package:flutterfirebase/ui/screens/product.dart';
import 'package:flutterfirebase/ui/widgets/favorite_widget.dart';
import 'package:flutterfirebase/ui/widgets/star_rating.dart';
import 'dart:async';
import 'package:show_more_text_popup/show_more_text_popup.dart';
import 'package:provider/provider.dart';

class TrendingItem extends StatefulWidget {
  final Product product;
  final List<Color> gradientColors;

  TrendingItem({this.product, this.gradientColors});

  @override
  _TrendingItemState createState() => _TrendingItemState();
}

class _TrendingItemState extends State<TrendingItem> {
  List<DocumentSnapshot> favorites = [];
  GlobalKey key = new GlobalKey();
  String checkFavoriteMethod(String productId) {
    String favorite;
    // print("favorite length: ${AppData.favoriteMobiles.length}");
    setState(() {
      favorites = AppData.favoriteMobiles
          .where((element) => element.documentID == productId)
          .toList();
    });

    if (favorites.length > 0) {
      setState(() {
        favorite = favorites[0].documentID;
      });
    } else {
      setState(() {
        favorite = "";
      });
    }
    print(favorite);
    return favorite;
  }

  bool favorite = false;
  bool deleteFavorite = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("check id: ${checkFavoriteMethod('1Yq5PFWie8CmqyyYnDTT')}");
  }

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
                        Container(
                          width: 30,
                          height: 20,
                          child: StreamProvider<List<FavoriteModal>>.value(
                            value: allFavorite,
                            child: FavoriteWidget(
                              mobile: widget.product.mobile,
                            ),
                          ),
                        ),
                      ],
                    ),
                    _productImage(),
                    _productDetails(),
                    InkWell(
                      onTap: () {
                        // if (AppData.compareList.length < 4) {
                        //   AppData.compareList.add(widget.product.mobile);
                        //   ShowMoreTextPopup popup = ShowMoreTextPopup(
                        //     context,
                        //     text:
                        //         'Mobiles in Compare list ${AppData.compareList.length.toString()} ',
                        //     textStyle: TextStyle(color: Colors.white),
                        //     height: 30,
                        //     width: 200,
                        //     backgroundColor: Colors.amber,
                        //     padding: EdgeInsets.all(4.0),
                        //     borderRadius: BorderRadius.circular(10.0),
                        //   );
                        //   popup.show(
                        //     widgetKey: key,
                        //   );
                        // } else {
                        //   ShowMoreTextPopup popup = ShowMoreTextPopup(
                        //     context,
                        //     text: 'You can compare only 4 mobiles',
                        //     textStyle: TextStyle(color: Colors.white),
                        //     height: 30,
                        //     width: 200,
                        //     backgroundColor: Colors.amber,
                        //     padding: EdgeInsets.all(4.0),
                        //     borderRadius: BorderRadius.circular(10.0),
                        //   );
                        //   popup.show(
                        //     widgetKey: key,
                        //   );
                        // }

                        /// show the popup for specific widget

                        print(
                            "total compare ${AppData.compareList.length.toString()}");

                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              if (AppData.compareList.length < 4) {
                                AppData.compareList.add(widget.product.mobile);
                                return AlertDialog(
                                  title: Row(
                                    children: <Widget>[
                                      Text(
                                        'Mobiles in Compare list ',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                          AppData.compareList.length.toString(),
                                          style: TextStyle(fontSize: 15)),
                                    ],
                                  ),
                                  content: FlatButton(
                                    onPressed: () {
                                      List<DocumentSnapshot> list =
                                          AppData.compareList;
                                      // AppData.compareList.clear();
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Comparison(
                                                    compareList: list,
                                                  )));
                                    },
                                    child: Text('Compare Now'),
                                    color: Colors.green,
                                  ),
                                );
                              } else {
                                return AlertDialog(
                                  title: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          'you Compare more then 4 mobiles ',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
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
                                    },
                                    child: Text('Compare Now'),
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
                              key: key,
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
            builder: (context) => ProductDetails(mobile: widget.product.mobile),
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
            child: Image.network(widget.product.icon, fit: BoxFit.contain),
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
          widget.product.company,
          style: TextStyle(fontSize: 12, color: Color(0XFFb1bdef)),
        ),
        Text(
          widget.product.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        ),
        StarRating(rating: widget.product.rating, size: 10),
        Row(
          children: <Widget>[
            Text(widget.product.price,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
          ],
        )
      ],
    );
  }

  _Favorite() {
    bool check = false;

    return Container(
      child: checkFavoriteMethod(widget.product.productId) ==
              widget.product.productId
          ? InkWell(
              onTap: () {
                if (deleteFavorite == false) {
                  Firestore.instance
                      .collection('favorites')
                      .where('product_id',
                          isEqualTo: widget.product.mobile.documentID)
                      .snapshots()
                      .listen((snapshot) {
                    snapshot.documents.forEach((doc) {
                      Firestore.instance
                          .collection('favorites')
                          .document(doc.documentID)
                          .delete()
                          .catchError((e) {
                        print(e.toString());
                      });
                    });
                  });

                  Future.delayed(Duration(seconds: 2)).then((value) {
                    setState(() {
                      deleteFavorite = true;
                    });
                  });
                } else {
                  CollectionReference collectionReference =
                      Firestore.instance.collection('favorites');
                  collectionReference.add({
                    'user_id': AppData.activeUserId,
                    'product_id': widget.product.mobile.documentID
                  }).then((value) => print(value.documentID));
                  Future.delayed(Duration(seconds: 2)).then((value) {
                    setState(() {
                      deleteFavorite = false;
                    });
                  });
                }
              },
              child: Icon(
                // Ionicons.getIconData("ios-heart-empty"),
                deleteFavorite ? Icons.favorite_border : Icons.favorite,
                //  Icons.favorite,

                color: deleteFavorite ? Colors.black54 : Colors.red,
              ),
            )
          : InkWell(
              onTap: () {
                if (favorite == false) {
                  CollectionReference collectionReference =
                      Firestore.instance.collection('favorites');
                  collectionReference.add({
                    'user_id': AppData.activeUserId,
                    'product_id': widget.product.mobile.documentID
                  }).then((value) => print(value.documentID));

                  Future.delayed(Duration(seconds: 2)).then((value) {
                    setState(() {
                      favorite = true;
                    });
                  });
                } else {
                  Firestore.instance
                      .collection('favorites')
                      .where('product_id',
                          isEqualTo: widget.product.mobile.documentID)
                      .snapshots()
                      .listen((snapshot) {
                    snapshot.documents.forEach((doc) {
                      Firestore.instance
                          .collection('favorites')
                          .document(doc.documentID)
                          .delete()
                          .catchError((e) {
                        print(e.toString());
                      });
                    });
                  });

                  Future.delayed(Duration(seconds: 2)).then((value) {
                    setState(() {
                      favorite = false;
                    });
                  });
                }
              },
              child: Icon(
                // Ionicons.getIconData("ios-heart-empty"),

                favorite ? Icons.favorite : Icons.favorite_border,
                color: favorite ? Colors.red : Colors.black54,
              ),
            ),
    );
  }
}
