import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/modal/mobile.dart';
import 'package:flutterfirebase/widgets/FullComparisonWidget.dart';
import 'package:flutterfirebase/widgets/OverviewWidget.dart';
import 'package:flutterfirebase/widgets/compareAdvantages.dart';

class Comparison extends StatefulWidget {
  List<DocumentSnapshot> compareList;
  Comparison({this.compareList});
  @override
  _ComparisonState createState() => _ComparisonState(compareList);
}

class _ComparisonState extends State<Comparison> {
  List<DocumentSnapshot> compareList;
  _ComparisonState(this.compareList);

  List<int> mobilesScore = [
    Mobile.score,
    Mobile.score,
    Mobile.score,
    Mobile.score
  ];

  int getNumber(int index, String feature, int endPoint) {
    return int.parse(RegExp(r'(\d+)')
        .allMatches(compareList[index][feature].toString())
        .map((e) => e.group(0))
        .join(' ')
        .toString()
        .substring(0, endPoint));
  }

  int getCamera(int index) {
    return getNumber(index, 'primary_camera', 2);
  }

  int getRam(int index) {
    return getNumber(index, 'ram', 1);
  }

  int getStorage(int index) {
    return getNumber(index, 'storage', 3);
  }

  int getBattery(int index) {
    return getNumber(index, 'battery', 4);
  }

  void getScore() {
    for (int i = 0; i < compareList.length; i++) {
      if (i == compareList.length - 1) {
        break;
      }
      if (getCamera(i) > getCamera(i + 1)) {
        setState(() {
          mobilesScore[i] += 5;
        });
      } else {
        setState(() {
          mobilesScore[i + 1] += 5;
        });
      }
      if (getStorage(i) > getStorage(i + 1)) {
        setState(() {
          mobilesScore[i] += 5;
        });
      } else {
        setState(() {
          mobilesScore[i + 1] += 5;
        });
      }
      if (getRam(i) > getRam(i + 1)) {
        setState(() {
          mobilesScore[i] += 5;
        });
      } else {
        setState(() {
          mobilesScore[i + 1] += 5;
        });
      }
      if (getBattery(i) > getBattery(i + 1)) {
        setState(() {
          mobilesScore[i] += 5;
        });
      } else {
        setState(() {
          mobilesScore[i + 1] += 5;
        });
      }
    }
  }

  void sortMobile() {
    int scoreTemp;
    DocumentSnapshot mobTemp;

    for (int i = 0; i < mobilesScore.length; i++) {
      for (int j = i + 1; j < mobilesScore.length; j++) {
        if (mobilesScore[i] < mobilesScore[j]) {
          scoreTemp = mobilesScore[i];
          mobilesScore[i] = mobilesScore[j];
          mobilesScore[j] = scoreTemp;
          // ---------------------
          mobTemp = compareList[i];
          compareList[i] = compareList[j];
          compareList[j] = mobTemp;
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getScore();
    sortMobile();
    // print(AppData.compareList.length);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: List.generate(
                                            compareList.length, (index) {
                                          return Text(
                                            compareList[index]['product_name'],
                                            style: TextStyle(
                                              fontSize: 18,
//                        fontWeight: FontWeight.bold,
                                              fontFamily: 'NeusaNextPro',
                                            ),
                                          );
                                        }),
//
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        icon: Icon(Icons.favorite_border,
                                            color: Color(0xFFFF6969), size: 30),
                                        onPressed: () {
                                          AppData.compareList.clear();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
//                            height: 80.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
//              margin: const EdgeInsets.all(4),
                            child: Column(
                              children:
                                  List.generate(compareList.length, (index) {
                                return CompareMobile(
                                  image: compareList[index]['product_image'],
                                  name: compareList[index]['product_name'],
                                  price: compareList[index]['price'],
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  OverviewWidget(
                    compareList: compareList,
                    mobilesScore: mobilesScore,
                  ),
                  CompareAdvantages(
                    compareList: compareList,
                    mobilesScore: mobilesScore,
                  ),
                  FullComparison(compareList: compareList),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CompareMobile extends StatelessWidget {
  final String name;
  final String price;
  final String image;

  CompareMobile({this.image, this.name, this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 2.0, color: Colors.grey)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            Image.network(
              image,
              height: 80,
              width: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 20.0),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Rs ',
                      style: TextStyle(fontSize: 20.0, color: Colors.red),
                    ),
                    Text(
                      price,
                      style: TextStyle(fontSize: 20.0, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}