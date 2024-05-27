import 'package:flutter/material.dart';
import 'package:flutter_project/screens/sign-in/signinform.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Login"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "Admin Login",
                    style: TextStyle(
                      color: Color.fromARGB(255, 112, 0, 0),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SignInForm(
                      destinationRoute:
                          '/admin'), // You can reuse the existing sign-in form
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
