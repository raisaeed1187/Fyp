import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutterfirebase/modal/comparisonMobileModal.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/modal/mobile.dart';
import 'package:flutterfirebase/provider/comparisonProvider.dart';
import 'package:flutterfirebase/services/favorite_services.dart';
import 'package:flutterfirebase/ui/screens/home.dart';
import 'package:flutterfirebase/ui/widgets/favorite_compare_widget.dart';
import 'package:flutterfirebase/widgets/FullComparisonWidget.dart';
import 'package:flutterfirebase/widgets/OverviewWidget.dart';
import 'package:flutterfirebase/widgets/compareAdvantages.dart';
import 'package:provider/provider.dart';

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

  double getScreenSize(int index, String feature, int endPoint) {
    return double.parse(RegExp(r'(\d+)')
        .allMatches(compareList[index][feature].toString())
        .map((e) => e.group(0))
        .join('.')
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
    for (int i = 0; i < this.compareList.length; i++) {
      if (i == this.compareList.length - 1) {
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
          mobTemp = this.compareList[i];
          this.compareList[i] = this.compareList[j];
          compareList[j] = mobTemp;
        }
      }
    }
  }

  void addInPreviousList() {
    if (AppData.compareList.length == 2) {
      String com_id = AppData.compareList[0].data['product_name'] +
          "+" +
          AppData.compareList[1].data['product_name'];
      String mobile1 = AppData.compareList[0].data['product_name'];
      String mobile2 = AppData.compareList[1].data['product_name'];
      // ComparisonMobileModal(
      //     id: com_id,
      //     mobileName1: mobile1,
      //     mobileName2: mobile2,
      //     mobileName3: "",
      //     mobileName4: "");
      AppData.previousComparisonsList.add(ComparisonMobileModal(
          id: com_id,
          mobileName1: mobile1,
          mobileName2: mobile2,
          mobileName3: "",
          mobileName4: ""));
    } else if (AppData.compareList.length == 3) {
      String com_id = AppData.compareList[0].data['product_name'] +
          "+" +
          AppData.compareList[1].data['product_name'] +
          "+" +
          AppData.compareList[2].data['product_name'];
      String mobile1 = AppData.compareList[0].data['product_name'];
      String mobile2 = AppData.compareList[1].data['product_name'];
      String mobile3 = AppData.compareList[2].data['product_name'];

      AppData.previousComparisonsList.add(ComparisonMobileModal(
          id: com_id,
          mobileName1: mobile1,
          mobileName2: mobile2,
          mobileName3: mobile3,
          mobileName4: ""));
    } else if (AppData.compareList.length == 4) {
      String com_id = AppData.compareList[0].data['product_name'] +
          "+" +
          AppData.compareList[1].data['product_name'] +
          "+" +
          AppData.compareList[2].data['product_name'] +
          "+" +
          AppData.compareList[3].data['product_name'];
      String mobile1 = AppData.compareList[0].data['product_name'];
      String mobile2 = AppData.compareList[1].data['product_name'];
      String mobile3 = AppData.compareList[2].data['product_name'];
      String mobile4 = AppData.compareList[3].data['product_name'];

      AppData.previousComparisonsList.add(ComparisonMobileModal(
          id: com_id,
          mobileName1: mobile1,
          mobileName2: mobile2,
          mobileName3: mobile3,
          mobileName4: mobile4));
    }
  }

  @override
  void initState() {
    super.initState();
    getScore();
    sortMobile();
    addInPreviousList();
    // print("screen size: ${getScreenSize(0, 'display', 3)}");
    // AppData.compareList.clear();
    // print(this.compareList.length);
    Comparator<DocumentSnapshot> mobileNameSort =
        (a, b) => a.data['product_name'].compareTo(b.data['product_name']);
    compareList.sort(mobileNameSort);
    // compareList.sort((a, b) => a.length.compareTo(b.length));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    AppData.compareList.clear();
    AppData.compareListNames.clear();
    ComparisonProvider().compareList.clear();
    Provider.of<ComparisonProvider>(context, listen: false).clearCompareList();
  }

  // Future<bool> _onPressed() {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
  // }

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
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: IconButton(
                                          icon: Icon(Ionicons.getIconData(
                                              "ios-arrow-back")),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Home()));
                                            AppData.compareList.clear();
                                            AppData.compareListNames.clear();
                                            final comparisonProvider = context
                                                .watch<ComparisonProvider>();
                                            comparisonProvider
                                                .clearCompareList();
                                            // Navigator.of(context).pop();
                                          },
                                        )),
                                    Expanded(
                                      child: Row(
                                        children: List.generate(
                                            compareList.length, (index) {
                                          return Container(
                                            child: Expanded(
                                              child: Text(
                                                compareList[index]
                                                    ['product_name'],
                                                style: TextStyle(
                                                  fontSize: 18,
//                        fontWeight: FontWeight.bold,
                                                  fontFamily: 'NeusaNextPro',
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
//
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        width: 30,
                                        height: 20,
                                        child:
                                            StreamProvider<QuerySnapshot>.value(
                                          value: favoriteCompare,
                                          child: FavoriteCompareWidget(
                                            compareList: compareList,
                                          ),
                                        ),
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
                                  price: compareList[index]['price'].toString(),
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
