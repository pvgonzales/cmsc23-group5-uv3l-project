import 'package:flutter/material.dart';
import 'package:flutter_project/screens/sign-up/signupform.dart';

class OrgSignUpScreen extends StatelessWidget {
  const OrgSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Organization Sign Up"),
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
                    "Organization Sign Up",
                    style: TextStyle(
                      color: Color.fromARGB(255, 112, 0, 0),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SignUpForm(), // You can reuse the existing sign-up form
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
