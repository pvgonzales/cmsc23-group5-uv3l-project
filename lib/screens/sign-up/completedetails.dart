import 'package:flutter/material.dart';
import 'package:flutter_project/screens/sign-up/detailsform.dart';

class CompleteDetailsScreen extends StatelessWidget {
  const CompleteDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Complete Profile',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: Color(0xFF212738),
            fontFamily: "MyFont3",
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
            child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      const Text("Complete Profile",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: "MyFont1",
                            color: Color(0xFF212738),
                          )),
                      const Text(
                        "Complete your profile details",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF212738),
                          fontFamily: "MyFont1",
                        ),
                      ),
                      const SizedBox(height: 16),
                      const DetailsForm(),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          )
        ])),
      ),
    );
  }
}
