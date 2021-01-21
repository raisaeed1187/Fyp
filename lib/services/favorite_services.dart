import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirebase/modal/favorite.dart';
import 'package:flutterfirebase/modal/user.dart';

List<FavoriteModal> _favoriteListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.documents.map((doc) {
    return FavoriteModal(
        productName: doc.data['product_name'] ?? '',
        productId: doc.data['product_id'] ?? '',
        userID: doc.data['user_id'] ?? '');
  }).toList();
}

CollectionReference favCollection = Firestore.instance.collection('favorites');
Stream<List<FavoriteModal>> get allFavorite {
  return favCollection.snapshots().map(_favoriteListFromSnapshot);
}

CollectionReference compareCollection =
    Firestore.instance.collection('favoriteCompare');
Stream<QuerySnapshot> get favoriteCompare {
  return compareCollection.snapshots();
}

Stream<QuerySnapshot> allFavoriteCompareQuery(String id) {
  return compareCollection.where('user_id', isEqualTo: id).snapshots();
}

CollectionReference mobilesCollection =
    Firestore.instance.collection('mobiles');

Stream<QuerySnapshot> favoriteMobiles(String name) {
  return mobilesCollection.where('product_name', isEqualTo: name).snapshots();
}

Stream<QuerySnapshot> getFavoriteMob(DocumentSnapshot snapshot) {
  return mobilesCollection
      .where('product_name', isEqualTo: snapshot.data['product_name'])
      .snapshots();
}

Stream<QuerySnapshot> allFavoriteQuery(String id) {
  return favCollection.where('user_id', isEqualTo: id).snapshots();
}

class FavoriteService {
  getFav() {
    Firestore.instance
        .collection('mobiles')
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        print(result.data['product_name']);
        return Firestore.instance
            .collection('mobiles')
            .where('product_name', isEqualTo: result.data['product_name'])
            .snapshots();
      });
    });
  }
}
