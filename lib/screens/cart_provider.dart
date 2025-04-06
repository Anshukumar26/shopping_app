import 'package:flutter/foundation.dart';

class CartItem {
  final String name;
  final String brand;
  final String imageUrl;
  final int price;
  final String size;
  int qty;

  CartItem({
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.price,
    required this.size,
    this.qty = 1,
  });
}

class ShippingAddress {
  final String fullName;
  final String addressLine;
  final String city;
  final String state;
  final String zipCode;
  final String phone;

  ShippingAddress({
    required this.fullName,
    required this.addressLine,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.phone,
  });
}

class Order {
  final String id;
  final List<CartItem> items;
  final ShippingAddress? shippingAddress;
  final String paymentMethod;
  final double total;
  final DateTime date;

  Order({
    required this.id,
    required this.items,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.total,
    required this.date,
  });
}

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  ShippingAddress? _shippingAddress;
  String _paymentMethod = '';
  Map<String, Order> _orders = {};

  List<CartItem> get items => _items;
  int get itemCount => _items.length;
  ShippingAddress? get shippingAddress => _shippingAddress;
  String get paymentMethod => _paymentMethod;
  Map<String, Order> get orders => _orders;

  double get totalAmount {
    double total = 0;
    for (var item in _items) {
      total += item.price * item.qty;
    }
    return total;
  }

  void addItem({
    required String name,
    required String brand,
    required String imageUrl,
    required int price,
    required String size,
  }) {
    // Check if item already exists in cart
    final existingItemIndex = _items.indexWhere((item) =>
    item.name == name && item.size == size && item.brand == brand);

    if (existingItemIndex >= 0) {
      // If item exists, increment quantity
      _items[existingItemIndex].qty += 1;
    } else {
      // If item doesn't exist, add new item
      _items.add(CartItem(
        name: name,
        brand: brand,
        imageUrl: imageUrl,
        price: price,
        size: size,
      ));
    }

    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void incrementQuantity(int index) {
    _items[index].qty += 1;
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (_items[index].qty > 1) {
      _items[index].qty -= 1;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void clearCart() {
    _items = [];
    notifyListeners();
  }

  void setShippingAddress(ShippingAddress address) {
    _shippingAddress = address;
    notifyListeners();
  }

  void setPaymentMethod(String method) {
    _paymentMethod = method;
    notifyListeners();
  }

  Order? getOrder(String orderId) {
    return _orders[orderId];
  }

  String placeOrder() {
    final orderId = 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';

    final order = Order(
      id: orderId,
      items: List.from(_items),
      shippingAddress: _shippingAddress,
      paymentMethod: _paymentMethod,
      total: totalAmount,
      date: DateTime.now(),
    );

    _orders[orderId] = order;
    notifyListeners();
    return orderId;
  }
}