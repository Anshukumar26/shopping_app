import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchScreen> {
  final List<String> allProducts = [
    'T-Shirt',
    'Jeans',
    'Sneakers',
    'Jacket',
    'Sunglasses',
    'Backpack',
    'Watch',
    'Hat',
    'Scarf',
    'Dress',
    'Hoodie',
  ];

  List<String> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = allProducts;
  }

  void _filterSearch(String query) {
    final results = allProducts.where((item) =>
        item.toLowerCase().contains(query.toLowerCase())).toList();

    setState(() {
      filteredProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context); // 👈 Goes back to the previous screen
          },
        ),
        title: Text('Search'),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔍 Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onChanged: _filterSearch,
            ),
            SizedBox(height: 20),
            // 🛍 Filtered product list
            Expanded(
              child: filteredProducts.isEmpty
                  ? Center(child: Text('No results found.'))
                  : ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.shopping_bag),
                    title: Text(filteredProducts[index]),
                    onTap: () {
                      // You can navigate to the product page here
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
