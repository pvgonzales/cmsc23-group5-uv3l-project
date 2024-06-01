import 'package:flutter/material.dart';
import 'package:flutter_project/screens/sign-in/signinform.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: "MyFont1",
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF212738),
        iconTheme: IconThemeData(
          color: Colors.white, // Change this color to the desired color
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFf4f6ff), // Start color
              Color(0xFFd3d8f0), // End color
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, top: 40),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "Welcome Back!",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF212738),
                            fontFamily: "MyFont3",
                          ),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          "Sign in with your email and password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF212738),
                            fontFamily: "MyFont1",
                          ),
                        ),
                        const SizedBox(height: 40),
                        const SignInForm(destinationRoute: '/home', expectedUserType: 'donor'),
                        const SizedBox(height: 20),
                        const Text(
                          "— or continue as — ",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF212738),
                            fontFamily: "MyFont1",
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color?>(
                                        Colors.white),
                              ),
                              onPressed: () {
                                // Navigate to admin login screen
                                Navigator.pushNamed(context, '/admin-login');
                              },
                              child: const Text(
                                "Admin",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF212738),
                                  fontFamily: "MyFont1",
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color?>(
                                        Colors.white),
                              ),
                              onPressed: () {
                                // Navigate to organization login screen
                                Navigator.pushNamed(context, '/org-login');
                              },
                              child: const Text(
                                "Organization",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF212738),
                                  fontFamily: "MyFont1",
                                ),
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
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF212738),
                                fontFamily: "MyFont1",
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/sign-up'),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF212738),
                                  fontFamily: "MyFont1",
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                            height: 16), // Add some space at the bottom
                      ],
                    ),
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
