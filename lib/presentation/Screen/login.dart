import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/products.dart';

import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/products.dart';
import 'constants.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Access the current theme

    return Scaffold(
      backgroundColor: theme.backgroundColor, // Use theme.backgroundColor
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.0), // Add padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100.0),
              Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              CustomInput(
                hintText: "Email",
              ),
              SizedBox(height: 20.0),
              CustomInput(
                hintText: "Password",
                isPassword: true, // Hide password text
              ),
              SizedBox(height: 20.0),
              CustomBtn(
                text: "Login",
                onPressed: () {
                  Future.delayed(Duration.zero, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductList(),
                      ),
                    );
                  });
                },
              ),

              SizedBox(height: 20.0),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Create Account",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}