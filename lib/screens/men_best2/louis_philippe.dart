import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../favorites_provider.dart';
import '../cart_provider.dart';

class LouisPhilippe extends StatelessWidget {
  final String name = 'Louis Philippe';
  final String imageUrl = 'https://example.com/product.jpg';
  final double price = 759.0;
  final String brand = 'Louis Philippe';
  final String size = 'M';

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    final favItem = FavoriteItem(
        name: name,
        imageUrl: imageUrl,
        price: price.toInt()
    );

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: "Search or ask a question...",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart'); // Ensure your cart screen is registered
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 300,
              child: PageView(
                children: [
                  Image.network(imageUrl, fit: BoxFit.cover),
                  Image.network("https://example.com/product2.jpg", fit: BoxFit.cover),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("Scott International Men's Cotton Regular Fit Polo T-Shirt", style: TextStyle(fontSize: 14)),
                  SizedBox(height: 8),

                  // Rating + Favorite
                  Row(
                    children: [
                      ...List.generate(3, (index) => Icon(Icons.star, color: Colors.orange, size: 16)),
                      Icon(Icons.star_half, color: Colors.orange, size: 16),
                      Icon(Icons.star_border, color: Colors.orange, size: 16),
                      Text(" 167 Ratings"),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          favoritesProvider.isFavorite(name) ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          if (favoritesProvider.isFavorite(name)) {
                            favoritesProvider.removeFavorite(name);
                          } else {
                            favoritesProvider.addFavorite(favItem);
                          }
                        },

                      ),
                      IconButton(
                        icon: Icon(Icons.qr_code_scanner),
                        onPressed: () {
                          // You can define your scanner action here
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Scanner icon pressed')),
                          );
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  // Color
                  Text("Colour: Red - White", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      _colorOption("https://example.com/color1.jpg"),
                      _colorOption("https://example.com/color2.jpg"),
                      _colorOption("https://example.com/color3.jpg"),
                    ],
                  ),

                  SizedBox(height: 12),

                  // Size
                  Text("Size:", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Row(
                    children: ["M", "L", "XL", "2XL"]
                        .map((sz) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(sz),
                      ),
                    ))
                        .toList(),
                  ),

                  SizedBox(height: 12),

                  // Price
                  Row(
                    children: [
                      Text("₹$price", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
                      SizedBox(width: 10),
                      Text("₹1,499", style: TextStyle(fontSize: 16, decoration: TextDecoration.lineThrough, color: Colors.grey)),
                      SizedBox(width: 10),
                      Text("-53%", style: TextStyle(fontSize: 16, color: Colors.red)),
                    ],
                  ),

                  SizedBox(height: 12),

                  Text("FREE delivery Wednesday, 9 April"),
                  Text("Fastest delivery Tuesday, 8 April"),

                  SizedBox(height: 12),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            cartProvider.addItem(
                              name: name,
                              brand: brand,
                              imageUrl: imageUrl,
                              price: price.toInt(),
                              size: size,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('$name added to cart')),
                            );
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                          child: Text("Add to Cart"),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                          child: Text("Buy Now"),
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
      padding: EdgeInsets.symmetric(horizontal: 4),
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