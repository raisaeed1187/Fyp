import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirebase/modal/favorite.dart';

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

CollectionReference mobilesCollection =
    Firestore.instance.collection('mobiles');

Stream<QuerySnapshot> favoriteMobiles(String name) {
  return mobilesCollection.where('product_name', isEqualTo: name).snapshots();
}

Stream<QuerySnapshot> get allFavoriteQuery {
  return favCollection.snapshots();
}
