import 'package:flutter/material.dart';
import 'package:flutter_project/screens/sign-in/signinform.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
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
                    "Welcome Back!",
                    style: TextStyle(
                      color: Color.fromARGB(255, 112, 0, 0),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Sign in with your email and password",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const SignInForm(destinationRoute: '/home'),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Navigate to admin login screen
                          Navigator.pushNamed(context, '/admin-login');
                        },
                        child: const Text(
                          "Admin",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                      const SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          // Navigate to organization login screen
                          Navigator.pushNamed(context, '/org-login');
                        },
                        child: const Text(
                          "Organization",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Do not have an account? ",
                        style: TextStyle(fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/sign-up'),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 0, 97, 10)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
