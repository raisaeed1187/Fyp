import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/modal/mobile.dart';
import 'package:flutterfirebase/modal/user.dart';
import 'package:flutterfirebase/services/database.dart';
import 'package:flutterfirebase/services/favorite_services.dart';
import 'package:flutterfirebase/ui/screens/home.dart';
import 'package:flutterfirebase/ui/screens/login.dart';
import 'package:flutterfirebase/ui/utils/progressdialog.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  ProgressDialog progressDialog;
  @override
  Widget build(BuildContext context) {
    // progressDialog = new ProgressDialog(context, ProgressDialogType.Normal);
    // progressDialog.setMessage('Logging in...');
    final user = Provider.of<User>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null) {
      return LoginScreen();
    } else {
      print("uid: ${user.uid}");
      setState(() {
        AppData.activeUserId = user.uid;
      });

      return Home(uid: user.uid);
    }
  }
}
