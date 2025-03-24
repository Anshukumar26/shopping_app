import 'package:flutter/material.dart';
import 'package:shopping_app/screens/signup_screen.dart';

import 'forgot_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
          child: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            Image.asset("images/freed.jpg",),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Enter Email",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Enter Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.remove_red_eye)
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => ForgotScreen(),));
                    }, child: Text("Forgot Password",
                    style: TextStyle(
                        color: Colors.pink,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    ),
                  ),),),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),));
                    },
                    child: Text("Log In",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(55),
                        backgroundColor: Colors.pink
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't Have an Account?",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15),
                      ),
                      TextButton(onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),));
                      }, child: Text("Sign Up",
                        style: TextStyle(
                            color: Colors.pink,
                            fontSize: 16,
                          fontWeight: FontWeight.w600
                        ),
                      ),),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );();
  }
}
