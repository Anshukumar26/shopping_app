import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/address_screen.dart';
import 'cart_provider.dart';
// import 'cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void updateQuantity(BuildContext context, int index, int change) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final item = cart.items[index];
    final newQty = item.qty + change;

    if (newQty >= 1) {
      setState(() {
        item.qty = newQty;
      });
      cart.notifyListeners(); // Notify provider about the change
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items;

    double totalPrice =
    cartItems.fold(0, (sum, item) => sum + (item.price * item.qty));

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Your Cart", style: GoogleFonts.playfairDisplay(fontSize: 24)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 160.0),
            child: cartItems.isEmpty
                ? Center(
              child: Text(
                "Your cart is empty",
                style: GoogleFonts.poppins(fontSize: 18),
              ),
            )
                : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  child: GlassmorphicContainer(
                    width: double.infinity,
                    height: 270,
                    borderRadius: 20,
                    blur: 20,
                    alignment: Alignment.center,
                    border: 1,
                    linearGradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.2),
                        Colors.white38.withOpacity(0.2),
                      ],
                    ),
                    borderGradient: LinearGradient(
                      colors: [
                        Colors.white24,
                        Colors.white10,
                      ],
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          item.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        item.name,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("${item.brand} · Size: ${item.size}"),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "\u{20B9}${(item.price * item.qty).toStringAsFixed(2)}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () => updateQuantity(context, index, -1),
                                child: Icon(Icons.remove_circle_outline, size: 18),
                              ),
                              SizedBox(width: 6),
                              Text(item.qty.toString()),
                              SizedBox(width: 6),
                              GestureDetector(
                                onTap: () => updateQuantity(context, index, 1),
                                child: Icon(Icons.add_circle_outline, size: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Divider(thickness: 2, indent: 100, endIndent: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal", style: GoogleFonts.poppins(fontSize: 16)),
                      Text("\u{20B9}${totalPrice.toStringAsFixed(2)}", style: GoogleFonts.poppins(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Shipping", style: GoogleFonts.poppins(fontSize: 16)),
                      Text("\u{20B9}15.00", style: GoogleFonts.poppins(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(
                        "\u{20B9}${(totalPrice + 15).toStringAsFixed(2)}",
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => AddressScreen(),));
                    },
                    icon: Icon(Icons.lock),
                    label: Text("Secure Checkout", style: GoogleFonts.poppins(fontSize: 16),),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
