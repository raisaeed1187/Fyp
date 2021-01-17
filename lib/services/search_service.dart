import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('mobiles')
        .where('key', isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }

  Future<QuerySnapshot> searchBrand(String brand) async {
    return await Firestore.instance
        .collection('mobiles')
        .where('brand', isEqualTo: brand)
        .getDocuments()
        .then((doc) {
      return doc;
    });
  }
}
