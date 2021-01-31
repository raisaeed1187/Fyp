import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirebase/modal/mobile.dart';
import 'package:flutterfirebase/modal/user.dart';
import 'package:flutterfirebase/ui/screens/userinfo.dart';

final CollectionReference bannerCollection =
    Firestore.instance.collection('Banners');

Stream<QuerySnapshot> get banners {
  return bannerCollection.snapshots();
}

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('Users');

  Future<void> addUserData(
    String name,
    String email,
  ) async {
    return await userCollection
        .document(uid)
        .setData({'name': name, 'img': '', 'email': email});
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      picUrl: snapshot.data['img'],
      email: snapshot.data['email'],
    );
  }

  Stream<UserData> get getUserData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  giveScore() {
    Firestore.instance
        .collection('mobiles')
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        print(result.data['product_name']);
        Mobile().giveScore(result.documentID, result.data['primary_camera'],
            result.data['ram'], result.data['storage'], result.data['battery']);
      });
    });
  }
  // Stream<QuerySnapshot> get users {
  //   return userCollection.snapshots();
  // }
}
