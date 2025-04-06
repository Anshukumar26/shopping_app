// import 'package:flutter/material.dart';
//
// class OrderScreen extends StatelessWidget {
//   const OrderScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Center(child: Text("Order Screen"),),);
//
//   }
// }


import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      "orderId": "#123456789",
      "status": "Delivered",
      "date": "March 28, 2025",
      "items": [
        {
          "name": "Men's Jacket",
          "image": "https://images.unsplash.com/photo-1551028719-00167b16eac5?q=80&w=1935",
          "price": "\$59.99"
        },
        {
          "name": "Smart Watch",
          "image": "https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?w=600",
          "price": "\$199.99"
        }
      ],
      "tracking": "Your order was delivered on March 28, 2025."
    },
    {
      "orderId": "#987654321",
      "status": "Shipped",
      "date": "Expected by April 5, 2025",
      "items": [
        {
          "name": "Wireless Earbuds",
          "image": "https://images.unsplash.com/photo-1586174715865-6bf94740d4a3?w=500",
          "price": "\$89.99"
        }
      ],
      "tracking": "Your order is on the way. Expected delivery by April 5, 2025."
    }
  ];

  OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.purple[700],
        title: Text("Your Orders", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return _buildOrderCard(context, orders[index]);
        },
      ),
    );
  }

  // Order Card Widget
  Widget _buildOrderCard(BuildContext context, Map<String, dynamic> order) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      margin: EdgeInsets.only(bottom: 10),
      child: ExpansionTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order["orderId"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 5),
            Text(order["status"], style: TextStyle(color: order["status"] == "Delivered" ? Colors.green : Colors.orange)),
            Text(order["date"], style: TextStyle(color: Colors.grey, fontSize: 14)),
          ],
        ),
        children: [
          Divider(),
          Column(
            children: order["items"].map<Widget>((item) => _buildOrderItem(item)).toList(),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(order["tracking"], style: TextStyle(color: Colors.blue, fontSize: 14)),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  // Order Item Widget
  Widget _buildOrderItem(Map<String, dynamic> item) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(item["image"], width: 60, height: 60, fit: BoxFit.cover),
      ),
      title: Text(item["name"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      subtitle: Text(item["price"], style: TextStyle(color: Colors.grey[700], fontSize: 14)),
    );
  }
}

