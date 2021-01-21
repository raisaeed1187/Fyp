import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/services/favorite_services.dart';
import 'package:flutterfirebase/ui/widgets/compareCard.dart';
import 'package:provider/provider.dart';

class FavoriteComparesList extends StatefulWidget {
  List<DocumentSnapshot> compareList;
  FavoriteComparesList({this.compareList});
  @override
  _FavoriteComparesListState createState() => _FavoriteComparesListState();
}

class _FavoriteComparesListState extends State<FavoriteComparesList> {
  @override
  Widget build(BuildContext context) {
    // final queryFavorites = Provider.of<QuerySnapshot>(context);

    return Material(
      child: StreamBuilder(
          stream: allFavoriteCompareQuery(AppData.activeUserId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('no data');
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
