import 'package:flutter/material.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final Map<String, Map<String, dynamic>> _products = {
    't-shirt': {'price': 1499, 'stock': 50, 'colors': ['red', 'blue', 'white']},
    'jeans': {'price': 3999, 'stock': 30, 'colors': ['black', 'blue', 'grey']},
    'jacket': {'price': 6499, 'stock': 20, 'colors': ['green', 'black', 'brown']},
  };
  final Map<String, int> _cart = {};
  final List<Map<String, dynamic>> _orders = [];

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.insert(0, ChatMessage(text: text, isUser: true));
    });
    _processMessage(text.toLowerCase());
  }

  void _processMessage(String message) {
    String response;
    List<String> suggestedQuestions = [
      "What clothes do you have?",
      "What's the price of a t-shirt?",
      "What colors are available for jeans?",
      "Can I customize a t-shirt?",
      "How can I track my order?",
      "What's in my cart?",
      "How much is a jacket?",
      "Is the jacket in stock?",
      "How do I checkout?",
      "What prints can I add to my clothes?",
      "Can we modify or customize products?"
    ];

    if (message.contains('hi') || message.contains('hello')) {
      response = "Hello! I'm Ansh, your shopping assistant. Welcome to our clothing store. How can I assist you today?";
    }
    else if (message.contains('clothes') || message.contains('products')) {
      response = "We have t-shirts, jeans, and jackets. What would you like to know more about?";
    }
    else if (message.contains('price')) {
      response = _getPriceResponse(message);
    }
    else if (message.contains('color') || message.contains('colors')) {
      response = _getColorsResponse(message);
    }
    else if (message.contains('custom') || message.contains('customize')) {
      response = _getCustomizationResponse(message);
    }
    else if (message.contains('stock') || message.contains('availability')) {
      response = _getStockResponse(message);
    }
    else if (message.contains('buy') || message.contains('add')) {
      response = _addToCart(message);
    }
    else if (message.contains('cart')) {
      response = _getCartResponse();
    }
    else if (message.contains('checkout')) {
      response = _processCheckout();
    }
    else if (message.contains('track') || message.contains('order')) {
      response = _trackOrder();
    }
    else if (message.contains('print')) {
      response = "We offer custom prints! Available options: floral, geometric, text, or your custom design. Which would you like?";
    }
    else if (message.contains('modify') || message.contains('customize') && message.contains('products')) {
      response = "Yes, you can modify or customize our products! You can change colors and add prints. Tell me what you'd like to customize!";
    }
    else {
      response = "Sorry, I didn't understand that. Here are some things you can ask:\n" +
          suggestedQuestions.map((q) => "• $q").join("\n");
    }

    setState(() {
      _messages.insert(0, ChatMessage(text: response, isUser: false));
    });
  }

  String _getPriceResponse(String message) {
    for (String product in _products.keys) {
      if (message.contains(product)) {
        return "The $product costs ₹${_products[product]!['price']}";
      }
    }
    return "Please specify which item (t-shirt, jeans, or jacket) you want the price for.";
  }

  String _getColorsResponse(String message) {
    for (String product in _products.keys) {
      if (message.contains(product)) {
        return "$product is available in: ${_products[product]!['colors'].join(', ')}";
      }
    }
    return "Please specify which item you want color options for.";
  }

  String _getCustomizationResponse(String message) {
    return "You can customize colors and add prints! Tell me which item you'd like to customize and your preferences (e.g., 'customize t-shirt red with floral print')";
  }

  String _getStockResponse(String message) {
    for (String product in _products.keys) {
      if (message.contains(product)) {
        return "We have ${_products[product]!['stock']} $product(s) in stock";
      }
    }
    return "Please specify which item's stock you want to check.";
  }

  String _addToCart(String message) {
    for (String product in _products.keys) {
      if (message.contains(product)) {
        _cart[product] = (_cart[product] ?? 0) + 1;
        return "Added 1 $product to your cart. Anything else you'd like?";
      }
    }
    return "Please specify what you'd like to buy (e.g., 'buy t-shirt')";
  }

  String _getCartResponse() {
    if (_cart.isEmpty) return "Your cart is empty. What would you like to add?";
    String cartContents = "Your cart contains:\n";
    _cart.forEach((product, qty) => cartContents += "$qty $product(s)\n");
    return cartContents;
  }

  String _processCheckout() {
    if (_cart.isEmpty) return "Your cart is empty. Add some items first!";
    String orderId = "ORD${DateTime.now().millisecondsSinceEpoch}";
    _orders.add({
      'id': orderId,
      'items': Map.from(_cart),
      'date': DateTime.now(),
      'status': 'Processing'
    });
    _cart.clear();
    return "Order $orderId placed successfully! You can track it by asking 'track my order'";
  }

  String _trackOrder() {
    if (_orders.isEmpty) return "You haven't placed any orders yet.";
    String response = "Your orders:\n";
    for (var order in _orders) {
      response += "Order ${order['id']} - Status: ${order['status']} - Placed: ${order['date']}\n";
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ansh - Clothes Shopping Assistant'),
        backgroundColor: Colors.pink, // Pink AppBar
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _messages[index],
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: "Ask Ansh about clothes, customization, or orders...",
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({super.key, required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) const CircleAvatar(child: Text('Ansh')), // Changed to "Ansh"
          const SizedBox(width: 8.0),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: isUser ? Colors.blue[100] : Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(text),
            ),
          ),
          const SizedBox(width: 8.0),
          if (isUser) const CircleAvatar(child: Text('You')),
        ],
      ),
    );
  }
}