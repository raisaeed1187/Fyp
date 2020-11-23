import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Firebase extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map data;

  addData() {
    Map<String, dynamic> demoData = {"name": "Saeed Programmer", "age": "22"};
    CollectionReference collectionReference =
        Firestore.instance.collection("mobiles");
    collectionReference.add(demoData);
  }

  fetchData() {
    CollectionReference collectionReference =
        Firestore.instance.collection("mobiles");
    collectionReference.snapshots().listen((snapshot) {
      setState(() {
        data = snapshot.documents[0].data;
      });
    });
  }

  updateData() async {
    CollectionReference collectionReference =
        Firestore.instance.collection('mobiles');
    QuerySnapshot querySnapshot = await collectionReference.getDocuments();
    querySnapshot.documents[0].reference
        .updateData({'name': 'Humair Anwar', 'age': '21'});
  }

  deleteData() async {
    CollectionReference collectionReference =
        Firestore.instance.collection("mobiles");
    QuerySnapshot querySnapshot = await collectionReference.getDocuments();
    querySnapshot.documents[0].reference.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: addData,
              child: Text("Add Data"),
              color: Colors.amberAccent,
            ),
            RaisedButton(
              onPressed: fetchData,
              child: Text("Fetch Data"),
              color: Colors.blueAccent,
            ),
            RaisedButton(
              onPressed: updateData,
              child: Text("Update Data"),
              color: Colors.green,
            ),
            RaisedButton(
              onPressed: deleteData,
              child: Text("Delete Data"),
              color: Colors.redAccent,
            ),
            Text(
              data != null ? data['brand'].toString() : 'no data',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _checkInternetConnectivity() {}
}
