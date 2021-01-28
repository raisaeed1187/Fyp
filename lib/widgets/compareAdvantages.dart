import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/modal/mobile.dart';

class CompareAdvantages extends StatefulWidget {
  List<DocumentSnapshot> compareList;
  List<int> mobilesScore;
  CompareAdvantages({this.compareList, this.mobilesScore});
  @override
  _CompareAdvantagesState createState() =>
      _CompareAdvantagesState(compareList, mobilesScore);
}

class _CompareAdvantagesState extends State<CompareAdvantages> {
  List<DocumentSnapshot> compareList;
  List<int> mobilesScore;

  _CompareAdvantagesState(this.compareList, this.mobilesScore);
  bool general = true;
  showWidget() {
    setState(() {
      general = !general;
    });
  }

  bool display = false;
  dispalyWidget() {
    setState(() {
      display = !display;
    });
  }

  List<bool> toggle = [true, true, true];

  // static Mobile mobile4;
  // List<void> toggleFunctions=[
  //   showWidget,
  // ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("list length in advatage ${this.compareList.length}");
    return Column(
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 60.0,
                padding: EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ADVANTAGES (FACTORS TO DECIDE WHICH MOBILE YOU SHOULD BUY)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border(
//                        bottom: BorderSide(color: Colors.black, width: 3.0),
                      ),
                  color: Colors.grey[200],
                ),
              ),
              //  // Container(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       InkWell(
              //         onTap: showWidget,
              //         child: Container(
              //           width: double.infinity,
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               Padding(
              //                 padding: const EdgeInsets.only(left: 8.0),
              //                 child: Container(
              //                   width: 45,
              //                   height: 45,
              //                   child: Align(
              //                     alignment: Alignment.center,
              //                     child: Text(
              //                       mobilesScore[0] > mobilesScore[1]
              //                           ? '# 1'
              //                           : '# 2',
              //                       style: TextStyle(fontSize: 20),
              //                     ),
              //                   ),
              //                   decoration: BoxDecoration(color: Colors.green),
              //                 ),
              //               ),
              //               Expanded(
              //                 child: Padding(
              //                   padding: const EdgeInsets.all(15.0),
              //                   child: Column(
              //                     children: <Widget>[
              //                       Text(
              //                         'Reasons to consider ',
              //                         style: TextStyle(
              //                             fontSize: 20, letterSpacing: 1),
              //                       ),
              //                       Text(
              //                         compareList[0]['product_name'],
              //                         style: TextStyle(
              //                             fontSize: 20, letterSpacing: 1),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.all(15.0),
              //                 child: Icon(general
              //                     ? Icons.keyboard_arrow_up
              //                     : Icons.keyboard_arrow_down),
              //               ),
              //             ],
              //           ),
              //           decoration: BoxDecoration(
              //               color: Colors.green[200],
              //               border: Border(top: BorderSide(width: 1))),
              //         ),
              //       ),
              //       Visibility(
              //         maintainSize: false,
              //         maintainAnimation: true,
              //         maintainState: true,
              //         visible: general,
              //         child: Column(
              //           children: [
              //             int.parse(compareList[0]['ram']
              //                         .toString()
              //                         .substring(0, 1)) >
              //                     int.parse(compareList[1]['ram']
              //                         .toString()
              //                         .substring(0, 1))
              //                 ? comparisonWidget(
              //                     title: 'More RAM',
              //                     compareList: compareList,
              //                     feature: 'ram',
              //                   )
              //                 : Text(''),
              //             comparisonWidget(
              //               title: 'Slimmer',
              //               compareList: compareList,
              //               feature: 'dimension',
              //             ),
              //             int.parse(RegExp(r'(\d+)')
              //                         .allMatches(compareList[0]
              //                                 ['primary_camera']
              //                             .toString())
              //                         .map((e) => e.group(0))
              //                         .join(' ')
              //                         .toString()
              //                         .substring(0, 3)) >
              //                     int.parse(RegExp(r'(\d+)')
              //                         .allMatches(compareList[1]
              //                                 ['primary_camera']
              //                             .toString())
              //                         .map((e) => e.group(0))
              //                         .join(' ')
              //                         .toString()
              //                         .substring(0, 3))
              //                 ? comparisonWidget(
              //                     title: 'Better Camera',
              //                     compareList: compareList,
              //                     feature: 'primary_camera',
              //                   )
              //                 : Text(''),
              //             int.parse(RegExp(r'(\d+)')
              //                         .allMatches(
              //                             compareList[0]['storage'].toString())
              //                         .map((e) => e.group(0))
              //                         .join(' ')
              //                         .toString()
              //                         .substring(0, 3)) >
              //                     int.parse(RegExp(r'(\d+)')
              //                         .allMatches(
              //                             compareList[1]['storage'].toString())
              //                         .map((e) => e.group(0))
              //                         .join(' ')
              //                         .toString()
              //                         .substring(0, 3))
              //                 ? comparisonWidget(
              //                     title: 'Storage',
              //                     compareList: compareList,
              //                     feature: 'storage',
              //                   )
              //                 : Text(''),
              //             int.parse(RegExp(r'(\d+)')
              //                         .allMatches(
              //                             compareList[0]['battery'].toString())
              //                         .map((e) => e.group(0))
              //                         .join(' ')
              //                         .toString()
              //                         .substring(0, 4)) >
              //                     int.parse(RegExp(r'(\d+)')
              //                         .allMatches(
              //                             compareList[1]['battery'].toString())
              //                         .map((e) => e.group(0))
              //                         .join(' ')
              //                         .toString()
              //                         .substring(0, 4))
              //                 ? comparisonWidget(
              //                     title: 'Bigger Battery',
              //                     compareList: compareList,
              //                     feature: 'battery',
              //                   )
              //                 : Text(''),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              //  // ),
              Column(
                children: List.generate(this.compareList.length, (index) {
                  return ReasonWidget(
                    getFunction: dispalyWidget,
                    compareList: compareList,
                    toggleVariable: display,
                    index: index,
                  );
                }),
              ),

              // ReasonWidget(
              //   getFunction: designWidget,
              //   compareList: compareList,
              //   mobilesScore: mobilesScore,
              //   toggleVariable: design,
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

class comparisonWidget extends StatelessWidget {
  final String title;
  String feature;
  List<DocumentSnapshot> compareList;
  List<Color> colors = [
    Colors.greenAccent,
    Colors.deepPurple[100],
    Colors.deepOrange[100]
  ];
  comparisonWidget({this.title, this.compareList, this.feature});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
              ),
              decoration: BoxDecoration(color: Colors.blue[200]),
            ),
            Column(
                children: List.generate(compareList.length, (index) {
              return Container(
                decoration: BoxDecoration(color: colors[index]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            compareList[index]['product_name'],
                            style: TextStyle(fontSize: 18, letterSpacing: 1),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          compareList[index][feature],
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
              );
            })),
          ],
        ),
      ),
    );
  }
}

class ReasonWidget extends StatefulWidget {
  Function getFunction;
  List<DocumentSnapshot> compareList;
  bool toggleVariable;
  int index;
  int secondIndex;
  ReasonWidget(
      {this.getFunction,
      this.compareList,
      this.toggleVariable,
      this.index,
      this.secondIndex});

  @override
  _ReasonWidgetState createState() => _ReasonWidgetState();
}

class _ReasonWidgetState extends State<ReasonWidget> {
  int getNumber(int index, String feature, int endPoint) {
    return int.parse(RegExp(r'(\d+)')
        .allMatches(widget.compareList[index][feature].toString())
        .map((e) => e.group(0))
        .join(' ')
        .toString()
        .substring(0, endPoint));
  }

  int getCamera(int index) {
    return getNumber(index, 'primary_camera', 3);
  }

  int getRam(int index) {
    return getNumber(index, 'ram', 1);
  }

  int getStorage(int index) {
    return getNumber(index, 'storage', 2);
  }

  int getBattery(int index) {
    return getNumber(index, 'battery', 4);
  }

  List<int> mobsRam = [];

  List<int> mobsCamera = [];

  List<int> mobsStorage = [];

  List<int> mobsBattery = [];

  void getMobInfo() {
    for (int i = 0; i < widget.compareList.length; i++) {
      // mobsRam.add(getRam(i));
      // mobsCamera.add(getCamera(i));
      // mobsStorage.add(getStorage(i));
      // mobsBattery.add(getBattery(i));
      mobsBattery.add(widget.compareList[i].data['battery_size'].round());
      mobsCamera.add(widget.compareList[i].data['primary_camera_size'].round());
      mobsStorage.add(widget.compareList[i].data['storage_size'].round());
      mobsRam.add(widget.compareList[i].data['ram_size'].round());
    }
    for (int i = 0; i < widget.compareList.length; i++) {
      for (int j = i + 1; j < widget.compareList.length; j++) {
        if (mobsRam[i] < mobsRam[j]) {
          int temp = mobsRam[i];
          mobsRam[i] = mobsRam[j];
          mobsRam[j] = temp;
        }
        if (mobsCamera[i] < mobsCamera[j]) {
          int temp = mobsCamera[i];
          mobsCamera[i] = mobsCamera[j];
          mobsCamera[j] = temp;
        }
        if (mobsStorage[i] < mobsStorage[j]) {
          int temp = mobsStorage[i];
          mobsStorage[i] = mobsStorage[j];
          mobsStorage[j] = temp;
        }
        if (mobsBattery[i] < mobsBattery[j]) {
          int temp = mobsBattery[i];
          mobsBattery[i] = mobsBattery[j];
          mobsBattery[j] = temp;
        }
      }
    }
    // print(mobsRam[0]);
    // for (int i = 0; i < widget.compareList.length; i++) {
    //   if (getRam(i) == mobsRam[0]) {
    //     print('more ram ${getRam(i)}');
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    getMobInfo();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: widget.getFunction,
            child: Expanded(
              child: Container(
                width: double.infinity,
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: 45,
                          height: 45,
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  ' # ',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  (widget.index + 1).toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(color: Colors.green),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Reasons to consider ',
                                style:
                                    TextStyle(fontSize: 20, letterSpacing: 1),
                              ),
                              Text(
                                widget.compareList[widget.index]
                                    ['product_name'],
                                style:
                                    TextStyle(fontSize: 20, letterSpacing: 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Icon(widget.toggleVariable
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.green[200],
                    border: Border(top: BorderSide(width: 1))),
              ),
            ),
          ),
          Visibility(
            maintainSize: false,
            maintainAnimation: true,
            maintainState: true,
            visible: widget.toggleVariable,
            child: Column(
              children: [
                // comparisonWidget('Supports NFC', 'No', 'Yes'),
                // int.parse(compareList[firstIndex]['ram']
                //             .toString()
                //             .substring(0, 1)) >
                //         int.parse(
                //             compareList[1]['ram'].toString().substring(0, 1))
                //     ? comparisonWidget(
                //         title: 'More RAM',
                //         compareList: compareList,
                //         feature: 'ram',
                //       )
                //     : Text(''),
                widget.compareList.length == 2
                    ? Column(
                        children: <Widget>[
                          //compalist length 2
                          widget.compareList[widget.index].data['ram_size']
                                      .round() ==
                                  mobsRam[0]
                              ? widget.compareList[0].data['ram_size'].round() >
                                      widget.compareList[1].data['ram_size']
                                          .round()
                                  ? comparisonWidget(
                                      title: 'More RAM',
                                      compareList: widget.compareList,
                                      feature: 'ram',
                                    )
                                  : widget.compareList[1].data['ram_size']
                                              .round() >
                                          widget.compareList[0].data['ram_size']
                                              .round()
                                      ? comparisonWidget(
                                          title: 'More RAM',
                                          compareList: widget.compareList,
                                          feature: 'ram',
                                        )
                                      : Text('')
                              : Text(''),

                          widget.compareList[widget.index]
                                      .data['primary_camera_size']
                                      .round() ==
                                  mobsCamera[0]
                              ? widget.compareList[0]
                                          .data['primary_camera_size']
                                          .round() >
                                      widget.compareList[1]
                                          .data['primary_camera_size']
                                          .round()
                                  ? comparisonWidget(
                                      title: 'Better Camera',
                                      compareList: widget.compareList,
                                      feature: 'primary_camera',
                                    )
                                  : widget.compareList[1]
                                              .data['primary_camera_size']
                                              .round() >
                                          widget.compareList[0]
                                              .data['primary_camera_size']
                                              .round()
                                      ? comparisonWidget(
                                          title: 'Better Camera',
                                          compareList: widget.compareList,
                                          feature: 'primary_camera',
                                        )
                                      : Text('')
                              : Text(''),
                          widget.compareList[widget.index].data['storage_size']
                                      .round() ==
                                  mobsStorage[0]
                              ? widget.compareList[0].data['storage_size']
                                          .round() >
                                      widget.compareList[1].data['storage_size']
                                          .round()
                                  ? comparisonWidget(
                                      title: 'Storage',
                                      compareList: widget.compareList,
                                      feature: 'storage',
                                    )
                                  : widget.compareList[1].data['storage_size']
                                              .round() >
                                          widget.compareList[0]
                                              .data['storage_size']
                                              .round()
                                      ? comparisonWidget(
                                          title: 'Storage',
                                          compareList: widget.compareList,
                                          feature: 'storage',
                                        )
                                      : Text('')
                              : Text(''),
                          getBattery(widget.index) == mobsBattery[0]
                              ? getBattery(0) > getBattery(1)
                                  ? comparisonWidget(
                                      title: 'Bigger Battery',
                                      compareList: widget.compareList,
                                      feature: 'battery',
                                    )
                                  : getBattery(1) > getBattery(0)
                                      ? comparisonWidget(
                                          title: 'Bigger Battery',
                                          compareList: widget.compareList,
                                          feature: 'battery',
                                        )
                                      : Text('')
                              : Text(''),
                        ],
                      )
                    : widget.compareList.length == 3
                        ? Column(
                            children: <Widget>[
                              //compalist length 3
                              widget.compareList[widget.index].data['ram_size'].round() ==
                                      mobsRam[0]
                                  ? (widget.compareList[0].data['ram_size'].round() >
                                              widget.compareList[1].data['ram_size']
                                                  .round()) &&
                                          (widget.compareList[0].data['ram_size'].round() >
                                              widget.compareList[2].data['ram_size']
                                                  .round()) //check 0 index
                                      ? comparisonWidget(
                                          title: 'More RAM',
                                          compareList: widget.compareList,
                                          feature: 'ram',
                                        )
                                      : (widget.compareList[1].data['ram_size'].round() >
                                                  widget.compareList[0].data['ram_size']
                                                      .round()) &&
                                              (widget.compareList[1].data['ram_size'].round() >
                                                  widget.compareList[2].data['ram_size']
                                                      .round()) //check 1 index
                                          ? comparisonWidget(
                                              title: 'More RAM',
                                              compareList: widget.compareList,
                                              feature: 'ram',
                                            )
                                          : (widget.compareList[2].data['ram_size'].round() > widget.compareList[0].data['ram_size'].round()) &&
                                                  (widget.compareList[2].data['ram_size'].round() >
                                                      widget.compareList[1]
                                                          .data['ram_size']
                                                          .round()) //check 2 index
                                              ? comparisonWidget(
                                                  title: 'More RAM',
                                                  compareList:
                                                      widget.compareList,
                                                  feature: 'ram',
                                                )
                                              : Text('')
                                  : Text(''),

                              widget.compareList[widget.index].data['primary_camera_size'].round() ==
                                      mobsCamera[0]
                                  ? (widget.compareList[0].data['primary_camera_size'].round() >
                                              widget.compareList[1].data['primary_camera_size']
                                                  .round()) &&
                                          (widget.compareList[0].data['primary_camera_size'].round() >
                                              widget.compareList[2].data['primary_camera_size']
                                                  .round()) //check 0 index
                                      ? comparisonWidget(
                                          title: 'Better Camera',
                                          compareList: widget.compareList,
                                          feature: 'primary_camera',
                                        )
                                      : (widget.compareList[1].data['primary_camera_size'].round() >
                                                  widget.compareList[0].data['primary_camera_size']
                                                      .round()) &&
                                              (widget.compareList[1].data['primary_camera_size'].round() >
                                                  widget.compareList[2].data['primary_camera_size']
                                                      .round()) //check 1 index
                                          ? comparisonWidget(
                                              title: 'Better Camera',
                                              compareList: widget.compareList,
                                              feature: 'primary_camera',
                                            )
                                          : (widget.compareList[2].data['primary_camera_size'].round() > widget.compareList[0].data['primary_camera_size'].round()) &&
                                                  (widget.compareList[2].data['primary_camera_size'].round() >
                                                      widget.compareList[1]
                                                          .data['primary_camera_size']
                                                          .round()) //check 2 index
                                              ? comparisonWidget(
                                                  title: 'Better Camera',
                                                  compareList:
                                                      widget.compareList,
                                                  feature: 'primary_camera',
                                                )
                                              : Text('')
                                  : Text(''),
                              widget.compareList[widget.index].data['storage_size'].round() ==
                                      mobsStorage[0]
                                  ? (widget.compareList[0].data['storage_size'].round() >
                                              widget.compareList[1].data['storage_size']
                                                  .round()) &&
                                          (widget.compareList[0].data['storage_size'].round() >
                                              widget.compareList[2].data['storage_size']
                                                  .round()) //check 0 index
                                      ? comparisonWidget(
                                          title: 'Storage',
                                          compareList: widget.compareList,
                                          feature: 'storage',
                                        )
                                      : (widget.compareList[1].data['storage_size'].round() > widget.compareList[0].data['storage_size'].round()) &&
                                              (widget.compareList[1].data['storage_size'].round() >
                                                  widget.compareList[2]
                                                      .data['storage_size']
                                                      .round()) //check 1 index
                                          ? comparisonWidget(
                                              title: 'Storage',
                                              compareList: widget.compareList,
                                              feature: 'storage',
                                            )
                                          : (widget.compareList[2].data['storage_size'].round() >
                                                      widget.compareList[0]
                                                          .data['storage_size']
                                                          .round()) &&
                                                  (widget.compareList[2].data['storage_size'].round() >
                                                      widget.compareList[1].data['storage_size'].round()) //check 2 index
                                              ? comparisonWidget(
                                                  title: 'Storage',
                                                  compareList:
                                                      widget.compareList,
                                                  feature: 'storage',
                                                )
                                              : Text('')
                                  : Text(''),
                              getBattery(widget.index) == mobsBattery[0]
                                  ? (getBattery(0) > getBattery(1)) &&
                                          (getBattery(0) >
                                              getBattery(2)) //check 0 index
                                      ? comparisonWidget(
                                          title: 'Bigger Battery',
                                          compareList: widget.compareList,
                                          feature: 'battery',
                                        )
                                      : (getBattery(1) > getBattery(0)) &&
                                              (getBattery(1) >
                                                  getBattery(2)) //check 1 index
                                          ? comparisonWidget(
                                              title: 'Bigger Battery',
                                              compareList: widget.compareList,
                                              feature: 'battery',
                                            )
                                          : (getBattery(2) > getBattery(0)) &&
                                                  (getBattery(2) >
                                                      getBattery(
                                                          1)) //check 2 index
                                              ? comparisonWidget(
                                                  title: 'Bigger Battery',
                                                  compareList:
                                                      widget.compareList,
                                                  feature: 'battery',
                                                )
                                              : Text('')
                                  : Text(''),
                            ],
                          )
                        : widget.compareList.length == 4
                            ? Column(
                                children: <Widget>[
                                  //compalist length 4
                                  widget.compareList[widget.index].data['ram_size'].round() ==
                                          mobsRam[0]
                                      ? (widget.compareList[0].data['ram_size'].round() > widget.compareList[1].data['ram_size'].round()) &&
                                              (widget.compareList[0].data['ram_size'].round() >
                                                  widget.compareList[2].data['ram_size']
                                                      .round()) &&
                                              (widget.compareList[0].data['ram_size'].round() >
                                                  widget.compareList[3].data['ram_size']
                                                      .round()) //check 0 index
                                          ? comparisonWidget(
                                              title: 'More RAM',
                                              compareList: widget.compareList,
                                              feature: 'ram',
                                            )
                                          : (widget.compareList[1].data['ram_size'].round() > widget.compareList[0].data['ram_size'].round()) &&
                                                  (widget.compareList[1].data['ram_size'].round() >
                                                      widget.compareList[2].data['ram_size']
                                                          .round()) &&
                                                  (widget.compareList[1].data['ram_size'].round() >
                                                      widget.compareList[3]
                                                          .data['ram_size']
                                                          .round()) //check 1 index
                                              ? comparisonWidget(
                                                  title: 'More RAM',
                                                  compareList:
                                                      widget.compareList,
                                                  feature: 'ram',
                                                )
                                              : (widget.compareList[2].data['ram_size'].round() > widget.compareList[0].data['ram_size'].round()) &&
                                                      (widget.compareList[2].data['ram_size'].round() >
                                                          widget.compareList[1]
                                                              .data['ram_size']
                                                              .round()) &&
                                                      (widget.compareList[2].data['ram_size'].round() > widget.compareList[3].data['ram_size'].round()) //check 2 index
                                                  ? comparisonWidget(
                                                      title: 'More RAM',
                                                      compareList:
                                                          widget.compareList,
                                                      feature: 'ram',
                                                    )
                                                  : (widget.compareList[3].data['ram_size'].round() > widget.compareList[0].data['ram_size'].round()) && (widget.compareList[3].data['ram_size'].round() > widget.compareList[1].data['ram_size'].round()) && (widget.compareList[3].data['ram_size'].round() > widget.compareList[2].data['ram_size'].round()) //check 3 index
                                                      ? comparisonWidget(
                                                          title: 'More RAM',
                                                          compareList: widget
                                                              .compareList,
                                                          feature: 'ram',
                                                        )
                                                      : Text('')
                                      : Text(''),

                                  widget.compareList[widget.index].data['primary_camera_size'].round() ==
                                          mobsCamera[0]
                                      ? (widget.compareList[0].data['primary_camera_size'].round() > widget.compareList[1].data['primary_camera_size'].round()) &&
                                              (widget.compareList[0].data['primary_camera_size'].round() >
                                                  widget.compareList[2].data['primary_camera_size']
                                                      .round()) &&
                                              (widget.compareList[0].data['primary_camera_size'].round() >
                                                  widget.compareList[3].data['primary_camera_size']
                                                      .round()) //check 0 index
                                          ? comparisonWidget(
                                              title: 'Better Camera',
                                              compareList: widget.compareList,
                                              feature: 'primary_camera',
                                            )
                                          : (widget.compareList[1].data['primary_camera_size'].round() > widget.compareList[0].data['primary_camera_size'].round()) &&
                                                  (widget.compareList[1].data['primary_camera_size'].round() >
                                                      widget.compareList[2].data['primary_camera_size']
                                                          .round()) &&
                                                  (widget.compareList[1].data['primary_camera_size'].round() >
                                                      widget.compareList[3].data['primary_camera_size']
                                                          .round()) //check 1 index
                                              ? comparisonWidget(
                                                  title: 'Better Camera',
                                                  compareList:
                                                      widget.compareList,
                                                  feature: 'primary_camera',
                                                )
                                              : (widget.compareList[2].data['primary_camera_size'].round() > widget.compareList[0].data['primary_camera_size'].round()) &&
                                                      (widget.compareList[2].data['primary_camera_size'].round() >
                                                          widget.compareList[1].data['primary_camera_size']
                                                              .round()) &&
                                                      (widget.compareList[2].data['primary_camera_size'].round() >
                                                          widget.compareList[3].data['primary_camera_size']
                                                              .round()) //check 2 index
                                                  ? comparisonWidget(
                                                      title: 'Better Camera',
                                                      compareList:
                                                          widget.compareList,
                                                      feature: 'primary_camera',
                                                    )
                                                  : (widget.compareList[3].data['primary_camera_size'].round() > widget.compareList[0].data['primary_camera_size'].round()) &&
                                                          (widget.compareList[3].data['primary_camera_size'].round() >
                                                              widget.compareList[1].data['primary_camera_size']
                                                                  .round()) &&
                                                          (widget.compareList[3].data['primary_camera_size'].round() >
                                                              widget
                                                                  .compareList[2]
                                                                  .data['primary_camera_size']
                                                                  .round()) //check 3 index
                                                      ? comparisonWidget(
                                                          title:
                                                              'Better Camera',
                                                          compareList: widget
                                                              .compareList,
                                                          feature:
                                                              'primary_camera',
                                                        )
                                                      : Text('')
                                      : Text(''),
                                  widget.compareList[widget.index].data['storage_size'].round() ==
                                          mobsStorage[0]
                                      ? (widget.compareList[0].data['storage_size'].round() > widget.compareList[1].data['storage_size'].round()) &&
                                              (widget.compareList[0].data['storage_size'].round() >
                                                  widget.compareList[2].data['storage_size']
                                                      .round()) &&
                                              (widget.compareList[0].data['storage_size'].round() >
                                                  widget.compareList[3].data['storage_size']
                                                      .round()) //check 0 index
                                          ? comparisonWidget(
                                              title: 'Storage',
                                              compareList: widget.compareList,
                                              feature: 'storage',
                                            )
                                          : (widget.compareList[1].data['storage_size'].round() >
                                                      widget.compareList[0]
                                                          .data['storage_size']
                                                          .round()) &&
                                                  (widget.compareList[1].data['storage_size'].round() >
                                                      widget.compareList[2]
                                                          .data['storage_size']
                                                          .round()) &&
                                                  (widget.compareList[1].data['storage_size'].round() >
                                                      widget.compareList[3]
                                                          .data['storage_size']
                                                          .round()) //check 1 index
                                              ? comparisonWidget(
                                                  title: 'Storage',
                                                  compareList:
                                                      widget.compareList,
                                                  feature: 'storage',
                                                )
                                              : (widget.compareList[2].data['storage_size'].round() > widget.compareList[0].data['storage_size'].round()) &&
                                                      (widget.compareList[2].data['storage_size'].round() > widget.compareList[1].data['storage_size'].round()) &&
                                                      (widget.compareList[2].data['storage_size'].round() > widget.compareList[3].data['storage_size'].round()) //check 2 index
                                                  ? comparisonWidget(
                                                      title: 'Storage',
                                                      compareList:
                                                          widget.compareList,
                                                      feature: 'storage',
                                                    )
                                                  : (widget.compareList[3].data['storage_size'].round() > widget.compareList[0].data['storage_size'].round()) && (widget.compareList[3].data['storage_size'].round() > widget.compareList[1].data['storage_size'].round()) && (widget.compareList[3].data['storage_size'].round() > widget.compareList[2].data['storage_size'].round()) //check 3 index
                                                      ? comparisonWidget(
                                                          title: 'Storage',
                                                          compareList: widget
                                                              .compareList,
                                                          feature: 'storage',
                                                        )
                                                      : Text('')
                                      : Text(''),
                                  getBattery(widget.index) == mobsBattery[0]
                                      ? (getBattery(0) > getBattery(1)) &&
                                              (getBattery(0) > getBattery(2)) &&
                                              (getBattery(0) >
                                                  getBattery(3)) //check 0 index
                                          ? comparisonWidget(
                                              title: 'Bigger Battery',
                                              compareList: widget.compareList,
                                              feature: 'battery',
                                            )
                                          : (getBattery(1) > getBattery(0)) &&
                                                  (getBattery(1) >
                                                      getBattery(2)) &&
                                                  (getBattery(1) >
                                                      getBattery(
                                                          3)) //check 1 index
                                              ? comparisonWidget(
                                                  title: 'Bigger Battery',
                                                  compareList:
                                                      widget.compareList,
                                                  feature: 'battery',
                                                )
                                              : (getBattery(2) >
                                                          getBattery(0)) &&
                                                      (getBattery(2) >
                                                          getBattery(1)) &&
                                                      (getBattery(2) >
                                                          getBattery(
                                                              3)) //check 2 index
                                                  ? comparisonWidget(
                                                      title: 'Bigger Battery',
                                                      compareList:
                                                          widget.compareList,
                                                      feature: 'battery',
                                                    )
                                                  : (getBattery(3) >
                                                              getBattery(0)) &&
                                                          (getBattery(3) >
                                                              getBattery(1)) &&
                                                          (getBattery(3) >
                                                              getBattery(
                                                                  2)) //check 3 index
                                                      ? comparisonWidget(
                                                          title:
                                                              'Bigger Battery',
                                                          compareList: widget
                                                              .compareList,
                                                          feature: 'battery',
                                                        )
                                                      : Text('')
                                      : Text(''),
                                ],
                              )
                            : Text(''), //end comparelist length 4
              ],
            ), //outer column
          ),
        ],
      ),
    );
  }
}
