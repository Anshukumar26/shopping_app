import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/address_screen.dart';
import 'package:shopping_app/confirmation_screen.dart';
import 'package:shopping_app/payment_screen.dart';
import 'package:shopping_app/screens/cart_provider.dart';
import 'package:shopping_app/screens/women_best1/vero_moda_colour.dart';
import 'package:shopping_app/screens/login_screen.dart';
import 'package:shopping_app/screens/navigation_screen.dart';
import 'package:shopping_app/screens/splash_screen.dart'; // if you use it

import 'firebase_options.dart';
import 'favorites_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.yellow,
      ),
      home: const SplashScreen(), // Or SplashScreen() if that comes first
      // home: const NavigationScreen(),

      // Define named routes
      routes: {
        '/address': (context) => const AddressScreen(),
        '/payment': (context) => const PaymentScreen(),

        // We must pass `orderId` when navigating to this route
        // So you shouldn't use `/confirmation` directly unless passing arguments
        // If needed, use onGenerateRoute for dynamic parameters
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/confirmation') {
          final args = settings.arguments as Map<String, dynamic>;
          final orderId = args['orderId'] as String;

          return MaterialPageRoute(
            builder: (context) => ConfirmationScreen(orderId: orderId),
          );
        }
        return null;
      },
    );
  }
}
