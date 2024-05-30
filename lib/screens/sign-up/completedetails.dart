import 'package:flutter/material.dart';
import 'package:flutter_project/screens/sign-up/detailsform.dart';

class CompleteDetailsScreen extends StatelessWidget {

  const CompleteDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: const SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Text("Complete Profile", style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 112, 0, 0),
                    height: 1.5,
                  )),
                  Text(
                    "Complete your profile details",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  DetailsForm(),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
