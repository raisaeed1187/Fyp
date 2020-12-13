import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/ui/screens/home.dart';
import 'package:flutterfirebase/ui/screens/register.dart';
import 'package:flutterfirebase/ui/screens/verifynumber.dart';
import 'package:flutterfirebase/ui/utils/progressdialog.dart';
import 'package:flutterfirebase/ui/widgets/edittext.dart';
import 'package:flutterfirebase/ui/widgets/submitbutton.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ProgressDialog progressDialog;
  getFavorites() {
    try {
      // List<DocumentSnapshot> favoriteMoblies = [];

      Firestore.instance
          .collection('favorites')
          .where('user_id', isEqualTo: '2345')
          .snapshots()
          .listen((snapshot) {
        snapshot.documents.forEach((mobile) {
          Firestore.instance
              .collection('mobiles')
              .document(mobile.data['product_id'])
              .get()
              .then((value) {
            // print('favorite: $value');
            AppData.favoriteMobiles.add(value);
          });
        });
        // print("favorite length in loop: ${favoriteMoblies.length}");
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = new ProgressDialog(context, ProgressDialogType.Normal);
    progressDialog.setMessage('Logging in...');
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Text("Welcome", style: Theme.of(context).textTheme.title),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text("Login to your account",
                      style: Theme.of(context).textTheme.subtitle),
                ),
                EditText(title: "Email"),
                EditText(title: "Password"),
                SubmitButton(
                  title: "Login",
                  act: () async {
                    AppData.favoriteMobiles.clear();
                    getFavorites();
                    progressDialog.show();
                    Future.delayed(const Duration(seconds: 2), () {
                      print('favorite : ${AppData.favoriteMobiles.length}');

                      setState(() {
                        progressDialog.hide();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      });
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text("Forgot your password?"),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account?  ",
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
