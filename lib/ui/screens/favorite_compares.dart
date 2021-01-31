import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/pages/comparison.dart';
import 'package:flutterfirebase/provider/comparisonProvider.dart';
import 'package:flutterfirebase/services/favorite_services.dart';
import 'package:flutterfirebase/ui/widgets/compareCard.dart';
import 'package:provider/provider.dart';

class FavoriteComparesList extends StatefulWidget {
  List<DocumentSnapshot> compareList;
  bool checkHomePage;
  FavoriteComparesList({this.compareList, this.checkHomePage});
  @override
  _FavoriteComparesListState createState() => _FavoriteComparesListState();
}

class _FavoriteComparesListState extends State<FavoriteComparesList> {
  GlobalKey key = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    // final queryFavorites = Provider.of<QuerySnapshot>(context);
    final comparisonProvider = context.watch<ComparisonProvider>();
    return Material(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Favorite Comparisons',
            style: TextStyle(
              fontSize: 18,
//                        fontWeight: FontWeight.bold,
              fontFamily: 'NeusaNextPro',
              color: Colors.black,
            ),
          ),
          titleSpacing: 0,
          leading: widget.checkHomePage
              ? IconButton(
                  icon: Icon(Icons.chevron_left,
                      color: Color(0xFFFF6969), size: 30),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
              : Text(''),
          actions: <Widget>[
            widget.checkHomePage
                ? GestureDetector(
                    onTap: () {
                      if (AppData.compareList.length >= 2) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Comparison(
                                  compareList: AppData.compareList,
                                )));
                      } else {
                        // infoToast("Select minimam two mobiles");
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        'Select minimam two mobiles',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                                content: Text(''),
                              );
                            });
                      }
                    },
                    child: Container(
                      width: 35,
                      margin: EdgeInsets.only(top: 15),
                      child: Stack(
                        // overflow: Overflow.visible,
                        children: <Widget>[
                          Icon(
                            Icons.compare_arrows,
                            color: Colors.black,
                            key: key,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                // Icon(
                                //   Icons.favorite,
                                //   color: Colors.red,
                                //   size: 20,
                                // ),
                                Container(
                                  width: 15,
                                  height: 15,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                Text(
                                    comparisonProvider.compareList.length
                                        .toString(),
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Text(''),
          ],
        ),
        body: StreamBuilder(
            stream: allFavoriteCompareQuery(AppData.activeUserId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('no data');
              }
              if (snapshot.data.documents.length == 0) {
                return Center(
                    child: Text(
                  'No favorite comparison yet',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF6969)),
                ));
              }
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot compares = snapshot.data.documents[index];
                    return CompareMobile(
                      mobilesCompare: compares,
                    );
                  });
            }),
      ),
      // child: ListView(
      //   children: List.generate(queryFavorites.documents.length, (index) {
      //     return CompareMobile(
      //       mobilesCompare: queryFavorites.documents[index],
      //     );
      //   }),
      // ),
    );
  }
}
