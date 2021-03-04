import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/feather.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutterfirebase/PageSearch.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/modal/mobile.dart';
import 'package:flutterfirebase/modal/user.dart';
import 'package:flutterfirebase/services/auth.dart';
import 'package:flutterfirebase/services/database.dart';
import 'package:flutterfirebase/services/favorite_services.dart';
import 'package:flutterfirebase/ui/screens/checkout.dart';
import 'package:flutterfirebase/ui/screens/home.dart';
import 'package:flutterfirebase/ui/screens/login.dart';
import 'package:flutterfirebase/ui/screens/previous_compares.dart';
import 'package:flutterfirebase/ui/screens/products_list.dart';
import 'package:flutterfirebase/ui/screens/profile.dart';
import 'package:flutterfirebase/ui/screens/search.dart';
import 'package:flutterfirebase/ui/screens/usersettings.dart';
import 'package:flutterfirebase/ui/utils/navigator.dart';
import 'package:provider/provider.dart';

class leftDrawerMenu extends StatefulWidget {
  @override
  _leftDrawerMenuState createState() => _leftDrawerMenuState();
}

class _leftDrawerMenuState extends State<leftDrawerMenu> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    setState(() {
      AppData.activeUserName = userData.name;
      AppData.activeUserImage = userData.picUrl;
      AppData.activeUserEmail = userData.email;
    });
    print(userData);
    Color blackColor = Colors.black.withOpacity(0.6);
    return Container(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            height: 150,
            child: DrawerHeader(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
                trailing: Icon(
                  Icons.chevron_right,
                  size: 28,
                ),
                subtitle: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                    // Navigator.push(
                    //   context,
                    //   PageTransition(
                    //     type: PageTransitionType.fade,
                    //     child: UserSettings(),
                    //   ),
                    // );
                  },
                  child: Text(
                    "See Profile",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: blackColor),
                  ),
                ),
                title: Text(
                  userData.name,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: blackColor),
                ),
                leading: CircleAvatar(
                  // backgroundImage: AssetImage('assets/images/me1.jpg'),
                  backgroundImage: AppData.activeUserImage.isEmpty
                      ? NetworkImage(
                          "https://ui-avatars.com/api/?color=ff0000&name=${AppData.activeUserName}")
                      : NetworkImage(AppData.activeUserImage),
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFFF8FAFB),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Feather.getIconData('home'),
              color: blackColor,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: blackColor),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Home()));
              // Navigator.push(
              //   context,
              //   PageTransition(
              //     type: PageTransitionType.fade,
              //     child: Home(),
              //   ),
              // );
            },
          ),
          StreamProvider<QuerySnapshot>.value(
            value: allFavoriteQuery(AppData.activeUserId),
            child: Container(
              child: AllFavoritesWidget(),
            ),
          ),
          StreamProvider<QuerySnapshot>.value(
            value: allFavoriteCompareQuery(AppData.activeUserId),
            child: Container(
              child: AllFavoriteComparesWidget(),
            ),
          ),
          ListTile(
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFFFB7C7A),
              ),
              child: Text(
                AppData.previousComparisonsList.length.toString() ?? "0",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            leading: Icon(Icons.compare_arrows, color: Colors.black54),
            title: Text('Previous Comparison',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54)),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PreviousCompres()));
            },
          ),
          ListTile(
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFFFB7C7A),
              ),
              child: Text(
                AppData.recentMobiles.length.toString() ?? "0",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            leading: Icon(Icons.mobile_screen_share, color: Colors.black54),
            title: Text('Recently Viewed',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54)),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductList(
                        mobilesList: AppData.recentMobiles,
                        checkHomePage: true,
                      )));
            },
          ),
          ListTile(
            leading: Icon(Feather.getIconData('search'), color: blackColor),
            title: Text('Search',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: blackColor)),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProductList(
                        mobilesList: AppData.mobilesList,
                        checkHomePage: true,
                      )));
              // Navigator.push(
              //   context,
              //   PageTransition(
              //     type: PageTransitionType.fade,
              //     child: Search(),
              //   ),
              // );
            },
          ),
          // ListTile(
          //   trailing: Icon(
          //     Ionicons.getIconData('ios-radio-button-on'),
          //     color: Color(0xFFFB7C7A),
          //     size: 18,
          //   ),
          //   leading: Icon(Feather.getIconData('bell'), color: blackColor),
          //   title: Text('Notifications',
          //       style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w600,
          //           color: blackColor)),
          //   onTap: () {
          //     // Nav.route(context, Checkout());
          //     // DatabaseService().giveScore();
          //   },
          // ),

          // ListTile(
          //   leading: Icon(Feather.getIconData('settings'), color: blackColor),
          //   title: Text('Settings',
          //       style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w600,
          //           color: blackColor)),
          //   onTap: () {
          //     Navigator.of(context).push(
          //         MaterialPageRoute(builder: (context) => UserSettings()));
          //     // Navigator.push(
          //     //   context,
          //     //   PageTransition(
          //     //     type: PageTransitionType.fade,
          //     //     child: UserSettings(),
          //     //   ),
          //     // );
          //   },
          // ),
          ListTile(
            // leading: Icon(Feather.getIconData('x-circle'), color: blackColor),
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: blackColor,
                )),
            onTap: () async {
              await _auth.signOut();
              setState(() {
                AppData.activeUserId = "";
              });
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
