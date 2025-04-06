
import 'package:flutter/material.dart';
import 'package:shopping_app/screens/select_product/select_product.dart';

class Featured2 extends StatelessWidget {
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
      body: SingleChildScrollView( // Wrap with SingleChildScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHorizontalList(),
            _buildTabBar(),
            _buildProductGrid(),
            // Let GridView be wrapped inside a constrained container
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

  Widget _buildProductGrid() {
    return Container(
      height: 600, // Adjust height if needed
      child: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to SelectProduct screen when a product is clicked
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SelectProduct()),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius
                            .circular(10)),
                        color: Colors.grey[300],
                      ),
                      child: Center(child: Icon(Icons.image, size: 50)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Product Name', style: TextStyle(
                            fontWeight: FontWeight.bold)),
                        Text('\u{20B9}399', style: TextStyle(
                            color: Colors.red)),
                        ElevatedButton(onPressed: () {}, child: Text(
                            'Add to Cart')),
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