import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/address_screen.dart';
import '../../../favorites_provider.dart';
import '../Kids_best3/kids_best3/babygo_color.dart';
import '../cart_provider.dart';

class Ponds extends StatefulWidget {
  final String name = 'Ponds';
  final String imageUrl = 'images/b4.jpg';
  final double price = 499.0;
  final String brand = 'Ponds';
  final Gradient? selectedGradient; // To receive gradient from GradientGenerator
  final String? uploadedImagePath; // To receive uploaded image path

  const Ponds({super.key, this.selectedGradient, this.uploadedImagePath});

  @override
  State<Ponds> createState() => _PondsScreenState();
}

class _PondsScreenState extends State<Ponds> {
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
            SizedBox(
              height: 500,
              child: PageView(
                children: [
                  Image.network(widget.imageUrl, fit: BoxFit.cover),

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
                  // Replaced Row with two containers
                  Row(
                    children: [
                      // Container for selected gradient
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GradientGenerator()),
                          );
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: widget.selectedGradient ?? const LinearGradient(colors: [Colors.grey, Colors.grey]),
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Container for uploaded image
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GradientGenerator()),
                          );
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: widget.uploadedImagePath != null
                              ? Image.file(
                            File(widget.uploadedImagePath!),
                            fit: BoxFit.cover,
                          )
                              : const Center(child: Icon(Icons.image, color: Colors.grey)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text("Customise", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text("Size:", style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: ["S", "M", "L", "XL", "2XL"]
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
                  Row(
                    children: [
                      Text("₹${widget.price}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
                      const SizedBox(width: 10),
                      const Text("₹999", style: TextStyle(fontSize: 16, decoration: TextDecoration.lineThrough, color: Colors.grey)),
                      const SizedBox(width: 10),
                      const Text("-73%", style: TextStyle(fontSize: 16, color: Colors.red)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text("FREE delivery Wednesday, 9 April"),
                  const Text("Fastest delivery Tuesday, 8 April"),
                  const SizedBox(height: 12),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddressScreen(),
                              ),
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
}