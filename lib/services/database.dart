import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> addUserData(String name, String img) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'img': img,
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      picUrl: snapshot.data['img'],
    );
  }

  Stream<UserData> get getUserData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  // Stream<QuerySnapshot> get users {
  //   return userCollection.snapshots();
  // }
}
