// lib/models/cart_manager.dart

class CartItem {
  final String name;
  final String brand;
  final String size;
  int qty;
  final double price;
  final String imageUrl;

  CartItem(this.name, this.brand, this.size, this.qty, this.price, this.imageUrl);
}

class CartManager {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  final List<CartItem> _cartItems = [];

  List<CartItem> get items => _cartItems;

  void addToCart(CartItem item) {
    var existing = _cartItems.where((i) => i.name == item.name).toList();
    if (existing.isNotEmpty) {
      existing.first.qty += item.qty;
    } else {
      _cartItems.add(item);
    }
  }

  void clearCart() {
    _cartItems.clear();
  }
}
