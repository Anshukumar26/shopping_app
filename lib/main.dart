import 'package:flutter/material.dart';
import 'package:shopping_app/screens/forgot_screen.dart';
import 'package:shopping_app/screens/login_screen.dart';
import 'package:shopping_app/screens/navigation_screen.dart';
import 'package:shopping_app/screens/onboarding_screen.dart';
import 'package:shopping_app/screens/otp_screen.dart';
import 'package:shopping_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
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
      home: SplashScreen(),
    );
  }
}

