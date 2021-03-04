import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/commons.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutterfirebase/ProductDetails.dart';
import 'package:flutterfirebase/modal/comparisonMobileModal.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/modal/mobile.dart';
import 'package:flutterfirebase/product_details.dart';
import 'package:flutterfirebase/provider/comparisonProvider.dart';
import 'package:flutterfirebase/services/favorite_services.dart';
import 'package:flutterfirebase/ui/screens/home.dart';
import 'package:flutterfirebase/ui/widgets/favorite_compare_widget.dart';
import 'package:flutterfirebase/ui/widgets/star_rating.dart';
import 'package:flutterfirebase/widgets/FullComparisonWidget.dart';
import 'package:flutterfirebase/widgets/OverviewWidget.dart';
import 'package:flutterfirebase/widgets/compareAdvantages.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

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

  int getWaight(int index) {
    return getNumber(index, 'weight', 4);
  }

  void getScore() {
    for (int i = 0; i < this.compareList.length; i++) {
      // if (i == this.compareList.length - 1) {
      //   break;
      // }
      setState(() {
        mobilesScore[i] = this.compareList[i].data['score'].round();
        // mobilesScore.add(this.compareList[i].data['score'].round());
      });

      //   if (getCamera(i) > getCamera(i + 1)) {
      //     setState(() {
      //       mobilesScore[i] += 5;
      //     });
      //   } else {
      //     setState(() {
      //       mobilesScore[i + 1] += 5;
      //     });
      //   }
      //   if (getStorage(i) > getStorage(i + 1)) {
      //     setState(() {
      //       mobilesScore[i] += 5;
      //     });
      //   } else {
      //     setState(() {
      //       mobilesScore[i + 1] += 5;
      //     });
      //   }
      //   if (getRam(i) > getRam(i + 1)) {
      //     setState(() {
      //       mobilesScore[i] += 5;
      //     });
      //   } else {
      //     setState(() {
      //       mobilesScore[i + 1] += 5;
      //     });
      //   }
      //   if (getBattery(i) > getBattery(i + 1)) {
      //     setState(() {
      //       mobilesScore[i] += 5;
      //     });
      //   } else {
      //     setState(() {
      //       mobilesScore[i + 1] += 5;
      //     });
      //   }
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

  List<String> compareListNames = [];

  @override
  void initState() {
    super.initState();
    getScore();
    sortMobile();
    addInPreviousList();
    // print("screen size: ${getScreenSize(0, 'display', 3)}");
    // AppData.compareList.clear();
    // print(this.compareList.length);

    // compareList.sort((a, b) => a.length.compareTo(b.length));
    // Comparator<DocumentSnapshot> mobileNameSort =
    //     (a, b) => a.data['product_name'].compareTo(b.data['product_name']);
    // compareList.sort(mobileNameSort);
    compareList.forEach((element) {
      compareListNames.add(element['product_name']);
    });
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
        appBar: AppBar(
          // centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Expanded(
            child: Row(
              children: List.generate(compareList.length, (index) {
                return Container(
                  child: Expanded(
                    child: Text(
                      compareList[index]['product_name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'NeusaNextPro',
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          titleSpacing: 0,
          leading: IconButton(
              icon:
                  Icon(Icons.chevron_left, color: Color(0xFFFF6969), size: 30),
              onPressed: () {
                // Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Home()));
                AppData.compareList.clear();
                AppData.compareListNames.clear();
                final comparisonProvider = context.watch<ComparisonProvider>();
                comparisonProvider.clearCompareList();
              }),
          actions: <Widget>[
            Container(
              height: 40,
              width: 40,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  StreamProvider<QuerySnapshot>.value(
                    value: allFavoriteCompareQuery(AppData.activeUserId),
                    child: FavoriteCompareWidget(
                      compareList: compareList,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
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
                          // Container(
                          //   width: double.infinity,
                          //   decoration: BoxDecoration(
                          //     color: Colors.grey[200],
                          //   ),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Container(
                          //       child: Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Align(
                          //               alignment: Alignment.centerLeft,
                          //               child: IconButton(
                          //                 icon: Icon(Ionicons.getIconData(
                          //                     "ios-arrow-back")),
                          //                 onPressed: () {
                          //                   Navigator.of(context).push(
                          //                       MaterialPageRoute(
                          //                           builder: (context) =>
                          //                               Home()));
                          //                   AppData.compareList.clear();
                          //                   AppData.compareListNames.clear();
                          //                   final comparisonProvider = context
                          //                       .watch<ComparisonProvider>();
                          //                   comparisonProvider
                          //                       .clearCompareList();
                          //                   // Navigator.of(context).pop();
                          //                 },
                          //               )),
                          //           Expanded(
                          //             child: Row(
                          //               children: List.generate(
                          //                   compareList.length, (index) {
                          //                 return Container(
                          //                   child: Expanded(
                          //                     child: Text(
                          //                       compareList[index]
                          //                           ['product_name'],
                          //                       style: TextStyle(
                          //                         fontSize: 18,
                          //                         fontFamily: 'NeusaNextPro',
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 );
                          //               }),
                          //             ),
                          //           ),
                          //           Align(
                          //             alignment: Alignment.centerRight,
                          //             child: Container(
                          //               width: 30,
                          //               height: 20,
                          //               child:
                          //                   StreamProvider<QuerySnapshot>.value(
                          //                 value: favoriteCompare,
                          //                 child: FavoriteCompareWidget(
                          //                   compareList: compareList,
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),

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
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetails(
                                          mobile: compareList[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: CompareMobileTop(
                                    image: compareList[index]['product_image'],
                                    name: compareList[index]['product_name'],
                                    price:
                                        compareList[index]['price'].toString(),
                                  ),
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
                  BuildComments(
                    mobsNames: compareListNames,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CompareMobileTop extends StatelessWidget {
  final String name;
  final String price;
  final String image;

  CompareMobileTop({this.image, this.name, this.price});

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
            Expanded(
              child: Column(
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
            ),
          ],
        ),
      ),
    );
  }
}

class BuildComments extends StatefulWidget {
  List<String> mobsNames;
  BuildComments({this.mobsNames});
  @override
  _BuildCommentsState createState() => _BuildCommentsState(this.mobsNames);
}

class _BuildCommentsState extends State<BuildComments> {
  final commentController = TextEditingController();
  final replyController = TextEditingController();

  List<String> mobsNames;
  _BuildCommentsState(this.mobsNames);
  String comment;
  String reply;
  // bool checkReply = false;
  // static int totalComment = 0;
  List<bool> checkReply = List(100);
  double rating = 5.0;
  setCheckReply() {
    for (var i = 0; i < checkReply.length; i++) {
      checkReply[i] = false;
    }
  }

  String selectedMobile = "";
  List<bool> _isSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  String compereMobiles = "";
  makeComperisonId() {
    print(mobsNames.length);
    if (mobsNames.length == 2) {
      setState(() {
        compereMobiles = "${mobsNames[0]}-${mobsNames[1]}";
      });
    }
    if (mobsNames.length == 3) {
      setState(() {
        compereMobiles = "${mobsNames[0]}-${mobsNames[1]}-${mobsNames[2]}";
      });
    }
    if (mobsNames.length == 4) {
      setState(() {
        compereMobiles =
            "${mobsNames[0]}-${mobsNames[1]}-${mobsNames[2]}-${mobsNames[3]}";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCheckReply();
    makeComperisonId();
    mobsNames.add(compereMobiles);
  }

  @override
  Widget build(BuildContext context) {
    print("active user: ${AppData.activeUserName}");
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.black12),
          bottom: BorderSide(width: 1.0, color: Colors.black12),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Discussion",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
                Container(
                  width: 190,
                  height: 40,
                  child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: List.generate(mobsNames.length, (index) {
                        return FilterChip(
                          label: Text(mobsNames[index]),
                          labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                          selected: _isSelected[index],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: Colors.grey.shade400,
                          onSelected: (isSelected) {
                            // widget.filterBrands(widget.chipName);
                            setState(() {
                              _isSelected[index] = isSelected;
                              if (_isSelected[index] == true) {
                                selectedMobile = mobsNames[index];
                              } else {
                                selectedMobile = "";
                              }
                            });
                            print(selectedMobile);
                          },
                          selectedColor: Theme.of(context).primaryColor,
                        );
                      })),
                ), //moile name
              ],
            ),
            SizedBox(height: 12),
            Column(children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your comment',
                ),
                controller: commentController,
                onChanged: (value) {
                  setState(() {
                    comment = value;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Color(0xFFFB7C7A),
                width: double.infinity,
                child: FlatButton(
                  onPressed: () {
                    var now = DateTime.now();
                    print(now);
                    CollectionReference collectionReference =
                        Firestore.instance.collection('comments');
                    if (selectedMobile.isNotEmpty) {
                      collectionReference.add({
                        'user_id': AppData.activeUserId,
                        'user_name': AppData.activeUserName,
                        'user_image': 'img',
                        'product_name': selectedMobile,
                        'comment': comment,
                        'rating': rating,
                        'date_time': now,
                      }).then((value) => print(value.documentID));
                      commentController.clear();
                    } else {
                      collectionReference.add({
                        'user_id': AppData.activeUserId,
                        'user_name': AppData.activeUserName,
                        'user_image': 'img',
                        'product_name': compereMobiles,
                        'comment': comment,
                        'rating': rating,
                        'date_time': now,
                      }).then((value) => print(value.documentID));
                      commentController.clear();
                    }
                  },
                  child: Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ]),

            StreamBuilder(
              stream: Firestore.instance
                  .collection('comments')
                  .orderBy('date_time', descending: true)
                  .where('product_name', whereIn: mobsNames)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text('no data');
                }
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      DocumentSnapshot comment = snapshot.data.documents[index];
                      // checkReply.add(false);

                      return StreamBuilder<Object>(
                          stream: Firestore.instance
                              .collection('Users')
                              .document(comment['user_id'])
                              .snapshots(),
                          builder: (context, userSnapshot) {
                            if (!userSnapshot.hasData) {
                              return Text('no data');
                            }
                            DocumentSnapshot userInfo = userSnapshot.data;
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    child: Divider(
                                      color: Colors.black26,
                                      height: 4,
                                    ),
                                    // height: 24,
                                  ),
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: userInfo['img'].isEmpty
                                          ? NetworkImage(
                                              "https://ui-avatars.com/api/?color=ff0000&name=${userInfo['name']}")
                                          : NetworkImage(userInfo['img']),
                                      // backgroundImage: NetworkImage(
                                      //     "https://miro.medium.com/fit/c/256/256/1*mZ3xXbns5BiBFxrdEwloKg.jpeg"),
                                    ),
                                    subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                              DateFormat("yyyy-MM-dd hh:mm:ss")
                                                  .format(comment['date_time']
                                                      .toDate()),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54)),
                                          Container(
                                            width: double.infinity,
                                            height: 25,
                                            child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              children: <Widget>[
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color:
                                                          Colors.amberAccent),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 3),
                                                  child: Center(
                                                    child: Text(
                                                      comment['product_name'],
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ), //moile name
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFFE9F1FE),
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Text(comment['comment']),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    checkReply[index] =
                                                        !checkReply[index];
                                                  });
                                                  print(
                                                      "check reply $index: ${checkReply[index]}");
                                                },
                                                child: Text(
                                                  'Reply',
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                          checkReply[index]
                                              ? Container(
                                                  width: double.infinity,
                                                  child:
                                                      Column(children: <Widget>[
                                                    TextField(
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            'Enter your reply',
                                                      ),
                                                      controller:
                                                          replyController,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          reply = value;
                                                        });
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      color: Color(0xFFFB7C7A),
                                                      width: 120,
                                                      height: 30,
                                                      child: FlatButton(
                                                        onPressed: () {
                                                          var now =
                                                              DateTime.now();
                                                          print(now);
                                                          CollectionReference
                                                              collectionReference =
                                                              Firestore.instance
                                                                  .collection(
                                                                      'comments')
                                                                  .document(comment
                                                                      .documentID)
                                                                  .collection(
                                                                      'Replies');
                                                          collectionReference.add({
                                                            'user_id': AppData
                                                                .activeUserId,
                                                            'user_name': AppData
                                                                .activeUserName,
                                                            'user_image': 'img',
                                                            'comment_id':
                                                                comment
                                                                    .documentID,
                                                            'comment': reply,
                                                            'date_time': now,
                                                          }).then((value) =>
                                                              print(value
                                                                  .documentID));
                                                          replyController
                                                              .clear();
                                                        },
                                                        child: Text(
                                                          'Send Reply',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                                )
                                              : Text(''),
                                          StreamBuilder(
                                            stream: Firestore.instance
                                                .collection('comments')
                                                .document(comment.documentID)
                                                .collection('Replies')
                                                .orderBy('date_time')
                                                .snapshots(),
                                            builder: (context, snapshot2) {
                                              if (!snapshot2.hasData) {
                                                return Text('no data');
                                              }
                                              return ListView.builder(
                                                  itemCount: snapshot2
                                                      .data.documents.length,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    DocumentSnapshot replyData =
                                                        snapshot2.data
                                                            .documents[index];

                                                    return StreamBuilder(
                                                        stream: Firestore
                                                            .instance
                                                            .collection('Users')
                                                            .document(replyData[
                                                                'user_id'])
                                                            .snapshots(),
                                                        builder: (context,
                                                            replyUserSnapshot) {
                                                          if (!replyUserSnapshot
                                                              .hasData) {
                                                            return Text(
                                                                'no data');
                                                          }
                                                          DocumentSnapshot
                                                              replyUser =
                                                              replyUserSnapshot
                                                                  .data;
                                                          return Column(
                                                            children: <Widget>[
                                                              ListTile(
                                                                leading:
                                                                    CircleAvatar(
                                                                  backgroundImage: replyUser[
                                                                              'img']
                                                                          .isEmpty
                                                                      ? NetworkImage(
                                                                          "https://ui-avatars.com/api/?color=ff0000&name=${replyUser['name']}")
                                                                      : NetworkImage(
                                                                          replyUser[
                                                                              'img']),
                                                                  // backgroundImage:
                                                                  //     NetworkImage(
                                                                  //         "https://miro.medium.com/fit/c/256/256/1*mZ3xXbns5BiBFxrdEwloKg.jpeg"),
                                                                ),
                                                                subtitle:
                                                                    Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0xFFE9F1FE),
                                                                        borderRadius:
                                                                            BorderRadius.circular(6.0),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(8),
                                                                        child: Text(
                                                                            replyData['comment']),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                title: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: <
                                                                          Widget>[
                                                                        Text(replyUser[
                                                                            'name']),
                                                                        Text(
                                                                          DateFormat("yyyy-MM-dd hh:mm:ss")
                                                                              .format(replyData['date_time'].toDate()),
                                                                          // "",
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: Colors.black54),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      width: 6,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        // DateFormat("yyyy-MM-dd hh:mm:ss")
                                                                        //     .format(replyData['date_time'].toDate()),
                                                                        "",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.black54),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                  });
                                            },
                                          ),
                                        ]),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(userInfo['name']),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        // Expanded(
                                        //   child: Text(
                                        //     DateFormat("yyyy-MM-dd hh:mm:ss")
                                        //         .format(comment['date_time']
                                        //             .toDate()),
                                        //     style: TextStyle(
                                        //         fontSize: 12,
                                        //         color: Colors.black54),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    });
              },
            ),

            // Container(
            //   child: Column(
            //     children: <Widget>[
            //       SizedBox(
            //         child: Divider(
            //           color: Colors.black26,
            //           height: 4,
            //         ),
            //         height: 24,
            //       ),
            //       ListTile(
            //         leading: CircleAvatar(
            //           backgroundImage: NetworkImage(
            //               "https://miro.medium.com/fit/c/256/256/1*mZ3xXbns5BiBFxrdEwloKg.jpeg"),
            //         ),
            //         subtitle: Text(
            //             "Cats are good pets, for they are clean and are not noisy."),
            //         title: Row(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: <Widget>[
            //             // StarRating(rating: 4, size: 15),
            //             Text('Saeed Anwar'),
            //             SizedBox(
            //               width: 8,
            //             ),
            //             Text(
            //               "12 Sep 2019",
            //               style: TextStyle(fontSize: 12, color: Colors.black54),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
