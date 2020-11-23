import 'package:flutter/material.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:getflutter/components/search_bar/gf_search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchCheckPage extends StatefulWidget {
  const SearchCheckPage({Key key}) : super(key: key);

  @override
  _SearchCheckPageState createState() => _SearchCheckPageState();
}

class _SearchCheckPageState extends State<SearchCheckPage> {
  // List of items to be searched
  List list = [
    "Flutter",
    "React",
    "Ionic",
    "Xamarin",
  ];
  fetchData() {
    Firestore.instance
        .collection("mobiles")
        .snapshots()
        .listen((querySnapshot) {
      AppData.mobilesList = querySnapshot.documents;
      print(AppData.mobilesList.length);
    });
  }

  String _selectedItemText = "Our Selection Item";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "SearchBar App",
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _selectedItemText,
              ),
              GFSearchBar(
                searchBoxInputDecoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(top: 0, bottom: 0, right: 30),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 0,
                      ),
                    ),
                    fillColor: Color(0x20727C8E),
                    filled: true,
                    prefixIcon: Icon(Icons.search, color: Color(0x40515C6F)),
                    hintStyle: TextStyle(
                        color: Color(0x40515C6F), fontFamily: 'NeusaNextPro'),
                    hintText: "Search Something"),
                searchList: AppData.mobilesList,
                searchQueryBuilder: (query, list) {
                  return list
                      .where((item) => item['product_name']
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                },
                overlaySearchListItemBuilder: (item) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      item['product_name'],
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                },
                onItemSelected: (item) {
                  setState(() {
                    _selectedItemText = item;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
