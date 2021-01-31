import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/ionicons.dart';
import 'package:flutterfirebase/ProductDetails.dart';
import 'package:flutterfirebase/favorite/main.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/modal/favorite.dart';
import 'package:flutterfirebase/pages/comparison.dart';
import 'package:flutterfirebase/provider/comparisonProvider.dart';
import 'package:flutterfirebase/ui/models/product.dart';
import 'package:flutterfirebase/ui/screens/product.dart';
import 'package:flutterfirebase/ui/widgets/favorite_widget.dart';
import 'package:flutterfirebase/ui/widgets/star_rating.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final List<Color> gradientColors;

  ProductCard({this.product, this.gradientColors});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  List<DocumentSnapshot> favorites = [];
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
    return favorite;
  }

  bool checkCompare = false;
  bool favorite = false;
  bool deleteFavorite = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (AppData.compareListNames.contains(widget.product.name)) {
      print('this mobile in list');
      setState(() {
        checkCompare = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double trendCardWidth = MediaQuery.of(context).size.width;

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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _productImage(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _productDetails(),
                            checkCompare
                                ? Container(
                                    height: 25,
                                    width: 80,
                                    margin: EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF6969),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    padding: EdgeInsets.only(
                                        top: 4, bottom: 4, left: 5),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        Text(
                                          'Compare',
                                          // key: key,
                                          style: TextStyle(
                                            fontFamily: 'NeusaNextPro',
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      if (AppData.compareList.length < 4) {
                                        setState(() {
                                          checkCompare = true;
                                          AppData.compareList
                                              .add(widget.product.mobile);
                                        });
                                        Provider.of<ComparisonProvider>(context,
                                                listen: false)
                                            .addItemInList(
                                                widget.product.mobile);
                                        AppData.compareListNames
                                            .add(widget.product.name);
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Text(
                                                        'you Compare more then 4 mobiles ',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                content: FlatButton(
                                                  onPressed: () {
                                                    List<DocumentSnapshot>
                                                        list =
                                                        AppData.compareList;
                                                    Navigator.pop(context);
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Comparison(
                                                                      compareList:
                                                                          list,
                                                                    )));
                                                  },
                                                  child: Text('Compare Now'),
                                                  color: Colors.green,
                                                ),
                                              );
                                            });
                                      }
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFF6969),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      padding: EdgeInsets.only(
                                          top: 4, bottom: 4, left: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Compare',
                                            style: TextStyle(
                                              fontFamily: 'NeusaNextPro',
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        DelayedDisplay(
                          delay: Duration(milliseconds: 200),
                          child: Container(
                            width: 30,
                            height: 20,
                            child: StreamProvider<List<FavoriteModal>>.value(
                              value: allFavorite,
                              child: FavoriteWidget(
                                mobile: widget.product.mobile,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: Colors.grey,
                    ),
                    _productSpecification(),
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
            builder: (context) => ProductDetails(
              mobile: widget.product.mobile,
            ),
          ),
        );
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => ProductDetails(mobile: product.mobile),
        //   ),
        // );
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
            child: Image.network(
                widget.product.icon != null ? widget.product.icon : '',
                fit: BoxFit.contain),
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.product.company,
          style: TextStyle(fontSize: 12, color: Color(0XFFb1bdef)),
        ),
        Text(
          widget.product.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        ),
        // StarRating(rating: widget.product.rating, size: 10),
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

  _productSpecification() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          _feature('sim'),
          _feature('ram'),
          _feature('storage'),
          _feature('primary_camera'),
          _feature('battery'),
        ],
      ),
    );
  }

  _feature(String feature) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.assignment_turned_in,
          color: Colors.black38,
        ),
        Expanded(
          child: Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(widget.product.mobile[feature])),
        )
      ],
    );
  }

  _Favorite() {
    bool check = false;
    // print('favorite: ${AppData.favoriteMobiles.length}');
    return Container(
      child: checkFavoriteMethod(widget.product.mobile.documentID) ==
              widget.product.mobile.documentID
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
                    'user_id': '2345',
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
                    'user_id': '2345',
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
