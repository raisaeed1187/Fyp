import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterfirebase/modal/data.dart';

class ComparisonProvider extends ChangeNotifier {
  List<DocumentSnapshot> compareList = [];

  void addItemInList(DocumentSnapshot mobile) {
    compareList.add(mobile);
    notifyListeners();
  }

  void clearCompareList() {
    compareList.clear();
    notifyListeners();
  }
}
