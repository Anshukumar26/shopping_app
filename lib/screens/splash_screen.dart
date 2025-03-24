import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopping_app/screens/home_screen.dart';
import 'package:shopping_app/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3),
    ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreen() ,)));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image:AssetImage("images/freed.jpg"),
            fit: BoxFit.cover,
            opacity: 0.5
          )

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart,
              size: 100,
              color: Colors.lime,
            ),
            Text(
              "SWIFT CART",
            style: TextStyle(
              color: Colors.white60,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle:FontStyle.italic,

            ),
            )
          ],
        ),
        ),
          

      );

  }
}
