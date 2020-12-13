import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterfirebase/PageGetStared.dart';
import 'package:flutterfirebase/PageCategories.dart';
import 'package:flutterfirebase/PageHome.dart';
// import 'package:flutterfirebase/PageSearch.dart';
import 'package:flutterfirebase/ProductDetails.dart';
import 'package:flutterfirebase/favorite/main.dart';
import 'package:flutterfirebase/filter/main.dart';
// import 'package:flutterfirebase/home.dart';
import 'package:flutterfirebase/pages/comparison.dart';
import 'package:flutterfirebase/pages/pageSearchResult.dart';
import 'package:flutterfirebase/provider/provider.dart';
import 'package:flutterfirebase/ui/main.dart';

// import 'package:flutterfirebase/firebase.dart';
// import 'package:flutterfirebase/pages/searchCheckPage.dart';

void main() => runApp(EcommerceApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFFF5F6F8), // status bar color
      systemNavigationBarColor: Color(0xFFF5F6F8), // navigation bar color
    ));
    return MaterialApp(
      title: 'MobHub',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => PageGetStared(),
//        '/': (context) => MyHomePage~`(),
        '/PageHome': (context) => PageHome(),
        '/PageAllCategories': (context) => PageAllCategories(),
        '/PageSearchResult': (context) => PageSearchResult(),
        '/ProductDetails': (context) => ProductDetails(),
        '/comparison': (context) => Comparison(),
      },
    );
  }
}
