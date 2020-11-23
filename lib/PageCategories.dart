import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/ProductDetails.dart';
import 'package:flutterfirebase/pages/comparison.dart';
import 'package:flutterfirebase/product_details.dart';
import 'package:flutterfirebase/widgets/SearchWidget.dart';
import 'package:flutterfirebase/modal/mobile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/services/search_service.dart';

class PageCategories extends StatefulWidget {
  @override
  _PageCategoriesState createState() => _PageCategoriesState();
}

class _PageCategoriesState extends State<PageCategories> {
  List<mCategory> mCategoryList;
  List bannerList = ['assets/images/banner1.png', 'assets/images/banner2.png'];
  Mobile mobile;
  String name;
  fetchData() {
    Firestore.instance
        .collection("mobiles")
        .snapshots()
        .listen((querySnapshot) {
      AppData.mobilesList = querySnapshot.documents;
      print(AppData.mobilesList.length);
    });

    // CollectionReference collectionReference =
    //     Firestore.instance.collection("mobiles");
    // collectionReference.snapshots().listen((snapshot) {
    //   name = snapshot.documents[0].data['product_name'].toString();
    //   Mobile(
    //       name: snapshot.documents[0].data['product_name'].toString(),
    //       brand: snapshot.documents[0].data['brand'].toString(),
    //       image: snapshot.documents[0].data['product_image'].toString());
    // });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    mobile = Mobile();
    mCategoryList = new List();

    mCategoryList.add(mCategory("Iphone", "assets/images/iphone_logo-2.png"));
    mCategoryList.add(mCategory("Samsung", "assets/images/samsung_logo.jpg"));
    mCategoryList.add(mCategory("Oppo", "assets/images/oppo_logo-2.png"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              'MOBHUB',
              style: TextStyle(
                  color: Color(0xFFFF6969),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NeusaNextPro'),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Stack(
            alignment: Alignment.bottomLeft,
            children: <Widget>[
              IconButton(
                  icon:
                      Icon(Icons.notifications_none, color: Color(0xFF727C8E)),
                  onPressed: () {}),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    color: Color(0xFFFF6969),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                height: 20,
                width: 20,
                child: Text("10",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: 'NeusaNextPro')),
              )
            ],
          ),
          SizedBox(width: 15)
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        children: <Widget>[
          SearchWidget(),
          Hero(
              tag: 'title',
              child: Text("Brand",
                  style: TextStyle(
//                      color: Color(0xFF515C6F),
                      fontSize: 35,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NeusaNextPro'))),
          SizedBox(height: 30),
          Container(
              child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ClipRRect(
                        child: Image.asset(
                          mCategoryList[0].iconName,
                          height: 65,
                          width: 65,
                        ),
                        borderRadius: BorderRadius.circular(100)),
                    SizedBox(height: 10),
                    Text(mCategoryList[0].name,
                        style: TextStyle(
//                          color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'NeusaNextPro'))
                  ],
                ),
                Column(
                  children: <Widget>[
                    ClipRRect(
                        child: Image.asset(
                          mCategoryList[1].iconName,
                          height: 70,
                          width: 70,
                        ),
                        borderRadius: BorderRadius.circular(100)),
                    SizedBox(height: 10),
                    Text(mCategoryList[1].name,
                        style: TextStyle(
//                          color: Color(0xFF515C6F),
                            fontSize: 17,
                            fontFamily: 'NeusaNextPro'))
                  ],
                ),
                Column(
                  children: <Widget>[
                    ClipRRect(
                      child: Image.asset(
                        mCategoryList[2].iconName,
                        height: 70,
                        width: 70,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    SizedBox(height: 10),
                    Text(
                      mCategoryList[2].name,
                      style: TextStyle(
//                        color: Color(0xFF515C6F),
                          fontSize: 17,
                          fontFamily: 'NeusaNextPro'),
                    )
                  ],
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                      "/PageAllCategories",
                      arguments: mCategoryList),
                  child: Column(
                    children: <Widget>[
                      Hero(
                          tag: 'rightIcon',
                          child: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[300],
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: Offset(0, 0))
                                ]),
                            child: Icon(Icons.chevron_right,
                                color: Color(0xFFFF6969), size: 30),
                          )),
                      SizedBox(height: 10),
                      Text("See All",
                          style: TextStyle(
//                            color: Color(0xFF515C6F),
                              fontSize: 17,
                              fontFamily: 'NeusaNextPro')),
                    ],
                  ),
                ),
              ],
            ),
          )),
          SizedBox(height: 30),
          Text("Latest",
              style: TextStyle(
//                  color: Color(0xFF515C6F),
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NeusaNextPro')),
          Container(
            width: double.infinity,
            height: 200,
            child: PageView.builder(
                itemCount: bannerList.length,
                pageSnapping: true,
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: AssetImage(
                              bannerList[i],
                            ),
                            fit: BoxFit.cover)),
                    width: MediaQuery.of(context).size.width,
                    height: double.infinity,
                    child: Container(
                      width: 120,
                      height: 35,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        onPressed: () {},
                        child: Container(
                          padding: EdgeInsets.only(left: 7, top: 5, bottom: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                  child: Text(
                                "SEE MORE",
                                textAlign: TextAlign.left,
                                style: TextStyle(
//                                  color: Color(0xFF727C8E),
                                  fontFamily: 'NeusaNextPro',
                                ),
                              )),
                              CircleAvatar(
                                backgroundColor: Color(0xFFFF6969),
                                child: Icon(Icons.chevron_right,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 270,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Letest',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream:
                        Firestore.instance.collection('mobiles').snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Text('no data');
                      }
                      return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          DocumentSnapshot mobile =
                              snapshot.data.documents[index];
                          return buildViewCard(mobile, mobile['product_name'],
                              mobile['price'], mobile['product_image']);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 270,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Popular',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream:
                        Firestore.instance.collection('mobiles').snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Text('no data');
                      }
                      return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          DocumentSnapshot mobile =
                              snapshot.data.documents[index];
                          return buildViewCard(mobile, mobile['product_name'],
                              mobile['price'], mobile['product_image']);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildViewCard(
      DocumentSnapshot mobile, String name, String price, String image) {
    return Container(
//      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey[200], blurRadius: 1, spreadRadius: 1)
          ]),
      width: (MediaQuery.of(context).size.width - 80) / 3,
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductDetails(mobile: mobile))),
            child: Container(
              height: 140,
              width: 70,
              child: Image.network(image),
            ),
          ),

          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductDetails(mobile: mobile)));
            },
            // onTap: () => Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => ProductDetails(mobile: mobile))),
            child: Text(
              name,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'NeusaNextPro',
                fontSize: 14,
              ),
            ),
          ),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Text(
//                price,
//                style: TextStyle(
//                  fontFamily: 'NeusaNextPro',
//                  fontWeight: FontWeight.w600,
//                  color: Color(0xFF515C6F),
//                ),
//              ),
//              Container(
//                  decoration: BoxDecoration(
//                    color: Color(0xFFFF6969),
//                    borderRadius: BorderRadius.circular(100),
//                  ),
//                  padding: EdgeInsets.only(top: 4, bottom: 4, left: 5),
//                  child: Row(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Text('Compare',
//                          style: TextStyle(
//                              fontFamily: 'NeusaNextPro', color: Colors.white)),
//                    ],
//                  )),
//            ],
//          )
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Rs ',
                  style: TextStyle(
//                color: Color(0xFF727C8E),
                    fontFamily: 'NeusaNextPro',
//                fontWeight: FontWeight.bold,
                  )),
              Text(
                price,
                style: TextStyle(
//                color: Color(0xFF727C8E),
                  fontFamily: 'NeusaNextPro',
//                fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    AppData.compareList.add(mobile);
                    return AlertDialog(
                      title: Row(
                        children: <Widget>[
                          Text('Mobiles in Compare list '),
                          Text(AppData.compareList.length.toString()),
                        ],
                      ),
                      content: FlatButton(
                        onPressed: () {
                          List<DocumentSnapshot> list = AppData.compareList;

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Comparison(
                                    compareList: list,
                                  )));
                          // AppData.compareList.clear();
                        },
                        child: Text('Compare Now'),
                        color: Colors.green,
                      ),
                    );
                  });
            },
            child: Container(
              height: 30,
              width: 70,
              decoration: BoxDecoration(
                color: Color(0xFFFF6969),
                borderRadius: BorderRadius.circular(100),
              ),
              padding: EdgeInsets.only(top: 4, bottom: 4, left: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Compare',
                    style: TextStyle(
                      fontFamily: 'NeusaNextPro',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class mCategory {
  String name;
  String iconName;

  mCategory(this.name, this.iconName);
}

class PageAllCategories extends StatefulWidget {
  static List<mCategory> mCategoryList;

  @override
  _PageAllCategoriesState createState() => _PageAllCategoriesState();
}

class _PageAllCategoriesState extends State<PageAllCategories> {
  int selectedCategory = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageAllCategories.mCategoryList = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 30),
              child: InkWell(
                  child: Hero(
                      tag: 'rightIcon',
                      child: Icon(Icons.close, color: Color(0xFFFF6969))),
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 50,
              margin: EdgeInsets.only(left: 30, top: 10, bottom: 0),
              width: double.infinity,
              child: Hero(
                  tag: 'title',
                  child: Text("All Brands",
                      style: TextStyle(
//                          color: Color(0xFF515C6F),
                          fontSize: 28,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NeusaNextPro'))),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              height: MediaQuery.of(context).size.height - 170,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 90,
                    child: ListView.builder(
                        itemCount: PageAllCategories.mCategoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedCategory = index;
                              });
                            },
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 20),
                                ClipRRect(
                                    child: Image.asset(
                                      PageAllCategories
                                          .mCategoryList[index].iconName,
                                      height: 50,
                                      width: 50,
                                    ),
                                    borderRadius: BorderRadius.circular(100)),
                                SizedBox(height: 10),
                                Text(
                                    PageAllCategories.mCategoryList[index].name,
                                    style: TextStyle(
                                        color: selectedCategory == index
                                            ? Color(0xFF515C6F)
                                            : Color(0x50515C6F),
                                        fontWeight: selectedCategory == index
                                            ? FontWeight.w600
                                            : FontWeight.w200,
                                        fontSize: 17,
                                        fontFamily: 'NeusaNextPro')),
                                SizedBox(height: 20),
                              ],
                            ),
                          );
                        }),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 130,
                    child: ListView(
                      padding: EdgeInsets.all(15),
                      children: <Widget>[
                        Text("Mobile's Brand",
                            style: TextStyle(
                                color: Color(0x50515C6F),
                                fontSize: 12,
                                fontFamily: 'NeusaNextPro')),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [BoxShadow(color: Colors.grey[300])]),
                          child: Column(
                            children: [
                              "Techno",
                              "Infinix",
                              "Q-Mobile",
                              "Huawei",
                              "HTC",
                              "Iphone",
                              "Nokia",
                              "Black Berry"
                            ].map((item) {
                              return ListTile(
                                contentPadding: EdgeInsets.only(
                                    left: 15, right: 10, top: 0, bottom: 0),
                                title: InkWell(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed("/PageSearchResult"),
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                        color: Color(0xFF515C6F),
                                        fontSize: 15,
                                        fontFamily: 'NeusaNextPro'),
                                  ),
                                ),
                                trailing: Padding(
                                    padding:
                                        EdgeInsets.only(top: 15, bottom: 15),
                                    child: CircleAvatar(
                                        backgroundColor: Color(0x20727C8E),
                                        child: Icon(Icons.chevron_right,
                                            color: Color(0xFF727C8E)))),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
