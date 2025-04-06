import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import 'package:shopping_app/screens/cart_provider.dart';

class ConfirmationScreen extends StatefulWidget {
  final String orderId;

  const ConfirmationScreen({super.key, required this.orderId});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 5));

    // Start confetti animation when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _confettiController.play();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final order = cart.getOrder(widget.orderId);
    final deliveryDate = DateTime.now().add(const Duration(days: 5));

    if (order == null) {
      return Scaffold(
        body: Center(
          child: Text(
            "Order not found",
            style: GoogleFonts.poppins(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Order Confirmation", style: GoogleFonts.playfairDisplay(fontSize: 24)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Confetti animation
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            particleDrag: 0.05,
            emissionFrequency: 0.05,
            numberOfParticles: 20,
            gravity: 0.1,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ],
          ),

          // Main content
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Success icon
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 60,
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  "Thank You!",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  "Your order has been placed successfully.",
                  style: GoogleFonts.poppins(fontSize: 16),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Order details
                GlassmorphicContainer(
                  width: double.infinity,
                  height: 280,
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
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Details",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        _buildDetailRow("Order ID", widget.orderId),
                        const SizedBox(height: 8),
                        _buildDetailRow("Date", "${order.date.day}/${order.date.month}/${order.date.year}"),
                        const SizedBox(height: 8),
                        _buildDetailRow("Payment Method", _getPaymentMethodName(order.paymentMethod)),
                        const SizedBox(height: 8),
                        _buildDetailRow("Total Amount", "\u{20B9}${order.total.toStringAsFixed(2)}"),
                        const SizedBox(height: 8),
                        _buildDetailRow("Items", "${order.items.length}"),
                        const SizedBox(height: 8),
                        _buildDetailRow(
                            "Estimated Delivery",
                            "${deliveryDate.day}/${deliveryDate.month}/${deliveryDate.year}"
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Buttons
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    // Clear cart and navigate back to home
                    cart.clearCart();
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: Text(
                    "Continue Shopping",
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ),

                const SizedBox(height: 16),

                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Track Order feature coming soon!"))
                    );
                  },
                  child: Text(
                    "Track Order",
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _getPaymentMethodName(String method) {
    switch (method) {
      case 'card':
        return 'Credit/Debit Card';
      case 'upi':
        return 'UPI Payment';
      case 'wallet':
        return 'Wallet';
      case 'cod':
        return 'Cash on Delivery';
      default:
        return 'Unknown';
    }
  }
}