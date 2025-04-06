import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../favorites_provider.dart';
import '../cart_provider.dart';

class Styli extends StatefulWidget {
  final String name = 'Styli';
  final String imageUrl = 'https://example.com/product.jpg';
  final double price = 499.0;
  final String brand = 'Styli';

  const Styli({super.key});

  @override
  State<Styli> createState() => _StyliState();
}

class _StyliState extends State<Styli> {
  String? _selectedSize = 'M'; // Default size

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    final favItem = FavoriteItem(
      name: widget.name,
      imageUrl: widget.imageUrl,
      price: widget.price.toInt(),
    );

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: "Search or ask a question...",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            SizedBox(
              height: 300,
              child: PageView(
                children: [
                  Image.network(widget.imageUrl, fit: BoxFit.cover),
                  Image.network("https://example.com/product2.jpg", fit: BoxFit.cover),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Text("Scott International Men's Cotton Regular Fit Polo T-Shirt", style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 8),

                  // Rating + Favorite
                  Row(
                    children: [
                      ...List.generate(3, (index) => const Icon(Icons.star, color: Colors.orange, size: 16)),
                      const Icon(Icons.star_half, color: Colors.orange, size: 16),
                      const Icon(Icons.star_border, color: Colors.orange, size: 16),
                      const Text(" 367 Ratings"),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          favoritesProvider.isFavorite(widget.name) ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          if (favoritesProvider.isFavorite(widget.name)) {
                            favoritesProvider.removeFavorite(widget.name);
                          } else {
                            favoritesProvider.addFavorite(favItem);
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.qr_code_scanner),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Scanner icon pressed')),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Color
                  const Text("Colour: Red - White", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _colorOption("https://example.com/color1.jpg"),
                      _colorOption("https://example.com/color2.jpg"),
                      _colorOption("https://example.com/color3.jpg"),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Size
                  const Text("Size:", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: ["M", "L", "XL", "2XL"]
                        .map((sz) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedSize = sz;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedSize == sz ? Colors.blue : null,
                          foregroundColor: _selectedSize == sz ? Colors.white : null,
                        ),
                        child: Text(sz),
                      ),
                    ))
                        .toList(),
                  ),

                  const SizedBox(height: 12),

                  // Price
                  Row(
                    children: [
                      Text("₹${widget.price}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
                      const SizedBox(width: 10),
                      const Text("₹1,499", style: TextStyle(fontSize: 16, decoration: TextDecoration.lineThrough, color: Colors.grey)),
                      const SizedBox(width: 10),
                      const Text("-73%", style: TextStyle(fontSize: 16, color: Colors.red)),
                    ],
                  ),

                  const SizedBox(height: 12),

                  const Text("FREE delivery Wednesday, 9 April"),
                  const Text("Fastest delivery Tuesday, 8 April"),

                  const SizedBox(height: 12),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_selectedSize != null) {
                              cartProvider.addItem(
                                name: widget.name,
                                brand: widget.brand,
                                imageUrl: widget.imageUrl,
                                price: widget.price.toInt(),
                                size: _selectedSize!,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${widget.name} (Size: $_selectedSize) added to cart')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please select a size')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                          child: const Text("Add to Cart"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your Buy Now navigation here if needed
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Buy Now pressed')),
                            );
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                          child: const Text("Buy Now"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorOption(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          shape: BoxShape.circle,
          image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
        ),
      ),
    );
  }
}