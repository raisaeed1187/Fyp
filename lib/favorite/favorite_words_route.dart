import 'package:flutter/material.dart';
import 'package:flutterfirebase/modal/favorite.dart';
import 'package:provider/provider.dart';

class FavoriteWordsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<List<FavoriteModal>>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites words'),
      ),
      body: ListView.separated(
        itemCount: favorites.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) => ListTile(
          title: Text(favorites[index].productName),
        ),
      ),
    );
  }
}
