import 'package:flutter/material.dart';
import 'package:flutterfirebase/PageCategories.dart';
import 'package:flutterfirebase/PageProduct.dart';
import 'package:flutterfirebase/PageSearch.dart';
import 'package:flutterfirebase/widgets/AppBarWidget.dart';
import 'package:flutterfirebase/product_details.dart';
import 'package:flutterfirebase/ProductDetails.dart';
import 'package:flutterfirebase/pages/comparison.dart';

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  int currentIndex = 0;

  List pages = [
//    ProductDetailPage(),

//    ProductDetails(),
    PageCategories(),
    PageSearch(),
    Comparison(),
    PageProduct(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xFFFF6969),
          unselectedItemColor: Color(0xFF727C8E),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          currentIndex: currentIndex,
          onTap: (e) {
            setState(() {
              currentIndex = e;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text("Search")),
            BottomNavigationBarItem(
                icon: Icon(Icons.compare_arrows), title: Text("Compare")),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text("Profile")),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu), title: Text("More")),
          ]),
    );
  }
}
