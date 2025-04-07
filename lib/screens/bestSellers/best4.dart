import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/screens/beauty_best4/facescanada.dart';
import 'package:shopping_app/screens/beauty_best4/lakme.dart';
import 'package:shopping_app/screens/beauty_best4/maybelline.dart';
import 'package:shopping_app/screens/beauty_best4/ponds.dart';
import 'package:shopping_app/screens/beauty_best4/sugar.dart';
import 'package:shopping_app/screens/beauty_best4/swiss.dart';
import '../cart_provider.dart';

class Best4 extends StatelessWidget {
  final List<Map<String, dynamic>> newArrivals = [
    {'name': 'Swiss Beauty', 'price': 399, 'imageAsset': 'images/b1.jpg', 'screen': Swiss()},
    {'name': 'Faces Canada', 'price': 599, 'imageAsset': 'images/b2.jpg', 'screen': Facescanada()},
    {'name': 'Maybelline', 'price': 299, 'imageAsset': 'images/b3.jpg', 'screen': Maybelline()},
    {'name': 'Ponds', 'price': 1299, 'imageAsset': 'images/b4.jpg', 'screen': Ponds()},
    {'name': 'SUGAR', 'price': 1499, 'imageAsset': 'images/b5.jpg', 'screen': Sugar()},
    {'name': 'Lakme', 'price': 499, 'imageAsset': 'images/b6.jpg', 'screen': Lakme()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search or ask a question',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        actions: [IconButton(icon: Icon(Icons.qr_code), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHorizontalList(),
            _buildTabBar(),
            _buildProductGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalList() {
    return SizedBox(
      height: 105,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newArrivals.length,
        itemBuilder: (context, index) {
          final item = newArrivals[index];
          final String imageAsset = item['imageAsset'] ?? 'assets/images/placeholder.jpg'; // Fallback asset

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(imageAsset), // Using AssetImage for local assets
                  backgroundColor: Colors.grey[300],
                  onBackgroundImageError: (exception, stackTrace) {
                    // Handle image loading error if needed
                  },
                ),
                const SizedBox(height: 5),
                Text(
                  item['name'] ?? 'Unknown',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: ['For You', 'Bestsellers', 'Deals', 'New Releases']
            .map((tab) => TextButton(onPressed: () {}, child: Text(tab)))
            .toList(),
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    return Padding( // Replaced Container with Padding
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true, // Allows GridView to size itself based on content
        physics: const NeverScrollableScrollPhysics(), // Let SingleChildScrollView handle scrolling
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: newArrivals.length,
        itemBuilder: (context, index) {
          final item = newArrivals[index];
          final String name = item['name'] ?? 'Unknown';
          final int price = item['price'] ?? 0;
          final String brand = item['brand'] ?? 'Trendy Brand';
          final String size = item['size'] ?? 'M';
          final String imageAsset = item['imageAsset'] ?? 'assets/images/placeholder.jpg'; // Fallback asset

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => item['screen']),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.asset( // Changed to Image.asset
                        imageAsset,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(child: Icon(Icons.broken_image, size: 40));
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('\u{20B9}$price', style: TextStyle(color: Colors.red)),
                        SizedBox(height: 6),
                        ElevatedButton(
                          onPressed: () {
                            Provider.of<CartProvider>(context, listen: false).addItem(
                              name: name,
                              brand: brand,
                              imageUrl: imageAsset, // Still named imageUrl in CartProvider
                              price: price,
                              size: size,
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$name added to cart'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Text('Add to Cart'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}