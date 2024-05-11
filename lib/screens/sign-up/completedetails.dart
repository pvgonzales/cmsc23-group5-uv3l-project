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
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text("Complete Profile", style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 112, 0, 0),
                    height: 1.5,
                  )),
                  const Text(
                    "Complete your profile details",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const DetailsForm(),
                  const SizedBox(height: 30),
                  Text(
                    "By continuing your confirm that you agree \nwith our Term and Condition",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
