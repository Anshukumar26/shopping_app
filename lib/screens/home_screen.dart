import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shopping_app/screens/bestSellers/best1.dart';
import 'package:shopping_app/screens/bestSellers/best2.dart';
import 'package:shopping_app/screens/bestSellers/best3.dart';
import 'package:shopping_app/screens/bestSellers/best4.dart';
import 'package:shopping_app/screens/cart_screen.dart';
import 'package:shopping_app/screens/featuredDesigners/Featured2.dart';
import 'package:shopping_app/screens/featuredDesigners/feactured3.dart';
import 'package:shopping_app/screens/featuredDesigners/featured1.dart';
import 'package:shopping_app/screens/featuredDesigners/featured4.dart';
import 'package:shopping_app/screens/new%20arrivals/1.dart';
import 'package:shopping_app/screens/new%20arrivals/2.dart';
import 'package:shopping_app/screens/new%20arrivals/3.dart';
import 'package:shopping_app/screens/new%20arrivals/product_screen.dart';
import 'package:shopping_app/screens/profile_screen.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 🆕 Each item includes image and screen to navigate to
    final List<Map<String, dynamic>> newArrivals = [
      {'image': 'images/product0.jpg', 'screen': ProductScreen1()},
      {'image': 'images/product1.jpg', 'screen': ProductScreen2()},
      {'image': 'images/product2.jpg', 'screen': ProductScreen3()},
      {'image': 'images/product3.jpg', 'screen': ProductScreen4()},
    ];

    final List<Map<String, dynamic>> bestSellers = [
      {'image': 'images/product2.jpg', 'screen': Best1()},
      {'image': 'images/product0.jpg', 'screen': Best2()},
      {'image': 'images/product3.jpg', 'screen': Best3()},
      {'image': 'images/product1.jpg', 'screen': Best4()},
    ];

    final List<Map<String, dynamic>> featuredDesigners = [
      {'image': 'images/product3.jpg', 'screen': Featured1()},
      {'image': 'images/product1.jpg', 'screen': Featured2()},
      {'image': 'images/product0.jpg', 'screen': Feactured3()},
      {'image': 'images/product2.jpg', 'screen': Featured4()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Swift Cart'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('images/logo.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Hello, User!',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Cart'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBanner(),
            _buildSectionTitle('New Arrivals'),
            _buildCustomList(newArrivals, context),
            _buildSectionTitle('Best Sellers'),
            _buildCustomList(bestSellers, context),
            _buildSectionTitle('Featured Designers'),
            _buildCustomList(featuredDesigners, context),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    final List<String> bannerImages = [
      'images/a1.jpg',
      'images/a2.jpg',
      'images/a3.jpg',
    ];

    return CarouselSlider(
      options: CarouselOptions(height: 200.0, autoPlay: true),
      items: bannerImages.map((item) {
        return Container(
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(item),
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 🆕 Used for all three sections now
  Widget _buildCustomList(List<Map<String, dynamic>> items, BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => items[index]['screen']),
              );
            },
            child: Container(
              width: 120,
              margin: EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  items[index]['image'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
