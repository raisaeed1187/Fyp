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
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Previous Comparisons',
            style: TextStyle(
              fontSize: 18,
//                        fontWeight: FontWeight.bold,
              fontFamily: 'NeusaNextPro',
              color: Colors.black,
            ),
          ),
          titleSpacing: 0,
          leading: IconButton(
              icon:
                  Icon(Icons.chevron_left, color: Color(0xFFFF6969), size: 30),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          actions: <Widget>[],
        ),
        body: ListView(
          children:
              List.generate(AppData.previousComparisonsList.length, (index) {
            return PreviousCompareCard(
              mobilesCompare: AppData.previousComparisonsList[index],
            );
          }),
        ),
      ),
    );
  }
}
