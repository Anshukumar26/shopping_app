import 'package:flutter/material.dart';


import 'home_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
          child: Center(
            child: Column(
              children: [
                //SizedBox(height: 110),
                Image.asset("images/freed.jpg"),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Enter Name",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(height: 15),

                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Enter Email",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      SizedBox(height: 15),

                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Enter Number",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.numbers),
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
                      SizedBox(height: 15),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: Icon(Icons.remove_red_eye)
                        ),
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(onPressed: () {}, child: Text("Forgot Password",
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
                        child: Text("Create Account",
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
                          Text("Already Have an Account?",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15),
                          ),
                          TextButton(onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),));
                          }, child: Text("Log In",
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


