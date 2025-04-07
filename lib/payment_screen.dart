import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _upiIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedPaymentMethod = 'cod'; // Default to COD
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final shippingAddress = cart.shippingAddress;

    double subtotal = cart.totalAmount;
    double shipping = 15.00;
    double tax = (subtotal * 0.05).roundToDouble();
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
              _glassContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Delivering to:", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    if (shippingAddress != null) ...[
                      Text("${shippingAddress.fullName}, ${shippingAddress.addressLine}", style: GoogleFonts.poppins(fontSize: 14)),
                      Text("${shippingAddress.city}, ${shippingAddress.state} ${shippingAddress.zipCode}", style: GoogleFonts.poppins(fontSize: 14)),
                    ],
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Change"),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Text("Selected Items", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _glassContainer(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
                                Text(item.brand, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])),
                                Text("Size: ${item.size} | Qty: ${item.qty}", style: GoogleFonts.poppins(fontSize: 12)),
                                Text("\u{20B9}${(item.price * item.qty).toStringAsFixed(2)}", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              Text("Select a payment method", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              _glassContainer(
                child: Column(
                  children: [
                    _buildPaymentMethod('card', 'Credit/Debit Card', Icons.credit_card),
                    if (_selectedPaymentMethod == 'card') ...[
                      _buildTextField(_cardNumberController, 'Card Number'),
                      _buildTextField(_expiryController, 'Expiry Date'),
                      _buildTextField(_cvvController, 'CVV'),
                    ],
                    const Divider(),
                    _buildPaymentMethod('upi', 'UPI Payment', Icons.account_balance),
                    if (_selectedPaymentMethod == 'upi') _buildTextField(_upiIdController, 'UPI ID'),
                    const Divider(),
                    _buildPaymentMethod('wallet', 'Wallet', Icons.account_balance_wallet),
                    const Divider(),
                    _buildPaymentMethod('cod', 'Cash on Delivery', Icons.money),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              _glassContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order Summary", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    _buildSummaryRow("Items", "\u{20B9}${subtotal.toStringAsFixed(2)}"),
                    _buildSummaryRow("Shipping", "\u{20B9}${shipping.toStringAsFixed(2)}"),
                    _buildSummaryRow("Tax", "\u{20B9}${tax.toStringAsFixed(2)}"),
                    const Divider(),
                    _buildSummaryRow("Total", "\u{20B9}${total.toStringAsFixed(2)}", isBold: true),
                  ],
                ),
              ),
            ],
          ),

          // Bottom Place Order Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, -5))],
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
                      if (_selectedPaymentMethod == 'card' &&
                          (_cardNumberController.text.isEmpty ||
                              _expiryController.text.isEmpty ||
                              _cvvController.text.isEmpty)) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all card details")));
                        return;
                      }

                      if (_selectedPaymentMethod == 'upi' && _upiIdController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter UPI ID")));
                        return;
                      }

                      cart.setPaymentMethod(_selectedPaymentMethod!);
                      final orderId = cart.placeOrder();
                      cart.orders[orderId] = Order(
                        id: orderId,
                        items: cart.items,
                        shippingAddress: cart.shippingAddress,
                        paymentMethod: cart.paymentMethod,
                        total: total,
                        date: DateTime.now(),
                      );

                      cart.clearCart();

                      Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmationScreen(orderId: orderId)));
                    },
                    child: Text("Place Order", style: GoogleFonts.poppins(fontSize: 16)),
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

  Widget _glassContainer({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(String value, String title, IconData icon) {
    return RadioListTile<String>(
      title: Row(children: [Icon(icon), const SizedBox(width: 12), Text(title, style: GoogleFonts.poppins())]),
      value: value,
      groupValue: _selectedPaymentMethod,
      onChanged: (newValue) => setState(() => _selectedPaymentMethod = newValue),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.poppins(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        Text(value, style: GoogleFonts.poppins(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white.withOpacity(0.8),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
