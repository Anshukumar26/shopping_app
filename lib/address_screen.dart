import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/screens/cart_provider.dart';
// import 'cart_provider.dart';
import 'payment_screen.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Delivery Address", style: GoogleFonts.playfairDisplay(fontSize: 24)),
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
          // Main form content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.only(bottom: 120), // Space for bottom button
                children: [
                  GlassmorphicContainer(
                    width: double.infinity,
                    height: 620,
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
                            "Shipping Address",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: "Full Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white70,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _addressLine1Controller,
                            decoration: InputDecoration(
                              labelText: "Address Line 1",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white70,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _addressLine2Controller,
                            decoration: InputDecoration(
                              labelText: "Address Line 2 (Optional)",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _cityController,
                                  decoration: InputDecoration(
                                    labelText: "City",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white70,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _stateController,
                                  decoration: InputDecoration(
                                    labelText: "State",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white70,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _zipController,
                            decoration: InputDecoration(
                              labelText: "ZIP Code",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white70,
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter ZIP code';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              labelText: "Phone Number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white70,
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter phone number';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom continue button container
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Create a ShippingAddress object instead of a Map
                        final address = ShippingAddress(
                          fullName: _nameController.text,
                          addressLine: _addressLine1Controller.text +
                              (_addressLine2Controller.text.isNotEmpty ?
                              ', ' + _addressLine2Controller.text : ''),
                          city: _cityController.text,
                          state: _stateController.text,
                          zipCode: _zipController.text,
                          phone: _phoneController.text,
                        );

                        // Save address to cart provider
                        cart.setShippingAddress(address);

                        // Navigate to payment screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Continue to Payment",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
