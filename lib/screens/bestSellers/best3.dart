import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/screens/select_product/select_product.dart';

import '../Kids_best3/kids_best3/babygo.dart';
import '../Kids_best3/kids_best3/hopscotch.dart';
import '../Kids_best3/kids_best3/kidsville.dart';
import '../Kids_best3/kids_best3/max.dart';
import '../Kids_best3/kids_best3/superminis.dart';
import '../Kids_best3/kids_best3/toonyport.dart';
import '../cart_provider.dart';
import '../cart_screen.dart';


class Best3 extends StatelessWidget {

  final List<Map<String, dynamic>> newArrivals = [
    {'name': 'Baby Go', 'price': 399, 'screen': Babygo()},
    {'name': 'Max', 'price': 599, 'screen': Max()},
    {'name': 'Hopscotch', 'price': 299, 'screen': Hopscotch()},
    {'name': 'Toonyport', 'price': 1299, 'screen': Toonyport()},
    {'name': 'Superminis', 'price': 1499, 'screen': Superminis()},
    {'name': 'Kidsville', 'price': 499, 'screen': Kidsville()},
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
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.image, size: 30, color: Colors.white),
                ),
                SizedBox(height: 5),
                Text('Viewed')
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

  // 🆕 Use newArrivals list to dynamically build each product card
  Widget _buildProductGrid(BuildContext context) {
    return Container(
      height: 1200,
      child: GridView.builder(
        // physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
          final String imageUrl = item['imageUrl'] ??
              'https://via.placeholder.com/150';

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
                      child: Image.network(
                        imageUrl,
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
                            // ✅ Use CartProvider to add item
                            Provider.of<CartProvider>(context, listen: false).addItem(
                              name: name,
                              brand: brand,
                              imageUrl: imageUrl,
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
