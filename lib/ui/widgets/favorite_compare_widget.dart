import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/modal/favorite.dart';
import 'package:flutterfirebase/modal/mobile.dart';
import 'package:provider/provider.dart';

class FavoriteCompareWidget extends StatefulWidget {
  List<DocumentSnapshot> compareList;
  FavoriteCompareWidget({this.compareList});

  @override
  _FavoriteCompareWidgetState createState() => _FavoriteCompareWidgetState();
}

class _FavoriteCompareWidgetState extends State<FavoriteCompareWidget> {
  List<String> savedWords = List<String>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Comparator<DocumentSnapshot> mobileNameSort =
    //     (a, b) => a.data['product_name'].compareTo(b.data['product_name']);
    // widget.compareList.sort(mobileNameSort);
    final favoriteCompares = Provider.of<QuerySnapshot>(context);
    // print(mobile.documentID);
    savedWords.clear();
    favoriteCompares.documents.forEach((element) {
      // print(element.productId);
      savedWords.add(element.data['compare_id'].toString());
    });
    print(savedWords);

    if (widget.compareList.length == 2) {
      String compareID =
          "${widget.compareList[0]['product_name']}+${widget.compareList[1]['product_name']}";

      String word = compareID;
      print(savedWords);
      bool isSaved = savedWords.contains(word);
      return isSaved
          ? InkWell(
              onTap: () {
                // print('delete tap ${widget.compareID}');
                Firestore.instance
                    .collection('favoriteCompare')
                    .where('compare_id', isEqualTo: compareID)
                    .snapshots()
                    .listen((snapshot) {
                  snapshot.documents.forEach((doc) {
                    Firestore.instance
                        .collection('favoriteCompare')
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
                    Firestore.instance.collection('favoriteCompare');
                collectionReference.add({
                  'user_id': AppData.activeUserId,
                  'product_name1': widget.compareList[0]['product_name'],
                  'product_name2': widget.compareList[1]['product_name'],
                  'product_name3': '',
                  'product_name4': '',
                  'compare_id': word
                }).then((value) => print(value.documentID));
                savedWords.add(word);
              },
              child: Icon(
                Icons.favorite_border,
                color: Colors.black26,
              ),
            );
    } else if (widget.compareList.length == 3) {
      String compareID =
          "${widget.compareList[0]['product_name']}+${widget.compareList[1]['product_name']}+${widget.compareList[2]['product_name']}";

      String word = compareID;
      print(savedWords);
      bool isSaved = savedWords.contains(word);
      return isSaved
          ? InkWell(
              onTap: () {
                // print('delete tap ${widget.compareID}');
                Firestore.instance
                    .collection('favoriteCompare')
                    .where('compare_id', isEqualTo: compareID)
                    .snapshots()
                    .listen((snapshot) {
                  snapshot.documents.forEach((doc) {
                    Firestore.instance
                        .collection('favoriteCompare')
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
                    Firestore.instance.collection('favoriteCompare');
                collectionReference.add({
                  'user_id': AppData.activeUserId,
                  'product_name1': widget.compareList[0]['product_name'],
                  'product_name2': widget.compareList[1]['product_name'],
                  'product_name3': widget.compareList[2]['product_name'],
                  'product_name4': '',
                  'compare_id': word
                }).then((value) => print(value.documentID));
                savedWords.add(word);
              },
              child: Icon(
                Icons.favorite_border,
                color: Colors.black26,
              ),
            );
    } else if (widget.compareList.length == 4) {
      String compareID =
          "${widget.compareList[0]['product_name']}+${widget.compareList[1]['product_name']}+${widget.compareList[2]['product_name']}+${widget.compareList[3]['product_name']}";

      String word = compareID;
      print(savedWords);
      bool isSaved = savedWords.contains(word);
      return isSaved
          ? InkWell(
              onTap: () {
                // print('delete tap ${widget.compareID}');
                Firestore.instance
                    .collection('favoriteCompare')
                    .where('compare_id', isEqualTo: compareID)
                    .snapshots()
                    .listen((snapshot) {
                  snapshot.documents.forEach((doc) {
                    Firestore.instance
                        .collection('favoriteCompare')
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
                    Firestore.instance.collection('favoriteCompare');
                collectionReference.add({
                  'user_id': AppData.activeUserId,
                  'product_name1': widget.compareList[0]['product_name'],
                  'product_name2': widget.compareList[1]['product_name'],
                  'product_name3': widget.compareList[2]['product_name'],
                  'product_name4': widget.compareList[3]['product_name'],
                  'compare_id': word
                }).then((value) => print(value.documentID));
                savedWords.add(word);
              },
              child: Icon(
                Icons.favorite_border,
                color: Colors.black26,
              ),
            );
    } else {
      return Text('slam');
    }
  }
}
