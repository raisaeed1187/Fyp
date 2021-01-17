import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/services/auth.dart';
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
  Future<void> getFavorites() async {
    try {
      // List<DocumentSnapshot> favoriteMoblies = [];

      Firestore.instance
          .collection('favorites')
          .where('user_id', isEqualTo: '2345')
          .snapshots()
          .listen((snapshot) {
        snapshot.documents.forEach((mobile) async {
          await Firestore.instance
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

  String email = "";
  String password = "";
  String error = "";
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

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
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, left: 24.0, right: 24.0),
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.text,
                            validator: (value) =>
                                value.isEmpty ? 'Enter an email' : null,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                            decoration: InputDecoration(
                              fillColor: Theme.of(context).dividerColor,
                              hintText: 'Email',
                              hintStyle: Theme.of(context).textTheme.display2,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              contentPadding: EdgeInsets.all(16),
                            ),
                          ),
                        ),
                      ),
                      error != ''
                          ? Text(error,
                              style: TextStyle(color: Colors.red, fontSize: 14))
                          : SizedBox(
                              height: 1,
                            ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, left: 24.0, right: 24.0),
                          child: TextFormField(
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.text,
                            validator: (value) => value.length < 6
                                ? 'Enter a password 6+ chars long'
                                : null,
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                            decoration: InputDecoration(
                              fillColor: Theme.of(context).dividerColor,
                              hintText: 'Password',
                              hintStyle: Theme.of(context).textTheme.display2,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              contentPadding: EdgeInsets.all(16),
                            ),
                          ),
                        ),
                      ),
                      SubmitButton(
                        title: "Login",
                        act: () async {
                          if (_formKey.currentState.validate()) {
                            AppData.favoriteMobiles.clear();
                            await getFavorites();
                            print('favorite : ${AppData.favoriteMobiles}');
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error =
                                    'Could not sign in with those credentials';
                              });
                            }
                          }
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => VerifyScreeen(),
                          //   ),
                          // );
                        },
                      ),
                    ],
                  ),
                ),
                // SubmitButton(
                //   title: "Login",
                //   act: () async {
                //     AppData.favoriteMobiles.clear();
                //     await getFavorites();
                //     print('favorite : ${AppData.favoriteMobiles}');
                //     dynamic result = await _auth.signInAnon();
                //     if (result == null) {
                //       print('error signing in');
                //     } else {
                //       print('signed in');
                //       print(result.uid);
                //     }
                //     // progressDialog.show();
                //     // Future.delayed(const Duration(seconds: 2), () {
                //     //   print('favorite : ${AppData.favoriteMobiles.length}');

                //     //   setState(() {
                //     //     progressDialog.hide();
                //     //     Navigator.pushReplacement(
                //     //       context,
                //     //       MaterialPageRoute(
                //     //         builder: (context) => Home(),
                //     //       ),
                //     //     );
                //     //   });
                //     // });
                //   },
                // ),
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
