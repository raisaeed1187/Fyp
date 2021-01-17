import 'package:flutter/material.dart';
import 'package:flutterfirebase/ProductDetails.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/services/search_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getflutter/components/search_bar/gf_search_bar.dart';

class PageSearchResult extends StatefulWidget {
  static String searchWord;

  @override
  _PageSearchResultState createState() => _PageSearchResultState();
}

class _PageSearchResultState extends State<PageSearchResult>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TabController tabController;
  var tabList;
  List<SearchResultData> searchDataList;

  TextEditingController searchWordController;

  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['product_name'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print('mobiles in list:${AppData.mobilesList.length}');
    print('slam');
    tabList = [
      Tab(
          child:
              Text("BEST MATCH", style: TextStyle(fontFamily: 'NeusaNextPro'))),
      Tab(
          child:
              Text("TOP RATED", style: TextStyle(fontFamily: 'NeusaNextPro'))),
      Tab(
          child: Text("PRICE LOW-HIGH",
              style: TextStyle(fontFamily: 'NeusaNextPro'))),
      Tab(
          child: Text("PRICE HIGH-LOW",
              style: TextStyle(fontFamily: 'NeusaNextPro'))),
    ];
    tabController = new TabController(length: tabList.length, vsync: this);

    searchDataList = [
      SearchResultData("Oppo S3", "assets/images/oppo.jpg", "\$24.99", "4.9"),
      SearchResultData(
          "Samsung S11", "assets/images/oppo.jpg", "\$24.99", "4.8"),
      SearchResultData("RealMe 5", "assets/images/oppo.jpg", "\$24.99", "4.5"),
      SearchResultData("Vivo K3", "assets/images/oppo.jpg", "\$24.99", "4.1"),
      SearchResultData(
          "QMobile A3", "assets/images/oppo.jpg", "\$24.99", "4.9"),
      SearchResultData("Techno A4", "assets/images/oppo.jpg", "\$24.99", "4.8"),
      SearchResultData(
          "Infinix H8", "assets/images/oppo.jpg", "\$24.99", "4.5"),
      SearchResultData("Huawei P7", "assets/images/oppo.jpg", "\$24.99", "4.1"),
      SearchResultData(
          "Samsung G9", "assets/images/oppo.jpg", "\$24.99", "4.9"),
      SearchResultData("HTC H12", "assets/images/oppo.jpg", "\$24.99", "4.8"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    PageSearchResult.searchWord = ModalRoute.of(context).settings.arguments;
    searchWordController =
        TextEditingController(text: PageSearchResult.searchWord.toString());
    // initiateSearch(PageSearchResult.searchWord.toString());
    print(PageSearchResult.searchWord.toString());

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 5),
          child: GFSearchBar(
            searchBoxInputDecoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 30),
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductDetails(mobile: item)));
            },
          ),
        ),
        titleSpacing: 0,
        leading: IconButton(
            icon: Icon(Icons.chevron_left, color: Color(0xFFFF6969), size: 30),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.filter_list, color: Color(0xFF727C8E), size: 30),
              onPressed: () {
                _scaffoldKey.currentState.openEndDrawer();
              })
        ],
        bottom: TabBar(
            labelPadding: EdgeInsets.only(left: 15, right: 15),
            isScrollable: true,
            indicator: BoxDecoration(color: Colors.transparent),
            labelStyle: TextStyle(fontSize: 14),
            labelColor: Color(0xFFFF6969),
            unselectedLabelColor: Color(0x50727C8E),
            controller: tabController,
            tabs: tabList),
      ),
      body: Stack(
        overflow: Overflow.clip,
        alignment: Alignment.centerRight,
        children: <Widget>[
          GridView.count(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              primary: false,
              shrinkWrap: true,
              children: AppData.mobilesList.map((element) {
                return buildResultCard(element);
              }).toList()),
        ],
      ),
      endDrawer: Drawer(
        elevation: 10,
        child: SafeArea(child: _buildFilterMenu()),
      ),
    );
  }

  _buildFilterMenu() {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("REFINE RESULTS",
                    style: TextStyle(
                        color: Color(0x60515C6F),
                        fontSize: 13,
                        fontFamily: 'NeusaNextPro')),
                Text("CLEAR",
                    style: TextStyle(
                        color: Color(0xFFFF6969),
                        fontSize: 13,
                        fontFamily: 'NeusaNextPro')),
              ],
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              "View",
              "Category",
              "Condition",
              "Colour",
              "Brand",
              "Size",
              "Price Range"
            ].map((item) {
              return ListTile(
                title: Text(item,
                    style: TextStyle(
                        fontFamily: 'NeusaNextPro',
                        color: Color(0xFF515C6F),
                        fontSize: 15)),
                contentPadding: EdgeInsets.all(0),
                trailing: Icon(Icons.chevron_right, color: Color(0x60515C6F)),
              );
            }).toList(),
          )),
          Container(
            padding: EdgeInsets.all(5),
            height: 50,
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xFFFF6969),
                  ),
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        "APPLY FILTERS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'NeusaNextPro',
                            fontWeight: FontWeight.bold),
                      )),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child:
                            Icon(Icons.chevron_right, color: Color(0xFFFF6969)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SearchResultData {
  String name, image, star, price;

  SearchResultData(this.name, this.image, this.price, this.star);
}

Widget buildResultCard(data) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    elevation: 2.0,
    child: Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 0),
            spreadRadius: 0.2)
      ], borderRadius: BorderRadius.circular(15), color: Colors.white),
      padding: EdgeInsets.only(top: 15, left: 15, bottom: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(data['product_image'], fit: BoxFit.contain),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(data['product_name'],
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'NeusaNextPro',
                      color: Color(0xFF515C6F),
                      fontSize: 14)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Rs ',
                style: TextStyle(
                  fontFamily: 'NeusaNextPro',
//                              fontWeight: FontWeight.w600,
                  color: Color(0xFF515C6F),
                ),
              ),
              Text(
                data['price'],
                style: TextStyle(
                  fontFamily: 'NeusaNextPro',
//                              fontWeight: FontWeight.w600,
                  color: Color(0xFF515C6F),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: 25,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF6969),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding:
                      EdgeInsets.only(top: 4, bottom: 4, left: 5, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.compare_arrows, size: 15, color: Colors.white),
                      Expanded(
                        child: Text(
                          'Compare',
                          style: TextStyle(
                            fontFamily: 'NeusaNextPro',
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          )
        ],
      ),
    ),
  );
}
