import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutterfirebase/favorite/favorite_words_route.dart';
import 'package:flutterfirebase/modal/favorite.dart';
import 'package:provider/provider.dart';

// void main() => runApp(MyApp());

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Likely Words',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Likely Words'),
    );
  }
}

List<FavoriteModal> _favoriteListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.documents.map((doc) {
    return FavoriteModal(
        productName: doc.data['product_name'] ?? '',
        productId: doc.data['product_id'] ?? '',
        userID: doc.data['user_id'] ?? '');
  }).toList();
}

CollectionReference favCollection = Firestore.instance.collection('favorites');
Stream<List<FavoriteModal>> get allFavorite {
  return favCollection.snapshots().map(_favoriteListFromSnapshot);
}

Stream<List<FavoriteModal>> selectFavorite(String productId) {
  return favCollection
      .where('product_id', isEqualTo: productId)
      .snapshots()
      .map(_favoriteListFromSnapshot);
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> words = nouns.take(40).toList();
  List<String> savedWords = List<String>();
  List<String> names = List<String>();
  getFavorite() {
    Firestore.instance.collection('favorites').snapshots().listen((snapshot) {
      snapshot.documents.forEach((mobile) {
        savedWords.add(mobile.data['product_name']);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<FavoriteModal>>.value(
      value: allFavorite,
      child: MaterialApp(
        home: ScaffullWidget(),
      ),
    );
  }
}

class ScaffullWidget extends StatefulWidget {
  @override
  _ScaffullWidgetState createState() => _ScaffullWidgetState();
}

class _ScaffullWidgetState extends State<ScaffullWidget> {
  List<String> savedWords = List<String>();
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<List<FavoriteModal>>(context);
    print(favorites);
    savedWords.clear();
    favorites.forEach((element) {
      // print(element.productId);

      savedWords.add(element.productName);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Likely Words'),
        actions: <Widget>[
          Badge(
            badgeContent: Text(favorites.length.toString()),
            toAnimate: false,
            position: BadgePosition.topStart(top: 0),
            child: IconButton(
              icon: Icon(Icons.bookmark),
              onPressed: () => pushToFavoriteWordsRoute(context),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('mobiles').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            print('lenght:${snapshot.data.documents.length}');
            return ListView.separated(
              itemCount: snapshot.data.documents.length,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot mobile = snapshot.data.documents[index];
                String word = mobile['product_name'];
                print(savedWords);
                bool isSaved = savedWords.contains(word);
                // print("match id :${favorites[0].productId}");
                // if (favorites[0].productId == mobile.documentID) {
                //   print("match id :${favorites[0].productId}");
                // } else {
                //   print('not match :${favorites[0].productId}');
                // }
                return StreamProvider<List<FavoriteModal>>.value(
                  value: selectFavorite(mobile.documentID),
                  child: ListTile(
                    title: Text(word),
                    trailing: isSaved
                        ? InkWell(
                            onTap: () {
                              Firestore.instance
                                  .collection('favorites')
                                  .where('product_id',
                                      isEqualTo: mobile.documentID)
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
                                'user_id': '2345',
                                'product_id': mobile.documentID,
                                'product_name': word,
                              }).then((value) => print(value.documentID));
                              savedWords.add(word);
                            },
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.black26,
                            ),
                          ),

                    // onTap: () {
                    //   setState(() {
                    //     if (isSaved) {
                    //       // savedWords.remove(word);
                    //       getFavorite();
                    //     } else {
                    //       // savedWords.add(word);
                    //       getFavorite();
                    //     }
                    //   });
                    // },
                  ),
                );
              },
            );
          }),
    );
  }

  pushToFavoriteWordsRoute(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => FavoriteWordsRoute(),
      ),
    );
  }
}
