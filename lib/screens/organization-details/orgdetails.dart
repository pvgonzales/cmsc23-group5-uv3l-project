import 'package:flutter/material.dart';
import 'package:flutter_project/model/org_model.dart';
import 'package:flutter_project/screens/organization-details/donorform.dart';

class OrgDonation extends StatefulWidget {
  final Organizations? org;
  const OrgDonation({super.key, this.org});

  @override
  State<OrgDonation> createState() => _OrgDonationState();
}

class _OrgDonationState extends State<OrgDonation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Donate',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: "MyFont1",
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Change this color to the desired color
        ),
        backgroundColor: Color(0xFF212738),
      ),
      backgroundColor: Color(0xfff4f6ff),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Container(
                    padding:
                        EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(173, 255, 229, 228),
                    ),
                    child: Text("Donate to ${widget.org!.name}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF212738),
                          height: 1.5,
                          fontFamily: "MyFont1",
                        )),
                  ),
                  const SizedBox(height: 16),
                  const DonorForm(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
