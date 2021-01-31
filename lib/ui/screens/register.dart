import 'package:flutter/material.dart';
import 'package:flutterfirebase/services/auth.dart';
import 'package:flutterfirebase/services/database.dart';
import 'package:flutterfirebase/ui/screens/login.dart';
import 'package:flutterfirebase/ui/screens/verifynumber.dart';
import 'package:flutterfirebase/ui/widgets/edittext.dart';
import 'package:flutterfirebase/ui/widgets/submitbutton.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String name = "";
  String email = "";
  String password = "";
  String error = "";

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Welcome",
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Text(
                    "Register account",
                    style: Theme.of(context).textTheme.subtitle,
                  ),
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
                                value.isEmpty ? 'Enter a name' : null,
                            onChanged: (val) {
                              setState(() {
                                name = val;
                              });
                            },
                            decoration: InputDecoration(
                              fillColor: Theme.of(context).dividerColor,
                              hintText: 'Name',
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
                        title: "Register",
                        act: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              error = '';
                            });
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Please enter a valid email';
                              });
                            } else {
                              await DatabaseService(uid: result.uid)
                                  .addUserData(name, email);
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
                Padding(
                  padding: const EdgeInsets.only(top: 48.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already exist account? ",
                        style: TextStyle(fontSize: 17),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
