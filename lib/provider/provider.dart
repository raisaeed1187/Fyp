import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// void main() => runApp(MyApp());

Stream<MyModal> documentStream = Firestore.instance
    .document('mobiles')
    .snapshots()
    .map((snapshot) => MyModal(mobile: snapshot));

List<Favorite> _favoriteListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.documents.map((doc) {
    return Favorite(
        productName: doc.data['product_name'] ?? '',
        productId: doc.data['product_Id'] ?? '',
        userID: doc.data['user_id'] ?? '');
  }).toList();
}

CollectionReference favCollection = Firestore.instance.collection('favorites');
Stream<List<Favorite>> get favorite {
  return favCollection.snapshots().map(_favoriteListFromSnapshot);
}

class LearnProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print();
    return StreamProvider<List<Favorite>>.value(
      value: favorite,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: titleWidget(),
          ),
          body: Consumer<List<Favorite>>(
            builder: (context, value, child) => Text(value[0].productName),
          ),
        ),
      ),
    );
    // return MaterialApp(
    //   home: Scaffold(
    //     appBar: AppBar(
    //       title: Text('Provider'),
    //     ),
    //     body: StreamBuilder(
    //       stream: favorite,
    //       builder:
    //           (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //         return ListView.builder(
    //             itemCount: snapshot.data.documents.length,
    //             itemBuilder: (context, index) {
    //               DocumentSnapshot doc = snapshot.data.documents[index];
    //               return Container(
    //                 child: Text(doc['product_name']),
    //               );
    //             });
    //       },
    //     ),
    //   ),
    // );

    // return StreamProvider<MyModal>(
    //   initialData: MyModal(mobile: null),
    //   create: (context) => myDacuemnt,
    //   child: MaterialApp(
    //     home: Scaffold(
    //       appBar: AppBar(title: Text('My App')),
    //       body: Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           Container(
    //             padding: const EdgeInsets.all(20),
    //             color: Colors.green[200],
    //             child: Consumer<MyModal>(
    //               builder: (context, myModal, child) {
    //                 return RaisedButton(
    //                   child: Text('Do something'),
    //                   onPressed: () {
    //                     myModal.doSomething();
    //                   },
    //                 );
    //               },
    //             ),
    //           ),
    //           Container(
    //             padding: const EdgeInsets.all(35),
    //             color: Colors.blue[200],
    //             child: Consumer<MyModal>(
    //               builder: (context, myModal, child) {
    //                 return Text(
    //                   myModal.mobile['product_name'],
    //                 );
    //               },
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

class titleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<List<Favorite>>(context);
    return Text('Provider${favorites.length}');
  }
}

class Favorite {
  final String productName;
  final String productId;
  final String userID;

  Favorite({this.productName, this.productId, this.userID});
}

class MyModal {
  DocumentSnapshot mobile;

  MyModal({this.mobile});
  factory MyModal.fromMap(Map<DocumentSnapshot, dynamic> data) {
    return MyModal(mobile: data['mobile']);
  }
  String someValue = "Slam";
  void doSomething() {
    someValue = "end the world";
    print(someValue);
  }
}
