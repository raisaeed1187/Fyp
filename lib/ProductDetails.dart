import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetails extends StatefulWidget {
  DocumentSnapshot mobile;
  ProductDetails({this.mobile});
  @override
  _ProductDetailsState createState() => _ProductDetailsState(mobile);
}

class _ProductDetailsState extends State<ProductDetails> {
  DocumentSnapshot mobile;
  _ProductDetailsState(this.mobile);
  bool general = true;
  void showWidget() {
    setState(() {
      general = !general;
    });
  }

  bool display = false;
  void dispalyWidget() {
    setState(() {
      display = !display;
    });
  }

  bool design = false;
  void designWidget() {
    setState(() {
      design = !design;
    });
  }

  bool memory = false;
  void memoryWidget() {
    setState(() {
      memory = !memory;
    });
  }

  bool camera = false;
  void cameraWidget() {
    setState(() {
      camera = !camera;
    });
  }

  bool battery = false;
  void batteryWidget() {
    setState(() {
      battery = !battery;
    });
  }

  bool extra = false;
  void extraWidget() {
    setState(() {
      extra = !extra;
    });
  }

  bool advantage = true;
  void showAdvantageWidget() {
    setState(() {
      advantage = !advantage;
    });
  }

  bool disadvantage = false;
  void showDisadvantageWidget() {
    setState(() {
      disadvantage = !disadvantage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          mobile['product_name'],
          style: TextStyle(
            fontSize: 18,
//                        fontWeight: FontWeight.bold,
            fontFamily: 'NeusaNextPro',
            color: Colors.black,
          ),
        ),
        titleSpacing: 0,
        leading: IconButton(
            icon: Icon(Icons.chevron_left, color: Color(0xFFFF6969), size: 30),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: <Widget>[
          Stack(
            alignment: Alignment.bottomLeft,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.favorite, color: Color(0xFFFF6969)),
                  onPressed: () {}),
            ],
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
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
//              margin: const EdgeInsets.all(4),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RaisedButton(
                          onPressed: () {},
                          child: Text(
                            'Price Alert',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          color: Color(0xFFFF6969),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        RaisedButton(
                          onPressed: () {},
                          child: Text(
                            'Compare',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          color: Colors.lightBlue,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
//              margin: const EdgeInsets.all(4),
                  child: Image.network(mobile['product_image']),
                ),
                Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
//              margin: const EdgeInsets.all(4),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Rs',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                mobile['price'],
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          RaisedButton(
                            onPressed: () => {},
                            child: Text(
                              'Buy Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            color: Colors.pinkAccent,
                            highlightColor: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
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
                            'Compare Prices',
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
                          color: Colors.amberAccent,
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      'Sumsang',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Rs 1500',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 20,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 20,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 20,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 20,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Free Shipping'),
                                      Text('2-3 Business Days')
                                    ],
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      String url =
                                          "https://www.amazon.com/gp/product/B07YQ58NPF/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=B07YQ58NPF&linkCode=as2&tag=raisaeedanwar-20&linkId=f27148cc04cec6c7cf38e38876a147f4";
                                      launch(url);
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.deepOrange,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                          child: Text(
                                        'Shop Now',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                mobile['product_name'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                ' SPECIFICATIONS',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border(
//                        bottom: BorderSide(color: Colors.black, width: 3.0),
                              ),
                          color: Colors.amberAccent,
                        ),
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: showAdvantageWidget,
                            child: Container(
                              width: double.infinity,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Colors.amberAccent[100],
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.0, color: Colors.black),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Advantages',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Icon(disadvantage
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Visibility(
                            maintainSize: false,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: advantage,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.blueGrey[100],
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
//                          mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      advantageWidget(
                                        type: 'Has Responsive Touch Screen',
                                        value: 'Capacitive, MultiTouch',
                                      ),
                                      advantageWidget(
                                        type: 'Quite Big Screen',
                                        value: '6.53 in',
                                      ),
                                      advantageWidget(
                                        type: 'Sharp Screen',
                                        value: '~395 PPI',
                                      ),
                                      advantageWidget(
                                        type: 'Octa Core CPU',
                                      ),
                                      advantageWidget(
                                        type: 'Lots of Storage Capacity',
                                        value: '64 GB',
                                      ),
                                      advantageWidget(
                                        type: 'Faster CPU',
                                        value: '2 GHz',
                                      ),
                                      advantageWidget(
                                        type: 'Lots Of RAM',
                                        value: '4 GB',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: showDisadvantageWidget,
                            child: Container(
                              width: double.infinity,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Colors.amberAccent[100],
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.0, color: Colors.black),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Disadvantages',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Icon(disadvantage
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Visibility(
                            maintainSize: false,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: disadvantage,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.blueGrey[100],
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
//                          mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      advantageWidget(
                                        type: 'Heavy Weight',
                                        value: '198 g',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              border: Border(
                                bottom:
                                    BorderSide(width: 1.0, color: Colors.black),
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Full Specification',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: showWidget,
                                  child: Container(
                                    width: double.infinity,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: Colors.amberAccent[100],
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 1.0, color: Colors.black),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'GENERAL',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(general
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  maintainSize: false,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  visible: general,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey[100],
                                    ),
                                    child: Column(
                                      children: [
                                        buildSigleDetail(
                                            'Sim Type', mobile['sim']),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                        buildSigleDetail('Dual Sim', 'Yes'),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                        buildSigleDetail(
                                            'Sim Size', 'Nano+Nono Sim'),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                        buildSigleDetail(
                                            'Device Type', 'Smartphone'),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                        buildSigleDetail('Release Date',
                                            mobile['released_date']),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: designWidget,
                                  child: Container(
                                    width: double.infinity,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: Colors.amberAccent[100],
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 1.0, color: Colors.black),
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'DESIGN',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(design
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  maintainSize: false,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  visible: design,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey[100],
                                    ),
                                    child: Column(
                                      children: [
                                        buildSigleDetail(
                                            'Dimensions', mobile['dimension']),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                        buildSigleDetail(
                                            'Weight', mobile['weight']),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: dispalyWidget,
                                  child: Container(
                                    width: double.infinity,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: Colors.amberAccent[100],
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 1.0, color: Colors.black),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'DISPLAY',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(display
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  maintainSize: false,
                                  maintainState: true,
                                  maintainAnimation: true,
                                  visible: display,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey[100]),
                                    child: Column(
                                      children: [
                                        buildSigleDetail('Type',
                                            'Color Super AMOLED screen (16 M)'),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                        buildSigleDetail(
                                            'Touch', 'Yes, with Multitouch'),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                        buildSigleDetail('Size',
                                            '6.5 inches, 1080 x 2400 pixels'),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                        buildSigleDetail(
                                            'Aspect Ratio', '20:9'),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                        buildSigleDetail(
                                            'Notch', 'Yes, Punch Hole'),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: memoryWidget,
                                  child: Container(
                                    width: double.infinity,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: Colors.amberAccent[100],
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 1.0, color: Colors.black),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'MEMORY',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(memory
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  maintainSize: false,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  visible: memory,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey[100]),
                                    child: Column(
                                      children: [
                                        buildSigleDetail('RAM', mobile['ram']),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                        buildSigleDetail(
                                            'Storage', mobile['storage']),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                        buildSigleDetail(
                                            'Card Slot', 'Yes, upto 512 GB'),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: cameraWidget,
                                  child: Container(
                                    width: double.infinity,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: Colors.amberAccent[100],
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 1.0, color: Colors.black),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'CAMERA',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(camera
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  maintainSize: false,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  visible: camera,
                                  child: Container(
                                    color: Colors.blueGrey[100],
                                    child: Column(
                                      children: [
                                        buildSigleDetail('Rear Camera',
                                            mobile['primary_camera']),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                        buildSigleDetail(
                                            'Features', mobile['features']),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                        buildSigleDetail(
                                            'Video Recording', mobile['video']),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                        buildSigleDetail('Front Camera',
                                            mobile['scondary_camera']),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: batteryWidget,
                                  child: Container(
                                    width: double.infinity,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: Colors.amberAccent[100],
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 1.0, color: Colors.black),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'BATTERY',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(battery
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  maintainSize: false,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  visible: battery,
                                  child: Container(
                                    color: Colors.blueGrey[100],
                                    child: Column(
                                      children: [
                                        buildSigleDetail(
                                            'Type', mobile['battery']),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                        buildSigleDetail(
                                            'Size', mobile['battery']),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                        buildSigleDetail('Fast Charging',
                                            '18W Fast Charging'),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                        buildSigleDetail(
                                            'Talk Time', '31 hours'),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                        buildSigleDetail(
                                            'Music Playback Time', '185 hours'),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: extraWidget,
                                  child: Container(
                                    width: double.infinity,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      color: Colors.amberAccent[100],
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 1.0, color: Colors.black),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'EXTRA',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(extra
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  maintainSize: false,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  visible: extra,
                                  child: Container(
                                    color: Colors.blueGrey[100],
                                    child: Column(
                                      children: [
                                        buildSigleDetail('GPS',
                                            'Yes with A-GPS, Glonass,beiou'),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                        buildSigleDetail(
                                            'FingerPrint Sencer', 'Yes, Rear'),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                        buildSigleDetail('Face Unlock', 'Yes'),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                        buildSigleDetail('Splash Resistant',
                                            'Yes P2i Technology'),
                                        Divider(
                                          height: 10.0,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildSigleDetail(String type, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              type,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value != null ? value : '?',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}

class advantageWidget extends StatelessWidget {
  final String type;
  final String value;

  advantageWidget({@required this.type, this.value = ""});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          type,
          style: TextStyle(fontSize: 18.0),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 18.0),
        ),
        Divider(
          height: 10.0,
          color: Colors.black,
        ),
      ],
    );
  }
}
