import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/services/favorite_services.dart';
import 'package:flutterfirebase/ui/widgets/compareCard.dart';
import 'package:flutterfirebase/ui/widgets/previousCompareCard.dart';
import 'package:provider/provider.dart';

class PreviousCompres extends StatefulWidget {
  List<DocumentSnapshot> compareList;
  PreviousCompres({this.compareList});
  @override
  _PreviousCompresState createState() => _PreviousCompresState();
}

class _PreviousCompresState extends State<PreviousCompres> {
  @override
  Widget build(BuildContext context) {
    // final queryFavorites = Provider.of<QuerySnapshot>(context);

    return Material(
      child: ListView(
        children:
            List.generate(AppData.previousComparisonsList.length, (index) {
          return PreviousCompareCard(
            mobilesCompare: AppData.previousComparisonsList[index],
          );
        }),
      ),
    );
  }
}
