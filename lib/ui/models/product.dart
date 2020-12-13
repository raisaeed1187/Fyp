import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String company;
  final String name;
  final String productId;
  final String icon;
  final double rating;
  final String price;
  final int remainingQuantity;
  final DocumentSnapshot mobile;
  Product(
      {this.company,
      this.name,
      this.productId,
      this.icon,
      this.rating,
      this.price,
      this.remainingQuantity,
      this.mobile});
}
