import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/modal/data.dart';

class FullComparison extends StatefulWidget {
  List<DocumentSnapshot> compareList;
  FullComparison({this.compareList});
  @override
  _FullComparisonState createState() => _FullComparisonState(compareList);
}

class _FullComparisonState extends State<FullComparison> {
  List<DocumentSnapshot> compareList;
  _FullComparisonState(this.compareList);
  bool general = true;
  void showWidget() {
    setState(() {
      general = !general;
    });
  }

  bool display = true;
  void dispalyWidget() {
    setState(() {
      display = !display;
    });
  }

  bool design = true;
  void designWidget() {
    setState(() {
      design = !design;
    });
  }

  bool memory = true;
  void memoryWidget() {
    setState(() {
      memory = !memory;
    });
  }

  bool camera = true;
  void cameraWidget() {
    setState(() {
      camera = !camera;
    });
  }

  bool battery = true;
  void batteryWidget() {
    setState(() {
      battery = !battery;
    });
  }

  bool extra = true;
  void extraWidget() {
    setState(() {
      extra = !extra;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    'FULL COMPARISON',
                    style: TextStyle(
                      fontSize: 20,
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
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: showWidget,
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'General',
                                style:
                                    TextStyle(fontSize: 20, letterSpacing: 1),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(general
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.green[200],
                            border: Border(top: BorderSide(width: 1))),
                      ),
                    ),
                    Visibility(
                      maintainSize: false,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: general,
                      child: Column(
                        children: [
                          comparisonWidget(
                            title: 'Sim Type',
                            compareList: compareList,
                            feature: 'sim',
                          ),
                          comparisonWidget(
                            title: 'Dual Sim',
                            compareList: compareList,
                            feature: 'sim',
                          ),
                          comparisonWidget(
                            title: 'Sim Size',
                            compareList: compareList,
                            feature: 'sim',
                          ),
                          comparisonWidget(
                            title: 'Device Type',
                            compareList: compareList,
                            feature: 'sim',
                          ),
                          comparisonWidget(
                            title: 'Release Date',
                            compareList: compareList,
                            feature: 'released_date',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: designWidget,
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'Design',
                                style:
                                    TextStyle(fontSize: 20, letterSpacing: 1),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(design
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.green[200],
                            border: Border(top: BorderSide(width: 1))),
                      ),
                    ),
                    Visibility(
                      maintainSize: false,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: design,
                      child: Column(
                        children: [
                          comparisonWidget(
                            title: 'Dimensions',
                            compareList: compareList,
                            feature: 'dimension',
                          ),
                          comparisonWidget(
                            title: 'Weight',
                            compareList: compareList,
                            feature: 'weight',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: dispalyWidget,
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'Display',
                                style:
                                    TextStyle(fontSize: 20, letterSpacing: 1),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(display
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.green[200],
                            border: Border(top: BorderSide(width: 1))),
                      ),
                    ),
                    Visibility(
                      maintainSize: false,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: display,
                      child: Column(
                        children: [
                          comparisonWidget(
                            title: 'Type',
                            compareList: compareList,
                            feature: 'dimension',
                          ),
                          comparisonWidget(
                            title: 'Touch',
                            compareList: compareList,
                            feature: 'dimension',
                          ),
                          comparisonWidget(
                            title: 'Size',
                            compareList: compareList,
                            feature: 'dimension',
                          ),
                          comparisonWidget(
                            title: 'Aspect Ratio',
                            compareList: compareList,
                            feature: 'dimension',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: memoryWidget,
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'Memory',
                                style:
                                    TextStyle(fontSize: 20, letterSpacing: 1),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(memory
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.green[200],
                            border: Border(top: BorderSide(width: 1))),
                      ),
                    ),
                    Visibility(
                      maintainSize: false,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: memory,
                      child: Column(
                        children: [
                          comparisonWidget(
                            title: 'RAM',
                            compareList: compareList,
                            feature: 'ram',
                          ),
                          comparisonWidget(
                            title: 'Storage',
                            compareList: compareList,
                            feature: 'storage',
                          ),
                          comparisonWidget(
                            title: 'Card Slot',
                            compareList: compareList,
                            feature: 'sim',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: cameraWidget,
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'Camera',
                                style:
                                    TextStyle(fontSize: 20, letterSpacing: 1),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(camera
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.green[200],
                            border: Border(top: BorderSide(width: 1))),
                      ),
                    ),
                    Visibility(
                      maintainSize: false,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: camera,
                      child: Column(
                        children: [
                          comparisonWidget(
                            title: 'Rear Camera',
                            compareList: compareList,
                            feature: 'primary_camera',
                          ),
                          comparisonWidget(
                            title: 'Features',
                            compareList: compareList,
                            feature: 'features',
                          ),
                          comparisonWidget(
                            title: 'Video Recording',
                            compareList: compareList,
                            feature: 'video',
                          ),
                          comparisonWidget(
                            title: 'Front Camera',
                            compareList: compareList,
                            feature: 'scondary_camera',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: extraWidget,
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'Extra',
                                style:
                                    TextStyle(fontSize: 20, letterSpacing: 1),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(extra
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.green[200],
                            border: Border(top: BorderSide(width: 1))),
                      ),
                    ),
                    Visibility(
                      maintainSize: false,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: extra,
                      child: Column(
                        children: [
                          comparisonWidget(
                            title: 'GPS',
                            compareList: compareList,
                            feature: 'sim',
                          ),
                          comparisonWidget(
                            title: 'FingerPrint Sencer',
                            compareList: compareList,
                            feature: 'sim',
                          ),
                          comparisonWidget(
                            title: 'Face Unlock',
                            compareList: compareList,
                            feature: 'sim',
                          ),
                          comparisonWidget(
                            title: 'Splash Resistant',
                            compareList: compareList,
                            feature: 'sim',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: batteryWidget,
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                'Battery',
                                style:
                                    TextStyle(fontSize: 20, letterSpacing: 1),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(battery
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.green[200],
                            border: Border(top: BorderSide(width: 1))),
                      ),
                    ),
                    Visibility(
                      maintainSize: false,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: battery,
                      child: Column(
                        children: [
                          comparisonWidget(
                            title: 'Type',
                            compareList: compareList,
                            feature: 'battery',
                          ),
                          comparisonWidget(
                            title: 'Size',
                            compareList: compareList,
                            feature: 'battery',
                          ),
                          comparisonWidget(
                            title: 'Fast Charging',
                            compareList: compareList,
                            feature: 'sim',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                          compareList[index][feature] ?? '?',
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
