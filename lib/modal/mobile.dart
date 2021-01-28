import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Color primaryColor = Color(0xFFCADCED);
List<BoxShadow> customShadow = [
  BoxShadow(
    color: Colors.white.withOpacity(0.5),
    spreadRadius: -5,
    offset: Offset(-5, -5),
    blurRadius: 30,
  ),
  BoxShadow(
    color: Colors.blue[900].withOpacity(0.2),
    spreadRadius: 2,
    offset: Offset(7, 7),
    blurRadius: 20,
  ),
];

class Mobile {
  String name;
  String brand;
  String price;
  String image;
  static int score = 5;
  Mobile({this.name, this.brand, this.image});
  int getNumber(String feature, int endPoint) {
    return int.parse(RegExp(r'(\d+)')
        .allMatches(feature.toString())
        .map((e) => e.group(0))
        .join(' ')
        .toString()
        .substring(0, endPoint));
  }

  int getCamera(String camera) {
    return getNumber(camera, 2);
  }

  int getRam(String ram) {
    return getNumber(ram, 1);
  }

  int getStorage(String storage) {
    return getNumber(storage, 3);
  }

  int getBattery(String battery) {
    return getNumber(battery, 4);
  }

  Future<void> giveScore(
      String docId, String camera, String ram, String storage, String battery) {
    double score = 60;
    double ramAns = (getRam(ram) / 2);
    double cameraAns = (getCamera(camera) / 10);
    double storageAns = (getStorage(storage) / 32);
    double batteryAns = (getRam(battery) / 500);
    score = score + ramAns + cameraAns + storageAns + batteryAns;
    return Firestore.instance
        .collection('mobiles')
        .document(docId)
        .updateData({'affiliate_link': score.toString()}).catchError((e) {
      print(e);
    });
  }
}
