import 'package:flutter/material.dart';

class Ponds extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
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
                  Image.network(
                    "https://example.com/product.jpg", // Replace with actual image URL
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    "https://example.com/product2.jpg",
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ponds",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Scott International Men's Cotton Regular Fit Polo T-Shirt",
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 8),

                  // Rating
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      Icon(Icons.star_half, color: Colors.orange, size: 16),
                      Icon(Icons.star_border, color: Colors.orange, size: 16),
                      Text(" 367 Ratings"),
                    ],
                  ),

                  SizedBox(height: 12),

                  // Color Selection
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

                  // Size Selection
                  Text("Size:", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Row(
                    children: ["M", "L", "XL", "2XL"]
                        .map((size) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(size),
                      ),
                    ))
                        .toList(),
                  ),

                  SizedBox(height: 12),

                  // Price
                  Row(
                    children: [
                      Text(
                        "₹399",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "₹1,499",
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "-73%",
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  // Delivery Info
                  Text("FREE delivery Wednesday, 9 April"),
                  Text("Fastest delivery Tuesday, 8 April"),

                  SizedBox(height: 12),

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
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
