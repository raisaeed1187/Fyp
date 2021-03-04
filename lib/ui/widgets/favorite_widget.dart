import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/modal/favorite.dart';
import 'package:flutterfirebase/modal/mobile.dart';
import 'package:provider/provider.dart';

class FavoriteWidget extends StatefulWidget {
  DocumentSnapshot mobile;
  FavoriteWidget({this.mobile});

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  List<String> savedWords = List<String>();
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<QuerySnapshot>(context);
    // print(mobile.documentID);
    savedWords.clear();
    favorites.documents.forEach((element) {
      // print(element.productId);
      savedWords.add(element.data['product_name'].toString());
    });
    print(savedWords);
    String word = widget.mobile['product_name'];
    print(savedWords);
    bool isSaved = savedWords.contains(word);
    return isSaved
        ? InkWell(
            onTap: () {
              print('delete tap ${widget.mobile.documentID}');
              Firestore.instance
                  .collection('favorites')
                  .where('product_name',
                      isEqualTo: widget.mobile.data['product_name'])
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
              setState(() {
                savedWords.remove(word);
              });
            },
            child: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          )
        : InkWell(
            onTap: () {
              CollectionReference collectionReference =
                  Firestore.instance.collection('favorites');
              collectionReference.add({
                'user_id': AppData.activeUserId,
                'product_id': widget.mobile.documentID,
                'product_name': word,
              }).then((value) => print(value.documentID));
              savedWords.add(word);
            },
            child: Icon(
              Icons.favorite_border,
              color: Colors.black26,
            ),
          );
  }
}
