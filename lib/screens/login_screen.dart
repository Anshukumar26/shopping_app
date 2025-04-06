import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_app/screens/navigation_screen.dart';
import 'signup_screen.dart';
import 'forgot_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _login() async {
    try {
      setState(() => _isLoading = true);
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavigationScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Login failed")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("images/freed.jpg"),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: "Enter Email",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Enter Password",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: Icon(Icons.remove_red_eye),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const ForgotScreen()));
                          },
                          child: const Text("Forgot Password",
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(55),
                            backgroundColor: Colors.pink),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Log In",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't Have an Account?",
                              style: TextStyle(color: Colors.black54, fontSize: 15)),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const SignupScreen()),
                              );
                            },
                            child: const Text("Sign Up",
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
