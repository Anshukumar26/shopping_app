// favorites_provider.dart
import 'package:flutter/material.dart';

class FavoriteItem {
  final String name;
  final String imageUrl;
  final int price;

  FavoriteItem({
    required this.name,
    required this.imageUrl,
    required this.price,
  });
}

class FavoritesProvider with ChangeNotifier {
  final List<FavoriteItem> _favorites = [];

  List<FavoriteItem> get favorites => _favorites;

  void addFavorite(FavoriteItem item) {
    if (!_favorites.any((f) => f.name == item.name)) {
      _favorites.add(item);
      notifyListeners();
    }
  }

  void removeFavorite(String name) {
    _favorites.removeWhere((item) => item.name == name);
    notifyListeners();
  }

  bool isFavorite(String name) {
    return _favorites.any((item) => item.name == name);
  }
}
