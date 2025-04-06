// favorites_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../favorites_provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesProvider>(context).favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Favorites'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: favorites.isEmpty
          ? Center(child: Text('No favorites yet!'))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final item = favorites[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ListTile(
              leading: Image.network(item.imageUrl, width: 50),
              title: Text(item.name),
              subtitle: Text('\u{20B9}${item.price}'),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  Provider.of<FavoritesProvider>(context, listen: false)
                      .removeFavorite(item.name);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
