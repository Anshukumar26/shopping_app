import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/address_screen.dart';
import 'package:shopping_app/confirmation_screen.dart';
import 'package:shopping_app/payment_screen.dart';
import 'package:shopping_app/screens/cart_provider.dart';
import 'package:shopping_app/screens/colour.dart';
import 'package:shopping_app/screens/login_screen.dart';

import 'favorites_provider.dart';
import 'firebase_options.dart';
import 'screens/navigation_screen.dart';
import 'screens/splash_screen.dart'; // if you use it
// import 'providers/cart_provider.dart'; // your cart provider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
  MultiProvider(
  providers: [
  ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const MyApp(),
    ),
  ],
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  get orderId => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.yellow,
      ),
      home: NavigationScreen(),

      initialRoute: '/address',
      routes: {
        '/address': (context) => const AddressScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/confirmation': (context) => ConfirmationScreen(orderId: orderId),
      },// or SplashScreen() if that’s first
    );
  }
}
