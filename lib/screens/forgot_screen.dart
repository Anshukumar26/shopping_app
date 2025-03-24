import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/screens/recovery_screen.dart';

import 'otp_screen.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {

  bool clrButton = false;

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Forgot Password",
                    style: TextStyle(fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 60),
                Text(
                  "Please enter your email address and we'll send a link on your email to forgot your password.",
                  style: TextStyle(fontSize: 15,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  onChanged: (val){
                    if(val != ""){
                      setState(() {
                        clrButton = true;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    suffix: InkWell(
                      onTap: (){
                        setState(() {
                          emailController.clear();
                        });
                      },

                    child: Icon(CupertinoIcons.multiply,
                      color: Colors.pink),
                ),
                    ),
                  ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                    context,
                        MaterialPageRoute(
                          builder: (context) => RecoveryScreen(),));
                  },
                  child: Text("Send Code",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(55),
                      backgroundColor: Colors.pink
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    Text("OR"),
                  ],
                ),
                TextButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => OTPScreen(),
                      ));
                },

            child: Text("Verify Using Number",
                      style: TextStyle(
                          color: Colors.pink,
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      ),
            ),
                    ),
                  ],
                )

            ),
      ),
      );

  }
}

