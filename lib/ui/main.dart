import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/modal/user.dart';
import 'package:flutterfirebase/provider/comparisonProvider.dart';
import 'package:flutterfirebase/services/auth.dart';
import 'package:flutterfirebase/ui/screens/home.dart';
import 'package:flutterfirebase/ui/screens/product.dart';
import 'package:flutterfirebase/ui/wrapper.dart';
import 'package:provider/provider.dart';
import 'screens/login.dart';

class TechHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: ChangeNotifierProvider(
        create: (_) => ComparisonProvider(),
        child: MaterialApp(
          theme: ThemeData(
            dividerColor: Color(0xFFECEDF1),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            primaryColor: Color(0xFFF93963),
            accentColor: Colors.cyan[600],
            fontFamily: 'Montserrat',
            textTheme: TextTheme(
              headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              title: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              subtitle: TextStyle(fontSize: 16),
              body1: TextStyle(fontSize: 14.0, fontFamily: 'Montserrat'),
              display1: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Montserrat1',
                  color: Colors.white),
              display2: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Montserrat',
                  color: Colors.black54),
            ),
          ),
          debugShowCheckedModeBanner: false,
          title: 'MOBHAB',
          home: Wrapper(),
          routes: {
            '/product': (context) => ProductPage(),
          },
        ),
      ),
    );
  }
}

class TabLayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      color: Colors.yellow,
      home: DefaultTabController(
        length: 4,
        child: new Scaffold(
          body: TabBarView(
            children: [
              new Container(
                color: Colors.yellow,
              ),
              new Container(
                color: Colors.orange,
              ),
              new Container(
                color: Colors.lightGreen,
              ),
              new Container(
                color: Colors.red,
              ),
            ],
          ),
          bottomNavigationBar: new TabBar(
            tabs: [
              Tab(
                icon: new Icon(Icons.home),
              ),
              Tab(
                icon: new Icon(Icons.rss_feed),
              ),
              Tab(
                icon: new Icon(Icons.perm_identity),
              ),
              Tab(
                icon: new Icon(Icons.settings),
              )
            ],
            labelColor: Colors.yellow,
            unselectedLabelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.red,
          ),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
