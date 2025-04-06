import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/screens/cart_provider.dart';
import 'confirmation_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    _selectedPaymentMethod = 'cod'; // Default to COD
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final shippingAddress = cart.shippingAddress;

    // Calculate totals using CartProvider's totalAmount
    double subtotal = cart.totalAmount;
    double shipping = 15.00;
    double tax = (subtotal * 0.05).roundToDouble(); // 5% tax
    double total = subtotal + shipping + tax;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Payment Method", style: GoogleFonts.playfairDisplay(fontSize: 24)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("CANCEL", style: TextStyle(color: Colors.black87)),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(bottom: 100, left: 16, right: 16, top: 10),
            children: [
              // Address summary
              GlassmorphicContainer(
                width: double.infinity,
                height: 220,
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
                  colors: [Colors.white24, Colors.white10],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivering to:",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (shippingAddress != null) ...[
                        Text(
                          "${shippingAddress.fullName}, ${shippingAddress.addressLine}",
                          style: GoogleFonts.poppins(fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${shippingAddress.city}, ${shippingAddress.state} ${shippingAddress.zipCode}",
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                      ],
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Change"),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(60, 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Selected Items
              Text(
                "Selected Items",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              GlassmorphicContainer(
                width: double.infinity,
                height: cart.items.length * 100.0 + 32, // Dynamic height based on item count
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
                  colors: [Colors.white24, Colors.white10],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            // Item Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item.imageUrl,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.grey,
                                  child: const Icon(Icons.image_not_supported),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Item Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    item.brand,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    "Size: ${item.size} | Qty: ${item.qty}",
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                  Text(
                                    "\u{20B9}${(item.price * item.qty).toStringAsFixed(2)}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Payment methods
              Text(
                "Select a payment method",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              GlassmorphicContainer(
                width: double.infinity,
                height: 380,
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
                  colors: [Colors.white24, Colors.white10],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildPaymentMethod('card', 'Credit/Debit Card', Icons.credit_card),
                      const Divider(),
                      _buildPaymentMethod('upi', 'UPI Payment', Icons.account_balance),
                      const Divider(),
                      _buildPaymentMethod('wallet', 'Wallet', Icons.account_balance_wallet),
                      const Divider(),
                      _buildPaymentMethod('cod', 'Cash on Delivery', Icons.money),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Order summary
              GlassmorphicContainer(
                width: double.infinity,
                height: 180,
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
                  colors: [Colors.white24, Colors.white10],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Summary",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildSummaryRow("Items", "\u{20B9}${subtotal.toStringAsFixed(2)}"),
                      const SizedBox(height: 8),
                      _buildSummaryRow("Shipping", "\u{20B9}${shipping.toStringAsFixed(2)}"),
                      const SizedBox(height: 8),
                      _buildSummaryRow("Tax", "\u{20B9}${tax.toStringAsFixed(2)}"),
                      const Divider(),
                      _buildSummaryRow("Total", "\u{20B9}${total.toStringAsFixed(2)}", isBold: true),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Bottom place order button
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      // Save payment method to cart provider
                      cart.setPaymentMethod(_selectedPaymentMethod!);

                      // Use CartProvider's placeOrder method and add shipping/tax
                      final orderId = cart.placeOrder();
                      // Update the order with final total including shipping and tax
                      cart.orders[orderId] = Order(
                        id: orderId,
                        items: cart.items,
                        shippingAddress: cart.shippingAddress,
                        paymentMethod: cart.paymentMethod,
                        total: total,
                        date: DateTime.now(),
                      );

                      // Clear cart after order placement
                      cart.clearCart();

                      // Navigate to confirmation screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmationScreen(orderId: orderId),
                        ),
                      );
                    },
                    child: Text(
                      "Place Order",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "By placing your order, you agree to our privacy notice and conditions of use.",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(String value, String title, IconData icon) {
    return RadioListTile<String>(
      title: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Text(title, style: GoogleFonts.poppins()),
        ],
      ),
      value: value,
      groupValue: _selectedPaymentMethod,
      onChanged: (newValue) {
        setState(() {
          _selectedPaymentMethod = newValue;
        });
      },
      contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}